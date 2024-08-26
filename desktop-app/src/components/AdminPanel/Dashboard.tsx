import React from 'react';
import { Line, Bar } from 'react-chartjs-2';
import { Chart as ChartJS, Title, Tooltip, Legend, LineElement, PointElement, ArcElement, CategoryScale, LinearScale, BarElement } from 'chart.js';

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  PointElement,
  ArcElement,
  CategoryScale,
  LinearScale,
  BarElement
);

const lineData = {
  labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
  datasets: [
    {
      label: 'Total Sales',
      data: [65, 59, 80, 81, 56, 55, 40],
      borderColor: 'rgba(75, 192, 192, 1)',
      backgroundColor: 'rgba(75, 192, 192, 0.2)',
      fill: true,
    },
  ],
};

const barData = {
  labels: ['Q1', 'Q2', 'Q3', 'Q4'],
  datasets: [
    {
      label: 'New Users',
      data: [50, 100, 150, 200],
      backgroundColor: 'rgba(153, 102, 255, 0.2)',
      borderColor: 'rgba(153, 102, 255, 1)',
      borderWidth: 1,
    },
  ],
};

const Dashboard = () => {
  return (
    <div className="flex flex-1 px-4 pt-4">
      <main className="flex-1">
        <header className="mb-8">
          <h1 className="text-3xl font-bold text-gray-800">Dashboard Overview</h1>
        </header>
        
        

        {/* Additional Content */}
        <section className="mt-8">
          <h2 className="text-2xl font-bold text-gray-800 mb-4">Recent Activities</h2>
          <div className="bg-white shadow-md rounded-lg p-6">
            <p>Recent activity content goes here...</p>
          </div>
        </section>

        {/* Charts */}
        <section className="mt-8 grid grid-cols-1 md:grid-cols-2 gap-6">
          {/* Line Chart */}
          <div className="bg-white shadow-md rounded-lg p-4">
            <h2 className="text-xl font-semibold text-gray-700 mb-2">Sales Trends</h2>
            <Line data={lineData} />
          </div>

          {/* Bar Chart */}
          <div className="bg-white shadow-md rounded-lg p-4">
            <h2 className="text-xl font-semibold text-gray-700 mb-2">User Growth</h2>
            <Bar data={barData} />
          </div>
        </section>
      </main>
    </div>
  );
};

export default Dashboard;
