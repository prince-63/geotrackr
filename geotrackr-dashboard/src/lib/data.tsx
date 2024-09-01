import {
  Briefcase,
  BarChart,
  User,
  Settings,
  HelpCircle,
  LogOut,
  UserRoundPen,
} from "lucide-react";
import {
  DASHBOARD_SIDEBAR_LINKS_TYPE,
  DASHBOARD_SIDEBAR_LINKS_FOOTER_TYPE,
} from "./types";

export const dashboard_sidebar_link: DASHBOARD_SIDEBAR_LINKS_TYPE = [
  {
    title: "Dashboard",
    icon: BarChart,
    link: "/dashboard",
  },
  {
    title: "Work",
    icon: Briefcase,
    link: "/work",
  },
  {
    title: "Employees",
    icon: User,
    link: "/employees",
  },
  {
    title: "Profile",
    icon: UserRoundPen,
    link: "/profile",
  },
];

export const dashboard_sidebar_footer: DASHBOARD_SIDEBAR_LINKS_FOOTER_TYPE = [
  {
    title: "Settings",
    icon: Settings,
    link: "/settings",
  },
  {
    title: "Help",
    icon: HelpCircle,
    link: "/help",
  },
  {
    title: "Logout",
    icon: LogOut,
    link: "/logout",
  },
];
