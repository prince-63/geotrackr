const errorResponseHandler = (res, errorCode, status, message) => {
    return res.status(errorCode).json({
        status: status,
        message: message,
    });
};

export default errorResponseHandler;
