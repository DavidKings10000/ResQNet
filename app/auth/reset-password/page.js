"use client";

import { useState } from 'react';
import { useRouter } from 'next/navigation';

export default function ResetPasswordPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [message, setMessage] = useState('');
  const router = useRouter();

  async function handleSubmit(e) {
    e.preventDefault();
    const response = await fetch('/api/auth/reset-password', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password }),
    });
    const data = await response.json();
    setMessage(data.message || 'Password reset complete.');
    if (response.ok) {
      setTimeout(() => router.push('/auth/login'), 800);
    }
  }

  return (
    <main className="page-shell">
      <div className="container">
        <h1>Reset password</h1>
        <p>Set a new password for your account.</p>
        <form className="form-grid" onSubmit={handleSubmit} style={{ marginTop: '1.5rem' }}>
          <input className="input" placeholder="Email" type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
          <input className="input" placeholder="New password" type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
          <button className="btn btn-primary" type="submit">Reset password</button>
          {message ? <p>{message}</p> : null}
        </form>
      </div>
    </main>
  );
}
