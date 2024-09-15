import ApiConfig from '../../config/api-config';

const addRemoteEmployee = async (
  {
    employeeName,
    employeeEmail,
    employeeContactNumber,
    employeeRole,
  }: {
    employeeName: string;
    employeeEmail: string;
    employeeContactNumber: string;
    employeeRole: string;
  },
  {
    token,
  }: {
    token: string | null;
  }
) => {
  const response = await fetch(ApiConfig.addRemoteEmployee, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify({
      employeeName,
      employeeEmail,
      employeeContactNumber,
      employeeRole,
    }),
  });
  console.log(response);

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  const responseBody = await response.json();
  return responseBody.data.employee;
};

export default addRemoteEmployee;
