export async function GET() {
  return Response.json({
    status: 'ok',
    service: 'ResQNet API',
    timestamp: new Date().toISOString(),
  });
}
