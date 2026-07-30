# ResQNet Database Design

## Overview
This database is designed for PostgreSQL and is compatible with Supabase or Neon. The schema follows 3NF and uses Prisma for type-safe access from the Next.js application.

## Core design goals
- Normalize entities and eliminate redundancy
- Support role-based access to emergency workflows
- Track incidents, responders, hospitals, media, AI results, blockchain activity, and audit history
- Remain scalable for production deployments on Vercel and cloud-hosted PostgreSQL

## Tables
- Roles: defines access roles for users
- Users: shared identity record for all personas
- Citizens: profile data for citizen accounts
- EmergencyReports: core incident lifecycle entity
- DispatchRecords: links incidents to responders and facilities
- Ambulances: registered ambulance assets
- FireStations: fire response stations
- PoliceStations: police response stations
- Hospitals: receiving facilities
- HospitalBeds: bed inventory per hospital
- Notifications: outbound alerts to users
- AIResults: triage and predictive classification output
- BlockchainLogs: immutable audit trail references
- AuditLogs: operational trace of system changes
- Messages: internal communication between users
- MediaUploads: incident evidence files
- Settings: configurable runtime values

## Relationships
- One role has many users
- One user has zero or one citizen profile
- One citizen has many emergency reports
- One emergency report has many dispatch records, AI results, notifications, blockchain logs, messages, media uploads, and audit logs
- One dispatch record may reference one ambulance, hospital, fire station, and police station
- Each hospital has many beds
- Each user may receive many notifications and messages

## Prisma usage
1. Set DATABASE_URL in the environment
2. Run `npm run db:generate`
3. Run `npm run db:migrate`
4. Run `npm run db:seed`
