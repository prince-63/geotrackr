import { createContext } from "react";

export interface UserContextType {
  userStatus: string;
  setUserStatus: (status: string) => void;
  token: string | null;
  setToken: (token: string | null) => void;
  logout: () => void;
}

export const UserContext = createContext<UserContextType | undefined>(undefined);