-- =============================================================
-- Viksit LMS — Seed Data
-- Run AFTER schema.sql in your Supabase SQL Editor
-- =============================================================

-- ─── Corridors ──────────────────────────────────────────────
insert into corridors (id, name, head) values
  ('KA', 'Karnataka', 'CA Rajasekar'),
  ('AP', 'Andhra Pradesh', 'CA Vijayabattu'),
  ('MH', 'Maharashtra', 'CA Ramesh Prabhu'),
  ('DJ', 'Delhi-Jaipur', 'Aaron Deswal');

-- ─── Service Lines ──────────────────────────────────────────
insert into service_lines (id, name, head, offerings) values
  ('sl-01','Accounting - Record to Report','CA Hari PS','{"Billing & Receipts - Other legal entities","Billing & Receipts - Society","Finalisation of Accounts","Management Reports & MIS Reporting"}'),
  ('sl-02','Audit & Assurance','CA Anshul Aggarwal','{"Bank Central Audit","Bank Concurrent Audit","Company Statutory Audit","Information System Audit","Rera Audit","Revenue Audit","Tax audit","Trust Statutory Audit"}'),
  ('sl-03','Finance Technology','CA Rajasekar','{"Accounting Software Management","Data Migration & Accounting System Setup"}'),
  ('sl-04','Risk & Internal Audit','CA Anshul Aggarwal','{"Compliance Audit","Cost Audit","Financial Investigation","Forensic Audit","Internal Audit","IT Audit/Cybersecurity","Stock Audit"}'),
  ('sl-05','Shared Services','CA Pradeep','{"Accounts Outsourcing - Global"}'),
  ('sl-06','Direct Tax','CA Srinitya','{"Advance Tax Advisory","Direct Tax Compliance"}'),
  ('sl-07','Indirect Tax','CA Pradeep','{"Goods and Services Tax (GST)"}'),
  ('sl-08','Registration & Compliance','CA Vijayabattu','{"Company Formation","Darpan for NGO","For Udyam","Formation","LLP Formation","ROC Filings","Start-up India"}'),
  ('sl-09','People, Payroll & HR Compliance','CA Deepak Pai','{"Payroll Processing","Professional Tax"}'),
  ('sl-10','Entity Compliance','CA Ramesh Prabhu','{"Annual Return Filing","Budgeting","Conduct Election Process","Filing O form","Maintaining Statutory Register"}'),
  ('sl-11','Transfer Pricing','CA Srinitya','{"Transfer Pricing – Sub Services"}'),
  ('sl-12','vCFO Services','CA Vijayabattu','{"Fundraising Strategy","Investor Management","Post-Funding Support","Transaction Support"}'),
  ('sl-13','Management Consulting','Aaron Deswal','{"Growth, Crisis & Problem Structuring","Human Resources Advisory","International Business Operations","Operations & Roadmap Modernization","Strategy Development & Execution"}'),
  ('sl-14','Real Estate Advisory','CA Ramesh Prabhu','{"Advisory for Real Estate Developers","RERA Complaints","RERA Agent Registration","Project Registration"}'),
  ('sl-15','Govt & Subsidy Advisory','CA Dilip Lohiya','{"Subsidy Practice"}'),
  ('sl-16','ESG & Sustainability','CA Mahendra Tiwari','{"Environmental Advisory","ESG Due Diligence","ESG Ratings & Benchmarking","ESG Reporting & Disclosures","ESG Strategy & Advisory"}'),
  ('sl-17','Debt Funding','CA Vijayabattu','{"Debt Funding Advisory"}'),
  ('sl-18','Equity & Capital Advisory','CA Anshul Aggarwal','{"Equity Funding Advisory"}'),
  ('sl-19','Valuation & M&A','CA Anshul Aggarwal','{"Business Valuation","Intangible Asset Valuation","Investments & Funds Valuation","Litigation & Dispute Valuation","Real Estate / Property Valuation","Tangible Asset Valuation","Valuation for Financial Reporting","Valuation for Tax & Regulatory Purposes"}'),
  ('sl-20','IPO & Capital Markets Advisory','CA Chinappa','{"Investor & Market Preparation","IPO Documentation Support","IPO Readiness Assessment","Pre-IPO Advisory"}'),
  ('sl-21','Technology & ICT','CA Venkatesh Padiyar','{"Cloud & Hybrid Infrastructure","Cybersecurity & Policies","Datacenter Modernization","Enterprise Technology Integration","Modern Workplace Solutions"}'),
  ('sl-22','AI Strategy & Consulting','Rohit Pradhan','{"AI Automation & Process Optimization","AI Governance, Ethics & Compliance","Machine Learning Model Development","Predictive Analytics & Forecasting"}'),
  ('sl-23','Global Capability Centre','CA Rajasekar','{"Business Process Management","Finance & Accounting Services","IT & Technology Services","Legal & Compliance Support"}');

-- ─── Delivery Centres ───────────────────────────────────────
insert into delivery_centres (id, name, city, region, contact, email, phone) values
  ('f-001','CA Hari PS & Associates','Ballari','Karnataka','CA Hari PS','office@harips.com','+91 98765 00001'),
  ('f-002','CA Chinappa & Associates','Bengaluru','Karnataka','CA Chinappa','info@chinappa.in','+91 80 2222 3333'),
  ('f-003','CA Venkatesh Padiyar','Bengaluru','Karnataka','CA Venkatesh Padiyar','venkatesh@padiyar.co.in','+91 99001 55555'),
  ('f-004','CA Deepak Pai & Associates','Bengaluru','Karnataka','CA Deepak Pai','deepak@paica.in','+91 99001 66666'),
  ('f-005','CA Pradeep & Associates','Anantpur','Andhra Pradesh','CA Pradeep','pradeep@pradeepca.in','+91 98456 77777'),
  ('f-006','CA Anshul Aggarwal & Co','Mumbai','Maharashtra','CA Anshul Aggarwal','anshul@aggarwalco.in','+91 22 4444 5555'),
  ('f-007','CA Dilip Lohiya & Associates','Nagpur','Maharashtra','CA Dilip Lohiya','dilip@lohiyaca.in','+91 99228 88888'),
  ('f-008','CA Mahendra Tiwari & Co','Bhayandar','Maharashtra','CA Mahendra Tiwari','mahendra@tiwarico.in','+91 99201 99999'),
  ('f-009','Anita & Associates','Palghar','Maharashtra','CA Anita','anita@anitaca.in','+91 98201 11111'),
  ('f-010','Bhavesh & Associates','Pune','Maharashtra','CA Bhavesh','bhavesh@bhaveshca.in','+91 98220 22222'),
  ('f-011','Rohit Pradhan Consulting','Jaipur','Rajasthan','Rohit Pradhan','rohit@pradhan.co.in','+91 99290 33333'),
  ('f-012','Aaron Deswal & Associates','Delhi','Delhi','Aaron Deswal','aaron@deswalca.in','+91 98110 44444');

-- ─── App Users ──────────────────────────────────────────────
insert into app_users (id, name, username, email, phone, roles, corridor, password) values
  ('u-coo','Mohan Kadampalli','mohan','mohan@viksit.in','+91 99000 00001','{"COO"}',null,'viksit'),
  ('u-adm','Arpana Paul','arpana','arpana@viksit.in','+91 99000 00002','{"Admin"}',null,'viksit'),
  ('u-ceo','CEO','ceo','ceo@viksit.in','+91 99000 00020','{"CEO"}',null,'viksit'),
  ('u-ch-ka','CA Rajasekar','rajasekar','rajasekar@viksit.in','+91 99000 00003','{"Corridor Head","CoE Head"}','KA','viksit'),
  ('u-ch-mh','CA Ramesh Prabhu','ramesh','ramesh@viksit.in','+91 99000 00004','{"Corridor Head","CoE Head"}','MH','viksit'),
  ('u-ch-ap','CA Vijayabattu','vijayabattu','vijayabattu@viksit.in','+91 99000 00005','{"Corridor Head","CoE Head"}','AP','viksit'),
  ('u-ch-dj','Aaron Deswal','aaron','aaron@viksit.in','+91 99000 00006','{"Corridor Head","CoE Head"}','DJ','viksit'),
  ('u-bdm-hp','CA Hari PS','harips','harips@viksit.in','+91 99000 00007','{"BDM","CoE Head"}','KA','viksit'),
  ('u-bdm-pr','CA Pradeep','pradeep','pradeep@viksit.in','+91 99000 00008','{"BDM","CoE Head"}','AP','viksit'),
  ('u-bdm-aa','CA Anshul Aggarwal','anshul','anshul@viksit.in','+91 99000 00009','{"BDM","CoE Head"}','MH','viksit'),
  ('u-bdm-rp','Rohit Pradhan','rohitp','rohitp@viksit.in','+91 99000 00010','{"BDM","CoE Head"}','DJ','viksit'),
  ('u-coe-sn','CA Srinitya','srinitya','srinitya@viksit.in','+91 99000 00018','{"CoE Head"}',null,'viksit'),
  ('u-coe-dp','CA Deepak Pai','deepakpai','deepakpai@viksit.in','+91 99000 00019','{"CoE Head"}','KA','viksit'),
  ('u-fp-002','CA Chinappa','chinappa','chinappa@viksit.in','+91 99000 00011','{"Delivery Centre"}','KA','viksit'),
  ('u-fp-003','CA Venkatesh Padiyar','venkatesh','venkatesh@viksit.in','+91 99000 00012','{"Delivery Centre"}','KA','viksit'),
  ('u-fp-007','CA Dilip Lohiya','dilip','dilip@viksit.in','+91 99000 00014','{"CoE Head"}','MH','viksit'),
  ('u-fp-008','CA Mahendra Tiwari','mahendra','mahendra@viksit.in','+91 99000 00015','{"CoE Head"}','MH','viksit');

-- ─── Customers ──────────────────────────────────────────────
insert into customers (id, name, industry, city, domain, contact_name, contact_designation, contact_phone, contact_email, created_by) values
  ('cust-001','Bellary Steel Works Pvt Ltd','Manufacturing','Ballari','bellarysteel.com','Ravi Kumar','CFO','+91 98765 43210','ravi@bellarysteel.com','u-bdm-hp'),
  ('cust-002','Mumbai Realty Projects Ltd','Real Estate','Mumbai','mumbairealty.in','Suresh Shah','CEO','+91 99201 23456','suresh@mumbairealty.in','u-bdm-aa');

-- ─── Sample Leads ───────────────────────────────────────────
insert into leads (id, customer_type, company, industry, city, contact_name, contact_designation, contact_email, source, stage, assigned_bdm, corridor_id, service_line, created_at) values
  ('VK-2026-00001','New Prospect','Bellary Steel Works Pvt Ltd','Manufacturing','Ballari','Ravi Kumar','CFO','ravi@bellarysteel.com','Referral','qualified','u-bdm-hp','KA','sl-01','2026-01-15'),
  ('VK-2026-00002','New Prospect','Mumbai Realty Projects Ltd','Real Estate','Mumbai','Suresh Shah','CEO','suresh@mumbairealty.in','Event','meeting_done','u-bdm-aa','MH','sl-14','2026-02-01'),
  ('VK-2026-00003','New Prospect','TechNova Solutions','IT & Software','Bengaluru','Anil Rao','CTO','anil@technova.in','Inbound','new_lead','u-bdm-hp','KA',null,'2026-03-10'),
  ('VK-2026-00004','New Prospect','Doon Valley Exports','FMCG','Delhi','Vikram Singh','Director','vikram@doonvalley.com','Cold Outreach','proposal_review','u-bdm-rp','DJ','sl-13','2026-01-20'),
  ('VK-2026-00005','Existing Customer','Pharma India Ltd','Pharma & Healthcare','Pune','Dr. Meera Joshi','CEO','meera@pharmaindia.in','Referral','followup','u-bdm-aa','MH','sl-04','2025-12-05'),
  ('VK-2026-00006','New Prospect','Green Earth Textiles','Textiles','Anantpur','Lakshmi Devi','MD','lakshmi@greenearth.co.in','Delivery Centre','won','u-bdm-pr','AP','sl-08','2025-11-15'),
  ('VK-2026-00007','New Prospect','AutoParts Global','Automobile','Jaipur','Rajesh Mehra','VP Finance','rajesh@autopartsglobal.com','Event','lost','u-bdm-rp','DJ','sl-02','2026-01-05');

-- Update sample leads with richer data
update leads set
  qualification = '{"oppSize":"₹20–50L","painCategories":["Tax Compliance","Process Inefficiency"],"transitionDate":"2026-01-20"}'::jsonb,
  meetings = '[{"id":"m1","date":"2026-01-25","mode":"In-person","bdmAction":"Request Proposal","clientAttendees":[{"name":"Ravi Kumar","designation":"CFO"}],"viksitAttendees":[{"name":"CA Hari PS","role":"BDM"}],"painPoints":["Tax Compliance"],"keyStatements":"Need end-to-end accounting support","capabilities":"","clientNextStep":"Share documents","bdmAction":"Nurture Further"}]'::jsonb
where id = 'VK-2026-00001';

update leads set
  qualification = '{"oppSize":"₹50L+","painCategories":["Regulatory","Strategy"],"transitionDate":"2026-02-05"}'::jsonb,
  meetings = '[{"id":"m2","date":"2026-02-10","mode":"Virtual","bdmAction":"Request Proposal","clientAttendees":[{"name":"Suresh Shah","designation":"CEO"}],"viksitAttendees":[{"name":"CA Anshul Aggarwal","role":"BDM"}],"painPoints":["Regulatory"],"keyStatements":"Need RERA compliance support","capabilities":"Full RERA advisory","clientNextStep":"Board discussion","bdmAction":"Request Proposal"}]'::jsonb
where id = 'VK-2026-00002';

update leads set
  qualification = '{"oppSize":"₹20–50L","painCategories":["Strategy"],"transitionDate":"2026-01-25"}'::jsonb,
  proposal = '{"serviceOfferings":["Growth, Crisis & Problem Structuring","Strategy Development & Execution"],"customerProblem":"Export market expansion strategy needed","proposedScope":"6-month strategic engagement","expectedOppValue":3500000,"corridorApproval":"Pending"}'::jsonb
where id = 'VK-2026-00004';

update leads set
  qualification = '{"oppSize":"₹5–20L","painCategories":["Process Inefficiency","Cash Flow"],"transitionDate":"2025-12-10"}'::jsonb,
  proposal = '{"serviceOfferings":["Internal Audit","Compliance Audit"],"customerProblem":"Recurring compliance gaps","proposedScope":"Quarterly internal audit","expectedOppValue":1500000,"corridorApproval":"Approved"}'::jsonb,
  followup_notes = '[{"action":"Negotiate Price","notes":"Client wants 10% discount","date":"2026-01-15"},{"action":"Nurture Further","notes":"Sent revised quote","date":"2026-02-01"}]'::jsonb
where id = 'VK-2026-00005';

update leads set
  qualification = '{"oppSize":"< ₹5L","painCategories":["Regulatory"],"transitionDate":"2025-11-20"}'::jsonb,
  won = '{"winDate":"2026-01-10","confirmationMode":"Signed Engagement Letter","agreedFee":400000,"deliveryCentre":"f-005"}'::jsonb
where id = 'VK-2026-00006';

update leads set
  lost_reason = 'Budget constraints — client postponed project indefinitely'
where id = 'VK-2026-00007';
