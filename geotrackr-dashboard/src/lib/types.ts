// import { Icon as LucideIcon } from 'lucide-react';
import { ComponentType } from "react";

export type DASHBOARD_SIDEBAR_LINKS_TYPE = {
  title: string;
  icon: ComponentType<{ className?: string }>;
  link: string;
}[];

export type DASHBOARD_SIDEBAR_LINKS_FOOTER_TYPE = {
  title: string;
  icon: ComponentType<{ className?: string }>;
  link: string;
}[];

interface Employee {
  id: string;
  name: string;
  email: string;
  phone: string;
}

export type InOfficeEmployeeType = Employee[];
export type OutOfficeEmployeeType = Employee[];