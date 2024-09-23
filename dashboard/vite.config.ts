import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react-swc';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    sourcemap: true, // Enable source maps for production builds
    chunkSizeWarningLimit: 1024, // Increase chunk size warning limit to 1kb
    rollupOptions: {
      output: {
        manualChunks: {
          // Split dependencies into a separate chunk
          react: ['react', 'react-dom'],
        },
      },
    },
  },
});
