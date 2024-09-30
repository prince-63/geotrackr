import { useEffect, useState } from 'react';
import { Bar, Line } from 'react-chartjs-2';
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    BarElement,
    Title,
    Tooltip,
    Legend,
    LineElement,
    PointElement,
} from 'chart.js';

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, LineElement, PointElement);

const generateRandomOfficeData = (id: number) => {
    const officeNames = ['Headquarters', 'Branch Office', 'Regional Office', 'Division Office', 'Local Office', 'Field Office'];
    const locations = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia'];
    const managerNames = ['John Doe', 'Jane Smith', 'Alice Johnson', 'Bob Brown', 'Charlie White', 'David Black'];
    
    return {
        officeId: id.toString(),
        officeName: officeNames[id - 1],
        officeLocation: locations[id - 1],
        officeContactNumber: `555-0${id}00`,
        officeManager: managerNames[id - 1],
        profit: Math.floor(Math.random() * 1000000),
        growth: Math.floor(Math.random() * 30),
        employeeCount: Math.floor(Math.random() * 100) + 20,
        expenses: Math.floor(Math.random() * 500000),
    };
};

const DashboardPage = () => {
    interface Office {
        officeId: string;
        officeName: string;
        officeLocation: string;
        officeContactNumber: string;
        officeManager: string;
        profit: number;
        growth: number;
        employeeCount: number;
        expenses: number;
    }

    const [offices, setOffices] = useState<Office[]>([]);

    useEffect(() => {
        const realisticOffices: Office[] = Array.from({ length: 5 }, (_, index) => generateRandomOfficeData(index + 1));
        setOffices(realisticOffices);
    }, []);

    const totalOffices = offices.length;
    const uniqueLocations = Array.from(new Set(offices.map(office => office.officeLocation))).length;
    const totalProfit = offices.reduce((acc, office) => acc + (office.profit || 0), 0);
    const averageProfit = totalOffices ? (totalProfit / totalOffices).toFixed(2) : 0;
    const totalGrowth = offices.reduce((acc, office) => acc + (office.growth || 0), 0);
    const averageGrowth = totalOffices ? (totalGrowth / totalOffices).toFixed(2) : 0;
    const totalEmployees = offices.reduce((acc, office) => acc + (office.employeeCount || 0), 0);
    const totalExpenses = offices.reduce((acc, office) => acc + (office.expenses || 0), 0);
    
    const profitMargin = totalExpenses ? ((totalProfit / totalExpenses) * 100).toFixed(2) : 0;
    const expensesPerEmployee = totalEmployees ? (totalExpenses / totalEmployees).toFixed(2) : 0;

    const profitData = {
        labels: offices.map(office => office.officeName),
        datasets: [
            {
                label: 'Profit',
                data: offices.map(office => office.profit),
                backgroundColor: 'rgba(75, 192, 192, 0.6)',
            },
        ],
    };

    const growthData = {
        labels: offices.map(office => office.officeName),
        datasets: [
            {
                label: 'Growth (%)',
                data: offices.map(office => office.growth),
                borderColor: 'rgba(153, 102, 255, 1)',
                backgroundColor: 'rgba(153, 102, 255, 0.5)',
                fill: true,
            },
        ],
    };

    // New Charts
    const employeePerformanceData = {
        labels: offices.map(office => office.officeName),
        datasets: [
            {
                label: 'Employee Count',
                data: offices.map(office => office.employeeCount),
                backgroundColor: 'rgba(255, 159, 64, 0.6)',
                borderColor: 'rgba(255, 159, 64, 1)',
                borderWidth: 1,
                fill: false,
                yAxisID: 'y',
            },
            {
                label: 'Profit',
                data: offices.map(office => office.profit),
                backgroundColor: 'rgba(75, 192, 192, 0.6)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1,
                fill: false,
                yAxisID: 'y1',
            },
        ],
    };

    const officeRankingData = {
        labels: offices.map(office => office.officeName),
        datasets: [
            {
                label: 'Profit Ranking',
                data: offices.sort((a, b) => b.profit - a.profit).map((office, index) => index + 1),
                backgroundColor: 'rgba(153, 102, 255, 0.6)',
            },
        ],
    };

    return (
        <div className="p-6 bg-gray-50">
            <h1 className="text-3xl font-bold mb-4 text-blue-600">Office Management Dashboard</h1>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-4">
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Total Offices</h2>
                    <p className="text-2xl font-bold text-blue-500">{totalOffices}</p>
                </div>
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Unique Locations</h2>
                    <p className="text-2xl font-bold text-green-500">{uniqueLocations}</p>
                </div>
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Total Profit</h2>
                    <p className="text-2xl font-bold text-yellow-500">${totalProfit.toFixed(2)}</p>
                </div>
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Average Profit per Office</h2>
                    <p className="text-2xl font-bold text-purple-500">${averageProfit}</p>
                </div>
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Total Growth</h2>
                    <p className="text-2xl font-bold text-orange-500">{totalGrowth.toFixed(2)}%</p>
                </div>
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Average Growth per Office</h2>
                    <p className="text-2xl font-bold text-teal-500">{averageGrowth}%</p>
                </div>
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Total Employees</h2>
                    <p className="text-2xl font-bold text-indigo-500">{totalEmployees}</p>
                </div>
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Total Expenses</h2>
                    <p className="text-2xl font-bold text-red-500">${totalExpenses.toFixed(2)}</p>
                </div>
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Profit Margin (%)</h2>
                    <p className="text-2xl font-bold text-blue-500">{profitMargin}%</p>
                </div>
                <div className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-semibold text-gray-700">Expenses per Employee</h2>
                    <p className="text-2xl font-bold text-green-500">${expensesPerEmployee}</p>
                </div>
            </div>
            <div className="flex flex-wrap justify-between mb-6">
                <div className="w-full md:w-1/2 mb-4 p-6">
                    <h2 className="text-xl font-semibold mb-4">Employee Count vs. Profit</h2>
                    <Line data={employeePerformanceData} options={{
                        scales: {
                            y: {
                                title: {
                                    display: true,
                                    text: 'Employee Count',
                                },
                            },
                            y1: {
                                title: {
                                    display: true,
                                    text: 'Profit',
                                },
                                position: 'right',
                            },
                        },
                    }} />
                </div>
                <div className="w-full md:w-1/2 mb-4 p-6">
                    <h2 className="text-xl font-semibold mb-4">Office Ranking by Profit</h2>
                    <Bar data={officeRankingData} options={{
                        scales: {
                            y: {
                                title: {
                                    display: true,
                                    text: 'Ranking',
                                },
                            },
                        },
                    }} />
                </div>
            </div>
            <div className="flex flex-wrap justify-between mb-6">
                <div className="w-full md:w-1/2 mb-4 p-6">
                    <h2 className="text-xl font-semibold mb-4">Profit Chart</h2>
                    <Bar data={profitData} />
                </div>
                <div className="w-full md:w-1/2 mb-4 p-6">
                    <h2 className="text-xl font-semibold mb-4">Growth Chart</h2>
                    <Line data={growthData} />
                </div>
            </div>
        </div>
    );
};

export default DashboardPage;
