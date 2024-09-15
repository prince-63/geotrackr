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
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  const responseBody = await response.json();
  return responseBody.data.token;
};

export default officeSignup;
