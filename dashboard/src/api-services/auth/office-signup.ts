import ApiConfig from '../../config/api-config';

const officeSignup = async ({
  officeName,
  officeEmail,
  officePassword,
}: {
  officeName: string;
  officeEmail: string;
  officePassword: string;
}) => {
  const response = await fetch(ApiConfig.officeSignup, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ officeName, officeEmail, officePassword }),
  });

  console.log(response);

  if (!response.ok) {
    const errorBody = await response.json();
    return { error: errorBody.message };
  }

  const responseBody = await response.json();
  return { token: responseBody['data']['token'], message: responseBody.message };
};

export default officeSignup;
