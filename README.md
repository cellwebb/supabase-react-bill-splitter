# Bill Splitter App

A collaborative bill-splitting application built with React, Deno, and Supabase.

## Features

- Create and join expense groups
- Add bills and expenses with descriptions and receipts
- Track payments between group members
- Automatic calculation of who owes what
- Secure group invitations

## Tech Stack

- Frontend: React with TypeScript
- Backend: Deno
- Database: Supabase
- UI: Tailwind CSS

## Prerequisites

- Node.js (v18 or higher)
- npm or yarn
- A Supabase account

## Installation

1. Clone the repository

   ```bash
   git clone https://github.com/yourusername/supabase-react-bill-splitter.git
   cd supabase-react-bill-splitter
   ```

2. Install dependencies

   ```bash
   npm install
   ```

3. Set up environment variables

   ```bash
   cp .env.example .env
   ```

   Then edit `.env` with your Supabase credentials:

   ```bash
   VITE_SUPABASE_URL="your-supabase-url"
   VITE_SUPABASE_ANON_KEY="your-supabase-anon-key"
   ```

4. Set up the database
   - Go to your Supabase project dashboard
   - Navigate to the SQL editor
   - Copy the contents of `supabase/schema.sql`
   - Run the SQL to create the necessary tables and policies

## Development

Start the development server:

```bash
npm run dev
```

The app will be available at `http://localhost:5173`

## Project Structure

```bash
src/
  ├── components/    # React components
  ├── hooks/         # Custom React hooks
  ├── pages/         # Page components
  ├── services/      # API and Supabase services
  ├── types/         # TypeScript types
  └── utils/         # Utility functions
```

## Usage

1. Sign up/Sign in using your email (magic link authentication)
2. Create a new expense group or join an existing one
3. Add expenses to your group:
   - Enter amount and description
   - Optionally add a receipt image
   - The app will automatically calculate splits
4. Track payments between group members
5. View your balance and settlement suggestions

## Deployment

1. Build the application:

   ```bash
   npm run build
   ```

2. Deploy to your preferred hosting service (e.g., Vercel, Netlify):
   - Configure build settings:
     - Build command: `npm run build`
     - Output directory: `dist`
   - Set up environment variables in your hosting platform

## Contributing

1. Fork the repository
2. Create your feature branch

   ```bash
   git checkout -b feature/AmazingFeature
   ```

3. Commit your changes

   ```bash
   git commit -m 'Add some AmazingFeature'
   ```

4. Push to the branch

   ```bash
   git push origin feature/AmazingFeature
   ```

5. Open a Pull Request

## Security

- Authentication is handled by Supabase
- Row Level Security (RLS) policies protect data access
- Environment variables are properly configured for client-side safety
- All database queries use parameterized inputs

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Supabase](https://supabase.io/) for the backend infrastructure
- [React](https://reactjs.org/) for the frontend framework
- [Tailwind CSS](https://tailwindcss.com/) for styling
- [Vite](https://vitejs.dev/) for the build tool
