"use client";

import { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';

export default function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const router = useRouter();

  async function handleSubmit(e) {
    e.preventDefault();
    setError('');

    const response = await fetch('/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password }),
    });

    const data = await response.json();
    if (!response.ok) {
      setError(data.message || 'Invalid credentials.');
      return;
    }

    document.cookie = `resqnet-session=${data.token}; path=/; max-age=28800`;
    router.push('/dashboard');
  }

  return (
    <main className="page-shell">
      <div className="container">
        <h1>Sign in</h1>
        <p>Access the ResQNet platform securely.</p>
        <form className="form-grid" onSubmit={handleSubmit} style={{ marginTop: '1.5rem' }}>
          {error ? <p style={{ color: '#ff8c8c' }}>{error}</p> : null}
          <input className="input" placeholder="Email" type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
          <input className="input" placeholder="Password" type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
          <button className="btn btn-primary" type="submit">Sign in</button>
          <div style={{ display: 'flex', justifyContent: 'space-between', gap: '1rem' }}>
            <Link href="/auth/register">Create account</Link>
            <Link href="/auth/forgot-password">Forgot password?</Link>
          </div>
        </form>
      </div>
    </main>
  );
}
