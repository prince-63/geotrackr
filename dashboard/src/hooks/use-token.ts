import { useUserContext } from './use-user-context';

const useToken = () => {
  const { token } = useUserContext();
  return token;
};

export default useToken;
