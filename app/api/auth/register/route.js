import bcrypt from 'bcryptjs';
import { prisma } from '../../../../lib/prisma';

export async function POST(request) {
  try {
    const body = await request.json();
    const email = String(body.email || '').trim().toLowerCase();
    const password = String(body.password || '');
    const fullName = String(body.fullName || '').trim();
    const roleName = String(body.role || 'CITIZEN').toUpperCase();

    if (!email || !password || !fullName) {
      return Response.json({ message: 'Missing required fields.' }, { status: 400 });
    }

    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) {
      return Response.json({ message: 'Email already in use.' }, { status: 409 });
    }

    const role = await prisma.role.findUnique({ where: { name: roleName } });
    if (!role) {
      return Response.json({ message: 'Unsupported role.' }, { status: 400 });
    }

    const passwordHash = await bcrypt.hash(password, 10);
    const user = await prisma.user.create({
      data: {
        email,
        passwordHash,
        fullName,
        roleId: role.id,
        isVerified: true,
      },
    });

    return Response.json({ message: 'User created.', userId: user.id }, { status: 201 });
  } catch (error) {
    console.error(error);
    return Response.json({ message: 'Registration failed.' }, { status: 500 });
  }
}
