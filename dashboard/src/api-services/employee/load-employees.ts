import ApiConfig from '../../config/api-config';

const loadEmployees = async ({ token }: { token: string | null }) => {
  const response = await fetch(ApiConfig.getEmployees, {
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
  return responseBody.data.employees;
};

export default loadEmployees;
