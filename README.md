# Setting Up Flutter on Your System

To set up Flutter on your system, follow these steps:

## 1. System Requirements

Ensure your system meets the following requirements:

- **Operating System**: Windows, macOS, or Linux
- **Disk Space**: 2.8 GB (does not include disk space for IDE/tools)
- **Tools**: Git for Windows (if on Windows)

## 2. Install Flutter

1. **Download Flutter SDK**:

   - Go to the [Flutter SDK download page](https://flutter.dev/docs/get-started/install) and download the appropriate version for your operating system.

2. **Extract the Flutter SDK**:

   - Extract the downloaded zip file and place the contained `flutter` directory in a desired installation location (e.g., `C:\src\flutter` on Windows).

3. **Update Your Path**:

   - Add the `flutter/bin` directory to your system's PATH environment variable.

   - **Windows**:

     1. Open the Start Search, type in "env", and select "Edit the system environment variables".
     2. In the System Properties window, click on the "Environment Variables" button.
     3. Under "System variables", find the `Path` variable, select it, and click "Edit".
     4. Click "New" and add the path to the `flutter/bin` directory.
     5. Click "OK" to close all windows.

   - **macOS** and **Linux**:
     1. Open a terminal.
     2. Edit your shell profile (`.bashrc`, `.zshrc`, etc.) and add the following line:
        ```sh
        export PATH="$PATH:<path-to-flutter-directory>/flutter/bin"
        ```
     3. Run `source <your-shell-profile>` to apply the changes.

## 3. Verify Installation

1. **Run `flutter doctor`**:
   - Open a terminal or command prompt.
   - Run the following command to check if there are any dependencies you need to install to complete the setup:
     ```sh
     flutter doctor
     ```
   - Follow the instructions provided by `flutter doctor` to install any missing dependencies.

## 4. Set Up an Editor

- **Visual Studio Code**:

  1. Install [Visual Studio Code](https://code.visualstudio.com/).
  2. Install the Flutter and Dart plugins:
     - Open Visual Studio Code.
     - Go to the Extensions view by clicking on the Extensions icon in the Activity Bar on the side of the window.
     - Search for "Flutter" and click "Install".
     - Search for "Dart" and click "Install".

- **Android Studio**:
  1. Install [Android Studio](https://developer.android.com/studio).
  2. Install the Flutter and Dart plugins:
     - Open Android Studio.
     - Go to `File > Settings > Plugins`.
     - Search for "Flutter" and click "Install".
     - Search for "Dart" and click "Install".

## 5. Create a New Flutter Project

1. **Using Visual Studio Code**:

   - Open Visual Studio Code.
   - Press `Ctrl+Shift+P` to open the command palette.
   - Type [`Flutter: New Project`](command:_github.copilot.openSymbolFromReferences?%5B%22Flutter%3A%20New%20Project%22%2C%5B%7B%22uri%22%3A%7B%22%24mid%22%3A1%2C%22fsPath%22%3A%22c%3A%5C%5CUsers%5C%5Cprinc%5C%5COneDrive%5C%5CDesktop%5C%5Cid-card%5C%5CREADME.md%22%2C%22_sep%22%3A1%2C%22external%22%3A%22file%3A%2F%2F%2Fc%253A%2FUsers%2Fprinc%2FOneDrive%2FDesktop%2Fid-card%2FREADME.md%22%2C%22path%22%3A%22%2FC%3A%2FUsers%2Fprinc%2FOneDrive%2FDesktop%2Fid-card%2FREADME.md%22%2C%22scheme%22%3A%22file%22%7D%2C%22pos%22%3A%7B%22line%22%3A76%2C%22character%22%3A27%7D%7D%5D%5D "Go to definition") and select it.
   - Follow the prompts to create a new Flutter project.

2. **Using Android Studio**:
   - Open Android Studio.
   - Click on [`Start a new Flutter project`](command:_github.copilot.openSymbolFromReferences?%5B%22Start%20a%20new%20Flutter%20project%22%2C%5B%7B%22uri%22%3A%7B%22%24mid%22%3A1%2C%22fsPath%22%3A%22c%3A%5C%5CUsers%5C%5Cprinc%5C%5COneDrive%5C%5CDesktop%5C%5Cid-card%5C%5CREADME.md%22%2C%22_sep%22%3A1%2C%22external%22%3A%22file%3A%2F%2F%2Fc%253A%2FUsers%2Fprinc%2FOneDrive%2FDesktop%2Fid-card%2FREADME.md%22%2C%22path%22%3A%22%2FC%3A%2FUsers%2Fprinc%2FOneDrive%2FDesktop%2Fid-card%2FREADME.md%22%2C%22scheme%22%3A%22file%22%7D%2C%22pos%22%3A%7B%22line%22%3A76%2C%22character%22%3A35%7D%7D%5D%5D "Go to definition").
   - Follow the prompts to create a new Flutter project.

Your Flutter setup is now complete! You can start building your Flutter applications.

# Setting Up Node.js on Your System

To set up Node.js on your system, follow these steps:

## 1. Download Node.js

1. **Go to the Node.js Download Page**:

   - Visit the [Node.js official website](https://nodejs.org/).

2. **Choose the Version**:
   - Download the LTS (Long Term Support) version for stability, or the Current version for the latest features.

## 2. Install Node.js

1. **Windows**:

   - Run the downloaded installer.
   - Follow the prompts in the installer (accept the license agreement, choose the installation path, etc.).
   - Ensure that the option to add Node.js to your PATH is selected.

2. **macOS**:

   - Open the downloaded `.pkg` file.
   - Follow the prompts in the installer (accept the license agreement, choose the installation path, etc.).

3. **Linux**:
   - Open a terminal.
   - Use a package manager to install Node.js. For example, on Ubuntu, you can use:
     ```sh
     sudo apt update
     sudo apt install nodejs npm
     ```

## 3. Verify Installation

1. **Check Node.js Version**:

   - Open a terminal or command prompt.
   - Run the following command to check the installed version of Node.js:
     ```sh
     node -v
     ```

2. **Check npm Version**:
   - Run the following command to check the installed version of npm (Node Package Manager):
     ```sh
     npm -v
     ```

## 4. Update npm (Optional)

- You can update npm to the latest version using the following command:
  ```sh
  npm install -g npm
  ```

# To run this project in your system follow these steps:

1. **clone the repo**:
   - Clone the repository using the following command:
     ```sh
     git clone https://github.com/prince-63/id-card
     ```
2. **Navigate to the Project Directory**:
   - Go to the project directory using the following command:
     ```sh
     cd id-card
     ```
3. **Run the Project**:
   - **for running server**
   - Go to the server directory using the following command:
     ```sh
     cd server
     ```
   - Install the required dependencies using the following command:
     ```sh
       npm install
     ```
   - Start the server using the following command:
     ```sh
       npm run dev
     ```
   - **for running flutter app**
   - Go to the flutter app directory using the following command:
     ```sh
     cd app
     ```
   - Connect a physical device via USB and enable USB debugging, or start an emulator.
   - Install the required dependencies using the following command:
     ```sh
       flutter pub get
     ```
   - Run the app using the following command:
     ```sh
       flutter run
     ```

## You have successfully set up the project on your system. Happy coding! 🚀

## Help & Support
## 1. Prince Kumar Prasad
Phone: +91 6289296197
Email: prince08833@gmail.com
## 2. Rupankar Das
Phone: +91 7439528452
Email: rupankardas53@gmail.com