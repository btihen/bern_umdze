--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6 (Ubuntu 14.6-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "heroku_ext";


--
-- Name: EXTENSION "pg_stat_statements"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "pg_stat_statements" IS 'track planning and execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: lvcojdekqylxki
--

CREATE TABLE "public"."ar_internal_metadata" (
    "key" character varying NOT NULL,
    "value" character varying,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO lvcojdekqylxki;

--
-- Name: attendances; Type: TABLE; Schema: public; Owner: lvcojdekqylxki
--

CREATE TABLE "public"."attendances" (
    "id" bigint NOT NULL,
    "location" character varying,
    "user_id" bigint,
    "participant_id" bigint,
    "reservation_id" bigint NOT NULL,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.attendances OWNER TO lvcojdekqylxki;

--
-- Name: attendances_id_seq; Type: SEQUENCE; Schema: public; Owner: lvcojdekqylxki
--

CREATE SEQUENCE "public"."attendances_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attendances_id_seq OWNER TO lvcojdekqylxki;

--
-- Name: attendances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lvcojdekqylxki
--

ALTER SEQUENCE "public"."attendances_id_seq" OWNED BY "public"."attendances"."id";


--
-- Name: events; Type: TABLE; Schema: public; Owner: lvcojdekqylxki
--

CREATE TABLE "public"."events" (
    "id" bigint NOT NULL,
    "event_name" character varying NOT NULL,
    "event_description" character varying,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.events OWNER TO lvcojdekqylxki;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: lvcojdekqylxki
--

CREATE SEQUENCE "public"."events_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO lvcojdekqylxki;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lvcojdekqylxki
--

ALTER SEQUENCE "public"."events_id_seq" OWNED BY "public"."events"."id";


--
-- Name: participants; Type: TABLE; Schema: public; Owner: lvcojdekqylxki
--

CREATE TABLE "public"."participants" (
    "id" bigint NOT NULL,
    "fullname" character varying,
    "email" character varying NOT NULL,
    "ip_addr" character varying NOT NULL,
    "login_token" character varying NOT NULL,
    "token_valid_until" timestamp without time zone NOT NULL,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.participants OWNER TO lvcojdekqylxki;

--
-- Name: participants_id_seq; Type: SEQUENCE; Schema: public; Owner: lvcojdekqylxki
--

CREATE SEQUENCE "public"."participants_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.participants_id_seq OWNER TO lvcojdekqylxki;

--
-- Name: participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lvcojdekqylxki
--

ALTER SEQUENCE "public"."participants_id_seq" OWNED BY "public"."participants"."id";


--
-- Name: repeat_bookings; Type: TABLE; Schema: public; Owner: lvcojdekqylxki
--

CREATE TABLE "public"."repeat_bookings" (
    "id" bigint NOT NULL,
    "repeat_every" integer NOT NULL,
    "repeat_unit" character varying NOT NULL,
    "repeat_ordinal" character varying NOT NULL,
    "repeat_choice" character varying NOT NULL,
    "repeat_until_date" "date" NOT NULL,
    "host_name" character varying,
    "alert_notice" "text",
    "start_date" "date" NOT NULL,
    "end_date" "date" NOT NULL,
    "start_time" time without time zone NOT NULL,
    "end_time" time without time zone NOT NULL,
    "start_date_time" timestamp without time zone NOT NULL,
    "end_date_time" timestamp without time zone NOT NULL,
    "is_cancelled" boolean DEFAULT false NOT NULL,
    "event_id" bigint NOT NULL,
    "space_id" bigint NOT NULL,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.repeat_bookings OWNER TO lvcojdekqylxki;

--
-- Name: repeat_bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: lvcojdekqylxki
--

CREATE SEQUENCE "public"."repeat_bookings_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.repeat_bookings_id_seq OWNER TO lvcojdekqylxki;

--
-- Name: repeat_bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lvcojdekqylxki
--

ALTER SEQUENCE "public"."repeat_bookings_id_seq" OWNED BY "public"."repeat_bookings"."id";


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: lvcojdekqylxki
--

CREATE TABLE "public"."reservations" (
    "id" bigint NOT NULL,
    "host_name" character varying,
    "alert_notice" "text",
    "start_date" "date" NOT NULL,
    "end_date" "date" NOT NULL,
    "start_time" time without time zone NOT NULL,
    "end_time" time without time zone NOT NULL,
    "start_date_time" timestamp without time zone NOT NULL,
    "end_date_time" timestamp without time zone NOT NULL,
    "is_cancelled" boolean DEFAULT false NOT NULL,
    "event_id" bigint NOT NULL,
    "space_id" bigint NOT NULL,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL,
    "repeat_booking_id" bigint,
    "remote_link" "text"
);


ALTER TABLE public.reservations OWNER TO lvcojdekqylxki;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: lvcojdekqylxki
--

CREATE SEQUENCE "public"."reservations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO lvcojdekqylxki;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lvcojdekqylxki
--

ALTER SEQUENCE "public"."reservations_id_seq" OWNED BY "public"."reservations"."id";


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: lvcojdekqylxki
--

CREATE TABLE "public"."schema_migrations" (
    "version" character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO lvcojdekqylxki;

--
-- Name: spaces; Type: TABLE; Schema: public; Owner: lvcojdekqylxki
--

CREATE TABLE "public"."spaces" (
    "id" bigint NOT NULL,
    "space_name" character varying NOT NULL,
    "space_location" "text",
    "publicly_visible" boolean DEFAULT true NOT NULL,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL,
    "onsite_limit" integer DEFAULT 6 NOT NULL
);


ALTER TABLE public.spaces OWNER TO lvcojdekqylxki;

--
-- Name: spaces_id_seq; Type: SEQUENCE; Schema: public; Owner: lvcojdekqylxki
--

CREATE SEQUENCE "public"."spaces_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spaces_id_seq OWNER TO lvcojdekqylxki;

--
-- Name: spaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lvcojdekqylxki
--

ALTER SEQUENCE "public"."spaces_id_seq" OWNED BY "public"."spaces"."id";


--
-- Name: users; Type: TABLE; Schema: public; Owner: lvcojdekqylxki
--

CREATE TABLE "public"."users" (
    "id" bigint NOT NULL,
    "email" character varying DEFAULT ''::character varying NOT NULL,
    "encrypted_password" character varying DEFAULT ''::character varying NOT NULL,
    "reset_password_token" character varying,
    "reset_password_sent_at" timestamp without time zone,
    "remember_created_at" timestamp without time zone,
    "sign_in_count" integer DEFAULT 0 NOT NULL,
    "current_sign_in_at" timestamp without time zone,
    "last_sign_in_at" timestamp without time zone,
    "current_sign_in_ip" "inet",
    "last_sign_in_ip" "inet",
    "confirmation_token" character varying,
    "confirmed_at" timestamp without time zone,
    "confirmation_sent_at" timestamp without time zone,
    "unconfirmed_email" character varying,
    "failed_attempts" integer DEFAULT 0 NOT NULL,
    "unlock_token" character varying,
    "locked_at" timestamp without time zone,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL,
    "real_name" character varying NOT NULL,
    "username" character varying NOT NULL,
    "access_role" character varying DEFAULT 'viewer'::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO lvcojdekqylxki;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: lvcojdekqylxki
--

CREATE SEQUENCE "public"."users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO lvcojdekqylxki;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lvcojdekqylxki
--

ALTER SEQUENCE "public"."users_id_seq" OWNED BY "public"."users"."id";


--
-- Name: attendances id; Type: DEFAULT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."attendances" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."attendances_id_seq"'::"regclass");


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."events" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."events_id_seq"'::"regclass");


--
-- Name: participants id; Type: DEFAULT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."participants" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."participants_id_seq"'::"regclass");


--
-- Name: repeat_bookings id; Type: DEFAULT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."repeat_bookings" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."repeat_bookings_id_seq"'::"regclass");


--
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."reservations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."reservations_id_seq"'::"regclass");


--
-- Name: spaces id; Type: DEFAULT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."spaces" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."spaces_id_seq"'::"regclass");


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."users" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."users_id_seq"'::"regclass");


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: lvcojdekqylxki
--

COPY "public"."ar_internal_metadata" ("key", "value", "created_at", "updated_at") FROM stdin;
environment	production	2022-12-10 18:26:58.915811	2022-12-10 18:26:58.915811
\.


--
-- Data for Name: attendances; Type: TABLE DATA; Schema: public; Owner: lvcojdekqylxki
--

COPY "public"."attendances" ("id", "location", "user_id", "participant_id", "reservation_id", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: lvcojdekqylxki
--

COPY "public"."events" ("id", "event_name", "event_description", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: participants; Type: TABLE DATA; Schema: public; Owner: lvcojdekqylxki
--

COPY "public"."participants" ("id", "fullname", "email", "ip_addr", "login_token", "token_valid_until", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: repeat_bookings; Type: TABLE DATA; Schema: public; Owner: lvcojdekqylxki
--

COPY "public"."repeat_bookings" ("id", "repeat_every", "repeat_unit", "repeat_ordinal", "repeat_choice", "repeat_until_date", "host_name", "alert_notice", "start_date", "end_date", "start_time", "end_time", "start_date_time", "end_date_time", "is_cancelled", "event_id", "space_id", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: lvcojdekqylxki
--

COPY "public"."reservations" ("id", "host_name", "alert_notice", "start_date", "end_date", "start_time", "end_time", "start_date_time", "end_date_time", "is_cancelled", "event_id", "space_id", "created_at", "updated_at", "repeat_booking_id", "remote_link") FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: lvcojdekqylxki
--

COPY "public"."schema_migrations" ("version") FROM stdin;
20201002183702
20201003094757
20201027082905
20201027083503
20201027083639
20201027083640
20201027083641
20210213105101
20210411110503
20210908083017
20210911135806
20210911181216
\.


--
-- Data for Name: spaces; Type: TABLE DATA; Schema: public; Owner: lvcojdekqylxki
--

COPY "public"."spaces" ("id", "space_name", "space_location", "publicly_visible", "created_at", "updated_at", "onsite_limit") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: lvcojdekqylxki
--

COPY "public"."users" ("id", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "sign_in_count", "current_sign_in_at", "last_sign_in_at", "current_sign_in_ip", "last_sign_in_ip", "confirmation_token", "confirmed_at", "confirmation_sent_at", "unconfirmed_email", "failed_attempts", "unlock_token", "locked_at", "created_at", "updated_at", "real_name", "username", "access_role") FROM stdin;
\.


--
-- Name: attendances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lvcojdekqylxki
--

SELECT pg_catalog.setval('"public"."attendances_id_seq"', 1, false);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lvcojdekqylxki
--

SELECT pg_catalog.setval('"public"."events_id_seq"', 1, false);


--
-- Name: participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lvcojdekqylxki
--

SELECT pg_catalog.setval('"public"."participants_id_seq"', 1, false);


--
-- Name: repeat_bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lvcojdekqylxki
--

SELECT pg_catalog.setval('"public"."repeat_bookings_id_seq"', 1, false);


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lvcojdekqylxki
--

SELECT pg_catalog.setval('"public"."reservations_id_seq"', 1, false);


--
-- Name: spaces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lvcojdekqylxki
--

SELECT pg_catalog.setval('"public"."spaces_id_seq"', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lvcojdekqylxki
--

SELECT pg_catalog.setval('"public"."users_id_seq"', 1, false);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."ar_internal_metadata"
    ADD CONSTRAINT "ar_internal_metadata_pkey" PRIMARY KEY ("key");


--
-- Name: attendances attendances_pkey; Type: CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."attendances"
    ADD CONSTRAINT "attendances_pkey" PRIMARY KEY ("id");


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."events"
    ADD CONSTRAINT "events_pkey" PRIMARY KEY ("id");


--
-- Name: participants participants_pkey; Type: CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."participants"
    ADD CONSTRAINT "participants_pkey" PRIMARY KEY ("id");


--
-- Name: repeat_bookings repeat_bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."repeat_bookings"
    ADD CONSTRAINT "repeat_bookings_pkey" PRIMARY KEY ("id");


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."reservations"
    ADD CONSTRAINT "reservations_pkey" PRIMARY KEY ("id");


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."schema_migrations"
    ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");


--
-- Name: spaces spaces_pkey; Type: CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."spaces"
    ADD CONSTRAINT "spaces_pkey" PRIMARY KEY ("id");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");


--
-- Name: index_attendances_on_participant_id; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_attendances_on_participant_id" ON "public"."attendances" USING "btree" ("participant_id");


--
-- Name: index_attendances_on_reservation_id; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_attendances_on_reservation_id" ON "public"."attendances" USING "btree" ("reservation_id");


--
-- Name: index_attendances_on_user_id; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_attendances_on_user_id" ON "public"."attendances" USING "btree" ("user_id");


--
-- Name: index_events_on_event_name; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_events_on_event_name" ON "public"."events" USING "btree" ("event_name");


--
-- Name: index_participants_on_email; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_participants_on_email" ON "public"."participants" USING "btree" ("email");


--
-- Name: index_participants_on_login_token; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_participants_on_login_token" ON "public"."participants" USING "btree" ("login_token");


--
-- Name: index_repeat_bookings_on_event_id; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_repeat_bookings_on_event_id" ON "public"."repeat_bookings" USING "btree" ("event_id");


--
-- Name: index_repeat_bookings_on_space_id; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_repeat_bookings_on_space_id" ON "public"."repeat_bookings" USING "btree" ("space_id");


--
-- Name: index_reservation_unique; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_reservation_unique" ON "public"."reservations" USING "btree" ("event_id", "space_id", "start_date_time", "end_date_time");


--
-- Name: index_reservations_on_end_date; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_reservations_on_end_date" ON "public"."reservations" USING "btree" ("end_date");


--
-- Name: index_reservations_on_event_id; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_reservations_on_event_id" ON "public"."reservations" USING "btree" ("event_id");


--
-- Name: index_reservations_on_repeat_booking_id; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_reservations_on_repeat_booking_id" ON "public"."reservations" USING "btree" ("repeat_booking_id");


--
-- Name: index_reservations_on_space_id; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_reservations_on_space_id" ON "public"."reservations" USING "btree" ("space_id");


--
-- Name: index_reservations_on_start_date; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE INDEX "index_reservations_on_start_date" ON "public"."reservations" USING "btree" ("start_date");


--
-- Name: index_spaces_on_space_name; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_spaces_on_space_name" ON "public"."spaces" USING "btree" ("space_name");


--
-- Name: index_unique_attendance_per_reservation; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_unique_attendance_per_reservation" ON "public"."attendances" USING "btree" ("user_id", "participant_id", "reservation_id");


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_users_on_confirmation_token" ON "public"."users" USING "btree" ("confirmation_token");


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_users_on_email" ON "public"."users" USING "btree" ("email");


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "public"."users" USING "btree" ("reset_password_token");


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_users_on_unlock_token" ON "public"."users" USING "btree" ("unlock_token");


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: lvcojdekqylxki
--

CREATE UNIQUE INDEX "index_users_on_username" ON "public"."users" USING "btree" ("username");


--
-- Name: reservations fk_rails_063b2ef947; Type: FK CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."reservations"
    ADD CONSTRAINT "fk_rails_063b2ef947" FOREIGN KEY ("space_id") REFERENCES "public"."spaces"("id");


--
-- Name: attendances fk_rails_554712257a; Type: FK CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."attendances"
    ADD CONSTRAINT "fk_rails_554712257a" FOREIGN KEY ("participant_id") REFERENCES "public"."participants"("id");


--
-- Name: reservations fk_rails_5aac3ed1a5; Type: FK CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."reservations"
    ADD CONSTRAINT "fk_rails_5aac3ed1a5" FOREIGN KEY ("repeat_booking_id") REFERENCES "public"."repeat_bookings"("id");


--
-- Name: attendances fk_rails_77ad02f5c5; Type: FK CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."attendances"
    ADD CONSTRAINT "fk_rails_77ad02f5c5" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");


--
-- Name: repeat_bookings fk_rails_a235ed719e; Type: FK CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."repeat_bookings"
    ADD CONSTRAINT "fk_rails_a235ed719e" FOREIGN KEY ("event_id") REFERENCES "public"."events"("id");


--
-- Name: repeat_bookings fk_rails_a54985177b; Type: FK CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."repeat_bookings"
    ADD CONSTRAINT "fk_rails_a54985177b" FOREIGN KEY ("space_id") REFERENCES "public"."spaces"("id");


--
-- Name: reservations fk_rails_af7a37539f; Type: FK CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."reservations"
    ADD CONSTRAINT "fk_rails_af7a37539f" FOREIGN KEY ("event_id") REFERENCES "public"."events"("id");


--
-- Name: attendances fk_rails_f004e1fff7; Type: FK CONSTRAINT; Schema: public; Owner: lvcojdekqylxki
--

ALTER TABLE ONLY "public"."attendances"
    ADD CONSTRAINT "fk_rails_f004e1fff7" FOREIGN KEY ("reservation_id") REFERENCES "public"."reservations"("id");


--
-- PostgreSQL database dump complete
--

