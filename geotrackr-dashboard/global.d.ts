interface ElectronAPI {
  setToken: (token: string) => Promise<void>;
  getToken: () => Promise<string | undefined>;
  removeToken: () => Promise<void>;
}

interface Window {
  electron: ElectronAPI;
}
