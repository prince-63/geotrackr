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
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  const responseBody = await response.json();
  return responseBody.data.token;
};

export default officeLogin;
