import ApiConfig from '../../config/api-config';

const addOffice = async ({ token }: { token: string | null; }) => {
    const response = await fetch(ApiConfig.addOffice, {
        method: 'POST',
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

export default addOffice;