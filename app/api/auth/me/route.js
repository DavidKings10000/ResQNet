import { cookies } from 'next/headers';
import { verifyToken } from '../../../../auth';

export async function GET() {
  const token = cookies().get('resqnet-session')?.value;
  if (!token) {
    return Response.json({ user: null }, { status: 401 });
  }

  const payload = verifyToken(token);
  if (!payload) {
    return Response.json({ user: null }, { status: 401 });
  }

  return Response.json({ user: { id: payload.sub, email: payload.email, role: payload.role } }, { status: 200 });
}
