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
    const response = await officeLogin({ officeEmail, officePassword });
    if (response.error) {
      return response;
    }
    setToken(response.token);
    setUserStatus('online');
    return response;
  };

  const signup = async (
    officeName: string,
    officeEmail: string,
    officePassword: string
  ) => {
    const response = await officeSignup({
      officeName,
      officeEmail,
      officePassword,
    });

    if (response.error) {
      return { error: response.error };
    }

    setToken(response.token);
    setUserStatus('online');

    return { message: response.message };
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
