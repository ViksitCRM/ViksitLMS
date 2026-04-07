# Viksit LMS — Lead Management System

A full-stack Lead Management System built with **Next.js**, **Supabase**, and deployable on **Vercel**.

---

## Architecture

| Layer       | Technology                                          |
|-------------|-----------------------------------------------------|
| Frontend    | Next.js 14 (App Router), React 18, Tailwind CSS     |
| Database    | Supabase (PostgreSQL)                                |
| Realtime    | Supabase Realtime (Postgres Changes)                 |
| Hosting     | Vercel                                               |
| Auth        | Application-level (app_users table, default pw: `viksit`) |

---

## Deployment Guide

### Step 1 — Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and sign in (or create a free account).
2. Click **New Project**, choose a name (e.g. `viksit-lms`), set a database password, choose a region.
3. Wait for the project to finish provisioning (~2 minutes).

### Step 2 — Set Up the Database

1. In the Supabase dashboard, go to **SQL Editor** (left sidebar).
2. Click **New Query**.
3. Open `supabase/schema.sql` from this repo, copy its entire contents, paste into the query editor, and click **Run**.
4. Once schema runs successfully, click **New Query** again.
5. Open `supabase/seed.sql`, copy its entire contents, paste, and click **Run**.
6. Verify by going to **Table Editor** — you should see tables: `corridors`, `service_lines`, `delivery_centres`, `app_users`, `customers`, `leads`, `lead_counter` all populated with data.

### Step 3 — Enable Realtime

1. In Supabase dashboard, go to **Database → Replication**.
2. Under **supabase_realtime**, make sure these tables are enabled:
   - `leads`
   - `customers`
   - `app_users`
   - `corridors`
   - `service_lines`
   - `delivery_centres`

   (The schema SQL already adds them, but verify they appear here.)

### Step 4 — Get Your API Keys

1. In Supabase, go to **Settings → API**.
2. Copy:
   - **Project URL** — looks like `https://abcdefgh.supabase.co`
   - **anon public key** — a long JWT string starting with `eyJ...`

### Step 5 — Push Code to GitHub

1. Create a new GitHub repository (e.g. `viksit-lms`).
2. Push this project:

```bash
cd viksit-lms
git init
git add .
git commit -m "Initial commit — Viksit LMS"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/viksit-lms.git
git push -u origin main
```

### Step 6 — Deploy on Vercel

1. Go to [vercel.com](https://vercel.com) and sign in with your GitHub account.
2. Click **Add New → Project**.
3. Import your `viksit-lms` repository from GitHub.
4. In the configuration screen:
   - **Framework Preset**: Next.js (auto-detected)
   - **Root Directory**: `.` (leave as-is)
   - **Environment Variables** — add these two:

     | Name                          | Value                              |
     |-------------------------------|------------------------------------|
     | `NEXT_PUBLIC_SUPABASE_URL`    | Your Supabase Project URL          |
     | `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Your Supabase anon public key    |

5. Click **Deploy**. Vercel will build and deploy in ~1–2 minutes.
6. You'll get a URL like `https://viksit-lms.vercel.app` — this is your live app!

---

## Running Locally

```bash
# 1. Clone the repo
git clone https://github.com/YOUR_USERNAME/viksit-lms.git
cd viksit-lms

# 2. Install dependencies
npm install

# 3. Create environment file
cp .env.local.example .env.local
# Edit .env.local with your Supabase URL and anon key

# 4. Run development server
npm run dev
# App opens at http://localhost:3000
```

---

## Default Login Credentials

All users share the default password: **`viksit`**

| Username     | Name                  | Role(s)                 | Corridor      |
|--------------|-----------------------|-------------------------|---------------|
| `mohan`      | Mohan Kadampalli      | COO                     | —             |
| `arpana`     | Arpana Paul           | Admin                   | —             |
| `ceo`        | CEO                   | CEO                     | —             |
| `rajasekar`  | CA Rajasekar          | Corridor Head, CoE Head | Karnataka     |
| `ramesh`     | CA Ramesh Prabhu      | Corridor Head, CoE Head | Maharashtra   |
| `vijayabattu`| CA Vijayabattu        | Corridor Head, CoE Head | Andhra Pradesh|
| `aaron`      | Aaron Deswal          | Corridor Head, CoE Head | Delhi-Jaipur  |
| `harips`     | CA Hari PS            | BDM, CoE Head           | Karnataka     |
| `pradeep`    | CA Pradeep            | BDM, CoE Head           | Andhra Pradesh|
| `anshul`     | CA Anshul Aggarwal    | BDM, CoE Head           | Maharashtra   |
| `rohitp`     | Rohit Pradhan         | BDM, CoE Head           | Delhi-Jaipur  |
| `srinitya`   | CA Srinitya           | CoE Head                | —             |
| `deepakpai`  | CA Deepak Pai         | CoE Head                | Karnataka     |

---

## Key Features

- **Role-based access**: BDM, Corridor Head, CoE Head, SL Head, Admin, COO, CEO
- **Full lead lifecycle**: New Lead → Qualify → Meeting → Proposal → Review → Follow-up → Won/Lost
- **Realtime sync**: Changes by one user appear instantly for all other logged-in users
- **Customer Master**: Auto-creation from new leads, full CRUD
- **Action History**: Every action screen shows complete audit trail
- **Pipeline View**: Visual Kanban-style board
- **Reports & KPIs**: Win rate, revenue, corridor breakdowns

---

## Project Structure

```
viksit-lms/
├── app/
│   ├── layout.js          # Root layout (fonts, meta)
│   ├── globals.css         # Global styles
│   └── page.js             # Entry point → loads LmsApp
├── components/
│   └── LmsApp.js           # Full LMS application component
├── lib/
│   └── supabase.js          # Supabase client, CRUD helpers, realtime
├── public/
│   ├── viksit-logo.png      # Viksit Consulting logo
│   └── vitoria-logo.jpg     # Vitoria Technologies logo
├── supabase/
│   ├── schema.sql           # Database schema (run first)
│   └── seed.sql             # Seed data (run second)
├── .env.local.example       # Environment variable template
├── .gitignore
├── next.config.js
├── package.json
├── postcss.config.js
├── tailwind.config.js
└── README.md
```

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Blank screen after deploy | Check Vercel env vars are set correctly. Redeploy after adding them. |
| "relation does not exist" errors | Run `schema.sql` first, then `seed.sql` in Supabase SQL Editor. |
| Realtime not syncing | Go to Supabase → Database → Replication and verify tables are enabled. |
| Login not working | Ensure `seed.sql` ran successfully. Check `app_users` table in Table Editor. |
| Build fails on Vercel | Check that `package.json` dependencies are correct. Run `npm install && npm run build` locally first. |
