import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import App from './App.tsx';
import './index.css';
import { UserProvider } from './hooks/user-context.tsx';
import { Providers } from './lib/providers.tsx';

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <UserProvider>
      <Providers>
        <App />
      </Providers>
    </UserProvider>
  </StrictMode>
);
