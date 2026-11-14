-- HR Consulting Engagement and Time Tracking: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."client" (
  "client_id" bigint NOT NULL,
  "legal_name" text NOT NULL,
  "industry" text NOT NULL,
  "active" boolean NOT NULL,
  CONSTRAINT "pk_client" PRIMARY KEY ("client_id"),
  CONSTRAINT "uq_client_0" UNIQUE ("legal_name")
);
CREATE TABLE portfolio."consultant" (
  "consultant_id" bigint NOT NULL,
  "full_name" text NOT NULL,
  "specialty" text NOT NULL,
  "hourly_rate" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_consultant" PRIMARY KEY ("consultant_id")
);
CREATE TABLE portfolio."engagement" (
  "engagement_id" bigint NOT NULL,
  "client_id" bigint NOT NULL,
  "title" text NOT NULL,
  "start_date" date NOT NULL,
  "end_date" date,
  "status" text NOT NULL,
  CONSTRAINT "pk_engagement" PRIMARY KEY ("engagement_id")
);
CREATE TABLE portfolio."work_log" (
  "work_log_id" bigint NOT NULL,
  "engagement_id" bigint NOT NULL,
  "consultant_id" bigint NOT NULL,
  "work_date" date NOT NULL,
  "hours" numeric(18,2) NOT NULL,
  "billable" boolean NOT NULL,
  "notes" text,
  CONSTRAINT "pk_work_log" PRIMARY KEY ("work_log_id"),
  CONSTRAINT "uq_work_log_0" UNIQUE ("engagement_id", "consultant_id", "work_date")
);
ALTER TABLE portfolio."engagement" ADD CONSTRAINT "fk_engagement_0" FOREIGN KEY ("client_id") REFERENCES portfolio."client" ("client_id");
ALTER TABLE portfolio."work_log" ADD CONSTRAINT "fk_work_log_0" FOREIGN KEY ("engagement_id") REFERENCES portfolio."engagement" ("engagement_id");
ALTER TABLE portfolio."work_log" ADD CONSTRAINT "fk_work_log_1" FOREIGN KEY ("consultant_id") REFERENCES portfolio."consultant" ("consultant_id");
ALTER TABLE portfolio."engagement" ADD CONSTRAINT "engagement_dates_valid" CHECK (("end_date" IS NULL) OR ("end_date" > "start_date"));
ALTER TABLE portfolio."work_log" ADD CONSTRAINT "work_log_positive_hours" CHECK ("hours" > 0);
COMMIT;
