import React, { useState, ReactNode, useEffect } from 'react';
import { UserContext } from './user-context-types';
import { officeLogin, officeSignup } from '../api-services/auth-service';

export const UserProvider: React.FC<{ children: ReactNode }> = ({
  children,
}) => {
  const [userStatus, setUserStatus] = useState<string>('offline');
  const [token, setToken] = useState<string | null>(null);

  useEffect(() => {
    const fetchToken = async () => {
      const storedToken = localStorage.getItem('authToken');
      if (storedToken) {
        setToken(storedToken);
      }
    };

    fetchToken();
  }, []);

  useEffect(() => {
    if (token) {
      setUserStatus('online');
      localStorage.setItem('authToken', token);
    } else {
      setUserStatus('offline');
      localStorage.removeItem('authToken');
    }
  }, [token]);

  const login = async (officeEmail: string, officePassword: string) => {
    try {
      const token = await officeLogin({ officeEmail, officePassword });
      setToken(token);
    } catch (error) {
      console.error('Login failed', error);
      setToken(null);
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
    } catch (error) {
      console.error('Signup failed', error);
      setToken(null);
    }
  };

  const logout = async () => {
    setToken(null);
    setUserStatus('offline');
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
