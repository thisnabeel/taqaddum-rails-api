export interface User {
  id: number;
  first_name: string;
  last_name: string;
  email?: string;
  profession: string;
  company: string;
  avatar_source_url?: string;
  avatar_cropped_url?: string;
  type: "Mentor" | "Mentee";
}

export interface Skill {
  id: number;
  title: string;
  description: string;
}

export interface Mentorship {
  id: number;
  user: User;
  skill: Skill;
  summary?: string;
  status: "approved" | "pending approval";
  profession: string;
  company: string;
}
