-- Show related client, engagement, work_log records (up to 20).
SELECT t0."client_id" AS "client_client_id",
       t0."legal_name" AS "client_legal_name",
       t1."engagement_id" AS "engagement_engagement_id",
       t1."title" AS "engagement_title",
       t2."work_log_id" AS "work_log_work_log_id",
       t2."work_date" AS "work_log_work_date"
FROM portfolio."client" t0
JOIN portfolio."engagement" t1 ON t1."client_id" = t0."client_id"
JOIN portfolio."work_log" t2 ON t2."engagement_id" = t1."engagement_id"
ORDER BY t0."client_id", t1."engagement_id", t2."work_log_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."client_id" AS "client_client_id",
       t0."legal_name" AS "client_legal_name",
       t1."engagement_id" AS "engagement_engagement_id",
       t1."title" AS "engagement_title",
       t2."work_log_id" AS "work_log_work_log_id",
       t2."work_date" AS "work_log_work_date"
FROM portfolio."client" t0
JOIN portfolio."engagement" t1 ON t1."client_id" = t0."client_id"
JOIN portfolio."work_log" t2 ON t2."engagement_id" = t1."engagement_id"
ORDER BY t0."client_id", t1."engagement_id", t2."work_log_id"
LIMIT 20;

-- Find work_log records where work_date matches "2026-03-02" (up to 20).
SELECT * FROM portfolio."work_log"
WHERE "work_date" IS NOT DISTINCT FROM '2026-03-02'
ORDER BY "work_log_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."work_log"
WHERE "work_date" IS NOT DISTINCT FROM '2026-03-02'
ORDER BY "work_log_id"
LIMIT 20;

-- Count engagement records for each client_id (up to 20 groups).
SELECT "client_id", count(*) AS record_count
FROM portfolio."engagement"
GROUP BY "client_id"
ORDER BY record_count DESC, "client_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "client_id", count(*) AS record_count
FROM portfolio."engagement"
GROUP BY "client_id"
ORDER BY record_count DESC, "client_id" NULLS LAST
LIMIT 20;

-- Count work_log records for each engagement_id (up to 20 groups).
SELECT "engagement_id", count(*) AS record_count
FROM portfolio."work_log"
GROUP BY "engagement_id"
ORDER BY record_count DESC, "engagement_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "engagement_id", count(*) AS record_count
FROM portfolio."work_log"
GROUP BY "engagement_id"
ORDER BY record_count DESC, "engagement_id" NULLS LAST
LIMIT 20;
