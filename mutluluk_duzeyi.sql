--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 16.4

-- Started on 2024-11-14 00:03:39

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
-- TOC entry 215 (class 1259 OID 24589)
-- Name: mutluluk_verisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mutluluk_verisi (
    id integer NOT NULL,
    yil integer NOT NULL,
    yas_grubu character varying(10) NOT NULL,
    mutluluk_seviyesi character varying(20) NOT NULL,
    oran numeric(5,2) NOT NULL
);


ALTER TABLE public.mutluluk_verisi OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24588)
-- Name: mutluluk_verisi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mutluluk_verisi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mutluluk_verisi_id_seq OWNER TO postgres;

--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 214
-- Name: mutluluk_verisi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mutluluk_verisi_id_seq OWNED BY public.mutluluk_verisi.id;


--
-- TOC entry 3173 (class 2604 OID 24592)
-- Name: mutluluk_verisi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mutluluk_verisi ALTER COLUMN id SET DEFAULT nextval('public.mutluluk_verisi_id_seq'::regclass);


--
-- TOC entry 3319 (class 0 OID 24589)
-- Dependencies: 215
-- Data for Name: mutluluk_verisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mutluluk_verisi (id, yil, yas_grubu, mutluluk_seviyesi, oran) FROM stdin;
1	2003	25-34	Çok Mutlu	14.53
2	2003	25-34	Mutlu	45.40
3	2003	25-34	Orta	33.95
4	2003	25-34	Mutsuz	4.28
5	2003	25-34	Çok Mutsuz	1.85
6	2004	25-34	Çok Mutlu	9.78
7	2004	25-34	Mutlu	46.98
8	2004	25-34	Orta	31.36
9	2004	25-34	Mutsuz	9.46
10	2004	25-34	Çok Mutsuz	2.42
11	2005	25-34	Çok Mutlu	8.59
12	2005	25-34	Mutlu	47.01
13	2005	25-34	Orta	31.60
14	2005	25-34	Mutsuz	9.87
15	2005	25-34	Çok Mutsuz	2.93
16	2006	25-34	Çok Mutlu	9.69
17	2006	25-34	Mutlu	47.65
18	2006	25-34	Orta	31.31
19	2006	25-34	Mutsuz	8.81
20	2006	25-34	Çok Mutsuz	2.54
21	2007	25-34	Çok Mutlu	8.96
22	2007	25-34	Mutlu	52.40
23	2007	25-34	Orta	28.66
24	2007	25-34	Mutsuz	8.29
25	2007	25-34	Çok Mutsuz	1.69
26	2008	25-34	Çok Mutlu	8.55
27	2008	25-34	Mutlu	47.14
28	2008	25-34	Orta	31.81
29	2008	25-34	Mutsuz	10.23
30	2008	25-34	Çok Mutsuz	2.27
31	2009	25-34	Çok Mutlu	8.56
32	2009	25-34	Mutlu	47.36
33	2009	25-34	Orta	31.40
34	2009	25-34	Mutsuz	10.50
35	2009	25-34	Çok Mutsuz	2.18
36	2010	25-34	Çok Mutlu	11.32
37	2010	25-34	Mutlu	53.04
38	2010	25-34	Orta	26.32
39	2010	25-34	Mutsuz	7.69
40	2010	25-34	Çok Mutsuz	1.63
41	2011	25-34	Çok Mutlu	9.92
42	2011	25-34	Mutlu	52.07
43	2011	25-34	Orta	28.07
44	2011	25-34	Mutsuz	8.29
45	2011	25-34	Çok Mutsuz	1.65
46	2012	25-34	Çok Mutlu	10.48
47	2012	25-34	Mutlu	55.13
48	2012	25-34	Orta	27.30
49	2012	25-34	Mutsuz	6.16
50	2012	25-34	Çok Mutsuz	0.93
51	2013	25-34	Çok Mutlu	11.46
52	2013	25-34	Mutlu	48.84
53	2013	25-34	Orta	30.89
54	2013	25-34	Mutsuz	6.65
55	2013	25-34	Çok Mutsuz	2.17
56	2014	25-34	Çok Mutlu	9.42
57	2014	25-34	Mutlu	48.47
58	2014	25-34	Orta	32.91
59	2014	25-34	Mutsuz	7.34
60	2014	25-34	Çok Mutsuz	1.86
61	2015	25-34	Çok Mutlu	10.55
62	2015	25-34	Mutlu	48.05
63	2015	25-34	Orta	31.88
64	2015	25-34	Mutsuz	6.85
65	2015	25-34	Çok Mutsuz	2.66
66	2016	25-34	Çok Mutlu	9.85
67	2016	25-34	Mutlu	52.11
68	2016	25-34	Orta	28.70
69	2016	25-34	Mutsuz	7.94
70	2016	25-34	Çok Mutsuz	1.40
71	2017	25-34	Çok Mutlu	10.82
72	2017	25-34	Mutlu	47.75
73	2017	25-34	Orta	31.94
74	2017	25-34	Mutsuz	7.51
75	2017	25-34	Çok Mutsuz	1.98
76	2018	25-34	Çok Mutlu	8.34
77	2018	25-34	Mutlu	44.90
78	2018	25-34	Orta	36.39
79	2018	25-34	Mutsuz	7.87
80	2018	25-34	Çok Mutsuz	2.50
81	2019	25-34	Çok Mutlu	7.71
82	2019	25-34	Mutlu	44.34
83	2019	25-34	Orta	34.27
84	2019	25-34	Mutsuz	9.51
85	2019	25-34	Çok Mutsuz	4.17
86	2020	25-34	Çok Mutlu	11.12
87	2020	25-34	Mutlu	35.69
88	2020	25-34	Orta	38.13
89	2020	25-34	Mutsuz	9.63
90	2020	25-34	Çok Mutsuz	5.43
91	2021	25-34	Çok Mutlu	7.16
92	2021	25-34	Mutlu	39.42
93	2021	25-34	Orta	36.35
94	2021	25-34	Mutsuz	12.55
95	2021	25-34	Çok Mutsuz	4.52
96	2022	25-34	Çok Mutlu	5.92
97	2022	25-34	Mutlu	40.84
98	2022	25-34	Orta	36.63
99	2022	25-34	Mutsuz	12.56
100	2022	25-34	Çok Mutsuz	4.04
101	2023	25-34	Çok Mutlu	4.80
102	2023	25-34	Mutlu	45.89
103	2023	25-34	Orta	34.86
104	2023	25-34	Mutsuz	10.89
105	2023	25-34	Çok Mutsuz	3.56
\.


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 214
-- Name: mutluluk_verisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mutluluk_verisi_id_seq', 105, true);


--
-- TOC entry 3175 (class 2606 OID 24594)
-- Name: mutluluk_verisi mutluluk_verisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mutluluk_verisi
    ADD CONSTRAINT mutluluk_verisi_pkey PRIMARY KEY (id);


-- Completed on 2024-11-14 00:03:39

--
-- PostgreSQL database dump complete
--

