--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7 (Ubuntu 12.7-1.pgdg16.04+1)
-- Dumped by pg_dump version 12.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE TABLE "public"."ar_internal_metadata" (
    "key" character varying NOT NULL,
    "value" character varying,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO shzeqjftbzzfxa;

--
-- Name: events; Type: TABLE; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE TABLE "public"."events" (
    "id" bigint NOT NULL,
    "event_name" character varying NOT NULL,
    "event_description" character varying,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.events OWNER TO shzeqjftbzzfxa;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE SEQUENCE "public"."events_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO shzeqjftbzzfxa;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER SEQUENCE "public"."events_id_seq" OWNED BY "public"."events"."id";


--
-- Name: repeat_bookings; Type: TABLE; Schema: public; Owner: shzeqjftbzzfxa
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


ALTER TABLE public.repeat_bookings OWNER TO shzeqjftbzzfxa;

--
-- Name: repeat_bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE SEQUENCE "public"."repeat_bookings_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.repeat_bookings_id_seq OWNER TO shzeqjftbzzfxa;

--
-- Name: repeat_bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER SEQUENCE "public"."repeat_bookings_id_seq" OWNED BY "public"."repeat_bookings"."id";


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: shzeqjftbzzfxa
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


ALTER TABLE public.reservations OWNER TO shzeqjftbzzfxa;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE SEQUENCE "public"."reservations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO shzeqjftbzzfxa;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER SEQUENCE "public"."reservations_id_seq" OWNED BY "public"."reservations"."id";


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE TABLE "public"."schema_migrations" (
    "version" character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO shzeqjftbzzfxa;

--
-- Name: spaces; Type: TABLE; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE TABLE "public"."spaces" (
    "id" bigint NOT NULL,
    "space_name" character varying NOT NULL,
    "space_location" "text",
    "publicly_visible" boolean DEFAULT true NOT NULL,
    "created_at" timestamp(6) without time zone NOT NULL,
    "updated_at" timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.spaces OWNER TO shzeqjftbzzfxa;

--
-- Name: spaces_id_seq; Type: SEQUENCE; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE SEQUENCE "public"."spaces_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spaces_id_seq OWNER TO shzeqjftbzzfxa;

--
-- Name: spaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER SEQUENCE "public"."spaces_id_seq" OWNED BY "public"."spaces"."id";


--
-- Name: users; Type: TABLE; Schema: public; Owner: shzeqjftbzzfxa
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
    "real_name" character varying,
    "username" character varying NOT NULL,
    "access_role" character varying DEFAULT 'member'::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO shzeqjftbzzfxa;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE SEQUENCE "public"."users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO shzeqjftbzzfxa;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER SEQUENCE "public"."users_id_seq" OWNED BY "public"."users"."id";


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."events" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."events_id_seq"'::"regclass");


--
-- Name: repeat_bookings id; Type: DEFAULT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."repeat_bookings" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."repeat_bookings_id_seq"'::"regclass");


--
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."reservations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."reservations_id_seq"'::"regclass");


--
-- Name: spaces id; Type: DEFAULT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."spaces" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."spaces_id_seq"'::"regclass");


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."users" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."users_id_seq"'::"regclass");


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: shzeqjftbzzfxa
--

COPY "public"."ar_internal_metadata" ("key", "value", "created_at", "updated_at") FROM stdin;
environment	production	2020-10-06 10:35:02.494282	2020-10-06 10:35:02.494282
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: shzeqjftbzzfxa
--

COPY "public"."events" ("id", "event_name", "event_description", "created_at", "updated_at") FROM stdin;
1	Tergar		2020-10-06 13:48:03.349067	2020-10-06 13:48:03.349067
3	Schnupperabend		2020-10-06 15:14:11.643839	2020-10-06 15:14:11.643839
4	Meditationsabend		2020-10-06 15:19:50.123072	2020-10-06 15:19:50.123072
7	Wermapraxis		2020-10-06 15:26:16.602785	2020-10-06 15:26:16.602785
8	Mitgefühl-Meditationspraxis		2020-10-06 15:30:25.170024	2020-10-06 15:30:25.170024
9	Shambhala V		2020-10-06 15:43:11.999103	2020-10-06 15:43:11.999103
10	ITS Herzsutra	\N	2020-10-08 06:56:51.898672	2020-10-08 06:56:51.898672
11	Kyudo-Panhelvetic	\N	2020-10-08 06:59:11.701608	2020-10-08 06:59:11.701608
12	Tara Mandala	\N	2020-12-31 13:52:23.882035	2020-12-31 13:52:23.882035
13	Shambhalatag Morgen	\N	2021-02-01 07:17:28.047685	2021-02-01 07:17:28.047685
14	Shambhalatag Abend	\N	2021-02-01 07:18:29.571157	2021-02-01 07:18:29.571157
15	Fremdnutzung	\N	2021-03-12 12:54:38.229568	2021-03-12 12:54:38.229568
48	Werma Study	\N	2021-04-30 14:45:42.487256	2021-04-30 14:45:42.487256
49	Mitglied Versammlung	\N	2021-05-31 17:38:06.99464	2021-05-31 17:38:06.99464
\.


--
-- Data for Name: repeat_bookings; Type: TABLE DATA; Schema: public; Owner: shzeqjftbzzfxa
--

COPY "public"."repeat_bookings" ("id", "repeat_every", "repeat_unit", "repeat_ordinal", "repeat_choice", "repeat_until_date", "host_name", "alert_notice", "start_date", "end_date", "start_time", "end_time", "start_date_time", "end_date_time", "is_cancelled", "event_id", "space_id", "created_at", "updated_at") FROM stdin;
1	2	week		sat	2021-04-08			2021-01-09	2021-01-09	10:00:00	12:00:00	2021-01-09 10:00:00	2021-01-09 12:00:00	f	1	1	2020-12-08 11:14:54.972565	2020-12-08 11:14:54.972565
4	2	week		sat	2021-12-22			2021-05-08	2021-05-08	10:00:00	12:00:00	2021-05-08 10:00:00	2021-05-08 12:00:00	f	1	1	2020-12-08 11:31:41.661228	2020-12-08 11:31:41.661228
5	1	week		wed	2021-12-22			2021-01-06	2021-01-06	18:30:00	20:00:00	2021-01-06 18:30:00	2021-01-06 20:00:00	f	4	1	2020-12-08 11:35:51.522744	2020-12-08 11:35:51.522744
8	3	week		sun	2021-12-31	Petra		2021-01-10	2021-01-10	18:00:00	22:00:00	2021-01-10 18:00:00	2021-01-10 22:00:00	f	12	1	2020-12-31 13:52:23.887208	2020-12-31 13:52:23.887208
9	1	week		sun	2021-12-24	Petra		2021-01-17	2021-01-17	18:00:00	22:00:00	2021-01-17 18:00:00	2021-01-17 22:00:00	f	12	1	2020-12-31 14:06:26.524255	2020-12-31 14:06:26.524255
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: shzeqjftbzzfxa
--

COPY "public"."reservations" ("id", "host_name", "alert_notice", "start_date", "end_date", "start_time", "end_time", "start_date_time", "end_date_time", "is_cancelled", "event_id", "space_id", "created_at", "updated_at", "repeat_booking_id", "remote_link") FROM stdin;
92			2021-07-03	2021-07-03	10:00:00	12:00:00	2021-07-03 10:00:00	2021-07-03 12:00:00	f	1	1	2020-12-08 11:31:41.708784	2020-12-08 11:31:41.708784	4	\N
93			2021-07-17	2021-07-17	10:00:00	12:00:00	2021-07-17 10:00:00	2021-07-17 12:00:00	f	1	1	2020-12-08 11:31:41.717895	2020-12-08 11:31:41.717895	4	\N
94			2021-07-31	2021-07-31	10:00:00	12:00:00	2021-07-31 10:00:00	2021-07-31 12:00:00	f	1	1	2020-12-08 11:31:41.727307	2020-12-08 11:31:41.727307	4	\N
95			2021-08-14	2021-08-14	10:00:00	12:00:00	2021-08-14 10:00:00	2021-08-14 12:00:00	f	1	1	2020-12-08 11:31:41.737448	2020-12-08 11:31:41.737448	4	\N
96			2021-08-28	2021-08-28	10:00:00	12:00:00	2021-08-28 10:00:00	2021-08-28 12:00:00	f	1	1	2020-12-08 11:31:41.749463	2020-12-08 11:31:41.749463	4	\N
4	Toni		2020-10-10	2020-10-10	10:00:00	12:00:00	2020-10-10 10:00:00	2020-10-10 12:00:00	f	1	1	2020-10-06 15:17:55.406016	2020-10-06 15:18:15.374961	\N	\N
97			2021-09-11	2021-09-11	10:00:00	12:00:00	2021-09-11 10:00:00	2021-09-11 12:00:00	f	1	1	2020-12-08 11:31:41.767356	2020-12-08 11:31:41.767356	4	\N
98			2021-09-25	2021-09-25	10:00:00	12:00:00	2021-09-25 10:00:00	2021-09-25 12:00:00	f	1	1	2020-12-08 11:31:41.779704	2020-12-08 11:31:41.779704	4	\N
99			2021-10-09	2021-10-09	10:00:00	12:00:00	2021-10-09 10:00:00	2021-10-09 12:00:00	f	1	1	2020-12-08 11:31:41.790336	2020-12-08 11:31:41.790336	4	\N
10	Toni		2020-10-24	2020-10-24	10:00:00	12:00:00	2020-10-24 10:00:00	2020-10-24 12:00:00	f	1	1	2020-10-06 15:29:03.373363	2020-10-06 15:29:03.373363	\N	\N
11	Regula		2020-10-21	2020-10-21	18:30:00	20:00:00	2020-10-21 18:30:00	2020-10-21 20:00:00	f	8	1	2020-10-06 15:30:25.172477	2020-10-06 15:30:25.172477	\N	\N
28	Toni		2020-12-05	2020-12-05	09:00:00	11:00:00	2020-12-05 10:00:00	2020-12-05 12:00:00	f	1	1	2020-10-11 07:02:39.509499	2020-11-01 11:09:51.428225	\N	\N
9	Helen		2020-11-14	2020-11-14	09:00:00	11:00:00	2020-11-14 10:00:00	2020-11-14 12:00:00	f	1	1	2020-10-06 15:28:28.881091	2020-11-01 11:10:41.382842	\N	\N
100			2021-10-23	2021-10-23	10:00:00	12:00:00	2021-10-23 10:00:00	2021-10-23 12:00:00	f	1	1	2020-12-08 11:31:41.803571	2020-12-08 11:31:41.803571	4	\N
14			2020-11-11	2020-11-11	18:30:00	20:00:00	2020-11-11 18:30:00	2020-11-11 20:00:00	f	4	1	2020-10-06 15:40:39.539519	2020-10-06 15:40:39.539519	\N	\N
101			2021-11-06	2021-11-06	10:00:00	12:00:00	2021-11-06 10:00:00	2021-11-06 12:00:00	f	1	1	2020-12-08 11:31:41.815855	2020-12-08 11:31:41.815855	4	\N
15	Regula		2020-11-27	2020-11-29	16:00:00	17:00:00	2020-11-27 16:00:00	2020-11-29 17:00:00	f	9	1	2020-10-06 15:43:12.001509	2020-10-06 15:44:14.500002	\N	\N
102			2021-11-20	2021-11-20	10:00:00	12:00:00	2021-11-20 10:00:00	2021-11-20 12:00:00	f	1	1	2020-12-08 11:31:41.825266	2020-12-08 11:31:41.825266	4	\N
5	Walter		2020-10-14	2020-10-14	18:30:00	20:00:00	2020-10-14 18:30:00	2020-10-14 20:00:00	f	4	1	2020-10-06 15:19:50.126087	2020-10-07 16:23:33.869896	\N	\N
17	Matthias		2020-10-07	2020-10-07	18:30:00	20:00:00	2020-10-07 18:30:00	2020-10-07 20:00:00	f	4	1	2020-10-08 06:55:09.996913	2020-10-08 06:55:09.996913	\N	\N
18	May		2020-10-17	2020-10-18	09:00:00	17:00:00	2020-10-17 09:00:00	2020-10-18 17:00:00	f	10	1	2020-10-08 06:56:51.906374	2020-10-08 06:56:51.906374	\N	\N
19	Toni	10 Kissen und Unterlagen sind am Panhelvetic	2020-10-30	2020-11-01	13:00:00	18:00:00	2020-10-30 13:00:00	2020-11-01 18:00:00	f	11	1	2020-10-08 06:59:11.704453	2020-10-08 06:59:11.704453	\N	\N
22			2020-12-02	2020-12-02	18:30:00	20:00:00	2020-12-02 18:30:00	2020-12-02 20:00:00	f	4	1	2020-10-08 07:03:35.580492	2020-10-08 07:03:35.580492	\N	\N
90	Helen		2021-06-05	2021-06-05	10:00:00	12:00:00	2021-06-05 10:00:00	2021-06-05 12:00:00	f	1	1	2020-12-08 11:31:41.68903	2020-12-31 13:42:37.737799	4	\N
25			2020-12-23	2020-12-23	18:30:00	20:00:00	2020-12-23 18:30:00	2020-12-23 20:00:00	f	4	1	2020-10-08 07:04:47.393119	2020-10-08 07:04:47.393119	\N	\N
26			2020-12-30	2020-12-30	18:30:00	20:00:00	2020-12-30 18:30:00	2020-12-30 20:00:00	f	4	1	2020-10-08 07:05:12.308554	2020-10-08 07:05:12.308554	\N	\N
27	Toni		2020-12-16	2020-12-16	18:30:00	20:00:00	2020-12-16 18:30:00	2020-12-16 20:00:00	f	8	1	2020-10-08 07:05:50.405607	2020-10-08 07:05:50.405607	\N	\N
91	Helen		2021-06-19	2021-06-19	10:00:00	12:00:00	2021-06-19 10:00:00	2021-06-19 12:00:00	f	1	1	2020-12-08 11:31:41.699035	2020-12-31 13:43:07.753556	4	\N
30	Toni		2020-12-12	2020-12-12	10:00:00	12:00:00	2020-12-12 10:00:00	2020-12-12 12:00:00	f	1	1	2020-10-11 07:03:56.894737	2020-10-11 07:03:56.894737	\N	\N
20	Regula		2020-11-04	2020-11-04	18:30:00	20:00:00	2020-11-04 18:30:00	2020-11-04 20:00:00	f	4	1	2020-10-08 07:00:04.648327	2020-11-04 11:45:43.416656	\N	\N
88	Toni		2021-05-08	2021-05-08	10:00:00	12:00:00	2021-05-08 10:00:00	2021-05-08 12:00:00	f	1	1	2020-12-08 11:31:41.664645	2020-12-31 13:44:56.996156	4	\N
12	Matthias		2020-10-28	2020-10-28	18:30:00	20:00:00	2020-10-28 18:30:00	2020-10-28 20:00:00	f	4	1	2020-10-06 15:39:07.341681	2020-10-14 16:28:53.024165	\N	\N
52	Toni		2021-04-24	2021-04-24	10:00:00	12:00:00	2021-04-24 10:00:00	2021-04-24 12:00:00	f	1	1	2020-12-08 11:20:26.515991	2020-12-31 13:45:24.590506	\N	\N
50	Toni		2021-04-10	2021-04-10	10:00:00	12:00:00	2021-04-10 10:00:00	2021-04-10 12:00:00	f	1	1	2020-12-08 11:14:55.102693	2020-12-31 13:45:32.977063	1	\N
49	Regula		2021-03-20	2021-03-20	09:00:00	13:00:00	2021-03-20 09:00:00	2021-03-20 13:00:00	f	15	1	2020-12-08 11:14:55.092961	2021-03-12 12:56:20.097297	1	
48	Helen		2021-03-06	2021-03-06	10:00:00	12:00:00	2021-03-06 10:00:00	2021-03-06 12:00:00	f	1	1	2020-12-08 11:14:55.077301	2020-12-31 13:46:01.825289	1	\N
47	Helen		2021-02-20	2021-02-20	10:00:00	12:00:00	2021-02-20 10:00:00	2021-02-20 12:00:00	f	1	1	2020-12-08 11:14:55.067327	2020-12-31 13:46:22.474345	1	\N
16	Toni		2020-11-18	2020-11-18	18:30:00	20:00:00	2020-11-18 19:30:00	2020-11-18 21:00:00	f	8	1	2020-10-06 15:45:21.822606	2020-10-28 16:42:29.592628	\N	\N
46	Toni		2021-02-07	2021-02-07	10:00:00	12:00:00	2021-02-07 10:00:00	2021-02-07 12:00:00	f	1	1	2020-12-08 11:14:55.057249	2020-12-31 13:46:33.267315	1	\N
45	Toni		2021-01-23	2021-01-23	10:00:00	12:00:00	2021-01-23 10:00:00	2021-01-23 12:00:00	f	1	1	2020-12-08 11:14:55.047784	2020-12-31 13:46:46.179424	1	\N
44	Toni		2021-01-09	2021-01-09	10:00:00	12:00:00	2021-01-09 10:00:00	2021-01-09 12:00:00	f	1	1	2020-12-08 11:14:55.029172	2020-12-31 13:46:55.294264	1	\N
34	Marianne		2021-03-07	2021-03-07	09:30:00	17:00:00	2021-03-07 09:30:00	2021-03-07 17:00:00	f	7	1	2020-10-29 09:24:09.739311	2021-02-13 11:59:59.303423	\N	https://zoom.us/j/98790197556
35	Marianne		2021-04-03	2021-04-03	09:30:00	17:00:00	2021-04-03 09:30:00	2021-04-03 17:00:00	f	7	1	2020-10-29 09:25:15.454496	2021-03-28 17:15:37.236338	\N	Vormittag: https://zoom.us/j/91835287473
37	Marianne		2021-06-06	2021-06-06	09:30:00	17:00:00	2021-06-06 09:30:00	2021-06-06 17:00:00	f	7	1	2020-10-29 09:25:52.105945	2021-05-29 13:12:17.678474	\N	Vormittag - https://zoom.us/j/94716895974 nachmittag - https://zoom.us/j/94039084723
41	Marianne		2021-10-02	2021-10-02	09:30:00	17:00:00	2021-10-02 09:30:00	2021-10-02 17:00:00	f	7	1	2020-10-29 09:26:59.264361	2020-11-05 15:12:06.150487	\N	\N
42	Marianne		2021-11-07	2021-11-07	09:30:00	17:00:00	2021-11-07 09:30:00	2021-11-07 17:00:00	f	7	1	2020-10-29 09:27:12.453087	2020-11-05 15:12:32.410317	\N	\N
43	Marianne		2021-12-05	2021-12-05	09:30:00	17:00:00	2021-12-05 09:30:00	2021-12-05 17:00:00	f	7	1	2020-10-29 09:27:26.177003	2020-11-05 15:12:57.223298	\N	\N
40	Marianne		2021-09-04	2021-09-04	09:30:00	17:00:00	2021-09-04 09:30:00	2021-09-04 17:00:00	f	7	1	2020-10-29 09:26:46.440202	2020-11-05 15:13:22.605873	\N	\N
39	Marianne		2021-08-07	2021-08-07	09:30:00	17:00:00	2021-08-07 09:30:00	2021-08-07 17:00:00	f	7	1	2020-10-29 09:26:32.465487	2020-11-05 15:13:36.239999	\N	\N
32	Marianne		2021-02-06	2021-02-06	09:30:00	17:00:00	2021-02-06 09:30:00	2021-02-06 17:00:00	f	7	1	2020-10-25 17:54:52.245543	2020-11-05 15:14:55.398117	\N	\N
31	Marianne		2021-01-10	2021-01-10	09:30:00	17:00:00	2021-01-10 09:30:00	2021-01-10 17:00:00	f	7	1	2020-10-20 10:38:15.642137	2020-11-05 15:15:16.482275	\N	\N
29	Marianne		2020-12-06	2020-12-06	09:30:00	17:00:00	2020-12-06 09:30:00	2020-12-06 17:00:00	f	7	1	2020-10-11 07:03:32.641005	2020-11-05 15:15:47.610222	\N	\N
8	Marianne		2020-11-07	2020-11-07	09:30:00	17:00:00	2020-11-07 09:30:00	2020-11-07 17:00:00	f	7	1	2020-10-06 15:26:16.71451	2020-11-05 15:16:10.201661	\N	\N
21	Walter		2020-11-25	2020-11-25	18:30:00	20:00:00	2020-11-25 18:30:00	2020-11-25 20:00:00	f	4	1	2020-10-08 07:00:33.92347	2020-11-23 15:22:26.415119	\N	\N
23	Matthias		2020-12-09	2020-12-09	18:30:00	20:00:00	2020-12-09 18:30:00	2020-12-09 20:00:00	f	4	1	2020-10-08 07:04:01.470198	2020-12-04 10:04:31.381372	\N	\N
51			2020-04-10	2020-12-23	10:00:00	12:00:00	2020-04-10 10:00:00	2020-12-23 12:00:00	f	1	1	2020-12-08 11:19:37.608132	2020-12-08 11:19:37.608132	\N	\N
103			2021-12-04	2021-12-04	10:00:00	12:00:00	2021-12-04 10:00:00	2021-12-04 12:00:00	f	1	1	2020-12-08 11:31:41.834925	2020-12-08 11:31:41.834925	4	\N
104			2021-12-18	2021-12-18	10:00:00	12:00:00	2021-12-18 10:00:00	2021-12-18 12:00:00	f	1	1	2020-12-08 11:31:41.844231	2020-12-08 11:31:41.844231	4	\N
105			2021-01-06	2021-01-06	18:30:00	20:00:00	2021-01-06 18:30:00	2021-01-06 20:00:00	f	4	1	2020-12-08 11:35:51.526122	2020-12-08 11:35:51.526122	5	\N
108			2021-01-27	2021-01-27	18:30:00	20:00:00	2021-01-27 18:30:00	2021-01-27 20:00:00	f	4	1	2020-12-08 11:35:51.561236	2020-12-08 11:35:51.561236	5	\N
109			2021-02-03	2021-02-03	18:30:00	20:00:00	2021-02-03 18:30:00	2021-02-03 20:00:00	f	4	1	2020-12-08 11:35:51.570471	2020-12-08 11:35:51.570471	5	\N
113			2021-03-03	2021-03-03	18:30:00	20:00:00	2021-03-03 18:30:00	2021-03-03 20:00:00	f	4	1	2020-12-08 11:35:51.61067	2020-12-08 11:35:51.61067	5	\N
114			2021-03-10	2021-03-10	18:30:00	20:00:00	2021-03-10 18:30:00	2021-03-10 20:00:00	f	4	1	2020-12-08 11:35:51.626015	2020-12-08 11:35:51.626015	5	\N
115			2021-03-17	2021-03-17	18:30:00	20:00:00	2021-03-17 18:30:00	2021-03-17 20:00:00	f	4	1	2020-12-08 11:35:51.637863	2020-12-08 11:35:51.637863	5	\N
116			2021-03-24	2021-03-24	18:30:00	20:00:00	2021-03-24 18:30:00	2021-03-24 20:00:00	f	4	1	2020-12-08 11:35:51.648911	2020-12-08 11:35:51.648911	5	\N
117			2021-03-31	2021-03-31	18:30:00	20:00:00	2021-03-31 18:30:00	2021-03-31 20:00:00	f	4	1	2020-12-08 11:35:51.664964	2020-12-08 11:35:51.664964	5	\N
118			2021-04-07	2021-04-07	18:30:00	20:00:00	2021-04-07 18:30:00	2021-04-07 20:00:00	f	4	1	2020-12-08 11:35:51.67455	2020-12-08 11:35:51.67455	5	\N
119			2021-04-14	2021-04-14	18:30:00	20:00:00	2021-04-14 18:30:00	2021-04-14 20:00:00	f	4	1	2020-12-08 11:35:51.685042	2020-12-08 11:35:51.685042	5	\N
120			2021-04-21	2021-04-21	18:30:00	20:00:00	2021-04-21 18:30:00	2021-04-21 20:00:00	f	4	1	2020-12-08 11:35:51.695856	2020-12-08 11:35:51.695856	5	\N
121			2021-04-28	2021-04-28	18:30:00	20:00:00	2021-04-28 18:30:00	2021-04-28 20:00:00	f	4	1	2020-12-08 11:35:51.70507	2020-12-08 11:35:51.70507	5	\N
122			2021-05-05	2021-05-05	18:30:00	20:00:00	2021-05-05 18:30:00	2021-05-05 20:00:00	f	4	1	2020-12-08 11:35:51.713803	2020-12-08 11:35:51.713803	5	\N
123			2021-05-12	2021-05-12	18:30:00	20:00:00	2021-05-12 18:30:00	2021-05-12 20:00:00	f	4	1	2020-12-08 11:35:51.72224	2020-12-08 11:35:51.72224	5	\N
124			2021-05-19	2021-05-19	18:30:00	20:00:00	2021-05-19 18:30:00	2021-05-19 20:00:00	f	4	1	2020-12-08 11:35:51.730612	2020-12-08 11:35:51.730612	5	\N
125			2021-05-26	2021-05-26	18:30:00	20:00:00	2021-05-26 18:30:00	2021-05-26 20:00:00	f	4	1	2020-12-08 11:35:51.739167	2020-12-08 11:35:51.739167	5	\N
126			2021-06-02	2021-06-02	18:30:00	20:00:00	2021-06-02 18:30:00	2021-06-02 20:00:00	f	4	1	2020-12-08 11:35:51.749216	2020-12-08 11:35:51.749216	5	\N
127			2021-06-09	2021-06-09	18:30:00	20:00:00	2021-06-09 18:30:00	2021-06-09 20:00:00	f	4	1	2020-12-08 11:35:51.75795	2020-12-08 11:35:51.75795	5	\N
128			2021-06-16	2021-06-16	18:30:00	20:00:00	2021-06-16 18:30:00	2021-06-16 20:00:00	f	4	1	2020-12-08 11:35:51.771036	2020-12-08 11:35:51.771036	5	\N
129			2021-06-23	2021-06-23	18:30:00	20:00:00	2021-06-23 18:30:00	2021-06-23 20:00:00	f	4	1	2020-12-08 11:35:51.780322	2020-12-08 11:35:51.780322	5	\N
130			2021-06-30	2021-06-30	18:30:00	20:00:00	2021-06-30 18:30:00	2021-06-30 20:00:00	f	4	1	2020-12-08 11:35:51.791796	2020-12-08 11:35:51.791796	5	\N
131			2021-07-07	2021-07-07	18:30:00	20:00:00	2021-07-07 18:30:00	2021-07-07 20:00:00	f	4	1	2020-12-08 11:35:51.802628	2020-12-08 11:35:51.802628	5	\N
132			2021-07-14	2021-07-14	18:30:00	20:00:00	2021-07-14 18:30:00	2021-07-14 20:00:00	f	4	1	2020-12-08 11:35:51.811869	2020-12-08 11:35:51.811869	5	\N
133			2021-07-21	2021-07-21	18:30:00	20:00:00	2021-07-21 18:30:00	2021-07-21 20:00:00	f	4	1	2020-12-08 11:35:51.821376	2020-12-08 11:35:51.821376	5	\N
134			2021-07-28	2021-07-28	18:30:00	20:00:00	2021-07-28 18:30:00	2021-07-28 20:00:00	f	4	1	2020-12-08 11:35:51.831818	2020-12-08 11:35:51.831818	5	\N
135			2021-08-04	2021-08-04	18:30:00	20:00:00	2021-08-04 18:30:00	2021-08-04 20:00:00	f	4	1	2020-12-08 11:35:51.842104	2020-12-08 11:35:51.842104	5	\N
136			2021-08-11	2021-08-11	18:30:00	20:00:00	2021-08-11 18:30:00	2021-08-11 20:00:00	f	4	1	2020-12-08 11:35:51.853069	2020-12-08 11:35:51.853069	5	\N
137			2021-08-18	2021-08-18	18:30:00	20:00:00	2021-08-18 18:30:00	2021-08-18 20:00:00	f	4	1	2020-12-08 11:35:51.863901	2020-12-08 11:35:51.863901	5	\N
138			2021-08-25	2021-08-25	18:30:00	20:00:00	2021-08-25 18:30:00	2021-08-25 20:00:00	f	4	1	2020-12-08 11:35:51.87526	2020-12-08 11:35:51.87526	5	\N
139			2021-09-01	2021-09-01	18:30:00	20:00:00	2021-09-01 18:30:00	2021-09-01 20:00:00	f	4	1	2020-12-08 11:35:51.888181	2020-12-08 11:35:51.888181	5	\N
140			2021-09-08	2021-09-08	18:30:00	20:00:00	2021-09-08 18:30:00	2021-09-08 20:00:00	f	4	1	2020-12-08 11:35:51.901151	2020-12-08 11:35:51.901151	5	\N
141			2021-09-15	2021-09-15	18:30:00	20:00:00	2021-09-15 18:30:00	2021-09-15 20:00:00	f	4	1	2020-12-08 11:35:51.913891	2020-12-08 11:35:51.913891	5	\N
142			2021-09-22	2021-09-22	18:30:00	20:00:00	2021-09-22 18:30:00	2021-09-22 20:00:00	f	4	1	2020-12-08 11:35:51.925216	2020-12-08 11:35:51.925216	5	\N
143			2021-09-29	2021-09-29	18:30:00	20:00:00	2021-09-29 18:30:00	2021-09-29 20:00:00	f	4	1	2020-12-08 11:35:51.943332	2020-12-08 11:35:51.943332	5	\N
144			2021-10-06	2021-10-06	18:30:00	20:00:00	2021-10-06 18:30:00	2021-10-06 20:00:00	f	4	1	2020-12-08 11:35:51.953103	2020-12-08 11:35:51.953103	5	\N
145			2021-10-13	2021-10-13	18:30:00	20:00:00	2021-10-13 18:30:00	2021-10-13 20:00:00	f	4	1	2020-12-08 11:35:51.963024	2020-12-08 11:35:51.963024	5	\N
146			2021-10-20	2021-10-20	18:30:00	20:00:00	2021-10-20 18:30:00	2021-10-20 20:00:00	f	4	1	2020-12-08 11:35:51.973598	2020-12-08 11:35:51.973598	5	\N
147			2021-10-27	2021-10-27	18:30:00	20:00:00	2021-10-27 18:30:00	2021-10-27 20:00:00	f	4	1	2020-12-08 11:35:51.984192	2020-12-08 11:35:51.984192	5	\N
148			2021-11-03	2021-11-03	18:30:00	20:00:00	2021-11-03 18:30:00	2021-11-03 20:00:00	f	4	1	2020-12-08 11:35:51.993769	2020-12-08 11:35:51.993769	5	\N
149			2021-11-10	2021-11-10	18:30:00	20:00:00	2021-11-10 18:30:00	2021-11-10 20:00:00	f	4	1	2020-12-08 11:35:52.006307	2020-12-08 11:35:52.006307	5	\N
150			2021-11-17	2021-11-17	18:30:00	20:00:00	2021-11-17 18:30:00	2021-11-17 20:00:00	f	4	1	2020-12-08 11:35:52.017134	2020-12-08 11:35:52.017134	5	\N
151			2021-11-24	2021-11-24	18:30:00	20:00:00	2021-11-24 18:30:00	2021-11-24 20:00:00	f	4	1	2020-12-08 11:35:52.031014	2020-12-08 11:35:52.031014	5	\N
152			2021-12-01	2021-12-01	18:30:00	20:00:00	2021-12-01 18:30:00	2021-12-01 20:00:00	f	4	1	2020-12-08 11:35:52.040908	2020-12-08 11:35:52.040908	5	\N
153			2021-12-08	2021-12-08	18:30:00	20:00:00	2021-12-08 18:30:00	2021-12-08 20:00:00	f	4	1	2020-12-08 11:35:52.04972	2020-12-08 11:35:52.04972	5	\N
154			2021-12-15	2021-12-15	18:30:00	20:00:00	2021-12-15 18:30:00	2021-12-15 20:00:00	f	4	1	2020-12-08 11:35:52.059012	2020-12-08 11:35:52.059012	5	\N
155			2021-12-22	2021-12-22	18:30:00	20:00:00	2021-12-22 18:30:00	2021-12-22 20:00:00	f	4	1	2020-12-08 11:35:52.08529	2020-12-08 11:35:52.08529	5	\N
107			2021-01-20	2021-01-20	18:30:00	20:00:00	2021-01-20 18:30:00	2021-01-20 20:00:00	f	8	1	2020-12-08 11:35:51.55189	2020-12-08 11:36:51.49677	5	\N
106	Walter		2021-01-13	2021-01-13	18:30:00	20:00:00	2021-01-13 18:30:00	2021-01-13 20:00:00	f	4	1	2020-12-08 11:35:51.542847	2020-12-09 07:56:24.838424	5	\N
159	Petra		2021-01-31	2021-01-31	18:00:00	22:00:00	2021-01-31 18:00:00	2021-01-31 22:00:00	f	12	1	2020-12-31 13:52:23.905965	2020-12-31 13:52:23.905965	8	\N
110	Walter		2021-02-10	2021-02-10	18:30:00	20:00:00	2021-02-10 18:30:00	2021-02-10 20:00:00	f	4	1	2020-12-08 11:35:51.580504	2020-12-09 07:56:53.92444	5	\N
89	Helen		2021-05-22	2021-05-22	10:00:00	12:00:00	2021-05-22 10:00:00	2021-05-22 12:00:00	f	1	1	2020-12-08 11:31:41.679173	2020-12-31 13:42:22.909686	4	\N
158	Petra		2021-01-10	2021-01-10	18:00:00	22:00:00	2021-01-10 18:00:00	2021-01-10 22:00:00	f	12	1	2020-12-31 13:52:23.890834	2020-12-31 13:52:23.890834	8	\N
160	Petra		2021-02-21	2021-02-21	18:00:00	22:00:00	2021-02-21 18:00:00	2021-02-21 22:00:00	f	12	1	2020-12-31 13:52:23.91903	2020-12-31 13:52:23.91903	8	\N
161	Petra		2021-03-14	2021-03-14	18:00:00	22:00:00	2021-03-14 18:00:00	2021-03-14 22:00:00	f	12	1	2020-12-31 13:52:23.927823	2020-12-31 13:52:23.927823	8	\N
162	Petra		2021-04-04	2021-04-04	18:00:00	22:00:00	2021-04-04 18:00:00	2021-04-04 22:00:00	f	12	1	2020-12-31 13:52:23.936685	2020-12-31 13:52:23.936685	8	\N
163	Petra		2021-04-25	2021-04-25	18:00:00	22:00:00	2021-04-25 18:00:00	2021-04-25 22:00:00	f	12	1	2020-12-31 13:52:23.945485	2020-12-31 13:52:23.945485	8	\N
164	Petra		2021-05-16	2021-05-16	18:00:00	22:00:00	2021-05-16 18:00:00	2021-05-16 22:00:00	f	12	1	2020-12-31 13:52:23.95457	2020-12-31 13:52:23.95457	8	\N
112	Toni		2021-02-24	2021-02-24	18:30:00	20:00:00	2021-02-24 18:30:00	2021-02-24 20:00:00	f	4	1	2020-12-08 11:35:51.59956	2021-02-22 11:50:53.219046	5	
165	Petra		2021-06-06	2021-06-06	18:00:00	22:00:00	2021-06-06 18:00:00	2021-06-06 22:00:00	f	12	1	2020-12-31 13:52:23.963652	2020-12-31 13:52:23.963652	8	\N
166	Petra		2021-06-27	2021-06-27	18:00:00	22:00:00	2021-06-27 18:00:00	2021-06-27 22:00:00	f	12	1	2020-12-31 13:52:23.974138	2020-12-31 13:52:23.974138	8	\N
167	Petra		2021-07-18	2021-07-18	18:00:00	22:00:00	2021-07-18 18:00:00	2021-07-18 22:00:00	f	12	1	2020-12-31 13:52:23.983149	2020-12-31 13:52:23.983149	8	\N
168	Petra		2021-08-08	2021-08-08	18:00:00	22:00:00	2021-08-08 18:00:00	2021-08-08 22:00:00	f	12	1	2020-12-31 13:52:23.995396	2020-12-31 13:52:23.995396	8	\N
169	Petra		2021-08-29	2021-08-29	18:00:00	22:00:00	2021-08-29 18:00:00	2021-08-29 22:00:00	f	12	1	2020-12-31 13:52:24.004649	2020-12-31 13:52:24.004649	8	\N
170	Petra		2021-09-19	2021-09-19	18:00:00	22:00:00	2021-09-19 18:00:00	2021-09-19 22:00:00	f	12	1	2020-12-31 13:52:24.014234	2020-12-31 13:52:24.014234	8	\N
171	Petra		2021-10-10	2021-10-10	18:00:00	22:00:00	2021-10-10 18:00:00	2021-10-10 22:00:00	f	12	1	2020-12-31 13:52:24.023991	2020-12-31 13:52:24.023991	8	\N
172	Petra		2021-10-31	2021-10-31	18:00:00	22:00:00	2021-10-31 18:00:00	2021-10-31 22:00:00	f	12	1	2020-12-31 13:52:24.033319	2020-12-31 13:52:24.033319	8	\N
173	Petra		2021-11-21	2021-11-21	18:00:00	22:00:00	2021-11-21 18:00:00	2021-11-21 22:00:00	f	12	1	2020-12-31 13:52:24.044685	2020-12-31 13:52:24.044685	8	\N
174	Petra		2021-12-12	2021-12-12	18:00:00	22:00:00	2021-12-12 18:00:00	2021-12-12 22:00:00	f	12	1	2020-12-31 13:52:24.061687	2020-12-31 13:52:24.061687	8	\N
175	Petra		2021-01-17	2021-01-17	18:00:00	22:00:00	2021-01-17 18:00:00	2021-01-17 22:00:00	f	12	1	2020-12-31 14:06:26.527992	2020-12-31 14:06:26.527992	9	\N
176	Petra		2021-01-24	2021-01-24	18:00:00	22:00:00	2021-01-24 18:00:00	2021-01-24 22:00:00	f	12	1	2020-12-31 14:06:26.542457	2020-12-31 14:06:26.542457	9	\N
178	Bill		2021-02-12	2021-02-12	07:30:00	09:00:00	2021-02-12 07:30:00	2021-02-12 09:00:00	f	13	1	2021-02-01 07:17:28.054281	2021-02-01 07:17:28.054281	\N	\N
179	Bill / Eberhard		2021-02-12	2021-02-12	18:30:00	20:00:00	2021-02-12 18:30:00	2021-02-12 20:00:00	f	14	1	2021-02-01 07:18:29.58848	2021-02-01 07:18:29.58848	\N	\N
111	Toni		2021-02-17	2021-02-17	18:30:00	20:00:00	2021-02-17 18:30:00	2021-02-17 20:00:00	f	4	1	2020-12-08 11:35:51.589421	2021-02-14 12:07:52.266297	5	https://zoom.us/j/98503226786?pwd=WUJ2M2FweTBFYUdWMlBzeTBtZDFUQT09
180	Petra		2021-04-13	2021-04-18	13:00:00	21:00:00	2021-04-13 13:00:00	2021-04-18 21:00:00	f	12	1	2021-03-21 12:21:11.718031	2021-03-21 12:21:11.718031	\N	
36	Marianne		2021-05-01	2021-05-01	09:30:00	17:00:00	2021-05-01 09:30:00	2021-05-01 17:00:00	f	7	1	2020-10-29 09:25:35.074733	2021-04-26 19:33:17.618437	\N	* Vormittag: https://zoom.us/j/91011488791 * Nachmittag: https://zoom.us/j/98375802684
181	Zeno und Monika		2021-05-02	2021-05-02	11:00:00	18:00:00	2021-05-02 11:00:00	2021-05-02 18:00:00	f	48	1	2021-04-30 14:45:42.493327	2021-04-30 14:45:42.493327	\N	
182			2021-10-23	2021-10-23	13:00:00	16:00:00	2021-10-23 13:00:00	2021-10-23 16:00:00	f	49	1	2021-05-31 17:38:07.013743	2021-05-31 17:38:07.013743	\N	
183	Marianne		2021-07-04	2021-07-04	10:00:00	17:00:00	2021-07-04 10:00:00	2021-07-04 17:00:00	f	7	1	2021-06-06 10:35:35.479009	2021-06-06 13:59:53.571146	\N	Vormittag - https://zoom.us/j/96510377484 Nachmittag - https://zoom.us/j/91990769143
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: shzeqjftbzzfxa
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
\.


--
-- Data for Name: spaces; Type: TABLE DATA; Schema: public; Owner: shzeqjftbzzfxa
--

COPY "public"."spaces" ("id", "space_name", "space_location", "publicly_visible", "created_at", "updated_at") FROM stdin;
1	Zentrum	\N	t	2020-10-06 10:37:48.602222	2020-10-06 10:37:48.602222
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: shzeqjftbzzfxa
--

COPY "public"."users" ("id", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "sign_in_count", "current_sign_in_at", "last_sign_in_at", "current_sign_in_ip", "last_sign_in_ip", "confirmation_token", "confirmed_at", "confirmation_sent_at", "unconfirmed_email", "failed_attempts", "unlock_token", "locked_at", "created_at", "updated_at", "real_name", "username", "access_role") FROM stdin;
13	monika.kunz@gmx.ch	$2a$12$sY4dQ1ZKxasnn4wBK89HeOkBE3JyKRRJwJf/LIqdQM.mr2EXFCDMS	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:28:21.282365	2020-10-09 18:37:30.007878	Monika Kunz	monika	viewer
4	petra.kruger@bluewin.ch	$2a$12$Mw32ihup.B6UAQZEHXRBv.lhhRBL5PsplnZEXeIcl95MxtiFpsJvO	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-06 14:08:23.473533	2020-10-09 18:37:39.308548	Petra Kruger	petra	viewer
3	regulastoeckli@bluewin.ch	$2a$12$VNkoVA3GQ6aUwk59X/wXiu6mmLSaBKCfrALGCMoywCDQ4UaWFVKmK	\N	\N	\N	2	2020-10-06 18:27:35.745655	2020-10-06 13:56:43.066578	62.202.190.201	62.202.190.201	\N	\N	\N	\N	0	\N	\N	2020-10-06 13:54:06.761737	2020-10-09 18:37:52.468325	Regula Stoeckli	regula	planner
7	walter.zanin@bluewin.ch	$2a$12$y77JvA5oCeDugIdO.TilGeAogBbnIaSW.RFBl2nhpmEYvRaf6OsKe	\N	\N	\N	5	2020-12-09 07:54:55.569509	2020-11-23 15:21:43.884984	141.101.69.37	141.101.96.138	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:11:08.986285	2020-12-09 07:54:55.570217	Walter Zanin	walter	host
19	bil.tih@container4.ch	$2a$12$J/sMnNoqZlh5GWQy4EZF9.GmGaRHPi3Og7DvJhP5YqHTCNdjfY2Uu	\N	\N	2021-04-29 09:10:40.789079	7	2021-04-30 15:12:23.241407	2021-04-29 11:59:51.082626	141.101.104.188	108.162.229.155	\N	\N	\N	\N	0	\N	\N	2020-12-07 17:44:15.562919	2021-04-30 15:12:23.241823	SHZ Bern Kalender	shzbernkalender	viewer
14	yves.hirtzel@bluewin.ch	$2a$12$rTvYM16h9dJmt3UHGci0julvcdm9sCdTjYnt93E6RLdxHS29hBMES	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:29:54.259183	2020-10-09 18:38:43.415579	Yves Hirtzel	yves	viewer
12	zeno.kupper@spk.unibe.ch	$2a$12$wNvdjrmjwJblIALnrbxTGev0h2tdHwlO2GnbtGMbV5ykjdljIgeZ2	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:26:21.445038	2020-10-09 18:38:51.561379	Zeno Kupper	zeno	viewer
10	may.isler@sunrise.ch	$2a$12$hhuUoc6gyxgfuGLWcncmUe7kL9LuqK5CMKHrkcZXv4yWhnXWsyDzm	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:24:26.619453	2020-10-09 18:39:09.767814	May Isler	may	host
1	btihen@gmail.com	$2a$12$jkSOP0CRLXg9Xo6VbS60pO05eMiDxZQ7kVB2Vx79r3wdmL7NAJski	\N	\N	\N	24	2021-05-31 17:35:09.040042	2021-05-29 13:08:55.734041	188.114.103.207	162.158.94.74	\N	\N	\N	\N	0	\N	\N	2020-10-06 10:37:12.699296	2021-05-31 17:35:09.041296	Bill Tihen	btihen	manager
15	asteinhilber@hotmail.com	$2a$12$o6m94WFQaHA9LQYYbk0WxuviQDQuANGNs5OmbJlxOUZ3qIAdjdGEW	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:30:54.025575	2020-10-09 18:35:53.673022	Agathe Steinwilber	agathe	viewer
8	heleninbasel@mac.com	$2a$12$bFunpfTZYpi8dv.fA3QLzeY5KMC8ivNj80.6HcBT3ni/HHseb1uEi	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:12:21.465791	2020-11-08 08:25:13.320512	Helen Bartenschlager	heleninbasel	viewer
17	e.timischl@gmx.ch	$2a$12$JWpVyHyiqf0kjRLLaocgFOLIeEuMSxv5Qcr6yX8iHu8ELPIEtKRxe	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:32:22.458008	2020-10-09 18:36:19.57993	Eberhard Timischl	eberhard	viewer
16	elisabeth.merkli@bluewin.ch	$2a$12$vi8lBMvQVtTVBvbnyhcONO/e27qlfsdS2Hg8ojB1VEp5sdkq113yK	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:31:39.35075	2020-10-09 18:36:28.547784	Elisabeth Merkli	elisabeth	viewer
5	msoncini@bluewin.ch	$2a$12$BEIRIEDXPs8KpUwG9nGtCeIx3I2k.VvkbwJ4R4Ohiu.QP/HbHiD7e	\N	\N	\N	12	2021-06-06 15:41:27.762827	2021-06-06 10:34:46.771978	162.158.129.34	188.114.103.192	\N	\N	\N	\N	0	\N	\N	2020-10-08 06:53:32.564002	2021-06-06 15:41:27.763257	Marianne Soncini-Ischer	marianne	planner
9	kflury@gmx.ch	$2a$12$fxfKMOLfncrqiAH0uXZYpOpy5OQbRNwMFz7bWrRI6pkeG10Cp3xfu	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:22:52.17128	2020-10-09 18:36:58.693648	Karin Flurry Kupper	karin	host
2	timfeld@gmx.ch	$2a$12$Qvyw7ANcXz6uvFCT5YtzGeu3sCwqA7izSwqQq/dzDwJBkP.c8WnKa	\N	\N	2021-06-07 18:47:50.984432	44	2021-06-14 17:48:32.92983	2021-06-14 17:14:30.649405	162.158.129.44	162.158.129.34	\N	\N	\N	\N	0	\N	\N	2020-10-06 11:35:44.190388	2021-06-14 17:48:32.930094	Toni Imfeld	timfeld	manager
11	tibipo@yahoo.de	$2a$12$7FdFZxNkClBFUXH/LsqPyuRkGbanHt8.y40rw7Qu6zziKHsPoLUhS	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:25:22.16168	2021-02-14 12:06:12.292569	Tino Bieri	tinu	host
6	malamusic@hotmail.com	$2a$12$q/ssyUrWCuad0ePVvF/US.eyEWYNyNMH17NURaYQgFalwT9vx4W.C	\N	\N	2020-10-08 17:31:24.121506	52	2020-12-19 08:42:18.584962	2020-12-18 21:06:23.659705	188.114.102.8	162.158.94.164	\N	\N	\N	\N	0	\N	\N	2020-10-08 14:08:50.63083	2020-12-19 08:42:18.585262	Matthias Lanz	matthias	host
\.


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shzeqjftbzzfxa
--

SELECT pg_catalog.setval('"public"."events_id_seq"', 49, true);


--
-- Name: repeat_bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shzeqjftbzzfxa
--

SELECT pg_catalog.setval('"public"."repeat_bookings_id_seq"', 9, true);


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shzeqjftbzzfxa
--

SELECT pg_catalog.setval('"public"."reservations_id_seq"', 183, true);


--
-- Name: spaces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shzeqjftbzzfxa
--

SELECT pg_catalog.setval('"public"."spaces_id_seq"', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shzeqjftbzzfxa
--

SELECT pg_catalog.setval('"public"."users_id_seq"', 19, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."ar_internal_metadata"
    ADD CONSTRAINT "ar_internal_metadata_pkey" PRIMARY KEY ("key");


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."events"
    ADD CONSTRAINT "events_pkey" PRIMARY KEY ("id");


--
-- Name: repeat_bookings repeat_bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."repeat_bookings"
    ADD CONSTRAINT "repeat_bookings_pkey" PRIMARY KEY ("id");


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."reservations"
    ADD CONSTRAINT "reservations_pkey" PRIMARY KEY ("id");


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."schema_migrations"
    ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");


--
-- Name: spaces spaces_pkey; Type: CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."spaces"
    ADD CONSTRAINT "spaces_pkey" PRIMARY KEY ("id");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");


--
-- Name: index_repeat_bookings_on_event_id; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE INDEX "index_repeat_bookings_on_event_id" ON "public"."repeat_bookings" USING "btree" ("event_id");


--
-- Name: index_repeat_bookings_on_space_id; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE INDEX "index_repeat_bookings_on_space_id" ON "public"."repeat_bookings" USING "btree" ("space_id");


--
-- Name: index_reservation_unique; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE UNIQUE INDEX "index_reservation_unique" ON "public"."reservations" USING "btree" ("event_id", "space_id", "start_date_time", "end_date_time");


--
-- Name: index_reservations_on_end_date; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE INDEX "index_reservations_on_end_date" ON "public"."reservations" USING "btree" ("end_date");


--
-- Name: index_reservations_on_event_id; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE INDEX "index_reservations_on_event_id" ON "public"."reservations" USING "btree" ("event_id");


--
-- Name: index_reservations_on_repeat_booking_id; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE INDEX "index_reservations_on_repeat_booking_id" ON "public"."reservations" USING "btree" ("repeat_booking_id");


--
-- Name: index_reservations_on_space_id; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE INDEX "index_reservations_on_space_id" ON "public"."reservations" USING "btree" ("space_id");


--
-- Name: index_reservations_on_start_date; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE INDEX "index_reservations_on_start_date" ON "public"."reservations" USING "btree" ("start_date");


--
-- Name: index_spaces_on_space_name; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE UNIQUE INDEX "index_spaces_on_space_name" ON "public"."spaces" USING "btree" ("space_name");


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE UNIQUE INDEX "index_users_on_confirmation_token" ON "public"."users" USING "btree" ("confirmation_token");


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE UNIQUE INDEX "index_users_on_email" ON "public"."users" USING "btree" ("email");


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "public"."users" USING "btree" ("reset_password_token");


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE UNIQUE INDEX "index_users_on_unlock_token" ON "public"."users" USING "btree" ("unlock_token");


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: shzeqjftbzzfxa
--

CREATE UNIQUE INDEX "index_users_on_username" ON "public"."users" USING "btree" ("username");


--
-- Name: reservations fk_rails_063b2ef947; Type: FK CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."reservations"
    ADD CONSTRAINT "fk_rails_063b2ef947" FOREIGN KEY ("space_id") REFERENCES "public"."spaces"("id");


--
-- Name: reservations fk_rails_5aac3ed1a5; Type: FK CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."reservations"
    ADD CONSTRAINT "fk_rails_5aac3ed1a5" FOREIGN KEY ("repeat_booking_id") REFERENCES "public"."repeat_bookings"("id");


--
-- Name: repeat_bookings fk_rails_a235ed719e; Type: FK CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."repeat_bookings"
    ADD CONSTRAINT "fk_rails_a235ed719e" FOREIGN KEY ("event_id") REFERENCES "public"."events"("id");


--
-- Name: repeat_bookings fk_rails_a54985177b; Type: FK CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."repeat_bookings"
    ADD CONSTRAINT "fk_rails_a54985177b" FOREIGN KEY ("space_id") REFERENCES "public"."spaces"("id");


--
-- Name: reservations fk_rails_af7a37539f; Type: FK CONSTRAINT; Schema: public; Owner: shzeqjftbzzfxa
--

ALTER TABLE ONLY "public"."reservations"
    ADD CONSTRAINT "fk_rails_af7a37539f" FOREIGN KEY ("event_id") REFERENCES "public"."events"("id");


--
-- PostgreSQL database dump complete
--

