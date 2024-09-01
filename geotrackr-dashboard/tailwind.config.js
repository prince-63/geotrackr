/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        placeholder: '#6B7280', // Custom placeholder color
      },
      fontWeight: {
        placeholder: '600', // Custom placeholder font weight
      },
    },
  },
  variants: {
    extend: {
      placeholderColor: ['focus'], // Enable focus variant for placeholder color
      placeholderOpacity: ['focus'], // Enable focus variant for placeholder opacity
      placeholderFontWeight: ['focus'], // Enable focus variant for placeholder font weight
    },
  },
  plugins: [],
}