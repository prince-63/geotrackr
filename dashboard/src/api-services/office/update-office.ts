import ApiConfig from '../../config/api-config';

const updateOffice = async (
  {
    officeName,
    officeEmail,
    officeContactNumber,
    officeSubTitle,
    officeCity,
    officeState,
    officeCountry,
    officePincodes,
    officeLongitude,
    officeLatitude,
  }: {
    officeName: string;
    officeEmail: string;
    officeContactNumber: string;
    officeSubTitle: string;
    officeCity: string;
    officeState: string;
    officeCountry: string;
    officePincodes: string;
    officeLongitude: string;
    officeLatitude: string;
  },
  {
    token,
  }: {
    token: string | null;
  }
) => {
  const response = await fetch(`${ApiConfig.updateOffice}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify({
      officeName,
      officeEmail,
      officeContactNumber,
      officeSubTitle,
      officeCity,
      officeState,
      officeCountry,
      officePincodes,
      officeLongitude,
      officeLatitude,
    }),
  });

  console.log(response);

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  const responseBody = await response.json();
  return responseBody.data.officeDetails;
};

export default updateOffice;
