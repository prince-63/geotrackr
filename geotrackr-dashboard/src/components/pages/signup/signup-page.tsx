import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import TextInput from "../../general/text-input";
import Button from "../../general/button";
import FormContainer from "../../general/form-container";
import { User, Lock, Mail } from "lucide-react";
import Typography from "../../general/typography";
import { Link } from "react-router-dom";
import LogoForPages from "../../general/logo-pages";
import SingupService from "../../../api-services/signup/signup-service";
import { useUserContext } from "../../../hooks/use-user-context";

const Signup: React.FC = () => {
  const [officeName, setOfficeName] = useState("");
  const [officeEmail, setOfficeEmail] = useState("");
  const [officePassword, setOfficePassword] = useState("");
  const { setUserStatus } = useUserContext();
  const navigate = useNavigate();

  const handleUsernameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficeName(e.target.value);
  };

  const handleEmailChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficeEmail(e.target.value);
  };

  const handlePasswordChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficePassword(e.target.value);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const response = await SingupService.signup({
        officeName,
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
      console.error("Signup failed", error);
      setUserStatus("offline");
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen">
      <FormContainer className="max-w-sm border">
        <div className="text-center mb-6">
          <LogoForPages message="Create a new office account to get started." />
        </div>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <TextInput
              type="text"
              placeholder="Name"
              value={officeName}
              onChange={handleUsernameChange}
              icon={User}
              className="w-full text-lg text-gray-700"
            />
          </div>
          <div className="mb-4">
            <TextInput
              type="email"
              placeholder="Email"
              value={officeEmail}
              onChange={handleEmailChange}
              icon={Mail}
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
          <Button
            type="submit"
            className="w-full py-2 bg-green-600 hover:bg-green-500 text-white font-medium"
          >
            Sign Up
          </Button>
        </form>
        <div className="flex justify-center items-center mt-4 space-x-2">
          <Typography variant="body3">Already have an account?</Typography>
          <Typography variant="body3" className="text-black">
            <Link
              to="/login"
              className="hover:text-blue-400 transition duration-200 ease-in-out"
            >
              Login
            </Link>
          </Typography>
        </div>
      </FormContainer>
    </div>
  );
};

export default Signup;
