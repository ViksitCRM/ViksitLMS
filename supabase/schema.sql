-- =============================================================
-- Viksit LMS — Supabase Schema
-- Run this in your Supabase SQL Editor (Dashboard → SQL Editor)
-- =============================================================

-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- ─── CORRIDORS ──────────────────────────────────────────────
create table corridors (
  id text primary key,
  name text not null,
  head text not null,
  status text not null default 'Active' check (status in ('Active','Inactive')),
  created_at timestamptz default now()
);

-- ─── SERVICE LINES ──────────────────────────────────────────
create table service_lines (
  id text primary key,
  name text not null,
  head text not null,
  offerings text[] not null default '{}',
  status text not null default 'Active' check (status in ('Active','Inactive')),
  created_at timestamptz default now()
);

-- ─── DELIVERY CENTRES ───────────────────────────────────────
create table delivery_centres (
  id text primary key,
  name text not null,
  city text not null,
  region text,
  address text,
  contact text not null,
  email text,
  phone text,
  partners jsonb default '[]',
  status text not null default 'Active' check (status in ('Active','Inactive')),
  created_at timestamptz default now()
);

-- ─── APP USERS (not Supabase auth users — app-level roles) ─
create table app_users (
  id text primary key,
  name text not null,
  username text unique not null,
  email text,
  phone text,
  roles text[] not null default '{}',
  corridor text references corridors(id),
  status text not null default 'Active' check (status in ('Active','Inactive')),
  password text not null default 'viksit',
  created_at timestamptz default now()
);

-- ─── CUSTOMERS ──────────────────────────────────────────────
create table customers (
  id text primary key,
  name text not null,
  industry text,
  city text,
  domain text,
  contact_name text,
  contact_designation text,
  contact_phone text,
  contact_email text,
  revenue_segment text,
  cin text,
  pan text,
  gst text,
  directors jsonb default '[]',
  status text not null default 'Active' check (status in ('Active','Inactive')),
  created_by text references app_users(id),
  created_at timestamptz default now()
);

-- ─── LEADS ──────────────────────────────────────────────────
create table leads (
  id text primary key,
  customer_type text not null default 'New Prospect',
  company text not null,
  industry text,
  city text,
  domain text,
  contact_name text not null,
  contact_designation text,
  contact_phone text,
  contact_email text,
  source text,
  referral_firm text,
  referral_person text,
  referral_contact text,
  service_line text references service_lines(id),
  service_offerings text[] default '{}',
  description text,
  stage text not null default 'new_lead',
  assigned_bdm text references app_users(id),
  corridor_id text references corridors(id),
  coe_head text references app_users(id),
  qualification jsonb,
  meetings jsonb default '[]',
  proposal jsonb,
  followup_notes jsonb default '[]',
  won jsonb,
  lost_reason text,
  on_hold_date date,
  notifications jsonb default '[]',
  created_at date not null default current_date,
  updated_at timestamptz default now()
);

-- ─── SEQUENCE for lead numbering ────────────────────────────
create table lead_counter (
  id int primary key default 1 check (id = 1),
  next_num int not null default 8
);
insert into lead_counter (id, next_num) values (1, 8);

-- ─── RLS Policies ───────────────────────────────────────────
-- Enable RLS on all tables
alter table corridors enable row level security;
alter table service_lines enable row level security;
alter table delivery_centres enable row level security;
alter table app_users enable row level security;
alter table customers enable row level security;
alter table leads enable row level security;
alter table lead_counter enable row level security;

-- Allow authenticated users full access (app handles authorization)
create policy "Authenticated full access" on corridors for all to authenticated using (true) with check (true);
create policy "Authenticated full access" on service_lines for all to authenticated using (true) with check (true);
create policy "Authenticated full access" on delivery_centres for all to authenticated using (true) with check (true);
create policy "Authenticated full access" on app_users for all to authenticated using (true) with check (true);
create policy "Authenticated full access" on customers for all to authenticated using (true) with check (true);
create policy "Authenticated full access" on leads for all to authenticated using (true) with check (true);
create policy "Authenticated full access" on lead_counter for all to authenticated using (true) with check (true);

-- Allow anon access (app handles its own auth via app_users table)
create policy "Anon full access" on corridors for all to anon using (true) with check (true);
create policy "Anon full access" on service_lines for all to anon using (true) with check (true);
create policy "Anon full access" on delivery_centres for all to anon using (true) with check (true);
create policy "Anon full access" on app_users for all to anon using (true) with check (true);
create policy "Anon full access" on customers for all to anon using (true) with check (true);
create policy "Anon full access" on leads for all to anon using (true) with check (true);
create policy "Anon full access" on lead_counter for all to anon using (true) with check (true);

-- ─── Realtime ───────────────────────────────────────────────
alter publication supabase_realtime add table leads;
alter publication supabase_realtime add table customers;
alter publication supabase_realtime add table app_users;
alter publication supabase_realtime add table corridors;
alter publication supabase_realtime add table service_lines;
alter publication supabase_realtime add table delivery_centres;

-- ─── Function: get next lead number atomically ──────────────
create or replace function get_next_lead_num()
returns int
language plpgsql
security definer
as $$
declare
  num int;
begin
  update lead_counter set next_num = next_num + 1 where id = 1 returning next_num - 1 into num;
  return num;
end;
$$;

grant execute on function get_next_lead_num() to anon;
grant execute on function get_next_lead_num() to authenticated;
