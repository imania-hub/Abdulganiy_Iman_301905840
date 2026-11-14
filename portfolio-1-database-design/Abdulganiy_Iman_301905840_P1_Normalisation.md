# HR Consulting Engagement and Time Tracking — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| client_id | engagement records (list) |
| --- | --- |
| 101 | [301] |
| 102 | [302] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| engagement.engagement_id | engagement.client_id | engagement.title | client.client_id | client.legal_name |
| --- | --- | --- | --- | --- |
| 301 | 101 | Workforce Planning Review | 101 | Northstar People Consulting Client |
| 302 | 102 | Employee Relations Assessment | 102 | Cedar Grove Advisory Client |

Key: engagement_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## engagement_example

| engagement.engagement_id | engagement.client_id | engagement.title | client.client_id | client.legal_name |
| --- | --- | --- | --- | --- |
| 301 | 101 | Workforce Planning Review | 101 | Northstar People Consulting Client |
| 302 | 102 | Employee Relations Assessment | 102 | Cedar Grove Advisory Client |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## client

| client_id | legal_name | industry | active |
| --- | --- | --- | --- |
| 101 | Northstar People Consulting Client | Manufacturing | true |
| 102 | Cedar Grove Advisory Client | Technology | true |

## consultant

| consultant_id | full_name | specialty | hourly_rate |
| --- | --- | --- | --- |
| 201 | Avery Morgan | Workforce Planning | 145 |
| 202 | Jordan Lee | Employee Relations | 160 |

## engagement

| engagement_id | client_id | title | start_date | end_date | status |
| --- | --- | --- | --- | --- | --- |
| 301 | 101 | Workforce Planning Review | 2026-03-01 | 2026-03-31 | active |
| 302 | 102 | Employee Relations Assessment | 2026-04-01 | NULL | active |

## work_log

| work_log_id | engagement_id | consultant_id | work_date | hours | billable | notes |
| --- | --- | --- | --- | --- | --- | --- |
| 401 | 301 | 201 | 2026-03-02 | 3.5 | true | Synthetic planning interview |
| 402 | 302 | 202 | 2026-04-02 | 2 | false | NULL |

## Dependencies

- client: (client_id) → legal_name, industry, active
- consultant: (consultant_id) → full_name, specialty, hourly_rate
- engagement: (engagement_id) → client_id, title, start_date, end_date, status
- work_log: (work_log_id) → engagement_id, consultant_id, work_date, hours, billable, notes

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
