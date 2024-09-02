import React, { useState, ReactNode, useEffect } from "react";
import { UserContext } from "./user-context-types"; // Adjust the import

export const UserProvider: React.FC<{ children: ReactNode }> = ({
  children,
}) => {
  const [userStatus, setUserStatus] = useState<string>("offline");
  const [token, setToken] = useState<string | null>(null);

  useEffect(() => {
    const fetchToken = async () => {
      const storeToken = await window.electron.getToken();
      setToken(storeToken ?? null);
    };

    fetchToken();
  }, []);

  useEffect(() => {
    if (token) {
      setUserStatus("online");
    } else {
      setUserStatus("offline");
    }
  }, [token]);

  const logout = async () => {
    await window.electron.removeToken();
    setToken(null);
    setUserStatus("offline");
  };

  return (
    <UserContext.Provider
      value={{ userStatus, setUserStatus, token, setToken, logout }}
    >
      {children}
    </UserContext.Provider>
  );
};
