import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';
import { sendEmail } from '../../utils/email.js';

const sendMessage = async (req, res) => {
  const { name, email, message } = req.body;

  if (!name || !email || !message) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  try {
    await sendEmail({
      email,
      subject: 'Message from Contact Form',
      message,
    });

    return responseHandler(res, 200, 'success', 'Message sent successfully');
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', 'Failed to send message');
  }
};

export default sendMessage;
