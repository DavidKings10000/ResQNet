"use client";

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

export default function RegisterPage() {
  const [form, setForm] = useState({ fullName: '', email: '', password: '', role: 'CITIZEN' });
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const router = useRouter();

  async function handleSubmit(e) {
    e.preventDefault();
    setError('');
    setSuccess('');

    const response = await fetch('/api/auth/register', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(form),
    });

    const data = await response.json();
    if (!response.ok) {
      setError(data.message || 'Registration failed.');
      return;
    }

    setSuccess('Account created. Please check your email to verify your account.');
    setTimeout(() => router.push('/auth/login'), 1000);
  }

  return (
    <main className="page-shell">
      <div className="container">
        <h1>Create account</h1>
        <p>Join ResQNet as a citizen, responder, or administrator.</p>
        <form className="form-grid" onSubmit={handleSubmit} style={{ marginTop: '1.5rem' }}>
          {error ? <p style={{ color: '#ff8c8c' }}>{error}</p> : null}
          {success ? <p style={{ color: '#8affb1' }}>{success}</p> : null}
          <input className="input" placeholder="Full name" value={form.fullName} onChange={(e) => setForm({ ...form, fullName: e.target.value })} required />
          <input className="input" placeholder="Email" type="email" value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} required />
          <input className="input" placeholder="Password" type="password" value={form.password} onChange={(e) => setForm({ ...form, password: e.target.value })} required />
          <select className="select" value={form.role} onChange={(e) => setForm({ ...form, role: e.target.value })}>
            <option value="CITIZEN">Citizen</option>
            <option value="DISPATCHER">Dispatcher</option>
            <option value="AMBULANCE">Ambulance</option>
            <option value="HOSPITAL">Hospital</option>
            <option value="POLICE">Police</option>
            <option value="FIRE">Fire Department</option>
            <option value="ADMIN">Administrator</option>
          </select>
          <button className="btn btn-primary" type="submit">Create account</button>
          <Link href="/auth/login">Already have an account?</Link>
        </form>
      </div>
    </main>
  );
}
