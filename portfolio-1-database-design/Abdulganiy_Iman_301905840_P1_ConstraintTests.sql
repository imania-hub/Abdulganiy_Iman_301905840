-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. reject client pk. Expected: pk_client, SQLSTATE 23505.
INSERT INTO portfolio."client" ("client_id", "legal_name", "industry", "active")
VALUES (101, 'Distinct Synthetic Client', 'Education', TRUE);

-- 2. reject client unique. Expected: uq_client_0, SQLSTATE 23505.
INSERT INTO portfolio."client" ("client_id", "legal_name", "industry", "active")
VALUES (1001, 'Northstar People Consulting Client', 'Education', TRUE);

-- 3. reject consultant pk. Expected: pk_consultant, SQLSTATE 23505.
INSERT INTO portfolio."consultant" ("consultant_id", "full_name", "specialty", "hourly_rate")
VALUES (201, 'Casey Example', 'Talent Strategy', 135);

-- 4. reject engagement pk. Expected: pk_engagement, SQLSTATE 23505.
INSERT INTO portfolio."engagement" ("engagement_id", "client_id", "title", "start_date", "end_date", "status")
VALUES (301, 102, 'Distinct Synthetic Project', '2026-05-01', '2026-05-10', 'planned');

-- 5. reject engagement fk. Expected: fk_engagement_0, SQLSTATE 23503.
INSERT INTO portfolio."engagement" ("engagement_id", "client_id", "title", "start_date", "end_date", "status")
VALUES (1002, 9001, 'Synthetic Project With Missing Client', '2026-05-01', '2026-05-10', 'planned');

-- 6. reject engagement dates. Expected: engagement_dates_valid, SQLSTATE 23514.
INSERT INTO portfolio."engagement" ("engagement_id", "client_id", "title", "start_date", "end_date", "status")
VALUES (1003, 101, 'Synthetic Project With Invalid Dates', '2026-05-10', '2026-05-01', 'planned');

-- 7. reject engagement not null. Expected: title, SQLSTATE 23502.
INSERT INTO portfolio."engagement" ("engagement_id", "client_id", "title", "start_date", "end_date", "status")
VALUES (1004, 101, NULL, '2026-05-01', '2026-05-10', 'planned');

-- 8. reject work log pk. Expected: pk_work_log, SQLSTATE 23505.
INSERT INTO portfolio."work_log" ("work_log_id", "engagement_id", "consultant_id", "work_date", "hours", "billable", "notes")
VALUES (401, 302, 202, '2026-04-03', 1, TRUE, 'Synthetic duplicate identifier');

-- 9. reject work log unique. Expected: uq_work_log_0, SQLSTATE 23505.
INSERT INTO portfolio."work_log" ("work_log_id", "engagement_id", "consultant_id", "work_date", "hours", "billable", "notes")
VALUES (1005, 301, 201, '2026-03-02', 1, TRUE, 'Synthetic duplicate daily key');

-- 10. reject work log engagement fk. Expected: fk_work_log_0, SQLSTATE 23503.
INSERT INTO portfolio."work_log" ("work_log_id", "engagement_id", "consultant_id", "work_date", "hours", "billable", "notes")
VALUES (1006, 9002, 201, '2026-05-02', 1, TRUE, 'Synthetic missing engagement');

-- 11. reject work log consultant fk. Expected: fk_work_log_1, SQLSTATE 23503.
INSERT INTO portfolio."work_log" ("work_log_id", "engagement_id", "consultant_id", "work_date", "hours", "billable", "notes")
VALUES (1007, 301, 9003, '2026-05-03', 1, TRUE, 'Synthetic missing consultant');

-- 12. reject work log hours. Expected: work_log_positive_hours, SQLSTATE 23514.
INSERT INTO portfolio."work_log" ("work_log_id", "engagement_id", "consultant_id", "work_date", "hours", "billable", "notes")
VALUES (1008, 302, 201, '2026-05-04', 0, TRUE, 'Synthetic invalid hours');
