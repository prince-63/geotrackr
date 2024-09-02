import { app, BrowserWindow, ipcMain } from "electron";
import { createRequire } from "module";
import { fileURLToPath } from "url";
import path from "path";
import dotenv from "dotenv";
import process from "process";
import Store from "electron-store";

const store = new Store();

// Load environment variables from .env file
dotenv.config();

// This is a workaround for the fact that Node.js doesn't support ESM in the main process.
createRequire(import.meta.url);

// Set the APP_ROOT environment variable to the absolute path of the project root.
const __dirname = path.dirname(fileURLToPath(import.meta.url));
process.env.APP_ROOT = process.env.APP_ROOT || path.join(__dirname, "..");

// Load environment variables from .env files.
const VITE_DEV_SERVER_URL = process.env["VITE_DEV_SERVER_URL"];
const MAIN_DIST = path.join(process.env.APP_ROOT, "main.js");
const RENDERER_DIST = path.join(process.env.APP_ROOT, "..", "dist");
process.env.VITE_PUBLIC = VITE_DEV_SERVER_URL
  ? path.join(process.env.APP_ROOT, "..", "public")
  : RENDERER_DIST;

let win: BrowserWindow | null;
function createWindow() {
  win = new BrowserWindow({
    icon: path.join(__dirname, "../assets/fab-icons/favicon.ico"),
    webPreferences: {
      preload: path.join(__dirname, "preload.mjs"),
    },
    autoHideMenuBar: true, // Add this line to auto-hide the menu bar
    frame: false,
  });

  win.webContents.on("did-finish-load", () => {
    win?.webContents.send("main-process-message", new Date().toLocaleString());
  });

  if (VITE_DEV_SERVER_URL) {
    win.loadURL(VITE_DEV_SERVER_URL);
  } else {
    win.loadFile(path.join(RENDERER_DIST, "index.html"));
  }

  // Explicitly hide the menu bar
  win.setMenuBarVisibility(false);
}

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
    win = null;
  }
});

app.on("activate", () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});

app.whenReady().then(() => {
  createWindow();
});

ipcMain.handle("set-token", async (_event, token) => {
  store.set("jwtToken", token);
});

ipcMain.handle("get-token", () => {
  return store.get("jwtToken");
});

ipcMain.handle("remove-token", () => {
  store.delete("jwtToken");
});

// IPC handlers for window controls
ipcMain.on("minimize-window", () => {
  win?.minimize();
});

ipcMain.on("maximize-window", () => {
  if (win?.isMaximized()) {
    win.unmaximize();
  } else {
    win?.maximize();
  }
});

ipcMain.on("close-window", () => {
  win?.close();
});


export { MAIN_DIST, RENDERER_DIST, VITE_DEV_SERVER_URL };
