# HR Consulting Engagement and Time Tracking — database design

My case study records client, consultant, engagement, work_log.

## Users

- HR consulting engagement managers
- Consultants recording work
- Billing staff reviewing hours

## Main operations

- Register clients and create engagements.
- Assign consultants to client engagements and record their work hours.
- Review billable hours and summarize consultant or client activity.
- Benchmark the same work-date filter on synthetic work logs, comparing a table scan with a B-tree index and inspecting the query plan; report no assumed outcome.

## Entities

| Entity | Information stored |
| --- | --- |
| client | Organizations receiving HR consulting services. |
| consultant | HR consulting firm personnel who deliver engagement work. |
| engagement | A defined HR consulting project for one client. |
| work_log | Consultant hours recorded against an engagement and work date. |

## client

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| client_id | BIGINT | PK | Yes |
| legal_name | TEXT | Unique | Yes |
| industry | TEXT |  | Yes |
| active | BOOLEAN |  | Yes |
- Unique key: (legal_name).

## consultant

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| consultant_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| specialty | TEXT |  | Yes |
| hourly_rate | NUMERIC(18,2) |  | Yes |


## engagement

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| engagement_id | BIGINT | PK | Yes |
| client_id | BIGINT | FK | Yes |
| title | TEXT |  | Yes |
| start_date | DATE |  | Yes |
| end_date | DATE |  | No |
| status | TEXT |  | Yes |
- client_id → client.client_id

## work_log

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| work_log_id | BIGINT | PK | Yes |
| engagement_id | BIGINT | FK | Yes |
| consultant_id | BIGINT | FK | Yes |
| work_date | DATE |  | Yes |
| hours | NUMERIC(18,2) |  | Yes |
| billable | BOOLEAN |  | Yes |
| notes | TEXT |  | No |
- engagement_id → engagement.engagement_id
- consultant_id → consultant.consultant_id
- Unique key: (engagement_id, consultant_id, work_date).

## Relationships and business rules

- Each client legal name is unique.
- Every engagement references an existing client.
- If an end date is present, it must be on or after the start date.
- Every work log references an existing engagement.
- Every work log references an existing consultant.
- Recorded hours must be greater than zero.
- A consultant may have at most one work-log entry per engagement per date.

## Assumptions

- Consultants are firm personnel, and each work log refers to one consultant and one engagement.
- Each consultant may record at most one work-log entry per engagement per date; additional hours for that day are combined in that entry.
- An engagement belongs to one client, and its end date cannot precede its start date.
- Normalization example rooted at engagement: keep client legal name and industry in client, referenced by engagement.client_id, rather than repeating client details on every engagement; engagement title, dates, and status describe the engagement.

