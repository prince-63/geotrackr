import React from 'react';
import ReactMarkdown from 'react-markdown';
import { FaAngleLeft } from "react-icons/fa";

const Docs = () => {
    return (
        <section className="container mx-auto max-w-7xl">
            <a href="/" className="flex p-4 items-center">
                <FaAngleLeft className="text-2xl text-green-800" />
                <span className="text-green-800 text-xl font-semibold">Back to Home</span>
            </a>
            <div className="max-w-3xl mx-auto p-10 bg-gradient-to-r from-green-100 to-green-200 rounded-xl shadow-2xl">
                <h2 className="text-3xl sm:text-4xl font-bold text-center mb-8 sm:mb-10 text-gray-900">
                    📚 Employee Guidelines
                </h2>
                <div className="prose prose-xl max-w-none text-gray-800 leading-loose">
                    <ReactMarkdown>
                        {`
## 🚀 Getting Started with Our App

1. **📱 Download Our App**  
   - Start by downloading our app from the [Google Play Store](#) or [Apple App Store](#).

2. **📧 Request a Joining Email**  
   - Contact your office admin and request them to send you a joining email.

3. **🔑 Log In with Temporary Credentials**  
   - After receiving the email, log in to our app using the temporary password provided.

4. **🛠️ Set Up Your Account**  
   - Complete your account setup.
   - Change the temporary password to something secure for your safety.

5. **📋 Stay Updated with Your Tasks**  
   - All tasks assigned by the admins will automatically appear in the app under the **Tasks** section.

6. **⏰ Attendance Guidelines:**

   **a. 🌍 Out-of-Office Employees**  
   - Visit the task location specified.
   - After completing the task, verify yourself using biometrics to mark your attendance.
   - **Note:** It might take a little time to update the task as completed.

   **b. 🏢 In-Office Employees**  
   - Your check-in and check-out will be automatic when you enter or leave the office within a 200-meter radius.
   - Total working hours will be calculated automatically.
                        `}
                    </ReactMarkdown>
                </div>
            </div>
        </section>
    );
}

export default Docs;
