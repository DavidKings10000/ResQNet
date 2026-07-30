"use client";

import { useState } from 'react';
import Link from 'next/link';

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');

  async function handleSubmit(e) {
    e.preventDefault();
    setMessage('If an account exists for this email, a reset link has been sent.');
  }

  return (
    <main className="page-shell">
      <div className="container">
        <h1>Forgot password</h1>
        <p>Reset your password securely.</p>
        <form className="form-grid" onSubmit={handleSubmit} style={{ marginTop: '1.5rem' }}>
          <input className="input" placeholder="Email" type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
          <button className="btn btn-primary" type="submit">Send reset link</button>
          <Link href="/auth/login">Back to sign in</Link>
          {message ? <p>{message}</p> : null}
        </form>
      </div>
    </main>
  );
}
