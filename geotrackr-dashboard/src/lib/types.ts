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
