-- CreateEnum
CREATE TYPE "RoleName" AS ENUM ('CITIZEN', 'DISPATCHER', 'AMBULANCE', 'POLICE', 'FIRE', 'HOSPITAL', 'ADMIN');

-- CreateEnum
CREATE TYPE "IncidentStatus" AS ENUM ('REPORTED', 'TRIAGED', 'DISPATCHED', 'IN_PROGRESS', 'RESOLVED', 'CLOSED');

-- CreateEnum
CREATE TYPE "PriorityLevel" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');

-- CreateEnum
CREATE TYPE "NotificationChannel" AS ENUM ('EMAIL', 'SMS', 'PUSH', 'IN_APP');

-- CreateEnum
CREATE TYPE "NotificationStatus" AS ENUM ('PENDING', 'SENT', 'FAILED');

-- CreateEnum
CREATE TYPE "MediaType" AS ENUM ('IMAGE', 'VIDEO', 'AUDIO', 'DOCUMENT');

-- CreateEnum
CREATE TYPE "BlockchainAction" AS ENUM ('INCIDENT_CREATED', 'DISPATCHED', 'STATUS_CHANGED', 'HANDOFF_CONFIRMED', 'COMPLETED');

-- CreateTable
CREATE TABLE "roles" (
    "id" TEXT NOT NULL,
    "name" "RoleName" NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "phone" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "roleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "citizens" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "address" TEXT,
    "latitude" DECIMAL(9,6),
    "longitude" DECIMAL(9,6),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "citizens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emergency_reports" (
    "id" TEXT NOT NULL,
    "reportNumber" TEXT NOT NULL,
    "citizenId" TEXT NOT NULL,
    "reporterUserId" TEXT NOT NULL,
    "emergencyType" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "latitude" DECIMAL(9,6) NOT NULL,
    "longitude" DECIMAL(9,6) NOT NULL,
    "address" TEXT,
    "status" "IncidentStatus" NOT NULL DEFAULT 'REPORTED',
    "priority" "PriorityLevel" NOT NULL DEFAULT 'MEDIUM',
    "severityScore" INTEGER NOT NULL DEFAULT 0,
    "riskLevel" TEXT,
    "resourceRequirement" TEXT,
    "estimatedResponseTime" INTEGER,
    "hospitalRecommendation" TEXT,
    "possibleDuplicate" BOOLEAN NOT NULL DEFAULT false,
    "possibleFalseReport" BOOLEAN NOT NULL DEFAULT false,
    "massCasualtyEvent" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "emergency_reports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dispatch_records" (
    "id" TEXT NOT NULL,
    "emergencyReportId" TEXT NOT NULL,
    "dispatcherUserId" TEXT NOT NULL,
    "ambulanceId" TEXT,
    "hospitalId" TEXT,
    "fireStationId" TEXT,
    "policeStationId" TEXT,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "etaMinutes" INTEGER,
    "status" "IncidentStatus" NOT NULL DEFAULT 'DISPATCHED',
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dispatch_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ambulances" (
    "id" TEXT NOT NULL,
    "registrationNumber" TEXT NOT NULL,
    "vehicleType" TEXT NOT NULL,
    "currentLatitude" DECIMAL(9,6),
    "currentLongitude" DECIMAL(9,6),
    "isAvailable" BOOLEAN NOT NULL DEFAULT true,
    "assignedUserId" TEXT,
    "hospitalId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ambulances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fire_stations" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT,
    "latitude" DECIMAL(9,6),
    "longitude" DECIMAL(9,6),
    "assignedUserId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fire_stations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "police_stations" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT,
    "latitude" DECIMAL(9,6),
    "longitude" DECIMAL(9,6),
    "assignedUserId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "police_stations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "hospitals" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT,
    "latitude" DECIMAL(9,6),
    "longitude" DECIMAL(9,6),
    "phone" TEXT,
    "assignedUserId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "hospitals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "hospital_beds" (
    "id" TEXT NOT NULL,
    "hospitalId" TEXT NOT NULL,
    "bedNumber" TEXT NOT NULL,
    "bedType" TEXT NOT NULL DEFAULT 'GENERAL',
    "isOccupied" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "hospital_beds_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" TEXT NOT NULL,
    "recipientUserId" TEXT NOT NULL,
    "emergencyReportId" TEXT,
    "channel" "NotificationChannel" NOT NULL,
    "status" "NotificationStatus" NOT NULL DEFAULT 'PENDING',
    "message" TEXT NOT NULL,
    "metadata" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ai_results" (
    "id" TEXT NOT NULL,
    "emergencyReportId" TEXT NOT NULL,
    "modelName" TEXT NOT NULL,
    "severityScore" INTEGER NOT NULL,
    "priorityLevel" "PriorityLevel" NOT NULL,
    "riskLevel" TEXT NOT NULL,
    "resourceRequirement" TEXT NOT NULL,
    "estimatedResponseTime" INTEGER NOT NULL,
    "hospitalRecommendation" TEXT NOT NULL,
    "duplicatePossible" BOOLEAN NOT NULL DEFAULT false,
    "falseReportPossible" BOOLEAN NOT NULL DEFAULT false,
    "massCasualtyEvent" BOOLEAN NOT NULL DEFAULT false,
    "createdByUserId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ai_results_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "blockchain_logs" (
    "id" TEXT NOT NULL,
    "emergencyReportId" TEXT NOT NULL,
    "action" "BlockchainAction" NOT NULL,
    "txHash" TEXT,
    "metadata" TEXT,
    "createdByUserId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "blockchain_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "emergencyReportId" TEXT,
    "action" TEXT NOT NULL,
    "details" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "messages" (
    "id" TEXT NOT NULL,
    "senderUserId" TEXT NOT NULL,
    "recipientUserId" TEXT NOT NULL,
    "emergencyReportId" TEXT,
    "content" TEXT NOT NULL,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "messages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "media_uploads" (
    "id" TEXT NOT NULL,
    "emergencyReportId" TEXT NOT NULL,
    "uploadedByUserId" TEXT NOT NULL,
    "fileName" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "mimeType" TEXT NOT NULL,
    "mediaType" "MediaType" NOT NULL,
    "sizeBytes" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "media_uploads_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "settings" (
    "id" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "settings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "roles_name_key" ON "roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_roleId_idx" ON "users"("roleId");

-- CreateIndex
CREATE UNIQUE INDEX "citizens_userId_key" ON "citizens"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "emergency_reports_reportNumber_key" ON "emergency_reports"("reportNumber");

-- CreateIndex
CREATE INDEX "emergency_reports_status_idx" ON "emergency_reports"("status");

-- CreateIndex
CREATE INDEX "emergency_reports_priority_idx" ON "emergency_reports"("priority");

-- CreateIndex
CREATE INDEX "emergency_reports_citizenId_idx" ON "emergency_reports"("citizenId");

-- CreateIndex
CREATE INDEX "emergency_reports_reporterUserId_idx" ON "emergency_reports"("reporterUserId");

-- CreateIndex
CREATE INDEX "dispatch_records_emergencyReportId_idx" ON "dispatch_records"("emergencyReportId");

-- CreateIndex
CREATE INDEX "dispatch_records_dispatcherUserId_idx" ON "dispatch_records"("dispatcherUserId");

-- CreateIndex
CREATE UNIQUE INDEX "ambulances_registrationNumber_key" ON "ambulances"("registrationNumber");

-- CreateIndex
CREATE INDEX "ambulances_isAvailable_idx" ON "ambulances"("isAvailable");

-- CreateIndex
CREATE UNIQUE INDEX "hospital_beds_hospitalId_bedNumber_key" ON "hospital_beds"("hospitalId", "bedNumber");

-- CreateIndex
CREATE INDEX "hospital_beds_hospitalId_idx" ON "hospital_beds"("hospitalId");

-- CreateIndex
CREATE INDEX "notifications_recipientUserId_idx" ON "notifications"("recipientUserId");

-- CreateIndex
CREATE INDEX "notifications_status_idx" ON "notifications"("status");

-- CreateIndex
CREATE INDEX "ai_results_emergencyReportId_idx" ON "ai_results"("emergencyReportId");

-- CreateIndex
CREATE INDEX "blockchain_logs_emergencyReportId_idx" ON "blockchain_logs"("emergencyReportId");

-- CreateIndex
CREATE INDEX "audit_logs_userId_idx" ON "audit_logs"("userId");

-- CreateIndex
CREATE INDEX "audit_logs_emergencyReportId_idx" ON "audit_logs"("emergencyReportId");

-- CreateIndex
CREATE INDEX "messages_senderUserId_idx" ON "messages"("senderUserId");

-- CreateIndex
CREATE INDEX "messages_recipientUserId_idx" ON "messages"("recipientUserId");

-- CreateIndex
CREATE INDEX "media_uploads_emergencyReportId_idx" ON "media_uploads"("emergencyReportId");

-- CreateIndex
CREATE UNIQUE INDEX "settings_key_key" ON "settings"("key");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "citizens" ADD CONSTRAINT "citizens_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emergency_reports" ADD CONSTRAINT "emergency_reports_citizenId_fkey" FOREIGN KEY ("citizenId") REFERENCES "citizens"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emergency_reports" ADD CONSTRAINT "emergency_reports_reporterUserId_fkey" FOREIGN KEY ("reporterUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dispatch_records" ADD CONSTRAINT "dispatch_records_emergencyReportId_fkey" FOREIGN KEY ("emergencyReportId") REFERENCES "emergency_reports"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dispatch_records" ADD CONSTRAINT "dispatch_records_dispatcherUserId_fkey" FOREIGN KEY ("dispatcherUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dispatch_records" ADD CONSTRAINT "dispatch_records_ambulanceId_fkey" FOREIGN KEY ("ambulanceId") REFERENCES "ambulances"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dispatch_records" ADD CONSTRAINT "dispatch_records_hospitalId_fkey" FOREIGN KEY ("hospitalId") REFERENCES "hospitals"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dispatch_records" ADD CONSTRAINT "dispatch_records_fireStationId_fkey" FOREIGN KEY ("fireStationId") REFERENCES "fire_stations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dispatch_records" ADD CONSTRAINT "dispatch_records_policeStationId_fkey" FOREIGN KEY ("policeStationId") REFERENCES "police_stations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ambulances" ADD CONSTRAINT "ambulances_assignedUserId_fkey" FOREIGN KEY ("assignedUserId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ambulances" ADD CONSTRAINT "ambulances_hospitalId_fkey" FOREIGN KEY ("hospitalId") REFERENCES "hospitals"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fire_stations" ADD CONSTRAINT "fire_stations_assignedUserId_fkey" FOREIGN KEY ("assignedUserId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "police_stations" ADD CONSTRAINT "police_stations_assignedUserId_fkey" FOREIGN KEY ("police_stations_assignedUserId_fkey") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "hospitals" ADD CONSTRAINT "hospitals_assignedUserId_fkey" FOREIGN KEY ("assignedUserId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "hospital_beds" ADD CONSTRAINT "hospital_beds_hospitalId_fkey" FOREIGN KEY ("hospitalId") REFERENCES "hospitals"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_recipientUserId_fkey" FOREIGN KEY ("recipientUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_emergencyReportId_fkey" FOREIGN KEY ("emergencyReportId") REFERENCES "emergency_reports"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ai_results" ADD CONSTRAINT "ai_results_emergencyReportId_fkey" FOREIGN KEY ("emergencyReportId") REFERENCES "emergency_reports"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ai_results" ADD CONSTRAINT "ai_results_createdByUserId_fkey" FOREIGN KEY ("createdByUserId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "blockchain_logs" ADD CONSTRAINT "blockchain_logs_emergencyReportId_fkey" FOREIGN KEY ("emergencyReportId") REFERENCES "emergency_reports"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "blockchain_logs" ADD CONSTRAINT "blockchain_logs_createdByUserId_fkey" FOREIGN KEY ("createdByUserId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_emergencyReportId_fkey" FOREIGN KEY ("emergencyReportId") REFERENCES "emergency_reports"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_senderUserId_fkey" FOREIGN KEY ("senderUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_recipientUserId_fkey" FOREIGN KEY ("recipientUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_emergencyReportId_fkey" FOREIGN KEY ("emergencyReportId") REFERENCES "emergency_reports"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "media_uploads" ADD CONSTRAINT "media_uploads_emergencyReportId_fkey" FOREIGN KEY ("emergencyReportId") REFERENCES "emergency_reports"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "media_uploads" ADD CONSTRAINT "media_uploads_uploadedByUserId_fkey" FOREIGN KEY ("uploadedByUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
