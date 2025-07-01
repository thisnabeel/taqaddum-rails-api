import React from "react";
import {
  Card,
  CardContent,
  Typography,
  Avatar,
  Chip,
  Grid,
  Box,
  Divider,
} from "@mui/material";
import { Mentorship, Skill } from "../types";

interface MentorshipCardProps {
  mentorship: Mentorship;
  showStatus?: boolean;
}

const MentorshipCard: React.FC<MentorshipCardProps> = ({
  mentorship,
  showStatus = true,
}) => {
  const { user, skill, profession, company, status } = mentorship;

  return (
    <Card
      sx={{
        height: "100%",
        display: "flex",
        flexDirection: "column",
        transition: "transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out",
        "&:hover": {
          transform: "translateY(-4px)",
          boxShadow: 4,
        },
      }}
    >
      <CardContent sx={{ flexGrow: 1 }}>
        <Box sx={{ display: "flex", alignItems: "center", mb: 2 }}>
          <Avatar
            src={user.avatar_cropped_url}
            alt={`${user.first_name} ${user.last_name}`}
            sx={{ width: 56, height: 56, mr: 2 }}
          />
          <Box>
            <Typography variant="h6" component="div" gutterBottom>
              {user.first_name} {user.last_name}
            </Typography>
            <Typography variant="body2" color="text.secondary">
              {profession} at {company}
            </Typography>
          </Box>
        </Box>

        <Divider sx={{ my: 2 }} />

        <Box
          sx={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
          }}
        >
          <Chip
            label={skill.title}
            color="primary"
            variant="outlined"
            size="small"
          />
          {showStatus && (
            <Chip
              label={status}
              color={status === "approved" ? "success" : "warning"}
              size="small"
            />
          )}
        </Box>
      </CardContent>
    </Card>
  );
};

interface MentorshipSectionProps {
  approvedMentorships: Mentorship[];
  pendingMentorships: Mentorship[];
}

const MentorshipSection: React.FC<MentorshipSectionProps> = ({
  approvedMentorships,
  pendingMentorships,
}) => {
  return (
    <Box sx={{ py: 4 }}>
      <Typography variant="h4" component="h2" gutterBottom>
        Your Mentorships
      </Typography>

      {/* Active Mentorships */}
      <Box sx={{ mb: 4 }}>
        <Typography variant="h5" component="h3" gutterBottom color="primary">
          Active Mentorships
        </Typography>
        <Grid container spacing={3}>
          {approvedMentorships.map((mentorship) => (
            <Grid item xs={12} sm={6} md={4} key={mentorship.id}>
              <MentorshipCard mentorship={mentorship} showStatus={false} />
            </Grid>
          ))}
          {approvedMentorships.length === 0 && (
            <Grid item xs={12}>
              <Typography variant="body1" color="text.secondary" align="center">
                No active mentorships yet.
              </Typography>
            </Grid>
          )}
        </Grid>
      </Box>

      {/* Pending Mentorships */}
      <Box>
        <Typography
          variant="h5"
          component="h3"
          gutterBottom
          color="warning.main"
        >
          Pending Approvals
        </Typography>
        <Grid container spacing={3}>
          {pendingMentorships.map((mentorship) => (
            <Grid item xs={12} sm={6} md={4} key={mentorship.id}>
              <MentorshipCard mentorship={mentorship} />
            </Grid>
          ))}
          {pendingMentorships.length === 0 && (
            <Grid item xs={12}>
              <Typography variant="body1" color="text.secondary" align="center">
                No pending mentorships.
              </Typography>
            </Grid>
          )}
        </Grid>
      </Box>
    </Box>
  );
};

export default MentorshipSection;
