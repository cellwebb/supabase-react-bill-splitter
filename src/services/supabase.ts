import { createClient } from "@supabase/supabase-js";

const supabaseUrl = Deno.env.get("VITE_SUPABASE_URL");
const supabaseAnonKey = Deno.env.get("VITE_SUPABASE_ANON_KEY");

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error(
    "Missing Supabase environment variables. Please check your .env file.",
  );
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export type Tables = {
  groups: {
    id: string;
    name: string;
    created_at: string;
    created_by: string;
    invite_code: string;
  };
  group_members: {
    id: string;
    group_id: string;
    user_id: string;
    joined_at: string;
  };
  expenses: {
    id: string;
    group_id: string;
    paid_by: string;
    amount: number;
    short_description: string;
    long_description?: string;
    receipt_url?: string;
    created_at: string;
  };
  payments: {
    id: string;
    group_id: string;
    from_user: string;
    to_user: string;
    amount: number;
    created_at: string;
  };
};
