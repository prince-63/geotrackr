const jwt = require('jsonwebtoken');
const User = require('../models/userModel');
const sendEmail = require('../utils/email');
const crypto = require('crypto');

const signToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

exports.verifyEmail = async (req, res) => {
  try {
    const { code } = req.body;
    const user = req.user;

    if (user.emailVerificationCode === code) {
      user.emailVerified = true;
      user.emailVerificationCode = undefined;
      await user.save();
      res.status(200).json({ status: 'success', message: 'Email verified' });
    } else {
      res.status(400).json({ status: 'fail', message: 'Invalid verification code' });
    }
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  }
};

exports.forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;

    console.log(email);
    const user = await User.findOne({ email });

    console.log(user);
    if (!user) {
      return res.status(404).json({ status: 'fail', message: 'There is no user with that email address.' });
    }

    const resetToken = user.createPasswordResetToken();

    console.log("1");
    await user.save({ validateBeforeSave: false });

    const resetURL = `${req.protocol}://${req.get('host')}/api/v1/auth/resetPassword/${resetToken}`;
    const message = `Forgot your password? Submit a PATCH request with your new password and passwordConfirm to: ${resetURL}.\nIf you didn't forget your password, please ignore this email!`;

    await sendEmail({
      email: user.email,
      subject: 'Your password reset token (valid for 10 minutes)',
      message,
    });

    res.status(200).json({ status: 'success', message: 'Token sent to email!' });
  } catch (error) {
    res.status(500).json({ status: 'fail', message: 'There was an error sending the email. Try again later!' });
  }
};

exports.resetPassword = async (req, res) => {
  try {
    const hashedToken = crypto.createHash('sha256').update(req.params.token).digest('hex');
    const user = await User.findOne({
      passwordResetToken: hashedToken,
      passwordResetExpires: { $gt: Date.now() },
    });

    if (!user) {
      return res.status(400).json({ status: 'fail', message: 'Token is invalid or has expired' });
    }

    user.password = req.body.password;
    user.passwordResetToken = undefined;
    user.passwordResetExpires = undefined;
    await user.save();

    const token = signToken(user._id);
    res.status(200).json({ status: 'success', token });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  }
};

exports.signup = async (req, res) => {
  try {
    const { username, password, email } = req.body;
    const emailVerificationCode = Math.floor(100000 + Math.random() * 900000).toString();

    const newUser = await User.create({
      username,
      password,
      email,
      emailVerificationCode,
    });

    let subject = 'Email Verification';
    let message = `Your email verification code is ${emailVerificationCode}`;
    await sendEmail({ email, subject, message });

    const token = signToken(newUser._id);
    res.status(201).json({
      status: 'success', token, data: {
        username: newUser.username,
        email: newUser.email,
      }
    });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  }
};

exports.login = async (req, res) => {
  try {
    const { username, password } = req.body;
    const user = await User.findOne({ username }).select('+password');
    if (!user || !(await user.correctPassword(password, user.password))) {
      return res.status(401).json({ status: 'fail', message: 'Incorrect username or password' });
    }
    const token = signToken(user._id);
    res.status(200).json({ status: 'success', token });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  }
};

exports.getUserFromToken = (req, res) => {
  if (!req.user) {
    return res.status(401).json({ status: 'fail', message: 'User not found!' });
  }
  res.status(200).json({
    status: 'success',
    data: {
      user: req.user.username,
      email: req.user.email
    },
  });
};
