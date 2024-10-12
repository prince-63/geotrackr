import ApiConfig from '../../config/api-config';

const getEmployeeAttandances = async (token: string) => {
    const response = await fetch(ApiConfig.employeeAttandances, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`
        }

    });

    if (response.ok) {
        const data = await response.json();
        return data;
    }

    return response.statusText;
}

export default getEmployeeAttandances;