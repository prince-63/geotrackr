import { ipcRenderer, contextBridge, IpcRendererEvent } from "electron";

// --------- Expose some API to the Renderer process ---------
contextBridge.exposeInMainWorld("ipcRenderer", {
  on(...args: Parameters<typeof ipcRenderer.on>) {
    const [channel, listener] = args;
    return ipcRenderer.on(channel, (event: IpcRendererEvent, ...args: []) =>
      listener(event, ...args)
    );
  },
  off(...args: Parameters<typeof ipcRenderer.off>) {
    const [channel, ...omit] = args;
    return ipcRenderer.off(channel, ...omit);
  },
  send(...args: Parameters<typeof ipcRenderer.send>) {
    const [channel, ...omit] = args;
    return ipcRenderer.send(channel, ...omit);
  },
  invoke(...args: Parameters<typeof ipcRenderer.invoke>) {
    const [channel, ...omit] = args;
    return ipcRenderer.invoke(channel, ...omit);
  },

  // You can expose other APIs you need here.
  // ...
});

contextBridge.exposeInMainWorld("electron", {
  getNonce: () => new URLSearchParams(window.location.search).get("nonce"),
  setToken: (token: string) => ipcRenderer.invoke("set-token", token),
  getToken: () => ipcRenderer.invoke("get-token"),
  removeToken: () => ipcRenderer.invoke("remove-token"),
});
