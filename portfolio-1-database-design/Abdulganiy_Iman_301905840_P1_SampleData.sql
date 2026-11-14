-- Fictional sample records for HR Consulting Engagement and Time Tracking.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."client" ("client_id", "legal_name", "industry", "active") VALUES (101, 'Northstar People Consulting Client', 'Manufacturing', TRUE);
INSERT INTO portfolio."client" ("client_id", "legal_name", "industry", "active") VALUES (102, 'Cedar Grove Advisory Client', 'Technology', TRUE);
INSERT INTO portfolio."consultant" ("consultant_id", "full_name", "specialty", "hourly_rate") VALUES (201, 'Avery Morgan', 'Workforce Planning', 145);
INSERT INTO portfolio."consultant" ("consultant_id", "full_name", "specialty", "hourly_rate") VALUES (202, 'Jordan Lee', 'Employee Relations', 160);
INSERT INTO portfolio."engagement" ("engagement_id", "client_id", "title", "start_date", "end_date", "status") VALUES (301, 101, 'Workforce Planning Review', '2026-03-01', '2026-03-31', 'active');
INSERT INTO portfolio."engagement" ("engagement_id", "client_id", "title", "start_date", "end_date", "status") VALUES (302, 102, 'Employee Relations Assessment', '2026-04-01', NULL, 'active');
INSERT INTO portfolio."work_log" ("work_log_id", "engagement_id", "consultant_id", "work_date", "hours", "billable", "notes") VALUES (401, 301, 201, '2026-03-02', 3.5, TRUE, 'Synthetic planning interview');
INSERT INTO portfolio."work_log" ("work_log_id", "engagement_id", "consultant_id", "work_date", "hours", "billable", "notes") VALUES (402, 302, 202, '2026-04-02', 2, FALSE, NULL);
COMMIT;
