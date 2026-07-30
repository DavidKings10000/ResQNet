import { verifyToken } from '../../../../auth';

export async function GET(request) {
  const token = request.headers.get('authorization')?.replace('Bearer ', '');
  if (!token) {
    return Response.json({ valid: false }, { status: 401 });
  }

  const payload = verifyToken(token);
  return Response.json({ valid: !!payload, payload }, { status: payload ? 200 : 401 });
}
