import errorResponseHandler from './error-response-handlers.js';

const globalErrorHandler = (err, req, res, next) => {
  console.error(err.stack);

  if (err.name === 'ValidationError') {
    return errorResponseHandler(res, 400, 'fail', err.message);
  }

  if (err.name === 'UnauthorizedError') {
    return errorResponseHandler(res, 401, 'fail', 'Unauthorized access');
  }

  return errorResponseHandler(
    res,
    500,
    'error',
    'An unexpected error occurred'
  );
};

export default globalErrorHandler;
