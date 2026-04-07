import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  console.warn('Supabase env vars missing — check .env.local');
}

export const supabase = createClient(supabaseUrl || '', supabaseAnonKey || '');

// ─── Data helpers ───────────────────────────────────────────

export async function fetchAllData() {
  const [corridors, serviceLines, deliveryCentres, users, customers, leads, counter] =
    await Promise.all([
      supabase.from('corridors').select('*').order('id'),
      supabase.from('service_lines').select('*').order('id'),
      supabase.from('delivery_centres').select('*').order('id'),
      supabase.from('app_users').select('*').order('name'),
      supabase.from('customers').select('*').order('name'),
      supabase.from('leads').select('*').order('created_at', { ascending: false }),
      supabase.from('lead_counter').select('*').single(),
    ]);

  return {
    corridors: corridors.data || [],
    serviceLines: (serviceLines.data || []).map(sl => ({ ...sl, offerings: sl.offerings || [] })),
    deliveryCentres: (deliveryCentres.data || []).map(dc => ({ ...dc, partners: dc.partners || [] })),
    users: users.data || [],
    customers: (customers.data || []).map(normalizeCustomer),
    leads: (leads.data || []).map(normalizeLead),
    nextLeadNum: counter.data?.next_num || 8,
  };
}

// Normalize DB snake_case → camelCase for lead objects (keeps compatibility with UI)
function normalizeLead(row) {
  return {
    id: row.id,
    customerType: row.customer_type,
    company: row.company,
    industry: row.industry,
    city: row.city,
    domain: row.domain,
    contactName: row.contact_name,
    contactDesignation: row.contact_designation,
    contactPhone: row.contact_phone,
    contactEmail: row.contact_email,
    source: row.source,
    referralFirm: row.referral_firm,
    referralPerson: row.referral_person,
    referralContact: row.referral_contact,
    serviceLine: row.service_line,
    serviceOfferings: row.service_offerings || [],
    description: row.description,
    stage: row.stage,
    assignedBDM: row.assigned_bdm,
    corridorId: row.corridor_id,
    coeHead: row.coe_head,
    qualification: row.qualification,
    meetings: row.meetings || [],
    proposal: row.proposal,
    followupNotes: row.followup_notes || [],
    won: row.won,
    lostReason: row.lost_reason,
    onHoldDate: row.on_hold_date,
    notifications: row.notifications || [],
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

// Normalize DB snake_case → camelCase for customer objects
function normalizeCustomer(row) {
  return {
    id: row.id,
    name: row.name,
    industry: row.industry,
    city: row.city,
    domain: row.domain,
    contactName: row.contact_name,
    contactDesignation: row.contact_designation,
    contactPhone: row.contact_phone,
    contactEmail: row.contact_email,
    revenueSegment: row.revenue_segment,
    cin: row.cin,
    pan: row.pan,
    gst: row.gst,
    directors: row.directors || [],
    status: row.status,
    createdBy: row.created_by,
  };
}

// Normalize DB snake_case → camelCase for user objects
function normalizeUser(row) {
  return {
    id: row.id,
    name: row.name,
    username: row.username,
    email: row.email,
    phone: row.phone,
    roles: row.roles || [],
    corridor: row.corridor,
    status: row.status,
    password: row.password,
  };
}

// ─── Lead CRUD ──────────────────────────────────────────────

export async function upsertLead(lead) {
  const row = {
    id: lead.id,
    customer_type: lead.customerType,
    company: lead.company,
    industry: lead.industry,
    city: lead.city,
    domain: lead.domain,
    contact_name: lead.contactName,
    contact_designation: lead.contactDesignation,
    contact_phone: lead.contactPhone,
    contact_email: lead.contactEmail,
    source: lead.source,
    referral_firm: lead.referralFirm,
    referral_person: lead.referralPerson,
    referral_contact: lead.referralContact,
    service_line: lead.serviceLine,
    service_offerings: lead.serviceOfferings || [],
    description: lead.description,
    stage: lead.stage,
    assigned_bdm: lead.assignedBDM,
    corridor_id: lead.corridorId,
    coe_head: lead.coeHead,
    qualification: lead.qualification,
    meetings: lead.meetings || [],
    proposal: lead.proposal,
    followup_notes: lead.followupNotes || [],
    won: lead.won,
    lost_reason: lead.lostReason,
    on_hold_date: lead.onHoldDate,
    notifications: lead.notifications || [],
    created_at: lead.createdAt,
    updated_at: new Date().toISOString(),
  };
  const { error } = await supabase.from('leads').upsert(row);
  if (error) console.error('upsertLead error:', error);
  return !error;
}

export async function getNextLeadNum() {
  const { data, error } = await supabase.rpc('get_next_lead_num');
  if (error) { console.error('getNextLeadNum error:', error); return Date.now(); }
  return data;
}

// ─── Customer CRUD ──────────────────────────────────────────

export async function upsertCustomer(c) {
  const row = {
    id: c.id,
    name: c.name,
    industry: c.industry,
    city: c.city,
    domain: c.domain,
    contact_name: c.contactName,
    contact_designation: c.contactDesignation,
    contact_phone: c.contactPhone,
    contact_email: c.contactEmail,
    revenue_segment: c.revenueSegment,
    cin: c.cin,
    pan: c.pan,
    gst: c.gst,
    directors: c.directors || [],
    status: c.status || 'Active',
    created_by: c.createdBy,
  };
  const { error } = await supabase.from('customers').upsert(row);
  if (error) console.error('upsertCustomer error:', error);
  return !error;
}

// ─── User CRUD ──────────────────────────────────────────────

export async function upsertUser(u) {
  const row = {
    id: u.id,
    name: u.name,
    username: u.username,
    email: u.email,
    phone: u.phone,
    roles: u.roles,
    corridor: u.corridor,
    status: u.status,
    password: u.password || 'viksit',
  };
  const { error } = await supabase.from('app_users').upsert(row);
  if (error) console.error('upsertUser error:', error);
  return !error;
}

// ─── Corridor CRUD ──────────────────────────────────────────

export async function upsertCorridor(c) {
  const { error } = await supabase.from('corridors').upsert(c);
  if (error) console.error('upsertCorridor error:', error);
  return !error;
}

// ─── Service Line CRUD ──────────────────────────────────────

export async function upsertServiceLine(sl) {
  const { error } = await supabase.from('service_lines').upsert(sl);
  if (error) console.error('upsertServiceLine error:', error);
  return !error;
}

// ─── Delivery Centre CRUD ───────────────────────────────────

export async function upsertDeliveryCentre(dc) {
  const { error } = await supabase.from('delivery_centres').upsert(dc);
  if (error) console.error('upsertDeliveryCentre error:', error);
  return !error;
}

// ─── Realtime subscription ──────────────────────────────────

export function subscribeToChanges(onDataChange) {
  const channel = supabase
    .channel('lms-realtime')
    .on('postgres_changes', { event: '*', schema: 'public', table: 'leads' }, () => onDataChange())
    .on('postgres_changes', { event: '*', schema: 'public', table: 'customers' }, () => onDataChange())
    .on('postgres_changes', { event: '*', schema: 'public', table: 'app_users' }, () => onDataChange())
    .on('postgres_changes', { event: '*', schema: 'public', table: 'corridors' }, () => onDataChange())
    .on('postgres_changes', { event: '*', schema: 'public', table: 'service_lines' }, () => onDataChange())
    .on('postgres_changes', { event: '*', schema: 'public', table: 'delivery_centres' }, () => onDataChange())
    .subscribe();

  return () => supabase.removeChannel(channel);
}
