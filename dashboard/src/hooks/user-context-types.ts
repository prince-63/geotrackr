import { createContext } from 'react';

export interface UserContextType {
  userStatus: string;
  setUserStatus: (status: string) => void;
  token: string | null;
  setToken: (token: string | null) => void;
  login: (officeEmail: string, officePassword: string) => Promise<void>;
  logout: () => Promise<void>;
  signup: (
    officeName: string,
    officeEmail: string,
    officePassword: string
  ) => Promise<void>;
}

export const UserContext = createContext<UserContextType | undefined>(
  undefined
);
