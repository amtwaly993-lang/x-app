-- شغّل هذا في Supabase > SQL Editor مرة واحدة

create table if not exists public.floating_ads (
  id int primary key,
  image_url text,
  target_link text,
  frequency text default 'session',   -- session | daily | once | always
  is_active boolean default false,
  updated_at timestamptz default now()
);

alter table public.floating_ads enable row level security;

-- أي عميل يقدر يقرأ الإعلان
create policy "floating_ads_read" on public.floating_ads
  for select using (true);

-- الكتابة فقط للمستخدمين المسجلين دخول (حسابات الإدارة)
create policy "floating_ads_write_insert" on public.floating_ads
  for insert to authenticated with check (true);
create policy "floating_ads_write_update" on public.floating_ads
  for update to authenticated using (true) with check (true);
