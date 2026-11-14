# HR Consulting Engagement and Time Tracking — ER diagram

```mermaid
erDiagram
    direction LR
    client {
        bigint client_id PK
        text legal_name UK
        text industry
        boolean active
    }
    consultant {
        bigint consultant_id PK
        text full_name
        text specialty
        numeric hourly_rate
    }
    engagement {
        bigint engagement_id PK
        bigint client_id FK
        text title
        date start_date
        date end_date "Optional"
        text status
    }
    work_log {
        bigint work_log_id PK
        bigint engagement_id FK
        bigint consultant_id FK
        date work_date
        numeric hours
        boolean billable
        text notes "Optional"
    }
    client ||--o{ engagement : "client_id"
    engagement ||--o{ work_log : "engagement_id"
    consultant ||--o{ work_log : "consultant_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Abdulganiy_Iman_301905840_ERDiagram.png)
