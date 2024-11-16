import { BrowserRouter as Router } from 'react-router-dom';
import { Auth } from './components/Auth';
import { useAuth } from './hooks/useAuth';

function App() {
  const { user, loading } = useAuth();

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <div className="text-lg">Loading...</div>
      </div>
    );
  }

  if (!user) {
    return <Auth />;
  }

  return (
    <Router>
      <div>
        {/* We'll add the main app layout and routes here in the next commit */}
        <div className="min-h-screen bg-gray-100">
          <div className="py-10">
            <header>
              <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                <h1 className="text-3xl font-bold leading-tight tracking-tight text-gray-900">
                  Welcome to Bill Splitter
                </h1>
              </div>
            </header>
            <main>
              <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
                {/* Main content will go here */}
              </div>
            </main>
          </div>
        </div>
      </div>
    </Router>
  );
}

export default App;
