const Content = () => {
    return (
        <div className="p-8 font-sans bg-gray-50 min-h-screen">
            <div className="max-w-4xl mx-auto bg-white shadow-lg rounded-lg p-8">
                <h1 className="text-4xl font-bold mb-8 text-center text-gray-800">How To Use</h1>
                <p className="text-lg mb-8 text-gray-700 leading-relaxed">
                    The application utilizes advanced geolocation technology to
                    accurately record employee check-in and check-out times, along
                    with their exact location as they enter and leave office
                    premises. This innovation enhances operational efficiency,
                    reduces manual attendance tracking errors, and provides
                    employees with a seamless experience for managing their
                    work-related movements.
                </p>

                <h2 className="text-3xl font-semibold mb-6 text-gray-800">
                    Key Features of the Application:
                </h2>

                <div className="space-y-6">
                    <div>
                        <h3 className="text-2xl font-semibold mb-2 text-gray-800">
                            1. Geolocation-Based Check-In and Check-Out
                        </h3>
                        <p className="text-lg text-gray-700 leading-relaxed">
                            The app automatically records an employee&apos;s check-in time
                            and location when they enter within a 200-meter radius of the
                            office. It also records check-out times as they exit this
                            radius, ensuring each check-in is paired with a corresponding
                            check-out, regardless of the frequency of entries and exits.
                        </p>
                    </div>

                    <div>
                        <h3 className="text-2xl font-semibold mb-2 text-gray-800">
                            2. Manual Location Check-In/Check-Out for Offsite Work
                        </h3>
                        <p className="text-lg text-gray-700 leading-relaxed">
                            For employees working offsite, the app provides a manual
                            check-in and check-out feature. It automatically suggests
                            relevant locations based on real-time longitude and latitude
                            data, allowing employees to confirm their check-in and check-out
                            at these suggested locations.
                        </p>
                    </div>

                    <div>
                        <h3 className="text-2xl font-semibold mb-2 text-gray-800">
                            3. Offline Attendance Tracking
                        </h3>
                        <p className="text-lg text-gray-700 leading-relaxed">
                            To ensure continuous functionality even without internet
                            connectivity, the app includes offline attendance tracking.
                            Employees can record their check-in and check-out times offline,
                            which will be automatically synced to the server once the device
                            is back online. This feature guarantees that no attendance data
                            is lost due to connectivity issues.
                        </p>
                    </div>

                    <div>
                        <h3 className="text-2xl font-semibold mb-2 text-gray-800">
                            4. Blockchain Implementation for Data Integrity
                        </h3>
                        <p className="text-lg text-gray-700 leading-relaxed">
                            To enhance data security and integrity, the app implements
                            blockchain technology for recording attendance data. This
                            ensures that each check-in and check-out entry is securely
                            stored in a tamper-proof ledger, providing a transparent and
                            immutable record of attendance events. This approach enhances
                            trust and reliability in attendance management.
                        </p>
                    </div>

                    <div>
                        <h3 className="text-2xl font-semibold mb-2 text-gray-800">
                            5. Total Working Hours Calculation
                        </h3>
                        <p className="text-lg text-gray-700 leading-relaxed">
                            The application calculates the total working hours for each
                            employee based on their check-in and check-out data, ensuring
                            accurate tracking of work hours. Data Accuracy and Integrity:
                            The application features real-time data synchronization and
                            secure storage to maintain accurate and tamper-proof records of
                            all check-in and check-out events. This prevents data loss and
                            ensures the reliability of attendance records.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Content;