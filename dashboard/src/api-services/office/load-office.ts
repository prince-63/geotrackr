import ApiConfig from '../../config/api-config';

const loadOffice = async ({ token }: { token: string | null }) => {
  const response = await fetch(ApiConfig.loadOffice, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
  });

  console.log(response);

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  const responseBody = await response.json();
  return responseBody.data.officeDetails;
};

export default loadOffice;
