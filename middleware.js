import { NextResponse } from 'next/server';
import { verifyToken } from './auth';

const publicRoutes = ['/','/about','/services','/auth/login','/auth/register','/auth/forgot-password','/auth/reset-password','/api/auth/register','/api/auth/login','/api/auth/reset-password','/api/auth/verify'];
const roleRoutes = {
  CITIZEN: ['/dashboard', '/citizen-dashboard', '/profile'],
  DISPATCHER: ['/dispatcher-dashboard', '/profile'],
  AMBULANCE: ['/ambulance-dashboard', '/profile'],
  HOSPITAL: ['/hospital-dashboard', '/profile'],
  POLICE: ['/police-dashboard', '/profile'],
  FIRE: ['/fire-dashboard', '/profile'],
  ADMIN: ['/admin-dashboard', '/profile'],
};

export async function middleware(request) {
  const { pathname } = request.nextUrl;

  if (publicRoutes.includes(pathname) || pathname.startsWith('/api/auth')) {
    return NextResponse.next();
  }

  const token = request.cookies.get('resqnet-session')?.value;
  if (!token) {
    return NextResponse.redirect(new URL('/auth/login', request.url));
  }

  const payload = verifyToken(token);
  if (!payload) {
    return NextResponse.redirect(new URL('/auth/login', request.url));
  }

  const role = payload.role;
  const allowed = roleRoutes[role] || [];
  const isProtectedRoute = ['/dashboard','/citizen-dashboard','/dispatcher-dashboard','/hospital-dashboard','/police-dashboard','/fire-dashboard','/admin-dashboard','/profile'].some((route) => pathname.startsWith(route));

  if (isProtectedRoute) {
    const isAllowed = allowed.some((route) => pathname.startsWith(route));
    if (!isAllowed) {
      return NextResponse.redirect(new URL('/auth/login', request.url));
    }
  }

  return NextResponse.next();
}

export const config = {
  matcher: ['/((?!_next/static|_next/image|favicon.ico).*)'],
};
