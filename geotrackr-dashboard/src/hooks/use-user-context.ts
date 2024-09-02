import { useContext } from "react";
import { UserContext, UserContextType } from "./user-context-types";

export const useUserContext = (): UserContextType => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error("useUserContext must be used within a UserProvider");
  }
  return context;
};
