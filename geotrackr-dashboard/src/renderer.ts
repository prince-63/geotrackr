const minimizeButton = document.getElementById("minimize");
const maximizeButton = document.getElementById("maximize");
const closeButton = document.getElementById("close");

if (minimizeButton) {
  minimizeButton.addEventListener("click", () => {
    window.ipcRenderer.send("minimize-window");
  });
}

if (maximizeButton) {
  maximizeButton.addEventListener("click", () => {
    window.ipcRenderer.send("maximize-window");
  });
}

if (closeButton) {
  closeButton.addEventListener("click", () => {
    window.ipcRenderer.send("close-window");
  });
}