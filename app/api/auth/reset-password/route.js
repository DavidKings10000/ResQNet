import { prisma } from '../../../../lib/prisma';
import bcrypt from 'bcryptjs';

export async function POST(request) {
  const body = await request.json();
  const user = await prisma.user.findUnique({ where: { email: String(body.email || '').trim().toLowerCase() } });

  if (!user) {
    return Response.json({ message: 'If an account exists, a reset link has been sent.' }, { status: 200 });
  }

  const passwordHash = await bcrypt.hash(String(body.password || ''), 10);
  await prisma.user.update({ where: { id: user.id }, data: { passwordHash } });

  return Response.json({ message: 'Password updated successfully.' }, { status: 200 });
}
