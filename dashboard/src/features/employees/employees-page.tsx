import OfficeEmployee from './office-employee';
import RemoteEmployee from './remote-employee';

const EmployeesPage = () => {
  return (
    <div className="p-4 h-full">
      <OfficeEmployee />
      <RemoteEmployee />
    </div>
  );
};

export default EmployeesPage;
