import { prisma } from './lib/prisma';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

export async function signInWithCredentials(email, password) {
  const normalizedEmail = String(email).trim().toLowerCase();
  const user = await prisma.user.findUnique({
    where: { email: normalizedEmail },
    include: { role: true },
  });

  if (!user || !user.isActive || !user.isVerified) {
    return null;
  }

  const passwordMatches = await bcrypt.compare(String(password), user.passwordHash);
  if (!passwordMatches) {
    return null;
  }

  const token = jwt.sign(
    { sub: user.id, email: user.email, role: user.role.name },
    process.env.AUTH_SECRET || 'dev-secret',
    { expiresIn: '8h' },
  );

  return { token, user: { id: user.id, email: user.email, role: user.role.name, name: user.fullName } };
}

export function verifyToken(token) {
  try {
    return jwt.verify(token, process.env.AUTH_SECRET || 'dev-secret');
  } catch {
    return null;
  }
}
