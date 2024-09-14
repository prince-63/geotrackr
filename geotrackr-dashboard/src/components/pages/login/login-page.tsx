import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import TextInput from "../../general/text-input";
import Button from "../../general/button";
import FormContainer from "../../general/form-container";
import { User, Lock } from "lucide-react";
import Typography from "../../general/typography";
import { Link } from "react-router-dom";
import LogoForPages from "../../general/logo-pages";
import LoginService from "../../../api-services/login/login-service";
import { useUserContext } from "../../../hooks/use-user-context";

const Login: React.FC = () => {
  const [officeEmail, setOfficeEmail] = useState("");
  const [officePassword, setOfficePassword] = useState("");
  const { setUserStatus } = useUserContext();
  const navigate = useNavigate();

  const handleUsernameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficeEmail(e.target.value);
  };

  const handlePasswordChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficePassword(e.target.value);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const response = await LoginService.login({
        officeEmail,
        officePassword,
      });

      if (response) {
        const token = response.data.token;
        await window.electron.setToken(token);
        setUserStatus("online");
        navigate("/dashboard");
      }
    } catch (error) {
      console.error("Login failed", error);
      setUserStatus("offline");
    }
  };

  return (
      <div className="flex items-center justify-center min-h-screen ">
        <FormContainer className="max-w-sm border">
          <div className="text-center mb-6">
            <LogoForPages message="Login to your office account." />
          </div>
          <form onSubmit={handleSubmit}>
            <div className="mb-4">
              <TextInput
                type="text"
                placeholder="Email"
                value={officeEmail}
                onChange={handleUsernameChange}
                icon={User}
                className="w-full text-lg text-gray-700"
              />
            </div>
            <div className="mb-4">
              <TextInput
                type="password"
                placeholder="Password"
                value={officePassword}
                onChange={handlePasswordChange}
                icon={Lock}
                className="w-full text-lg text-gray-700"
              />
            </div>
            <div className="flex justify-end my-2">
              <Typography
                variant="body3"
                className="text-black hover:text-blue-400 transition duration-200 ease-in-out"
              >
                <Link to="/forgot-password">Forgot password?</Link>
              </Typography>
            </div>
            <Button
              type="submit"
              className="w-full py-2 bg-green-600 hover:bg-green-500 text-white font-medium"
            >
              Login
            </Button>
          </form>
          <div className="flex justify-center items-center mt-4 space-x-2">
            <Typography variant="body3">Don't have an account?</Typography>
            <Typography variant="body3" className="text-black">
              <Link
                to="/signup"
                className="hover:text-blue-400 transition duration-200 ease-in-out"
              >
                Sign up
              </Link>
            </Typography>
          </div>
        </FormContainer>
      </div>
  );
};

export default Login;
