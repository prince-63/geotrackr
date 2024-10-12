import { createContext } from 'react';

interface LoginResponse {
  error?: string;
  message?: string;
}

interface SignupResponse {
  error?: string;
  message?: string;
}

export interface UserContextType {
  userStatus: string;
  setUserStatus: (status: string) => void;
  token: string | null;
  setToken: (token: string | null) => void;
  login: (
    officeEmail: string,
    officePassword: string
  ) => Promise<LoginResponse>;
  logout: () => Promise<void>;
  signup: (
    officeName: string,
    officeEmail: string,
    officePassword: string
  ) => Promise<SignupResponse>;
}

export const UserContext = createContext<UserContextType | undefined>(
  undefined
);
