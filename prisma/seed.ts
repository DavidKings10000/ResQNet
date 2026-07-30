import { PrismaClient, RoleName, NotificationChannel, NotificationStatus, IncidentStatus, PriorityLevel, BlockchainAction, MediaType } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  const roleCitizen = await prisma.role.upsert({
    where: { name: RoleName.CITIZEN },
    update: {},
    create: { name: RoleName.CITIZEN, description: 'Citizen user' },
  });

  const roleDispatcher = await prisma.role.upsert({
    where: { name: RoleName.DISPATCHER },
    update: {},
    create: { name: RoleName.DISPATCHER, description: 'Dispatcher user' },
  });

  const roleAdmin = await prisma.role.upsert({
    where: { name: RoleName.ADMIN },
    update: {},
    create: { name: RoleName.ADMIN, description: 'Administrator user' },
  });

  const user = await prisma.user.create({
    data: {
      email: 'demo@resqnet.app',
      passwordHash: 'placeholder-hash',
      fullName: 'Demo Citizen',
      phone: '+254700000000',
      isVerified: true,
      roleId: roleCitizen.id,
    },
  });

  const citizen = await prisma.citizen.create({
    data: {
      userId: user.id,
      address: 'Nairobi, Kenya',
      latitude: 1.2921,
      longitude: 36.8219,
    },
  });

  const hospital = await prisma.hospital.create({
    data: {
      name: 'Nairobi West Hospital',
      address: 'Nairobi, Kenya',
      latitude: 1.2921,
      longitude: 36.8219,
      phone: '+254720000000',
    },
  });

  const ambulance = await prisma.ambulance.create({
    data: {
      registrationNumber: 'KAA-100A',
      vehicleType: 'ALS',
      currentLatitude: 1.2921,
      currentLongitude: 36.8219,
      isAvailable: true,
      hospitalId: hospital.id,
    },
  });

  const fireStation = await prisma.fireStation.create({
    data: {
      name: 'Nairobi Fire Station',
      address: 'Nairobi, Kenya',
      latitude: 1.2921,
      longitude: 36.8219,
    },
  });

  const policeStation = await prisma.policeStation.create({
    data: {
      name: 'Nairobi Central Police Station',
      address: 'Nairobi, Kenya',
      latitude: 1.2921,
      longitude: 36.8219,
    },
  });

  const report = await prisma.emergencyReport.create({
    data: {
      reportNumber: 'RPT-1001',
      citizenId: citizen.id,
      reporterUserId: user.id,
      emergencyType: 'Medical',
      description: 'Chest pain and breathing difficulty reported near the CBD.',
      latitude: 1.2921,
      longitude: 36.8219,
      address: 'Nairobi CBD',
      status: IncidentStatus.REPORTED,
      priority: PriorityLevel.CRITICAL,
      severityScore: 92,
      riskLevel: 'High',
      resourceRequirement: 'Ambulance and hospital',
      estimatedResponseTime: 6,
      hospitalRecommendation: hospital.name,
      possibleDuplicate: false,
      possibleFalseReport: false,
      massCasualtyEvent: false,
    },
  });

  await prisma.aiResult.create({
    data: {
      emergencyReportId: report.id,
      modelName: 'resqnet-triage-v1',
      severityScore: 92,
      priorityLevel: PriorityLevel.CRITICAL,
      riskLevel: 'High',
      resourceRequirement: 'Ambulance and hospital',
      estimatedResponseTime: 6,
      hospitalRecommendation: hospital.name,
      duplicatePossible: false,
      falseReportPossible: false,
      massCasualtyEvent: false,
      createdByUserId: user.id,
    },
  });

  await prisma.dispatchRecord.create({
    data: {
      emergencyReportId: report.id,
      dispatcherUserId: user.id,
      ambulanceId: ambulance.id,
      hospitalId: hospital.id,
      fireStationId: fireStation.id,
      policeStationId: policeStation.id,
      etaMinutes: 8,
      status: IncidentStatus.DISPATCHED,
      notes: 'Dispatched to the nearest available ambulance.',
    },
  });

  await prisma.notification.create({
    data: {
      recipientUserId: user.id,
      emergencyReportId: report.id,
      channel: NotificationChannel.EMAIL,
      status: NotificationStatus.SENT,
      message: 'Your emergency report has been received and triaged.',
      metadata: '{"source":"seed"}',
    },
  });

  await prisma.blockchainLog.create({
    data: {
      emergencyReportId: report.id,
      action: BlockchainAction.INCIDENT_CREATED,
      txHash: '0xabc123',
      metadata: '{"seed":true}',
      createdByUserId: user.id,
    },
  });

  await prisma.message.create({
    data: {
      senderUserId: user.id,
      recipientUserId: user.id,
      emergencyReportId: report.id,
      content: 'Dispatch received. Please stay calm.',
      isRead: true,
    },
  });

  await prisma.mediaUpload.create({
    data: {
      emergencyReportId: report.id,
      uploadedByUserId: user.id,
      fileName: 'incident-photo.jpg',
      url: 'https://example.com/incident-photo.jpg',
      mimeType: 'image/jpeg',
      mediaType: MediaType.IMAGE,
      sizeBytes: 204800,
    },
  });

  await prisma.setting.create({
    data: {
      key: 'default_response_window_minutes',
      value: '8',
      description: 'Default dispatch response window in minutes',
    },
  });
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
}).finally(async () => {
  await prisma.$disconnect();
});
