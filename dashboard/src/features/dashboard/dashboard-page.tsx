import React, { useEffect } from 'react';
import { Line, Bar } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js';
import { useNavigate } from 'react-router-dom';
import { getEmployeeAttandances } from '../../api-services/employee-service';
import { useUserContext } from '../../hooks/use-user-context';

// Register necessary chart components
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Title,
  Tooltip,
  Legend
);

const DashboardPage: React.FC = () => {
  // Line Chart Data for Attendance Trends
  const attendanceData = {
    labels: Array.from({ length: 30 }, (_, i) => i + 1), // 1 to 30
    datasets: [
      {
        label: 'Attendance',
        data: [
          23, 45, 56, 78, 55, 72, 57, 21, 34, 72, 59, 72, 61, 8, 93, 39, 56, 78,
          55, 72, 57, 21, 34, 72, 59, 72, 61, 8, 93, 39,
        ],
        fill: false,
        borderColor: '#34D399', // Green tone
        tension: 0.3,
      },
    ],
  };

  // Bar Chart Data for Tasks Completion
  const tasksData = {
    labels: [
      'Jane Doe',
      'John Smith',
      'Alice Johnson',
      'Bob Brown',
      'Charlie White',
    ],
    datasets: [
      {
        label: 'Tasks Completed',
        data: [12, 19, 10, 15, 8],
        backgroundColor: [
          'rgba(54, 162, 235, 0.6)',
          'rgba(255, 99, 132, 0.6)',
          'rgba(255, 206, 86, 0.6)',
          'rgba(75, 192, 192, 0.6)',
          'rgba(153, 102, 255, 0.6)',
        ],
        borderColor: [
          'rgba(54, 162, 235, 1)',
          'rgba(255, 99, 132, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
        ],
        borderWidth: 2,
      },
    ],
  };

  // Recent Attendance Records Data
  const recentAttendance = [
    { name: 'Jane Doe', date: '2024-09-09', status: 'Present' },
    { name: 'John Smith', date: '2024-09-09', status: 'Absent' },
    { name: 'Alice Johnson', date: '2024-09-08', status: 'Present' },
    { name: 'Bob Brown', date: '2024-09-08', status: 'Present' },
    { name: 'Charlie White', date: '2024-09-07', status: 'Present' },
  ];

  const navigate = useNavigate();
  const { token } = useUserContext();
  useEffect(() => {
    const fetchEmployeeAttendances = async () => {
      try {
        if (token) {
          const response = await getEmployeeAttandances(token);
          console.log('Fetched employee attendance:', response);
        } else {
          console.error('Token is null, cannot fetch employee attendance');
        }
      } catch (error) {
        console.error('Failed to fetch employee attendance:', error);
      }
    };

    fetchEmployeeAttendances();
  }, [token]);

  const handleEmployeeProfile = () => {
    navigate('/employee-profile');
  };

  // Project Deadlines Data
  const projectDeadlines = [
    { name: 'Marketing Campaign', due: '2024-09-15' },
    { name: 'Website Redesign', due: '2024-09-25' },
    { name: 'Mobile App Launch', due: '2024-10-05' },
  ];

  // Announcements Data
  const announcements = [
    { message: 'Team meeting scheduled for 2024-09-12 at 10:00 AM.' },
    {
      message: 'Annual performance reviews to be completed by 2024-09-30.',
    },
  ];

  const [showEmployees, setShowEmployees] = React.useState(false);

  return (
    <div className="min-h-screen bg-gray-50 p-10">
      {/* Header */}
      <header className="bg-gradient-to-r from-green-400 to-blue-500 text-white p-8 rounded-xl shadow-md mb-8">
        <h1 className="text-4xl font-extrabold">Dashboard</h1>
        <p className="mt-2 text-sm opacity-90">
          Monitor key metrics and stay updated on the latest project
          developments
        </p>
      </header>

      {/* Main Content */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
        {/* Attendance Trends */}
        <div className="bg-white p-8 rounded-xl shadow-lg border border-gray-200">
          <h2 className="text-2xl font-semibold text-gray-800 mb-4">
            Attendance Trends
          </h2>
          <Line data={attendanceData} options={{ responsive: true }} />
        </div>

        {/* Task Completion */}
        <div className="bg-white p-8 rounded-xl shadow-lg border border-gray-200">
          <h2 className="text-2xl font-semibold text-gray-800 mb-4">
            Task Completion
          </h2>
          <Bar data={tasksData} options={{ responsive: true }} />
        </div>
      </div>

      {/* Recent Attendance Records */}
      <div className="bg-white p-8 rounded-xl shadow-lg border border-gray-200 mb-8">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-semibold text-gray-800 mb-4">
            Recent Attendance Records
          </h2>
          <p
            className="text-gray-700 mb-4 cursor-pointer"
            onClick={() => setShowEmployees(true)}
          >
            View all employees &rarr;
          </p>
        </div>
        <table className="w-full text-left text-sm">
          <thead className="bg-gray-100">
            <tr>
              <th className="border-b px-6 py-4">Name</th>
              <th className="border-b px-6 py-4">Date</th>
              <th className="border-b px-6 py-4">Status</th>
            </tr>
          </thead>
          <tbody>
            {recentAttendance.map((record, index) => (
              <tr key={index} className="hover:bg-gray-50">
                <td className="border-b px-6 py-4">{record.name}</td>
                <td className="border-b px-6 py-4">{record.date}</td>
                <td
                  className={`border-b px-6 py-4 ${record.status === 'Present' ? 'text-green-600' : 'text-red-600'}`}
                >
                  {record.status}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Project Deadlines */}
      <div className="bg-white p-8 rounded-xl shadow-lg border border-gray-200 mb-8">
        <h2 className="text-2xl font-semibold text-gray-800 mb-4">
          Upcoming Project Deadlines
        </h2>
        <ul className="list-disc pl-8 text-gray-700 space-y-2">
          {projectDeadlines.map((deadline, index) => (
            <li key={index}>
              <span className="font-bold">{deadline.name}</span> - Due by{' '}
              {deadline.due}
            </li>
          ))}
        </ul>
      </div>

      {/* Announcements */}
      <div className="bg-white p-8 rounded-xl shadow-lg border border-gray-200">
        <h2 className="text-2xl font-semibold text-gray-800 mb-4">
          Announcements
        </h2>
        <ul className="list-disc pl-8 text-gray-700 space-y-2">
          {announcements.map((announcement, index) => (
            <li key={index}>{announcement.message}</li>
          ))}
        </ul>
      </div>

      {/* Employees Modal */}
      {showEmployees && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
          <div className="bg-white p-8 rounded-lg shadow-lg max-w-md w-full relative">
            <h2 className="text-2xl font-bold text-gray-900 mb-6 border-b pb-2">
              All Employees
            </h2>
            <ul className="list-disc pl-5 space-y-3 text-gray-700">
              <li
                className="hover:bg-gray-100 transition-colors p-4 rounded-lg flex items-center space-x-4"
                onClick={handleEmployeeProfile}
              >
                <img
                  src="https://via.placeholder.com/40"
                  alt="Employee"
                  className="w-12 h-12 rounded-full object-cover"
                />
                <div>
                  <p className="text-lg font-semibold text-gray-900">
                    John Doe
                  </p>
                  <p className="text-sm text-gray-600">
                    24/A Central Avenue, Kolkata-700111
                  </p>
                </div>
              </li>
              <li className="hover:bg-gray-100 transition-colors p-4 rounded-lg flex items-center space-x-4">
                <img
                  src="https://via.placeholder.com/40"
                  alt="Employee"
                  className="w-12 h-12 rounded-full object-cover"
                />
                <div>
                  <p className="text-lg font-semibold text-gray-900">
                    John Smith
                  </p>
                  <p className="text-sm text-gray-600">24/A Central Avenue</p>
                </div>
              </li>
            </ul>
            <button
              className="absolute top-4 right-4 bg-red-500 text-white font-semibold px-4 py-2 rounded-lg shadow-md hover:bg-red-600 transition-all"
              onClick={() => setShowEmployees(false)}
            >
              Close
            </button>
          </div>
        </div>
      )}

      {/* Toggle Button */}
    </div>
  );
};

export default DashboardPage;
