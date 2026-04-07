'use client';
import dynamic from 'next/dynamic';

const LmsApp = dynamic(() => import('../components/LmsApp'), { ssr: false });

export default function Home() {
  return <LmsApp />;
}
