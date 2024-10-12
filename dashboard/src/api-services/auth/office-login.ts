import ApiConfig from '../../config/api-config';

const officeLogin = async ({
  officeEmail,
  officePassword,
}: {
  officeEmail: string;
  officePassword: string;
}) => {
  const response = await fetch(ApiConfig.officeLogin, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ officeEmail, officePassword }),
  });

  console.log(response);

  if (!response.ok) {
    const errorBody = await response.json();
    return { error: errorBody.message };
  }

  const responseBody = await response.json();
  return {
    token: responseBody['data']['token'],
    message: responseBody.message,
  };
};

export default officeLogin;
