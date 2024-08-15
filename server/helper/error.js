export const errorResponseHandler = (res, errorCode, status, message) => {
  return res.status(errorCode).json({
    status: status,
    message: message,
  });
};

export const responseHandler = (res, statusCode, status, message, data) => {
  return res.status(statusCode).json({
    status: status,
    message: message,
    data: data,
  });
};
