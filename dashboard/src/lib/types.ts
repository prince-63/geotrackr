import { ComponentType } from 'react';

export type DASHBOARD_SIDEBAR_LINKS_TYPE = {
  title: string;
  icon: ComponentType<{ className?: string }>;
  link: string;
}[];

export type EmployeeType = {
  employeeId: string;
  employeeName: string;
  employeeEmail: string;
  employeeContactNumber: string;
  employeeRole: Array<string>;
};

export type officeData = {
  officeId: string;
  officeName: string;
  officeEmail: string;
  officeSubTitle: string;
  officeContactNumber: string;
  officeCity: string;
  officeState: string;
  officeCountry: string;
  officePincodes: string;
  officeLongitude: string;
  officeLatitude: string;
};
