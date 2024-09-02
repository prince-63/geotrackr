import React from "react";
import { Navigate } from "react-router-dom";
import { useUserContext } from "./hooks/use-user-context";

interface ProtectedRouteProps {
  element: React.ReactElement;
}

const ProtectedRoute: React.FC<ProtectedRouteProps> = ({ element }) => {
  const { userStatus } = useUserContext();

  console.log("userStatus", userStatus);

  return userStatus === "online" ? element : <Navigate to="/login" />;
};

export default ProtectedRoute;
