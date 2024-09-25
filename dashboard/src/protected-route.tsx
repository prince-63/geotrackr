import React from 'react';
import { Navigate } from 'react-router-dom';
import { useUserContext } from './hooks/use-user-context';

interface ProtectedRouteProps {
  element: React.ReactElement;
}

const ProtectedRoute: React.FC<ProtectedRouteProps> = ({ element }) => {
  const { userStatus, token } = useUserContext();

  return userStatus === 'online' || token ? element : <Navigate to="/login" />;
};

export default ProtectedRoute;
