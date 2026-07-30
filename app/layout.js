import './globals.css';
import Link from 'next/link';

export const metadata = {
  title: 'ResQNet | Emergency Response Coordination',
  description: 'AI-assisted emergency response coordination platform for Kenya and beyond',
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        <header className="site-header">
          <div className="container nav-shell">
            <Link href="/" className="brand">
              <span className="brand-badge">R</span>
              <span>ResQNet</span>
            </Link>
            <nav className="nav-links">
              <Link href="/about">About</Link>
              <Link href="/services">Services</Link>
              <Link href="/report">Report</Link>
              <Link href="/analytics">Analytics</Link>
              <Link href="/maps">Maps</Link>
              <Link href="/login">Login</Link>
              <Link href="/register" className="btn btn-primary">Register</Link>
            </nav>
          </div>
        </header>
        {children}
        <footer className="site-footer">
          <div className="container footer-shell">
            <p>© 2026 ResQNet. Built for resilient emergency response in Kenya.</p>
            <div className="footer-links">
              <Link href="/about">About</Link>
              <Link href="/services">Services</Link>
              <Link href="/report">Report</Link>
            </div>
          </div>
        </footer>
      </body>
    </html>
  );
}
