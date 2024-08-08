# USE FOR `.env` file

### PORT
PORT='8000'

### Database Configuration
MONGO_URI='mongodb+srv://admin:admin@cluster0.wunnp8w.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0'

### JWT Configuration
JWT_SECRET='quantum-qrcode'
JWT_EXPIRES_IN='90d'

### Email Configuration
EMAIL_USERNAME='prince08833@gmail.com'
EMAIL_PASSWORD='nxrr sash okmn opcl'
EMAIL_FROM='prince08833@gmail.com'

## Installation
1. Clone the repository.
2. Run `npm install` to install dependencies.
3. Create a `.env` file and add the necessary environment variables.
4. Run `npm run dev` to start the development server.

## Endpoints
- `POST /api/v1/auth/signup`: Sign up a new user.
- `POST /api/v1/auth/login`: Log in an existing user.
- `POST /api/v1/auth/verify-email`: Verify the user's email.
- `POST /api/v1/auth/forgotPassword`: Request a password reset.
- `PATCH /api/v1/auth/resetPassword/:token`: Reset the user's password.
- `GET /api/v1/auth/me`: Get the authenticated user's information.