
import InOfficeEmployee from "./in-office-employee";
import OutOfficeEmployee from "./out-office-employee";
const EmployeesPage = () => {
  return (
    <div className="p-4 h-full">
      <InOfficeEmployee />
      <OutOfficeEmployee />
    </div>
  );
};

export default EmployeesPage;