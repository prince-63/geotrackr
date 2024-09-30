import ApiConfig from "../../config/api-config";

const deleteOffice = async (
    { officeId }: { officeId: string },
    { token }: { token: string | null }
) => {
    const response = await fetch(`${ApiConfig.deleteOffice}/${officeId}`, {
        method: "DELETE",
        headers: {
            Authorization: `Bearer ${token}`,
        },
    });

    console.log(response);

    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    const responseBody = await response.json();
    return responseBody.status;
};

export default deleteOffice;