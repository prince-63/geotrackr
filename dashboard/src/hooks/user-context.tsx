import React, { useState, ReactNode, useEffect } from 'react';
import { UserContext } from './user-context-types';
import { officeLogin, officeSignup } from '../api-services/auth-service';

export const UserProvider: React.FC<{ children: ReactNode }> = ({
  children,
}) => {
  const [userStatus, setUserStatus] = useState<string>('offline');
  const [token, setToken] = useState<string | null>(null);

  useEffect(() => {
    const fetchToken = () => {
      const storedToken = sessionStorage.getItem('authToken');
      if (storedToken) {
        setToken(storedToken);
        setUserStatus('online');
      }
    };

    fetchToken();
  }, []);

  useEffect(() => {
    if (token) {
      // check token already stored in session storage
      if (!sessionStorage.getItem('authToken')) {
        sessionStorage.setItem('authToken', token);
      }
      setUserStatus('online');
    } else {
      sessionStorage.removeItem('authToken');
      setUserStatus('offline');
    }
  }, [token]);

  const login = async (officeEmail: string, officePassword: string) => {
    try {
      const token = await officeLogin({ officeEmail, officePassword });
      setToken(token);
      setUserStatus('online');
    } catch (error) {
      console.error('Login failed', error);
      setToken(null);
      setUserStatus('offline');
    }
  };

  const signup = async (
    officeName: string,
    officeEmail: string,
    officePassword: string
  ) => {
    try {
      const token = await officeSignup({
        officeName,
        officeEmail,
        officePassword,
      });
      setToken(token);
      setUserStatus('online');
    } catch (error) {
      console.error('Signup failed', error);
      setToken(null);
      setUserStatus('offline');
    }
  };

  const logout = async () => {
    setToken(null);
    setUserStatus('offline');
    sessionStorage.removeItem('authToken');
  };

  return (
    <UserContext.Provider
      value={{
        userStatus,
        setUserStatus,
        token,
        setToken,
        login,
        logout,
        signup,
      }}
    >
      {children}
    </UserContext.Provider>
  );
};
