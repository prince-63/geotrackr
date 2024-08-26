import React from 'react'

const Settings = () => {
    return (
        <div className="flex flex-1">
            <main className="flex-1 p-6">
                <header className="mb-8">
                    <h1 className="text-3xl font-bold text-gray-800">Settings</h1>
                </header>
                <section className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
                    {/* Card 1 */}
                    <div className="bg-white shadow-md rounded-lg p-4">
                        <h2 className="text-xl font-semibold text-gray-700 mb-2">Change Password</h2>
                        <p className="text-2xl font-bold text-gray-900">********</p>
                    </div>
                    {/* Card 2 */}
                    <div className="bg-white shadow-md rounded-lg p-4">
                        <h2 className="text-xl font-semibold text-gray-700 mb-2">Change Email</h2>
                        <p className="text-2xl font-bold text-gray-900">********</p>
                    </div>
                    {/* Card 3 */}
                    <div className="bg-white shadow-md rounded-lg p-4">
                        <h2 className="text-xl font-semibold text-gray-700 mb-2">Change Username</h2>
                        <p className="text-2xl font-bold text-gray-900">********</p>
                    </div>
                </section>
            </main>

        </div>
    )
}

export default Settings