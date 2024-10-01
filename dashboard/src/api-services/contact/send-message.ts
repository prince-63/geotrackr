import ApiConfig from '../../config/api-config';

const sendMessage = async ({
  name,
  email,
  message,
}: {
  name: string;
  email: string;
  message: string;
}) => {
  const response = await fetch(ApiConfig.sendMessage, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ name, email, message }),
  });

  console.log(response);

  if (!response.ok) {
    const responseBody = await response.json();
    return { error: responseBody['message'] };
  }

  const responseBody = await response.json();
  return { success: responseBody['message'] };
};

export default sendMessage;
