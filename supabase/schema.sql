-- Create tables for the bill splitter app

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Groups table
CREATE TABLE groups (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by UUID NOT NULL REFERENCES auth.users(id),
  invite_code TEXT NOT NULL UNIQUE DEFAULT substr(md5(random()::text), 0, 8)
);

-- Group members table
CREATE TABLE group_members (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  group_id UUID NOT NULL REFERENCES groups(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id),
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(group_id, user_id)
);

-- Expenses table
CREATE TABLE expenses (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  group_id UUID NOT NULL REFERENCES groups(id) ON DELETE CASCADE,
  paid_by UUID NOT NULL REFERENCES auth.users(id),
  amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
  short_description TEXT NOT NULL,
  long_description TEXT,
  receipt_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Payments table
CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  group_id UUID NOT NULL REFERENCES groups(id) ON DELETE CASCADE,
  from_user UUID NOT NULL REFERENCES auth.users(id),
  to_user UUID NOT NULL REFERENCES auth.users(id),
  amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CHECK (from_user != to_user)
);

-- Row Level Security Policies

-- Groups
ALTER TABLE groups ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view groups they are members of" ON groups
  FOR SELECT USING (
    auth.uid() IN (
      SELECT user_id FROM group_members WHERE group_id = id
    )
  );

CREATE POLICY "Any user can create a group" ON groups
  FOR INSERT WITH CHECK (
    auth.uid() = created_by
  );

CREATE POLICY "Only group creator can update group" ON groups
  FOR UPDATE USING (
    auth.uid() = created_by
  );

-- Group Members
ALTER TABLE group_members ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view members of their groups" ON group_members
  FOR SELECT USING (
    auth.uid() IN (
      SELECT user_id FROM group_members WHERE group_id = group_members.group_id
    )
  );

CREATE POLICY "Users can join groups" ON group_members
  FOR INSERT WITH CHECK (
    auth.uid() = user_id
  );

-- Expenses
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view expenses in their groups" ON expenses
  FOR SELECT USING (
    auth.uid() IN (
      SELECT user_id FROM group_members WHERE group_id = expenses.group_id
    )
  );

CREATE POLICY "Users can add expenses to their groups" ON expenses
  FOR INSERT WITH CHECK (
    auth.uid() IN (
      SELECT user_id FROM group_members WHERE group_id = expenses.group_id
    )
  );

-- Payments
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view payments in their groups" ON payments
  FOR SELECT USING (
    auth.uid() IN (
      SELECT user_id FROM group_members WHERE group_id = payments.group_id
    )
  );

CREATE POLICY "Users can add payments in their groups" ON payments
  FOR INSERT WITH CHECK (
    auth.uid() IN (
      SELECT user_id FROM group_members WHERE group_id = payments.group_id
    )
  );
