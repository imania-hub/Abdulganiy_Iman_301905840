# HR Consulting Engagement and Time Tracking — SQL queries

## 1. Show related client, engagement, work_log records (up to 20).

```sql
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
```

| client_client_id | client_legal_name | engagement_engagement_id | engagement_title | work_log_work_log_id | work_log_work_date |
| --- | --- | --- | --- | --- | --- |
| 101 | Northstar People Consulting Client | 301 | Workforce Planning Review | 401 | 2026-03-02 |
| 102 | Cedar Grove Advisory Client | 302 | Employee Relations Assessment | 402 | 2026-04-02 |

## 2. Find work_log records where work_date matches "2026-03-02" (up to 20).

```sql
SELECT * FROM portfolio."work_log"
WHERE "work_date" IS NOT DISTINCT FROM '2026-03-02'
ORDER BY "work_log_id"
LIMIT 20;
```

| work_log_id | engagement_id | consultant_id | work_date | hours | billable | notes |
| --- | --- | --- | --- | --- | --- | --- |
| 401 | 301 | 201 | 2026-03-02 | 3.5 | true | Synthetic planning interview |

## 3. Count engagement records for each client_id (up to 20 groups).

```sql
SELECT "client_id", count(*) AS record_count
FROM portfolio."engagement"
GROUP BY "client_id"
ORDER BY record_count DESC, "client_id" NULLS LAST
LIMIT 20;
```

| client_id | record_count |
| --- | --- |
| 101 | 1 |
| 102 | 1 |

## 4. Count work_log records for each engagement_id (up to 20 groups).

```sql
SELECT "engagement_id", count(*) AS record_count
FROM portfolio."work_log"
GROUP BY "engagement_id"
ORDER BY record_count DESC, "engagement_id" NULLS LAST
LIMIT 20;
```

| engagement_id | record_count |
| --- | --- |
| 301 | 1 |
| 302 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.94 | 1.935, 1.94, 1.954 | Sort → Seq Scan | 274 |
| After index | 0.231 | 0.233, 0.231, 0.227 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 55 |

The median execution time changed from 1.94 ms to 0.231 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.906..1.909 rows=50 loops=1)
  Seq Scan on work_log (actual time=0.015..1.866 rows=50 loops=1)
Planning Time: 0.338 ms
Execution Time: 1.935 ms
```

### Before index, run 2

```text
Sort (actual time=1.912..1.915 rows=50 loops=1)
  Seq Scan on work_log (actual time=0.014..1.874 rows=50 loops=1)
Planning Time: 0.317 ms
Execution Time: 1.94 ms
```

### Before index, run 3

```text
Sort (actual time=1.927..1.93 rows=50 loops=1)
  Seq Scan on work_log (actual time=0.014..1.889 rows=50 loops=1)
Planning Time: 0.306 ms
Execution Time: 1.954 ms
```

### After index, run 1

```text
Sort (actual time=0.185..0.187 rows=50 loops=1)
  Bitmap Heap Scan on work_log (actual time=0.029..0.148 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.015 rows=50 loops=1)
Planning Time: 0.509 ms
Execution Time: 0.233 ms
```

### After index, run 2

```text
Sort (actual time=0.182..0.185 rows=50 loops=1)
  Bitmap Heap Scan on work_log (actual time=0.029..0.146 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.015 rows=50 loops=1)
Planning Time: 0.497 ms
Execution Time: 0.231 ms
```

### After index, run 3

```text
Sort (actual time=0.178..0.181 rows=50 loops=1)
  Bitmap Heap Scan on work_log (actual time=0.029..0.143 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.015 rows=50 loops=1)
Planning Time: 0.482 ms
Execution Time: 0.227 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Abdulganiy_Iman_301905840_P2_Queries.sql, then Abdulganiy_Iman_301905840_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Abdulganiy_Iman_301905840_P2_QueryResults.png) · [Index comparison](screenshots/Abdulganiy_Iman_301905840_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

