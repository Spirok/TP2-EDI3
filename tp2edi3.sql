--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.1
-- Dumped by pg_dump version 9.4.0
-- Started on 2015-11-16 23:42:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 178 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2028 (class 0 OID 0)
-- Dependencies: 178
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 536 (class 1247 OID 40960)
-- Name: dom_estados; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN dom_estados AS character(30) NOT NULL DEFAULT 'Iniciada'::bpchar
	CONSTRAINT estados_validos CHECK ((VALUE = ANY (ARRAY['Iniciada'::bpchar, 'Despachada'::bpchar, 'En Solucion'::bpchar, 'Cerrada'::bpchar])));


ALTER DOMAIN dom_estados OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 175 (class 1259 OID 73753)
-- Name: estados; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estados (
    id integer NOT NULL,
    descripcion character varying(30)
);


ALTER TABLE estados OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 73751)
-- Name: estados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE estados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estados_id_seq OWNER TO postgres;

--
-- TOC entry 2029 (class 0 OID 0)
-- Dependencies: 174
-- Name: estados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estados_id_seq OWNED BY estados.id;


--
-- TOC entry 173 (class 1259 OID 32771)
-- Name: peticiones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE peticiones (
    id integer NOT NULL,
    comando character varying(100),
    id_cliente character varying(10),
    respuesta character varying(150) NOT NULL,
    fecha timestamp with time zone
);


ALTER TABLE peticiones OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 32769)
-- Name: peticiones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE peticiones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE peticiones_id_seq OWNER TO postgres;

--
-- TOC entry 2030 (class 0 OID 0)
-- Dependencies: 172
-- Name: peticiones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE peticiones_id_seq OWNED BY peticiones.id;


--
-- TOC entry 177 (class 1259 OID 114725)
-- Name: solicitudes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE solicitudes (
    id integer NOT NULL,
    id_estado integer DEFAULT 1 NOT NULL
);


ALTER TABLE solicitudes OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 114723)
-- Name: solicitudes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solicitudes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE solicitudes_id_seq OWNER TO postgres;

--
-- TOC entry 2031 (class 0 OID 0)
-- Dependencies: 176
-- Name: solicitudes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE solicitudes_id_seq OWNED BY solicitudes.id;


--
-- TOC entry 1896 (class 2604 OID 73756)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estados ALTER COLUMN id SET DEFAULT nextval('estados_id_seq'::regclass);


--
-- TOC entry 1895 (class 2604 OID 32774)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY peticiones ALTER COLUMN id SET DEFAULT nextval('peticiones_id_seq'::regclass);


--
-- TOC entry 1897 (class 2604 OID 114728)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY solicitudes ALTER COLUMN id SET DEFAULT nextval('solicitudes_id_seq'::regclass);


--
-- TOC entry 2018 (class 0 OID 73753)
-- Dependencies: 175
-- Data for Name: estados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estados (id, descripcion) FROM stdin;
1	Iniciada
2	Despachada
3	En Solucion
4	Cerrada
\.


--
-- TOC entry 2032 (class 0 OID 0)
-- Dependencies: 174
-- Name: estados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estados_id_seq', 4, true);


--
-- TOC entry 2016 (class 0 OID 32771)
-- Dependencies: 173
-- Data for Name: peticiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY peticiones (id, comando, id_cliente, respuesta, fecha) FROM stdin;
1	conectar	1	Comando conectar OK	2015-10-28 18:58:15.861-03
2	fechaServidor	1	Wed Oct 28 18:59:59 ART 2015	2015-10-28 18:59:59.925-03
3	conectar	1	Comando conectar OK	2015-11-11 15:10:24.268-03
4	desconectar		Sesion Cerrada (id : 1)	2015-11-11 15:11:33.843-03
5	conectar	1	Comando conectar OK	2015-11-11 19:05:08.365-03
6	estadoServidor	1	ACTIVO	2015-11-11 19:05:38.539-03
7	fechaServidor	1	Wed Nov 11 19:05:52 ART 2015	2015-11-11 19:05:52.156-03
8	nroDeSolicitud	1	nroDeSolicitud comando desconocido	2015-11-11 19:06:47.74-03
9	nroSolicitud	1	Numero solicitud : 1	2015-11-11 19:07:33.69-03
10	nroSolicitud	1	Numero solicitud : 2	2015-11-11 19:07:37.39-03
11	nroSolicitud	1	Numero solicitud : 3	2015-11-11 19:07:38.328-03
12	nroSolicitud	1	Numero solicitud : 4	2015-11-11 19:07:38.591-03
13	nroSolicitud	1	Error!	2015-11-11 19:07:38.987-03
14	nroSolicitud	1	Error!	2015-11-11 19:07:43.742-03
15	nroSolicitud	1	Error!	2015-11-11 19:07:44.591-03
16	nroSolicitud	1	Error!	2015-11-11 19:09:01.276-03
17	nroSolicitud	1	Numero solicitud : 1	2015-11-11 19:11:05.1-03
18	nroSolicitud	1	Error!	2015-11-11 19:11:06.276-03
19	nroSolicitud	1	Error!	2015-11-11 19:11:06.671-03
20	nroSolicitud	1	Error!	2015-11-11 19:11:54.592-03
21	nroSolicitud	1	Error!	2015-11-11 19:11:55.481-03
22	nroSolicitud	1	Numero solicitud : 1	2015-11-11 19:13:19.816-03
23	nroSolicitud	1	Numero solicitud : 2	2015-11-11 19:13:20.418-03
24	nroSolicitud	1	Numero solicitud : 3	2015-11-11 19:13:21.14-03
25	nroSolicitud	1	Numero solicitud : 4	2015-11-11 19:13:21.796-03
26	nroSolicitud	1	Numero solicitud : 5	2015-11-11 19:13:22.36-03
27	nroSolicitud	1	Numero solicitud : 6	2015-11-11 19:13:23.102-03
28	nroSolicitud	1	Numero solicitud : 7	2015-11-11 19:13:23.44-03
29	nroSolicitud	1	Numero solicitud : 8	2015-11-11 19:13:24.321-03
30	nroSolicitud	1	Numero solicitud : 9	2015-11-11 19:13:24.648-03
31	nroSolicitud	1	Numero solicitud : 10	2015-11-11 19:13:25.057-03
32	nroSolicitud	1	Numero solicitud : 11	2015-11-11 19:13:25.402-03
33	nroSolicitud	1	Numero solicitud : 12	2015-11-11 19:13:26.869-03
34	nroSolicitud	1	Numero solicitud : 13	2015-11-11 19:13:27.115-03
35	cambiarEstadoSolicitud	1	ERROR ( Estado : 2 no contemplado por el servidor)	2015-11-11 19:14:20.791-03
36	cambiarEstadoSolicitud	1	OK	2015-11-11 19:14:31.886-03
37	consultarSolicitud	1	consultarSolicitud comando desconocido	2015-11-11 19:15:13.962-03
38	consultarEstadoSolicitud	1	Despachada	2015-11-11 19:15:24.582-03
39	consultarEstadoSolicitud	1	Iniciada	2015-11-11 19:15:29.462-03
40	consultarEstadoSolicitud	1	Solicitud inexistente	2015-11-11 19:15:36.1-03
41	desconectar		Sesion Cerrada (id : 1)	2015-11-11 19:16:12.538-03
42	conectar	2	Comando conectar OK	2015-11-11 19:16:22.941-03
43	consultarEstadoSolicitud	2	Despachada	2015-11-11 19:16:52.084-03
44	consultarEstadoSolicitud	2	Iniciada	2015-11-11 19:16:56.819-03
45	consultarEstadoSolicitud	2	Solicitud inexistente	2015-11-11 19:17:01.591-03
46	conectar	3	Comando conectar OK	2015-11-11 19:18:12.997-03
47	estadoServidor		Id incorrecta	2015-11-11 19:18:28.413-03
48	estadoServidor		Id incorrecta	2015-11-11 19:18:37.778-03
49	estadoServidor		Id incorrecta	2015-11-11 19:19:19.841-03
50	estadoServidor		Parametro/s incorrecto/s	2015-11-11 19:19:28.865-03
51	estadoServidor		Parametro/s incorrecto/s	2015-11-11 19:20:00.701-03
52	estadoServidor		Id incorrecta	2015-11-11 19:20:30.038-03
53	conectar	4	Comando conectar OK	2015-11-11 19:21:12.287-03
54	fechaServidor		No esta conectado!	2015-11-11 19:22:40.079-03
55	fechaServidor		No esta conectado!	2015-11-11 19:22:56.338-03
56	conectar	5	Comando conectar OK	2015-11-11 19:23:20.236-03
57	conectar	10	Comando conectar OK	2015-11-11 19:23:20.299-03
58	conectar	9	Comando conectar OK	2015-11-11 19:23:20.389-03
59	conectar	8	Comando conectar OK	2015-11-11 19:23:20.468-03
60	conectar	7	Comando conectar OK	2015-11-11 19:23:20.55-03
61	conectar	6	Comando conectar OK	2015-11-11 19:23:20.604-03
62	conectar	15	Comando conectar OK	2015-11-11 19:23:20.673-03
63	conectar	14	Comando conectar OK	2015-11-11 19:23:20.743-03
64	conectar	13	Comando conectar OK	2015-11-11 19:23:20.824-03
65	conectar	12	Comando conectar OK	2015-11-11 19:23:20.882-03
66	conectar	11	Comando conectar OK	2015-11-11 19:23:20.959-03
67	conectar	20	Comando conectar OK	2015-11-11 19:23:21.026-03
68	conectar	19	Comando conectar OK	2015-11-11 19:23:21.085-03
69	conectar	18	Comando conectar OK	2015-11-11 19:23:21.156-03
70	conectar	17	Comando conectar OK	2015-11-11 19:23:21.237-03
71	conectar	16	Comando conectar OK	2015-11-11 19:23:21.299-03
72	conectar	25	Comando conectar OK	2015-11-11 19:23:21.345-03
73	conectar	24	Comando conectar OK	2015-11-11 19:23:21.35-03
74	conectar	23	Comando conectar OK	2015-11-11 19:23:21.361-03
75	conectar	22	Comando conectar OK	2015-11-11 19:23:21.368-03
76	conectar	21	Comando conectar OK	2015-11-11 19:23:21.37-03
77	conectar	30	Comando conectar OK	2015-11-11 19:23:21.373-03
78	conectar	29	Comando conectar OK	2015-11-11 19:23:21.376-03
79	conectar	28	Comando conectar OK	2015-11-11 19:23:21.378-03
80	conectar	27	Comando conectar OK	2015-11-11 19:23:21.379-03
81	conectar	26	Comando conectar OK	2015-11-11 19:23:21.381-03
82	conectar	34	Comando conectar OK	2015-11-11 19:23:21.383-03
83	conectar	33	Comando conectar OK	2015-11-11 19:23:21.386-03
84	conectar	32	Comando conectar OK	2015-11-11 19:23:21.389-03
85	conectar	31	Comando conectar OK	2015-11-11 19:23:21.391-03
86	conectar	39	Comando conectar OK	2015-11-11 19:23:21.394-03
87	conectar	38	Comando conectar OK	2015-11-11 19:23:21.421-03
88	conectar	37	Comando conectar OK	2015-11-11 19:23:21.443-03
89	conectar	36	Comando conectar OK	2015-11-11 19:23:21.454-03
90	conectar	35	Comando conectar OK	2015-11-11 19:23:21.457-03
91	conectar	44	Comando conectar OK	2015-11-11 19:23:21.459-03
92	conectar	43	Comando conectar OK	2015-11-11 19:23:21.462-03
93	conectar	42	Comando conectar OK	2015-11-11 19:23:21.466-03
94	conectar	41	Comando conectar OK	2015-11-11 19:23:21.468-03
95	conectar	40	Comando conectar OK	2015-11-11 19:23:21.471-03
96	conectar	49	Comando conectar OK	2015-11-11 19:23:21.474-03
97	conectar	48	Comando conectar OK	2015-11-11 19:23:21.477-03
98	conectar	47	Comando conectar OK	2015-11-11 19:23:21.479-03
99	conectar	52	Comando conectar OK	2015-11-11 19:23:21.495-03
100	conectar	46	Comando conectar OK	2015-11-11 19:23:21.496-03
101	conectar	54	Comando conectar OK	2015-11-11 19:23:21.499-03
102	conectar	45	Comando conectar OK	2015-11-11 19:23:21.5-03
103	conectar	56	Comando conectar OK	2015-11-11 19:23:21.501-03
104	conectar	57	Comando conectar OK	2015-11-11 19:23:21.503-03
105	conectar	55	Comando conectar OK	2015-11-11 19:23:21.504-03
106	conectar	59	Comando conectar OK	2015-11-11 19:23:21.505-03
107	conectar	53	Comando conectar OK	2015-11-11 19:23:21.507-03
108	conectar	51	Comando conectar OK	2015-11-11 19:23:21.509-03
109	conectar	50	Comando conectar OK	2015-11-11 19:23:21.51-03
110	conectar	62	Comando conectar OK	2015-11-11 19:23:21.512-03
111	conectar	61	Comando conectar OK	2015-11-11 19:23:21.513-03
112	conectar	60	Comando conectar OK	2015-11-11 19:23:21.515-03
113	conectar	58	Comando conectar OK	2015-11-11 19:23:21.517-03
114	conectar	67	Comando conectar OK	2015-11-11 19:23:21.518-03
115	conectar	66	Comando conectar OK	2015-11-11 19:23:21.52-03
116	conectar	69	Comando conectar OK	2015-11-11 19:23:21.521-03
117	conectar	70	Comando conectar OK	2015-11-11 19:23:21.522-03
118	conectar	65	Comando conectar OK	2015-11-11 19:23:21.525-03
119	conectar	64	Comando conectar OK	2015-11-11 19:23:21.527-03
120	conectar	63	Comando conectar OK	2015-11-11 19:23:21.533-03
121	conectar	74	Comando conectar OK	2015-11-11 19:23:21.536-03
122	conectar	73	Comando conectar OK	2015-11-11 19:23:21.539-03
123	conectar	72	Comando conectar OK	2015-11-11 19:23:21.541-03
124	conectar	71	Comando conectar OK	2015-11-11 19:23:21.544-03
125	conectar	68	Comando conectar OK	2015-11-11 19:23:21.547-03
126	conectar	79	Comando conectar OK	2015-11-11 19:23:21.551-03
127	conectar	78	Comando conectar OK	2015-11-11 19:23:21.554-03
128	conectar	77	Comando conectar OK	2015-11-11 19:23:21.559-03
129	conectar	76	Comando conectar OK	2015-11-11 19:23:21.563-03
130	conectar	75	Comando conectar OK	2015-11-11 19:23:21.589-03
131	conectar	84	Comando conectar OK	2015-11-11 19:23:21.592-03
132	conectar	83	Comando conectar OK	2015-11-11 19:23:21.595-03
133	conectar	82	Comando conectar OK	2015-11-11 19:23:21.598-03
134	conectar	81	Comando conectar OK	2015-11-11 19:23:21.606-03
135	conectar	80	Comando conectar OK	2015-11-11 19:23:21.611-03
136	conectar	89	Comando conectar OK	2015-11-11 19:23:21.615-03
137	conectar	88	Comando conectar OK	2015-11-11 19:23:21.617-03
138	conectar	87	Comando conectar OK	2015-11-11 19:23:21.623-03
139	conectar	86	Comando conectar OK	2015-11-11 19:23:21.634-03
140	conectar	85	Comando conectar OK	2015-11-11 19:23:21.669-03
141	conectar	94	Comando conectar OK	2015-11-11 19:23:21.671-03
142	conectar	93	Comando conectar OK	2015-11-11 19:23:21.674-03
143	conectar	92	Comando conectar OK	2015-11-11 19:23:21.677-03
144	conectar	91	Comando conectar OK	2015-11-11 19:23:21.68-03
145	conectar	90	Comando conectar OK	2015-11-11 19:23:21.683-03
146	conectar	99	Comando conectar OK	2015-11-11 19:23:21.687-03
147	conectar	98	Comando conectar OK	2015-11-11 19:23:21.69-03
148	conectar	97	Comando conectar OK	2015-11-11 19:23:21.693-03
149	conectar	96	Comando conectar OK	2015-11-11 19:23:21.697-03
150	conectar	95	Comando conectar OK	2015-11-11 19:23:21.701-03
151	conectar	104	Comando conectar OK	2015-11-11 19:23:21.704-03
152	conectar	103	Comando conectar OK	2015-11-11 19:23:21.707-03
153	conectar	102	Comando conectar OK	2015-11-11 19:23:21.71-03
154	conectar	101	Comando conectar OK	2015-11-11 19:23:21.713-03
155	conectar	100	Comando conectar OK	2015-11-11 19:23:21.715-03
156	conectar	109	Comando conectar OK	2015-11-11 19:23:21.72-03
157	conectar	108	Comando conectar OK	2015-11-11 19:23:21.721-03
158	conectar	107	Comando conectar OK	2015-11-11 19:23:21.725-03
159	conectar	106	Comando conectar OK	2015-11-11 19:23:21.726-03
160	conectar	105	Comando conectar OK	2015-11-11 19:23:21.728-03
161	conectar	110	Comando conectar OK	2015-11-11 19:23:21.745-03
162	conectar	113	Comando conectar OK	2015-11-11 19:23:21.747-03
163	conectar	112	Comando conectar OK	2015-11-11 19:23:21.749-03
164	conectar	111	Comando conectar OK	2015-11-11 19:23:21.75-03
165	conectar	115	Comando conectar OK	2015-11-11 19:23:21.752-03
166	conectar	114	Comando conectar OK	2015-11-11 19:23:21.754-03
167	conectar	119	Comando conectar OK	2015-11-11 19:23:21.755-03
168	conectar	118	Comando conectar OK	2015-11-11 19:23:21.757-03
169	conectar	122	Comando conectar OK	2015-11-11 19:23:21.758-03
170	conectar	117	Comando conectar OK	2015-11-11 19:23:21.76-03
171	conectar	124	Comando conectar OK	2015-11-11 19:23:21.761-03
172	conectar	125	Comando conectar OK	2015-11-11 19:23:21.762-03
173	conectar	116	Comando conectar OK	2015-11-11 19:23:21.764-03
174	conectar	127	Comando conectar OK	2015-11-11 19:23:21.765-03
175	conectar	128	Comando conectar OK	2015-11-11 19:23:21.768-03
176	conectar	129	Comando conectar OK	2015-11-11 19:23:21.769-03
177	conectar	130	Comando conectar OK	2015-11-11 19:23:21.77-03
178	conectar	126	Comando conectar OK	2015-11-11 19:23:21.772-03
179	conectar	132	Comando conectar OK	2015-11-11 19:23:21.773-03
180	conectar	133	Comando conectar OK	2015-11-11 19:23:21.774-03
181	conectar	123	Comando conectar OK	2015-11-11 19:23:21.777-03
182	conectar	121	Comando conectar OK	2015-11-11 19:23:21.779-03
183	conectar	120	Comando conectar OK	2015-11-11 19:23:21.782-03
184	conectar	137	Comando conectar OK	2015-11-11 19:23:21.786-03
185	conectar	136	Comando conectar OK	2015-11-11 19:23:21.789-03
186	conectar	135	Comando conectar OK	2015-11-11 19:23:21.79-03
187	conectar	134	Comando conectar OK	2015-11-11 19:23:21.794-03
188	conectar	131	Comando conectar OK	2015-11-11 19:23:21.808-03
189	conectar	142	Comando conectar OK	2015-11-11 19:23:21.811-03
190	conectar	141	Comando conectar OK	2015-11-11 19:23:21.878-03
191	conectar	140	Comando conectar OK	2015-11-11 19:23:21.885-03
192	conectar	139	Comando conectar OK	2015-11-11 19:23:21.888-03
193	conectar	138	Comando conectar OK	2015-11-11 19:23:21.891-03
194	conectar	147	Comando conectar OK	2015-11-11 19:23:21.894-03
195	conectar	146	Comando conectar OK	2015-11-11 19:23:21.898-03
196	conectar	145	Comando conectar OK	2015-11-11 19:23:21.902-03
197	conectar	144	Comando conectar OK	2015-11-11 19:23:21.905-03
198	conectar	143	Comando conectar OK	2015-11-11 19:23:21.908-03
199	conectar	152	Comando conectar OK	2015-11-11 19:23:21.911-03
200	conectar	151	Comando conectar OK	2015-11-11 19:23:21.914-03
201	conectar	150	Comando conectar OK	2015-11-11 19:23:21.918-03
202	conectar	149	Comando conectar OK	2015-11-11 19:23:21.923-03
203	conectar	148	Comando conectar OK	2015-11-11 19:23:21.93-03
204	conectar	156	Comando conectar OK	2015-11-11 19:23:21.932-03
205	conectar	155	Comando conectar OK	2015-11-11 19:23:21.933-03
206	conectar	159	Comando conectar OK	2015-11-11 19:23:21.935-03
207	conectar	154	Comando conectar OK	2015-11-11 19:23:21.937-03
208	conectar	161	Comando conectar OK	2015-11-11 19:23:21.938-03
209	conectar	162	Comando conectar OK	2015-11-11 19:23:21.939-03
210	conectar	163	Comando conectar OK	2015-11-11 19:23:21.941-03
211	conectar	164	Comando conectar OK	2015-11-11 19:23:21.942-03
212	conectar	165	Comando conectar OK	2015-11-11 19:23:21.943-03
213	conectar	166	Comando conectar OK	2015-11-11 19:23:21.944-03
214	conectar	167	Comando conectar OK	2015-11-11 19:23:21.946-03
215	conectar	153	Comando conectar OK	2015-11-11 19:23:21.947-03
216	conectar	168	Comando conectar OK	2015-11-11 19:23:21.949-03
217	conectar	170	Comando conectar OK	2015-11-11 19:23:21.951-03
218	conectar	160	Comando conectar OK	2015-11-11 19:23:21.952-03
219	conectar	158	Comando conectar OK	2015-11-11 19:23:21.954-03
220	conectar	157	Comando conectar OK	2015-11-11 19:23:21.957-03
221	conectar	174	Comando conectar OK	2015-11-11 19:23:21.96-03
222	conectar	173	Comando conectar OK	2015-11-11 19:23:21.963-03
223	conectar	172	Comando conectar OK	2015-11-11 19:23:21.965-03
224	conectar	171	Comando conectar OK	2015-11-11 19:23:21.972-03
225	conectar	169	Comando conectar OK	2015-11-11 19:23:21.976-03
226	conectar	179	Comando conectar OK	2015-11-11 19:23:21.978-03
227	conectar	178	Comando conectar OK	2015-11-11 19:23:21.987-03
228	conectar	177	Comando conectar OK	2015-11-11 19:23:21.99-03
229	conectar	176	Comando conectar OK	2015-11-11 19:23:21.993-03
230	conectar	175	Comando conectar OK	2015-11-11 19:23:21.996-03
231	conectar	184	Comando conectar OK	2015-11-11 19:23:21.999-03
232	conectar	183	Comando conectar OK	2015-11-11 19:23:22.003-03
233	conectar	182	Comando conectar OK	2015-11-11 19:23:22.006-03
234	conectar	181	Comando conectar OK	2015-11-11 19:23:22.018-03
235	conectar	180	Comando conectar OK	2015-11-11 19:23:22.021-03
236	conectar	189	Comando conectar OK	2015-11-11 19:23:22.031-03
237	conectar	188	Comando conectar OK	2015-11-11 19:23:22.033-03
238	conectar	187	Comando conectar OK	2015-11-11 19:23:22.037-03
239	conectar	186	Comando conectar OK	2015-11-11 19:23:22.047-03
240	conectar	185	Comando conectar OK	2015-11-11 19:23:22.052-03
241	conectar	194	Comando conectar OK	2015-11-11 19:23:22.056-03
242	conectar	193	Comando conectar OK	2015-11-11 19:23:22.059-03
243	conectar	192	Comando conectar OK	2015-11-11 19:23:22.065-03
244	conectar	197	Comando conectar OK	2015-11-11 19:23:22.066-03
245	conectar	191	Comando conectar OK	2015-11-11 19:23:22.068-03
246	conectar	199	Comando conectar OK	2015-11-11 19:23:22.069-03
247	conectar	200	Comando conectar OK	2015-11-11 19:23:22.07-03
248	conectar	190	Comando conectar OK	2015-11-11 19:23:22.072-03
249	conectar	202	Comando conectar OK	2015-11-11 19:23:22.115-03
250	conectar	201	Comando conectar OK	2015-11-11 19:23:22.124-03
251	conectar	198	Comando conectar OK	2015-11-11 19:23:22.14-03
252	conectar	196	Comando conectar OK	2015-11-11 19:23:22.143-03
253	conectar	195	Comando conectar OK	2015-11-11 19:23:22.146-03
254	conectar	207	Comando conectar OK	2015-11-11 19:23:22.149-03
255	conectar	206	Comando conectar OK	2015-11-11 19:23:22.154-03
256	conectar	205	Comando conectar OK	2015-11-11 19:23:22.155-03
257	conectar	204	Comando conectar OK	2015-11-11 19:23:22.166-03
258	conectar	203	Comando conectar OK	2015-11-11 19:23:22.17-03
259	conectar	212	Comando conectar OK	2015-11-11 19:23:22.173-03
260	conectar	211	Comando conectar OK	2015-11-11 19:23:22.176-03
261	conectar	210	Comando conectar OK	2015-11-11 19:23:22.179-03
262	conectar	209	Comando conectar OK	2015-11-11 19:23:22.182-03
263	conectar	208	Comando conectar OK	2015-11-11 19:23:22.186-03
264	conectar	217	Comando conectar OK	2015-11-11 19:23:22.189-03
265	conectar	216	Comando conectar OK	2015-11-11 19:23:22.192-03
266	conectar	215	Comando conectar OK	2015-11-11 19:23:22.195-03
267	conectar	214	Comando conectar OK	2015-11-11 19:23:22.198-03
268	conectar	213	Comando conectar OK	2015-11-11 19:23:22.199-03
269	conectar	222	Comando conectar OK	2015-11-11 19:23:22.201-03
270	conectar	221	Comando conectar OK	2015-11-11 19:23:22.203-03
271	conectar	224	Comando conectar OK	2015-11-11 19:23:22.205-03
272	conectar	220	Comando conectar OK	2015-11-11 19:23:22.206-03
273	conectar	226	Comando conectar OK	2015-11-11 19:23:22.207-03
274	conectar	227	Comando conectar OK	2015-11-11 19:23:22.208-03
275	conectar	228	Comando conectar OK	2015-11-11 19:23:22.21-03
276	conectar	219	Comando conectar OK	2015-11-11 19:23:22.211-03
277	conectar	230	Comando conectar OK	2015-11-11 19:23:22.213-03
278	conectar	231	Comando conectar OK	2015-11-11 19:23:22.214-03
279	conectar	218	Comando conectar OK	2015-11-11 19:23:22.216-03
280	conectar	233	Comando conectar OK	2015-11-11 19:23:22.217-03
281	conectar	232	Comando conectar OK	2015-11-11 19:23:22.22-03
282	conectar	229	Comando conectar OK	2015-11-11 19:23:22.221-03
283	conectar	236	Comando conectar OK	2015-11-11 19:23:22.223-03
284	conectar	237	Comando conectar OK	2015-11-11 19:23:22.224-03
285	conectar	238	Comando conectar OK	2015-11-11 19:23:22.225-03
286	conectar	225	Comando conectar OK	2015-11-11 19:23:22.227-03
287	conectar	223	Comando conectar OK	2015-11-11 19:23:22.228-03
288	conectar	241	Comando conectar OK	2015-11-11 19:23:22.231-03
289	conectar	240	Comando conectar OK	2015-11-11 19:23:22.233-03
290	conectar	239	Comando conectar OK	2015-11-11 19:23:22.237-03
291	conectar	235	Comando conectar OK	2015-11-11 19:23:22.24-03
292	conectar	234	Comando conectar OK	2015-11-11 19:23:22.243-03
293	conectar	246	Comando conectar OK	2015-11-11 19:23:22.246-03
294	conectar	245	Comando conectar OK	2015-11-11 19:23:22.248-03
295	conectar	244	Comando conectar OK	2015-11-11 19:23:22.259-03
296	conectar	243	Comando conectar OK	2015-11-11 19:23:22.268-03
297	conectar	242	Comando conectar OK	2015-11-11 19:23:22.272-03
298	conectar	251	Comando conectar OK	2015-11-11 19:23:22.295-03
299	conectar	250	Comando conectar OK	2015-11-11 19:23:22.305-03
300	conectar	249	Comando conectar OK	2015-11-11 19:23:22.316-03
301	conectar	248	Comando conectar OK	2015-11-11 19:23:22.34-03
302	conectar	247	Comando conectar OK	2015-11-11 19:23:22.343-03
303	conectar	256	Comando conectar OK	2015-11-11 19:23:22.352-03
304	conectar	255	Comando conectar OK	2015-11-11 19:23:22.356-03
305	conectar	254	Comando conectar OK	2015-11-11 19:23:22.358-03
306	conectar	253	Comando conectar OK	2015-11-11 19:23:22.361-03
307	conectar	252	Comando conectar OK	2015-11-11 19:23:22.375-03
308	conectar	261	Comando conectar OK	2015-11-11 19:23:22.409-03
309	conectar	260	Comando conectar OK	2015-11-11 19:23:22.429-03
310	conectar	259	Comando conectar OK	2015-11-11 19:23:22.442-03
311	conectar	258	Comando conectar OK	2015-11-11 19:23:22.456-03
312	conectar	257	Comando conectar OK	2015-11-11 19:23:22.471-03
313	conectar	266	Comando conectar OK	2015-11-11 19:23:22.489-03
314	conectar	265	Comando conectar OK	2015-11-11 19:23:22.504-03
315	conectar	264	Comando conectar OK	2015-11-11 19:23:22.512-03
316	conectar	263	Comando conectar OK	2015-11-11 19:23:22.516-03
317	conectar	262	Comando conectar OK	2015-11-11 19:23:22.518-03
318	conectar	271	Comando conectar OK	2015-11-11 19:23:22.522-03
319	conectar	270	Comando conectar OK	2015-11-11 19:23:22.524-03
320	conectar	269	Comando conectar OK	2015-11-11 19:23:22.525-03
321	conectar	268	Comando conectar OK	2015-11-11 19:23:22.527-03
322	conectar	275	Comando conectar OK	2015-11-11 19:23:22.528-03
323	conectar	276	Comando conectar OK	2015-11-11 19:23:22.529-03
324	conectar	277	Comando conectar OK	2015-11-11 19:23:22.531-03
325	conectar	278	Comando conectar OK	2015-11-11 19:23:22.532-03
326	conectar	279	Comando conectar OK	2015-11-11 19:23:22.533-03
327	conectar	280	Comando conectar OK	2015-11-11 19:23:22.534-03
328	conectar	281	Comando conectar OK	2015-11-11 19:23:22.535-03
329	conectar	267	Comando conectar OK	2015-11-11 19:23:22.538-03
330	conectar	282	Comando conectar OK	2015-11-11 19:23:22.539-03
331	conectar	284	Comando conectar OK	2015-11-11 19:23:22.54-03
332	conectar	285	Comando conectar OK	2015-11-11 19:23:22.542-03
333	conectar	286	Comando conectar OK	2015-11-11 19:23:22.543-03
334	conectar	274	Comando conectar OK	2015-11-11 19:23:22.544-03
335	conectar	273	Comando conectar OK	2015-11-11 19:23:22.548-03
336	conectar	272	Comando conectar OK	2015-11-11 19:23:22.55-03
337	conectar	290	Comando conectar OK	2015-11-11 19:23:22.554-03
338	conectar	289	Comando conectar OK	2015-11-11 19:23:22.557-03
339	conectar	288	Comando conectar OK	2015-11-11 19:23:22.56-03
340	conectar	287	Comando conectar OK	2015-11-11 19:23:22.592-03
341	conectar	283	Comando conectar OK	2015-11-11 19:23:22.606-03
342	conectar	294	Comando conectar OK	2015-11-11 19:23:22.615-03
343	conectar	293	Comando conectar OK	2015-11-11 19:23:22.626-03
344	conectar	292	Comando conectar OK	2015-11-11 19:23:22.635-03
345	conectar	291	Comando conectar OK	2015-11-11 19:23:22.652-03
346	conectar	295	Comando conectar OK	2015-11-11 19:23:22.661-03
347	conectar	296	Comando conectar OK	2015-11-11 19:23:22.672-03
348	conectar	297	Comando conectar OK	2015-11-11 19:23:22.675-03
349	conectar	298	Comando conectar OK	2015-11-11 19:23:22.682-03
350	conectar	299	Comando conectar OK	2015-11-11 19:23:22.685-03
351	conectar	300	Comando conectar OK	2015-11-11 19:23:22.687-03
352	conectar	301	Comando conectar OK	2015-11-11 19:23:22.713-03
353	conectar	302	Comando conectar OK	2015-11-11 19:23:22.73-03
354	conectar	303	Comando conectar OK	2015-11-11 19:23:22.733-03
355	conectar	304	Comando conectar OK	2015-11-11 19:23:22.735-03
356	conectar	305	Comando conectar OK	2015-11-11 19:23:22.766-03
357	conectar	306	Comando conectar OK	2015-11-11 19:23:22.783-03
358	conectar	307	Comando conectar OK	2015-11-11 19:23:22.797-03
359	conectar	308	Comando conectar OK	2015-11-11 19:23:22.825-03
360	conectar	313	Comando conectar OK	2015-11-11 19:23:22.864-03
361	conectar	312	Comando conectar OK	2015-11-11 19:23:22.879-03
362	conectar	311	Comando conectar OK	2015-11-11 19:23:22.893-03
363	conectar	310	Comando conectar OK	2015-11-11 19:23:22.896-03
364	conectar	309	Comando conectar OK	2015-11-11 19:23:22.898-03
365	conectar	318	Comando conectar OK	2015-11-11 19:23:22.903-03
366	conectar	317	Comando conectar OK	2015-11-11 19:23:22.928-03
367	conectar	316	Comando conectar OK	2015-11-11 19:23:22.936-03
368	conectar	315	Comando conectar OK	2015-11-11 19:23:22.959-03
369	conectar	314	Comando conectar OK	2015-11-11 19:23:22.968-03
370	conectar	323	Comando conectar OK	2015-11-11 19:23:22.969-03
371	conectar	322	Comando conectar OK	2015-11-11 19:23:22.982-03
372	conectar	321	Comando conectar OK	2015-11-11 19:23:22.985-03
373	conectar	320	Comando conectar OK	2015-11-11 19:23:22.989-03
374	conectar	319	Comando conectar OK	2015-11-11 19:23:23.001-03
375	conectar	328	Comando conectar OK	2015-11-11 19:23:23.006-03
376	conectar	327	Comando conectar OK	2015-11-11 19:23:23.008-03
377	conectar	326	Comando conectar OK	2015-11-11 19:23:23.01-03
378	conectar	325	Comando conectar OK	2015-11-11 19:23:23.014-03
379	conectar	324	Comando conectar OK	2015-11-11 19:23:23.017-03
380	conectar	333	Comando conectar OK	2015-11-11 19:23:23.02-03
381	conectar	332	Comando conectar OK	2015-11-11 19:23:23.024-03
382	conectar	331	Comando conectar OK	2015-11-11 19:23:23.029-03
383	conectar	330	Comando conectar OK	2015-11-11 19:23:23.058-03
384	conectar	329	Comando conectar OK	2015-11-11 19:23:23.082-03
385	conectar	338	Comando conectar OK	2015-11-11 19:23:23.092-03
386	conectar	337	Comando conectar OK	2015-11-11 19:23:23.099-03
387	conectar	336	Comando conectar OK	2015-11-11 19:23:23.11-03
388	conectar	335	Comando conectar OK	2015-11-11 19:23:23.113-03
389	conectar	334	Comando conectar OK	2015-11-11 19:23:23.116-03
390	conectar	343	Comando conectar OK	2015-11-11 19:23:23.121-03
391	conectar	342	Comando conectar OK	2015-11-11 19:23:23.125-03
392	conectar	341	Comando conectar OK	2015-11-11 19:23:23.128-03
393	conectar	340	Comando conectar OK	2015-11-11 19:23:23.131-03
394	conectar	339	Comando conectar OK	2015-11-11 19:23:23.152-03
395	conectar	348	Comando conectar OK	2015-11-11 19:23:23.164-03
396	conectar	347	Comando conectar OK	2015-11-11 19:23:23.32-03
397	conectar	346	Comando conectar OK	2015-11-11 19:23:23.322-03
398	conectar	345	Comando conectar OK	2015-11-11 19:23:23.325-03
399	conectar	344	Comando conectar OK	2015-11-11 19:23:23.33-03
400	conectar	353	Comando conectar OK	2015-11-11 19:23:23.333-03
401	conectar	352	Comando conectar OK	2015-11-11 19:23:23.335-03
402	conectar	351	Comando conectar OK	2015-11-11 19:23:23.338-03
403	conectar	350	Comando conectar OK	2015-11-11 19:23:23.34-03
404	conectar	349	Comando conectar OK	2015-11-11 19:23:23.344-03
405	conectar	358	Comando conectar OK	2015-11-11 19:23:23.348-03
406	conectar	357	Comando conectar OK	2015-11-11 19:23:23.35-03
407	conectar	356	Comando conectar OK	2015-11-11 19:23:23.354-03
408	conectar	355	Comando conectar OK	2015-11-11 19:23:23.356-03
409	conectar	354	Comando conectar OK	2015-11-11 19:23:23.36-03
410	conectar	363	Comando conectar OK	2015-11-11 19:23:23.383-03
411	conectar	362	Comando conectar OK	2015-11-11 19:23:23.396-03
412	conectar	361	Comando conectar OK	2015-11-11 19:23:23.402-03
413	conectar	360	Comando conectar OK	2015-11-11 19:23:23.411-03
414	conectar	359	Comando conectar OK	2015-11-11 19:23:23.414-03
415	conectar	368	Comando conectar OK	2015-11-11 19:23:23.417-03
416	conectar	367	Comando conectar OK	2015-11-11 19:23:23.419-03
417	conectar	366	Comando conectar OK	2015-11-11 19:23:23.423-03
418	conectar	365	Comando conectar OK	2015-11-11 19:23:23.426-03
419	conectar	364	Comando conectar OK	2015-11-11 19:23:23.429-03
420	conectar	372	Comando conectar OK	2015-11-11 19:23:23.43-03
421	conectar	371	Comando conectar OK	2015-11-11 19:23:23.432-03
422	conectar	370	Comando conectar OK	2015-11-11 19:23:23.433-03
423	conectar	369	Comando conectar OK	2015-11-11 19:23:23.434-03
424	conectar	376	Comando conectar OK	2015-11-11 19:23:23.435-03
425	conectar	378	Comando conectar OK	2015-11-11 19:23:23.436-03
426	conectar	379	Comando conectar OK	2015-11-11 19:23:23.438-03
427	conectar	375	Comando conectar OK	2015-11-11 19:23:23.439-03
428	conectar	381	Comando conectar OK	2015-11-11 19:23:23.441-03
429	conectar	382	Comando conectar OK	2015-11-11 19:23:23.443-03
430	conectar	374	Comando conectar OK	2015-11-11 19:23:23.445-03
431	conectar	373	Comando conectar OK	2015-11-11 19:23:23.448-03
432	conectar	384	Comando conectar OK	2015-11-11 19:23:23.449-03
433	conectar	386	Comando conectar OK	2015-11-11 19:23:23.45-03
434	conectar	387	Comando conectar OK	2015-11-11 19:23:23.451-03
435	conectar	388	Comando conectar OK	2015-11-11 19:23:23.453-03
436	conectar	383	Comando conectar OK	2015-11-11 19:23:23.455-03
437	conectar	380	Comando conectar OK	2015-11-11 19:23:23.459-03
438	conectar	377	Comando conectar OK	2015-11-11 19:23:23.461-03
439	conectar	392	Comando conectar OK	2015-11-11 19:23:23.466-03
440	conectar	391	Comando conectar OK	2015-11-11 19:23:23.486-03
441	conectar	390	Comando conectar OK	2015-11-11 19:23:23.501-03
442	conectar	389	Comando conectar OK	2015-11-11 19:23:23.504-03
443	conectar	385	Comando conectar OK	2015-11-11 19:23:23.506-03
444	conectar	397	Comando conectar OK	2015-11-11 19:23:23.51-03
445	conectar	396	Comando conectar OK	2015-11-11 19:23:23.52-03
446	conectar	395	Comando conectar OK	2015-11-11 19:23:23.523-03
447	conectar	394	Comando conectar OK	2015-11-11 19:23:23.527-03
448	conectar	393	Comando conectar OK	2015-11-11 19:23:23.53-03
449	conectar	402	Comando conectar OK	2015-11-11 19:23:23.532-03
450	conectar	401	Comando conectar OK	2015-11-11 19:23:23.535-03
451	conectar	400	Comando conectar OK	2015-11-11 19:23:23.537-03
452	conectar	399	Comando conectar OK	2015-11-11 19:23:23.54-03
453	conectar	398	Comando conectar OK	2015-11-11 19:23:23.544-03
454	conectar	407	Comando conectar OK	2015-11-11 19:23:23.546-03
455	conectar	406	Comando conectar OK	2015-11-11 19:23:23.549-03
456	conectar	405	Comando conectar OK	2015-11-11 19:23:23.551-03
457	conectar	404	Comando conectar OK	2015-11-11 19:23:23.565-03
458	conectar	403	Comando conectar OK	2015-11-11 19:23:23.582-03
459	conectar	412	Comando conectar OK	2015-11-11 19:23:23.594-03
460	conectar	411	Comando conectar OK	2015-11-11 19:23:23.597-03
461	conectar	410	Comando conectar OK	2015-11-11 19:23:23.6-03
462	conectar	415	Comando conectar OK	2015-11-11 19:23:23.601-03
463	conectar	416	Comando conectar OK	2015-11-11 19:23:23.602-03
464	conectar	417	Comando conectar OK	2015-11-11 19:23:23.603-03
465	conectar	418	Comando conectar OK	2015-11-11 19:23:23.605-03
466	conectar	419	Comando conectar OK	2015-11-11 19:23:23.606-03
467	conectar	420	Comando conectar OK	2015-11-11 19:23:23.607-03
468	conectar	421	Comando conectar OK	2015-11-11 19:23:23.609-03
469	conectar	409	Comando conectar OK	2015-11-11 19:23:23.611-03
470	conectar	408	Comando conectar OK	2015-11-11 19:23:23.613-03
471	conectar	424	Comando conectar OK	2015-11-11 19:23:23.615-03
472	conectar	425	Comando conectar OK	2015-11-11 19:23:23.616-03
473	conectar	426	Comando conectar OK	2015-11-11 19:23:23.618-03
474	conectar	423	Comando conectar OK	2015-11-11 19:23:23.62-03
475	conectar	422	Comando conectar OK	2015-11-11 19:23:23.622-03
476	conectar	414	Comando conectar OK	2015-11-11 19:23:23.623-03
477	conectar	413	Comando conectar OK	2015-11-11 19:23:23.627-03
478	conectar	431	Comando conectar OK	2015-11-11 19:23:23.632-03
479	conectar	430	Comando conectar OK	2015-11-11 19:23:23.635-03
480	conectar	429	Comando conectar OK	2015-11-11 19:23:23.65-03
481	conectar	428	Comando conectar OK	2015-11-11 19:23:23.662-03
482	conectar	427	Comando conectar OK	2015-11-11 19:23:23.665-03
483	conectar	436	Comando conectar OK	2015-11-11 19:23:23.667-03
484	conectar	435	Comando conectar OK	2015-11-11 19:23:23.671-03
485	conectar	434	Comando conectar OK	2015-11-11 19:23:23.673-03
486	conectar	439	Comando conectar OK	2015-11-11 19:23:23.683-03
487	conectar	433	Comando conectar OK	2015-11-11 19:23:23.686-03
488	conectar	432	Comando conectar OK	2015-11-11 19:23:23.688-03
489	conectar	438	Comando conectar OK	2015-11-11 19:23:23.689-03
490	conectar	437	Comando conectar OK	2015-11-11 19:23:23.69-03
491	conectar	440	Comando conectar OK	2015-11-11 19:23:23.694-03
492	conectar	441	Comando conectar OK	2015-11-11 19:23:23.748-03
493	conectar	442	Comando conectar OK	2015-11-11 19:23:23.757-03
494	conectar	443	Comando conectar OK	2015-11-11 19:23:23.78-03
495	conectar	444	Comando conectar OK	2015-11-11 19:23:23.789-03
496	conectar	445	Comando conectar OK	2015-11-11 19:23:23.799-03
497	conectar	446	Comando conectar OK	2015-11-11 19:23:23.803-03
498	conectar	451	Comando conectar OK	2015-11-11 19:23:23.815-03
499	conectar	450	Comando conectar OK	2015-11-11 19:23:23.865-03
500	conectar	449	Comando conectar OK	2015-11-11 19:23:23.873-03
501	conectar	454	Comando conectar OK	2015-11-11 19:23:23.875-03
502	conectar	448	Comando conectar OK	2015-11-11 19:23:23.88-03
503	conectar	447	Comando conectar OK	2015-11-11 19:23:23.882-03
504	conectar	457	Comando conectar OK	2015-11-11 19:23:23.885-03
505	conectar	456	Comando conectar OK	2015-11-11 19:23:23.886-03
506	conectar	455	Comando conectar OK	2015-11-11 19:23:23.89-03
507	conectar	453	Comando conectar OK	2015-11-11 19:23:23.894-03
508	conectar	452	Comando conectar OK	2015-11-11 19:23:23.897-03
509	conectar	462	Comando conectar OK	2015-11-11 19:23:23.9-03
510	conectar	461	Comando conectar OK	2015-11-11 19:23:23.902-03
511	conectar	460	Comando conectar OK	2015-11-11 19:23:23.905-03
512	conectar	459	Comando conectar OK	2015-11-11 19:23:23.908-03
513	conectar	458	Comando conectar OK	2015-11-11 19:23:23.911-03
514	conectar	466	Comando conectar OK	2015-11-11 19:23:23.913-03
515	conectar	465	Comando conectar OK	2015-11-11 19:23:23.917-03
516	conectar	464	Comando conectar OK	2015-11-11 19:23:23.922-03
517	conectar	463	Comando conectar OK	2015-11-11 19:23:23.925-03
518	conectar	471	Comando conectar OK	2015-11-11 19:23:23.947-03
519	conectar	470	Comando conectar OK	2015-11-11 19:23:23.952-03
520	conectar	469	Comando conectar OK	2015-11-11 19:23:23.955-03
521	conectar	468	Comando conectar OK	2015-11-11 19:23:23.957-03
522	conectar	467	Comando conectar OK	2015-11-11 19:23:23.958-03
523	conectar	475	Comando conectar OK	2015-11-11 19:23:23.959-03
524	conectar	474	Comando conectar OK	2015-11-11 19:23:23.961-03
525	conectar	473	Comando conectar OK	2015-11-11 19:23:23.963-03
526	conectar	472	Comando conectar OK	2015-11-11 19:23:23.965-03
527	conectar	480	Comando conectar OK	2015-11-11 19:23:23.967-03
528	conectar	479	Comando conectar OK	2015-11-11 19:23:23.975-03
529	conectar	478	Comando conectar OK	2015-11-11 19:23:23.978-03
530	conectar	477	Comando conectar OK	2015-11-11 19:23:23.981-03
531	conectar	476	Comando conectar OK	2015-11-11 19:23:23.983-03
532	conectar	485	Comando conectar OK	2015-11-11 19:23:23.986-03
533	conectar	484	Comando conectar OK	2015-11-11 19:23:23.988-03
534	conectar	483	Comando conectar OK	2015-11-11 19:23:24.005-03
535	conectar	482	Comando conectar OK	2015-11-11 19:23:24.012-03
536	conectar	481	Comando conectar OK	2015-11-11 19:23:24.014-03
537	conectar	490	Comando conectar OK	2015-11-11 19:23:24.017-03
538	conectar	489	Comando conectar OK	2015-11-11 19:23:24.02-03
539	conectar	488	Comando conectar OK	2015-11-11 19:23:24.025-03
540	conectar	487	Comando conectar OK	2015-11-11 19:23:24.029-03
541	conectar	486	Comando conectar OK	2015-11-11 19:23:24.03-03
542	conectar	495	Comando conectar OK	2015-11-11 19:23:24.032-03
543	conectar	496	Comando conectar OK	2015-11-11 19:23:24.033-03
544	conectar	497	Comando conectar OK	2015-11-11 19:23:24.034-03
545	conectar	498	Comando conectar OK	2015-11-11 19:23:24.035-03
546	conectar	499	Comando conectar OK	2015-11-11 19:23:24.036-03
547	conectar	500	Comando conectar OK	2015-11-11 19:23:24.037-03
548	conectar	501	Comando conectar OK	2015-11-11 19:23:24.039-03
549	conectar	494	Comando conectar OK	2015-11-11 19:23:24.046-03
550	conectar	493	Comando conectar OK	2015-11-11 19:23:24.049-03
551	conectar	492	Comando conectar OK	2015-11-11 19:23:24.051-03
552	conectar	491	Comando conectar OK	2015-11-11 19:23:24.054-03
553	conectar	506	Comando conectar OK	2015-11-11 19:23:24.057-03
554	conectar	505	Comando conectar OK	2015-11-11 19:23:24.061-03
555	conectar	504	Comando conectar OK	2015-11-11 19:23:24.063-03
556	conectar	503	Comando conectar OK	2015-11-11 19:23:24.066-03
557	conectar	502	Comando conectar OK	2015-11-11 19:23:24.07-03
558	conectar	511	Comando conectar OK	2015-11-11 19:23:24.075-03
559	conectar	510	Comando conectar OK	2015-11-11 19:23:24.083-03
560	conectar	509	Comando conectar OK	2015-11-11 19:23:24.087-03
561	conectar	508	Comando conectar OK	2015-11-11 19:23:24.09-03
562	conectar	507	Comando conectar OK	2015-11-11 19:23:24.093-03
563	conectar	516	Comando conectar OK	2015-11-11 19:23:24.097-03
564	conectar	515	Comando conectar OK	2015-11-11 19:23:24.1-03
565	conectar	514	Comando conectar OK	2015-11-11 19:23:24.103-03
566	conectar	519	Comando conectar OK	2015-11-11 19:23:24.105-03
567	conectar	513	Comando conectar OK	2015-11-11 19:23:24.107-03
568	conectar	512	Comando conectar OK	2015-11-11 19:23:24.111-03
569	conectar	522	Comando conectar OK	2015-11-11 19:23:24.116-03
570	conectar	521	Comando conectar OK	2015-11-11 19:23:24.118-03
571	conectar	520	Comando conectar OK	2015-11-11 19:23:24.121-03
572	conectar	518	Comando conectar OK	2015-11-11 19:23:24.124-03
573	conectar	517	Comando conectar OK	2015-11-11 19:23:24.127-03
574	conectar	527	Comando conectar OK	2015-11-11 19:23:24.13-03
575	conectar	526	Comando conectar OK	2015-11-11 19:23:24.132-03
576	conectar	525	Comando conectar OK	2015-11-11 19:23:24.135-03
577	conectar	524	Comando conectar OK	2015-11-11 19:23:24.137-03
578	conectar	523	Comando conectar OK	2015-11-11 19:23:24.144-03
579	conectar	528	Comando conectar OK	2015-11-11 19:23:24.153-03
580	conectar	529	Comando conectar OK	2015-11-11 19:23:24.16-03
581	conectar	530	Comando conectar OK	2015-11-11 19:23:24.167-03
582	conectar	531	Comando conectar OK	2015-11-11 19:23:24.169-03
583	conectar	532	Comando conectar OK	2015-11-11 19:23:24.171-03
584	conectar	533	Comando conectar OK	2015-11-11 19:23:24.173-03
585	conectar	534	Comando conectar OK	2015-11-11 19:23:24.177-03
586	conectar	539	Comando conectar OK	2015-11-11 19:23:24.183-03
587	conectar	538	Comando conectar OK	2015-11-11 19:23:24.184-03
588	conectar	537	Comando conectar OK	2015-11-11 19:23:24.185-03
589	conectar	542	Comando conectar OK	2015-11-11 19:23:24.186-03
590	conectar	543	Comando conectar OK	2015-11-11 19:23:24.188-03
591	conectar	536	Comando conectar OK	2015-11-11 19:23:24.189-03
592	conectar	535	Comando conectar OK	2015-11-11 19:23:24.19-03
593	conectar	545	Comando conectar OK	2015-11-11 19:23:24.192-03
594	conectar	544	Comando conectar OK	2015-11-11 19:23:24.193-03
595	conectar	548	Comando conectar OK	2015-11-11 19:23:24.195-03
596	conectar	549	Comando conectar OK	2015-11-11 19:23:24.197-03
597	conectar	541	Comando conectar OK	2015-11-11 19:23:24.202-03
598	conectar	540	Comando conectar OK	2015-11-11 19:23:24.205-03
599	conectar	552	Comando conectar OK	2015-11-11 19:23:24.207-03
600	conectar	551	Comando conectar OK	2015-11-11 19:23:24.21-03
601	conectar	550	Comando conectar OK	2015-11-11 19:23:24.216-03
602	conectar	547	Comando conectar OK	2015-11-11 19:23:24.225-03
603	conectar	546	Comando conectar OK	2015-11-11 19:23:24.229-03
604	conectar	557	Comando conectar OK	2015-11-11 19:23:24.232-03
605	conectar	556	Comando conectar OK	2015-11-11 19:23:24.243-03
606	conectar	555	Comando conectar OK	2015-11-11 19:23:24.25-03
607	conectar	554	Comando conectar OK	2015-11-11 19:23:24.255-03
608	conectar	553	Comando conectar OK	2015-11-11 19:23:24.262-03
609	conectar	562	Comando conectar OK	2015-11-11 19:23:24.267-03
610	conectar	561	Comando conectar OK	2015-11-11 19:23:24.277-03
611	conectar	560	Comando conectar OK	2015-11-11 19:23:24.279-03
612	conectar	559	Comando conectar OK	2015-11-11 19:23:24.282-03
613	conectar	558	Comando conectar OK	2015-11-11 19:23:24.291-03
614	conectar	567	Comando conectar OK	2015-11-11 19:23:24.299-03
615	conectar	566	Comando conectar OK	2015-11-11 19:23:24.304-03
616	conectar	565	Comando conectar OK	2015-11-11 19:23:24.309-03
617	conectar	564	Comando conectar OK	2015-11-11 19:23:24.312-03
618	conectar	563	Comando conectar OK	2015-11-11 19:23:24.317-03
619	conectar	572	Comando conectar OK	2015-11-11 19:23:24.32-03
620	conectar	571	Comando conectar OK	2015-11-11 19:23:24.323-03
621	conectar	570	Comando conectar OK	2015-11-11 19:23:24.326-03
622	conectar	569	Comando conectar OK	2015-11-11 19:23:24.33-03
623	conectar	568	Comando conectar OK	2015-11-11 19:23:24.331-03
624	conectar	577	Comando conectar OK	2015-11-11 19:23:24.332-03
625	conectar	578	Comando conectar OK	2015-11-11 19:23:24.334-03
626	conectar	576	Comando conectar OK	2015-11-11 19:23:24.337-03
627	conectar	575	Comando conectar OK	2015-11-11 19:23:24.339-03
628	conectar	581	Comando conectar OK	2015-11-11 19:23:24.341-03
629	conectar	582	Comando conectar OK	2015-11-11 19:23:24.342-03
630	conectar	583	Comando conectar OK	2015-11-11 19:23:24.343-03
631	conectar	584	Comando conectar OK	2015-11-11 19:23:24.345-03
632	conectar	574	Comando conectar OK	2015-11-11 19:23:24.346-03
633	conectar	586	Comando conectar OK	2015-11-11 19:23:24.348-03
634	conectar	573	Comando conectar OK	2015-11-11 19:23:24.355-03
635	conectar	588	Comando conectar OK	2015-11-11 19:23:24.357-03
636	conectar	587	Comando conectar OK	2015-11-11 19:23:24.36-03
637	conectar	585	Comando conectar OK	2015-11-11 19:23:24.395-03
638	conectar	580	Comando conectar OK	2015-11-11 19:23:24.4-03
639	conectar	579	Comando conectar OK	2015-11-11 19:23:24.403-03
640	conectar	593	Comando conectar OK	2015-11-11 19:23:24.407-03
641	conectar	592	Comando conectar OK	2015-11-11 19:23:24.408-03
642	conectar	591	Comando conectar OK	2015-11-11 19:23:24.411-03
643	conectar	590	Comando conectar OK	2015-11-11 19:23:24.414-03
644	conectar	589	Comando conectar OK	2015-11-11 19:23:24.427-03
645	conectar	597	Comando conectar OK	2015-11-11 19:23:24.442-03
646	conectar	596	Comando conectar OK	2015-11-11 19:23:24.443-03
647	conectar	595	Comando conectar OK	2015-11-11 19:23:24.445-03
648	conectar	594	Comando conectar OK	2015-11-11 19:23:24.448-03
649	conectar	601	Comando conectar OK	2015-11-11 19:23:24.449-03
650	conectar	600	Comando conectar OK	2015-11-11 19:23:24.454-03
651	conectar	599	Comando conectar OK	2015-11-11 19:23:24.456-03
652	conectar	598	Comando conectar OK	2015-11-11 19:23:24.458-03
653	conectar	606	Comando conectar OK	2015-11-11 19:23:24.466-03
654	conectar	605	Comando conectar OK	2015-11-11 19:23:24.469-03
655	conectar	604	Comando conectar OK	2015-11-11 19:23:24.472-03
656	conectar	603	Comando conectar OK	2015-11-11 19:23:24.474-03
657	conectar	602	Comando conectar OK	2015-11-11 19:23:24.477-03
658	conectar	611	Comando conectar OK	2015-11-11 19:23:24.481-03
659	conectar	612	Comando conectar OK	2015-11-11 19:23:24.483-03
660	conectar	610	Comando conectar OK	2015-11-11 19:23:24.486-03
661	conectar	609	Comando conectar OK	2015-11-11 19:23:24.491-03
662	conectar	608	Comando conectar OK	2015-11-11 19:23:24.493-03
663	conectar	607	Comando conectar OK	2015-11-11 19:23:24.495-03
664	conectar	615	Comando conectar OK	2015-11-11 19:23:24.502-03
665	conectar	614	Comando conectar OK	2015-11-11 19:23:24.503-03
666	conectar	613	Comando conectar OK	2015-11-11 19:23:24.505-03
667	conectar	616	Comando conectar OK	2015-11-11 19:23:24.521-03
668	conectar	621	Comando conectar OK	2015-11-11 19:23:24.523-03
669	conectar	620	Comando conectar OK	2015-11-11 19:23:24.536-03
670	conectar	619	Comando conectar OK	2015-11-11 19:23:24.538-03
671	conectar	618	Comando conectar OK	2015-11-11 19:23:24.541-03
672	conectar	617	Comando conectar OK	2015-11-11 19:23:24.543-03
673	conectar	626	Comando conectar OK	2015-11-11 19:23:24.547-03
674	conectar	625	Comando conectar OK	2015-11-11 19:23:24.55-03
675	conectar	624	Comando conectar OK	2015-11-11 19:23:24.562-03
676	conectar	623	Comando conectar OK	2015-11-11 19:23:24.573-03
677	conectar	622	Comando conectar OK	2015-11-11 19:23:24.576-03
678	conectar	631	Comando conectar OK	2015-11-11 19:23:24.578-03
679	conectar	630	Comando conectar OK	2015-11-11 19:23:24.599-03
680	conectar	629	Comando conectar OK	2015-11-11 19:23:24.602-03
681	conectar	628	Comando conectar OK	2015-11-11 19:23:24.605-03
682	conectar	627	Comando conectar OK	2015-11-11 19:23:24.608-03
683	conectar	636	Comando conectar OK	2015-11-11 19:23:24.61-03
684	conectar	635	Comando conectar OK	2015-11-11 19:23:24.613-03
685	conectar	634	Comando conectar OK	2015-11-11 19:23:24.616-03
686	conectar	633	Comando conectar OK	2015-11-11 19:23:24.62-03
687	conectar	632	Comando conectar OK	2015-11-11 19:23:24.623-03
688	conectar	641	Comando conectar OK	2015-11-11 19:23:24.628-03
689	conectar	640	Comando conectar OK	2015-11-11 19:23:24.631-03
690	conectar	639	Comando conectar OK	2015-11-11 19:23:24.634-03
691	conectar	638	Comando conectar OK	2015-11-11 19:23:24.637-03
692	conectar	637	Comando conectar OK	2015-11-11 19:23:24.641-03
693	conectar	646	Comando conectar OK	2015-11-11 19:23:24.643-03
694	conectar	645	Comando conectar OK	2015-11-11 19:23:24.648-03
695	conectar	644	Comando conectar OK	2015-11-11 19:23:24.651-03
696	conectar	643	Comando conectar OK	2015-11-11 19:23:24.654-03
697	conectar	642	Comando conectar OK	2015-11-11 19:23:24.656-03
698	conectar	651	Comando conectar OK	2015-11-11 19:23:24.659-03
699	conectar	650	Comando conectar OK	2015-11-11 19:23:24.661-03
700	conectar	649	Comando conectar OK	2015-11-11 19:23:24.665-03
701	conectar	648	Comando conectar OK	2015-11-11 19:23:24.667-03
702	conectar	647	Comando conectar OK	2015-11-11 19:23:24.671-03
703	conectar	656	Comando conectar OK	2015-11-11 19:23:24.673-03
704	conectar	655	Comando conectar OK	2015-11-11 19:23:24.676-03
705	conectar	658	Comando conectar OK	2015-11-11 19:23:24.677-03
706	conectar	654	Comando conectar OK	2015-11-11 19:23:24.678-03
707	conectar	660	Comando conectar OK	2015-11-11 19:23:24.679-03
708	conectar	661	Comando conectar OK	2015-11-11 19:23:24.681-03
709	conectar	662	Comando conectar OK	2015-11-11 19:23:24.683-03
710	conectar	663	Comando conectar OK	2015-11-11 19:23:24.684-03
711	conectar	653	Comando conectar OK	2015-11-11 19:23:24.685-03
712	conectar	652	Comando conectar OK	2015-11-11 19:23:24.687-03
713	conectar	666	Comando conectar OK	2015-11-11 19:23:24.688-03
714	conectar	665	Comando conectar OK	2015-11-11 19:23:24.689-03
715	conectar	664	Comando conectar OK	2015-11-11 19:23:24.692-03
716	conectar	659	Comando conectar OK	2015-11-11 19:23:24.694-03
717	conectar	657	Comando conectar OK	2015-11-11 19:23:24.697-03
718	conectar	671	Comando conectar OK	2015-11-11 19:23:24.702-03
719	conectar	670	Comando conectar OK	2015-11-11 19:23:24.705-03
720	conectar	669	Comando conectar OK	2015-11-11 19:23:24.707-03
721	conectar	668	Comando conectar OK	2015-11-11 19:23:24.713-03
722	conectar	667	Comando conectar OK	2015-11-11 19:23:24.724-03
723	conectar	676	Comando conectar OK	2015-11-11 19:23:24.726-03
724	conectar	675	Comando conectar OK	2015-11-11 19:23:24.728-03
725	conectar	674	Comando conectar OK	2015-11-11 19:23:24.731-03
726	conectar	673	Comando conectar OK	2015-11-11 19:23:24.734-03
727	conectar	672	Comando conectar OK	2015-11-11 19:23:24.744-03
728	conectar	681	Comando conectar OK	2015-11-11 19:23:24.746-03
729	conectar	680	Comando conectar OK	2015-11-11 19:23:24.751-03
730	conectar	679	Comando conectar OK	2015-11-11 19:23:24.755-03
731	conectar	678	Comando conectar OK	2015-11-11 19:23:24.757-03
732	conectar	677	Comando conectar OK	2015-11-11 19:23:24.76-03
733	conectar	686	Comando conectar OK	2015-11-11 19:23:24.763-03
734	conectar	685	Comando conectar OK	2015-11-11 19:23:24.765-03
735	conectar	684	Comando conectar OK	2015-11-11 19:23:24.778-03
736	conectar	683	Comando conectar OK	2015-11-11 19:23:24.783-03
737	conectar	682	Comando conectar OK	2015-11-11 19:23:24.787-03
738	conectar	691	Comando conectar OK	2015-11-11 19:23:24.789-03
739	conectar	690	Comando conectar OK	2015-11-11 19:23:24.792-03
740	conectar	689	Comando conectar OK	2015-11-11 19:23:24.805-03
741	conectar	688	Comando conectar OK	2015-11-11 19:23:24.808-03
742	conectar	687	Comando conectar OK	2015-11-11 19:23:24.811-03
743	conectar	696	Comando conectar OK	2015-11-11 19:23:24.812-03
744	conectar	695	Comando conectar OK	2015-11-11 19:23:24.817-03
745	conectar	694	Comando conectar OK	2015-11-11 19:23:24.82-03
746	conectar	693	Comando conectar OK	2015-11-11 19:23:24.823-03
747	conectar	692	Comando conectar OK	2015-11-11 19:23:24.826-03
748	conectar	701	Comando conectar OK	2015-11-11 19:23:24.827-03
749	conectar	700	Comando conectar OK	2015-11-11 19:23:24.832-03
750	conectar	699	Comando conectar OK	2015-11-11 19:23:24.835-03
751	conectar	698	Comando conectar OK	2015-11-11 19:23:24.837-03
752	conectar	697	Comando conectar OK	2015-11-11 19:23:24.841-03
753	conectar	706	Comando conectar OK	2015-11-11 19:23:24.843-03
754	conectar	705	Comando conectar OK	2015-11-11 19:23:24.847-03
755	conectar	704	Comando conectar OK	2015-11-11 19:23:24.851-03
756	conectar	703	Comando conectar OK	2015-11-11 19:23:24.854-03
757	conectar	702	Comando conectar OK	2015-11-11 19:23:24.855-03
758	conectar	711	Comando conectar OK	2015-11-11 19:23:24.86-03
759	conectar	710	Comando conectar OK	2015-11-11 19:23:24.861-03
760	conectar	709	Comando conectar OK	2015-11-11 19:23:24.866-03
761	conectar	708	Comando conectar OK	2015-11-11 19:23:24.867-03
762	conectar	707	Comando conectar OK	2015-11-11 19:23:24.879-03
763	conectar	716	Comando conectar OK	2015-11-11 19:23:24.883-03
764	conectar	715	Comando conectar OK	2015-11-11 19:23:24.885-03
765	conectar	714	Comando conectar OK	2015-11-11 19:23:24.888-03
766	conectar	713	Comando conectar OK	2015-11-11 19:23:24.905-03
767	conectar	712	Comando conectar OK	2015-11-11 19:23:24.908-03
768	conectar	721	Comando conectar OK	2015-11-11 19:23:24.91-03
769	conectar	720	Comando conectar OK	2015-11-11 19:23:24.913-03
770	conectar	719	Comando conectar OK	2015-11-11 19:23:24.92-03
771	conectar	718	Comando conectar OK	2015-11-11 19:23:24.923-03
772	conectar	717	Comando conectar OK	2015-11-11 19:23:24.926-03
773	conectar	726	Comando conectar OK	2015-11-11 19:23:24.972-03
774	conectar	725	Comando conectar OK	2015-11-11 19:23:24.983-03
775	conectar	724	Comando conectar OK	2015-11-11 19:23:24.992-03
776	conectar	723	Comando conectar OK	2015-11-11 19:23:25.004-03
777	conectar	722	Comando conectar OK	2015-11-11 19:23:25.009-03
778	conectar	731	Comando conectar OK	2015-11-11 19:23:25.017-03
779	conectar	730	Comando conectar OK	2015-11-11 19:23:25.026-03
780	conectar	729	Comando conectar OK	2015-11-11 19:23:25.035-03
781	conectar	728	Comando conectar OK	2015-11-11 19:23:25.04-03
782	conectar	727	Comando conectar OK	2015-11-11 19:23:25.043-03
783	conectar	736	Comando conectar OK	2015-11-11 19:23:25.045-03
784	conectar	735	Comando conectar OK	2015-11-11 19:23:25.054-03
785	conectar	734	Comando conectar OK	2015-11-11 19:23:25.056-03
786	conectar	733	Comando conectar OK	2015-11-11 19:23:25.06-03
787	conectar	732	Comando conectar OK	2015-11-11 19:23:25.062-03
788	conectar	741	Comando conectar OK	2015-11-11 19:23:25.067-03
789	conectar	740	Comando conectar OK	2015-11-11 19:23:25.069-03
790	conectar	739	Comando conectar OK	2015-11-11 19:23:25.072-03
791	conectar	738	Comando conectar OK	2015-11-11 19:23:25.081-03
792	conectar	737	Comando conectar OK	2015-11-11 19:23:25.084-03
793	conectar	746	Comando conectar OK	2015-11-11 19:23:25.087-03
794	conectar	745	Comando conectar OK	2015-11-11 19:23:25.091-03
795	conectar	744	Comando conectar OK	2015-11-11 19:23:25.093-03
796	conectar	743	Comando conectar OK	2015-11-11 19:23:25.098-03
797	conectar	742	Comando conectar OK	2015-11-11 19:23:25.102-03
798	conectar	751	Comando conectar OK	2015-11-11 19:23:25.105-03
799	conectar	750	Comando conectar OK	2015-11-11 19:23:25.108-03
800	conectar	749	Comando conectar OK	2015-11-11 19:23:25.111-03
801	conectar	748	Comando conectar OK	2015-11-11 19:23:25.113-03
802	conectar	747	Comando conectar OK	2015-11-11 19:23:25.117-03
803	conectar	756	Comando conectar OK	2015-11-11 19:23:25.119-03
804	conectar	755	Comando conectar OK	2015-11-11 19:23:25.12-03
805	conectar	754	Comando conectar OK	2015-11-11 19:23:25.122-03
806	conectar	759	Comando conectar OK	2015-11-11 19:23:25.123-03
807	conectar	753	Comando conectar OK	2015-11-11 19:23:25.126-03
808	conectar	752	Comando conectar OK	2015-11-11 19:23:25.128-03
809	conectar	762	Comando conectar OK	2015-11-11 19:23:25.131-03
810	conectar	761	Comando conectar OK	2015-11-11 19:23:25.135-03
811	conectar	760	Comando conectar OK	2015-11-11 19:23:25.137-03
812	conectar	758	Comando conectar OK	2015-11-11 19:23:25.139-03
813	conectar	757	Comando conectar OK	2015-11-11 19:23:25.142-03
814	conectar	767	Comando conectar OK	2015-11-11 19:23:25.145-03
815	conectar	766	Comando conectar OK	2015-11-11 19:23:25.162-03
816	conectar	769	Comando conectar OK	2015-11-11 19:23:25.164-03
817	conectar	765	Comando conectar OK	2015-11-11 19:23:25.168-03
818	conectar	764	Comando conectar OK	2015-11-11 19:23:25.185-03
819	conectar	772	Comando conectar OK	2015-11-11 19:23:25.187-03
820	conectar	763	Comando conectar OK	2015-11-11 19:23:25.2-03
821	conectar	774	Comando conectar OK	2015-11-11 19:23:25.208-03
822	conectar	773	Comando conectar OK	2015-11-11 19:23:25.217-03
823	conectar	771	Comando conectar OK	2015-11-11 19:23:25.226-03
824	conectar	770	Comando conectar OK	2015-11-11 19:23:25.237-03
825	conectar	768	Comando conectar OK	2015-11-11 19:23:25.246-03
826	conectar	779	Comando conectar OK	2015-11-11 19:23:25.255-03
827	conectar	778	Comando conectar OK	2015-11-11 19:23:25.266-03
828	conectar	777	Comando conectar OK	2015-11-11 19:23:25.281-03
829	conectar	776	Comando conectar OK	2015-11-11 19:23:25.282-03
830	conectar	775	Comando conectar OK	2015-11-11 19:23:25.286-03
831	conectar	784	Comando conectar OK	2015-11-11 19:23:25.292-03
832	conectar	783	Comando conectar OK	2015-11-11 19:23:25.295-03
833	conectar	782	Comando conectar OK	2015-11-11 19:23:25.299-03
834	conectar	781	Comando conectar OK	2015-11-11 19:23:25.302-03
835	conectar	780	Comando conectar OK	2015-11-11 19:23:25.314-03
836	conectar	789	Comando conectar OK	2015-11-11 19:23:25.315-03
837	conectar	788	Comando conectar OK	2015-11-11 19:23:25.323-03
838	conectar	787	Comando conectar OK	2015-11-11 19:23:25.333-03
839	conectar	792	Comando conectar OK	2015-11-11 19:23:25.336-03
840	conectar	786	Comando conectar OK	2015-11-11 19:23:25.337-03
841	conectar	785	Comando conectar OK	2015-11-11 19:23:25.341-03
842	conectar	795	Comando conectar OK	2015-11-11 19:23:25.343-03
843	conectar	794	Comando conectar OK	2015-11-11 19:23:25.346-03
844	conectar	793	Comando conectar OK	2015-11-11 19:23:25.349-03
845	conectar	791	Comando conectar OK	2015-11-11 19:23:25.366-03
846	conectar	790	Comando conectar OK	2015-11-11 19:23:25.375-03
847	conectar	800	Comando conectar OK	2015-11-11 19:23:25.379-03
848	conectar	799	Comando conectar OK	2015-11-11 19:23:25.381-03
849	conectar	798	Comando conectar OK	2015-11-11 19:23:25.385-03
850	conectar	797	Comando conectar OK	2015-11-11 19:23:25.388-03
851	conectar	796	Comando conectar OK	2015-11-11 19:23:25.39-03
852	conectar	805	Comando conectar OK	2015-11-11 19:23:25.393-03
853	conectar	804	Comando conectar OK	2015-11-11 19:23:25.396-03
854	conectar	807	Comando conectar OK	2015-11-11 19:23:25.397-03
855	conectar	808	Comando conectar OK	2015-11-11 19:23:25.398-03
856	conectar	809	Comando conectar OK	2015-11-11 19:23:25.4-03
857	conectar	803	Comando conectar OK	2015-11-11 19:23:25.401-03
858	conectar	802	Comando conectar OK	2015-11-11 19:23:25.403-03
859	conectar	801	Comando conectar OK	2015-11-11 19:23:25.404-03
860	conectar	813	Comando conectar OK	2015-11-11 19:23:25.406-03
861	conectar	811	Comando conectar OK	2015-11-11 19:23:25.409-03
862	conectar	812	Comando conectar OK	2015-11-11 19:23:25.41-03
863	conectar	810	Comando conectar OK	2015-11-11 19:23:25.428-03
864	conectar	817	Comando conectar OK	2015-11-11 19:23:25.43-03
865	conectar	806	Comando conectar OK	2015-11-11 19:23:25.432-03
866	conectar	819	Comando conectar OK	2015-11-11 19:23:25.436-03
867	conectar	818	Comando conectar OK	2015-11-11 19:23:25.439-03
868	conectar	816	Comando conectar OK	2015-11-11 19:23:25.441-03
869	conectar	815	Comando conectar OK	2015-11-11 19:23:25.443-03
870	conectar	814	Comando conectar OK	2015-11-11 19:23:25.447-03
871	conectar	824	Comando conectar OK	2015-11-11 19:23:25.449-03
872	conectar	823	Comando conectar OK	2015-11-11 19:23:25.454-03
873	conectar	822	Comando conectar OK	2015-11-11 19:23:25.456-03
874	conectar	821	Comando conectar OK	2015-11-11 19:23:25.459-03
875	conectar	820	Comando conectar OK	2015-11-11 19:23:25.462-03
876	conectar	829	Comando conectar OK	2015-11-11 19:23:25.464-03
877	conectar	828	Comando conectar OK	2015-11-11 19:23:25.467-03
878	conectar	827	Comando conectar OK	2015-11-11 19:23:25.483-03
879	conectar	826	Comando conectar OK	2015-11-11 19:23:25.486-03
880	conectar	825	Comando conectar OK	2015-11-11 19:23:25.488-03
881	conectar	834	Comando conectar OK	2015-11-11 19:23:25.491-03
882	conectar	833	Comando conectar OK	2015-11-11 19:23:25.504-03
883	conectar	832	Comando conectar OK	2015-11-11 19:23:25.507-03
884	conectar	831	Comando conectar OK	2015-11-11 19:23:25.51-03
885	conectar	830	Comando conectar OK	2015-11-11 19:23:25.513-03
886	conectar	839	Comando conectar OK	2015-11-11 19:23:25.515-03
887	conectar	838	Comando conectar OK	2015-11-11 19:23:25.519-03
888	conectar	837	Comando conectar OK	2015-11-11 19:23:25.522-03
889	conectar	836	Comando conectar OK	2015-11-11 19:23:25.525-03
890	conectar	835	Comando conectar OK	2015-11-11 19:23:25.527-03
891	conectar	844	Comando conectar OK	2015-11-11 19:23:25.53-03
892	conectar	843	Comando conectar OK	2015-11-11 19:23:25.532-03
893	conectar	842	Comando conectar OK	2015-11-11 19:23:25.533-03
894	conectar	847	Comando conectar OK	2015-11-11 19:23:25.536-03
895	conectar	841	Comando conectar OK	2015-11-11 19:23:25.538-03
896	conectar	840	Comando conectar OK	2015-11-11 19:23:25.539-03
897	conectar	850	Comando conectar OK	2015-11-11 19:23:25.54-03
898	conectar	851	Comando conectar OK	2015-11-11 19:23:25.541-03
899	conectar	849	Comando conectar OK	2015-11-11 19:23:25.543-03
900	conectar	853	Comando conectar OK	2015-11-11 19:23:25.544-03
901	conectar	854	Comando conectar OK	2015-11-11 19:23:25.545-03
902	conectar	848	Comando conectar OK	2015-11-11 19:23:25.552-03
903	conectar	846	Comando conectar OK	2015-11-11 19:23:25.553-03
904	conectar	845	Comando conectar OK	2015-11-11 19:23:25.556-03
905	conectar	857	Comando conectar OK	2015-11-11 19:23:25.558-03
906	conectar	856	Comando conectar OK	2015-11-11 19:23:25.561-03
907	conectar	855	Comando conectar OK	2015-11-11 19:23:25.57-03
908	conectar	852	Comando conectar OK	2015-11-11 19:23:25.573-03
909	conectar	861	Comando conectar OK	2015-11-11 19:23:25.576-03
910	conectar	860	Comando conectar OK	2015-11-11 19:23:25.578-03
911	conectar	859	Comando conectar OK	2015-11-11 19:23:25.583-03
912	conectar	858	Comando conectar OK	2015-11-11 19:23:25.589-03
913	conectar	866	Comando conectar OK	2015-11-11 19:23:25.593-03
914	conectar	865	Comando conectar OK	2015-11-11 19:23:25.596-03
915	conectar	864	Comando conectar OK	2015-11-11 19:23:25.598-03
916	conectar	863	Comando conectar OK	2015-11-11 19:23:25.602-03
917	conectar	862	Comando conectar OK	2015-11-11 19:23:25.605-03
918	conectar	871	Comando conectar OK	2015-11-11 19:23:25.608-03
919	conectar	870	Comando conectar OK	2015-11-11 19:23:25.614-03
920	conectar	869	Comando conectar OK	2015-11-11 19:23:25.62-03
921	conectar	868	Comando conectar OK	2015-11-11 19:23:25.624-03
922	conectar	867	Comando conectar OK	2015-11-11 19:23:25.629-03
923	conectar	875	Comando conectar OK	2015-11-11 19:23:25.637-03
924	conectar	874	Comando conectar OK	2015-11-11 19:23:25.647-03
925	conectar	873	Comando conectar OK	2015-11-11 19:23:25.65-03
926	conectar	872	Comando conectar OK	2015-11-11 19:23:25.657-03
927	conectar	878	Comando conectar OK	2015-11-11 19:23:25.661-03
928	conectar	877	Comando conectar OK	2015-11-11 19:23:25.665-03
929	conectar	876	Comando conectar OK	2015-11-11 19:23:25.668-03
930	conectar	883	Comando conectar OK	2015-11-11 19:23:25.671-03
931	conectar	882	Comando conectar OK	2015-11-11 19:23:25.672-03
932	conectar	881	Comando conectar OK	2015-11-11 19:23:25.673-03
933	conectar	886	Comando conectar OK	2015-11-11 19:23:25.675-03
934	conectar	887	Comando conectar OK	2015-11-11 19:23:25.676-03
935	conectar	888	Comando conectar OK	2015-11-11 19:23:25.677-03
936	conectar	889	Comando conectar OK	2015-11-11 19:23:25.678-03
937	conectar	890	Comando conectar OK	2015-11-11 19:23:25.679-03
938	conectar	880	Comando conectar OK	2015-11-11 19:23:25.689-03
939	conectar	879	Comando conectar OK	2015-11-11 19:23:25.698-03
940	conectar	893	Comando conectar OK	2015-11-11 19:23:25.706-03
941	conectar	892	Comando conectar OK	2015-11-11 19:23:25.709-03
942	conectar	891	Comando conectar OK	2015-11-11 19:23:25.71-03
943	conectar	885	Comando conectar OK	2015-11-11 19:23:25.713-03
944	conectar	884	Comando conectar OK	2015-11-11 19:23:25.715-03
945	conectar	897	Comando conectar OK	2015-11-11 19:23:25.718-03
946	conectar	896	Comando conectar OK	2015-11-11 19:23:25.722-03
947	conectar	895	Comando conectar OK	2015-11-11 19:23:25.725-03
948	conectar	894	Comando conectar OK	2015-11-11 19:23:25.727-03
949	conectar	901	Comando conectar OK	2015-11-11 19:23:25.73-03
950	conectar	900	Comando conectar OK	2015-11-11 19:23:25.732-03
951	conectar	899	Comando conectar OK	2015-11-11 19:23:25.735-03
952	conectar	898	Comando conectar OK	2015-11-11 19:23:25.738-03
953	conectar	906	Comando conectar OK	2015-11-11 19:23:25.742-03
954	conectar	905	Comando conectar OK	2015-11-11 19:23:25.745-03
955	conectar	904	Comando conectar OK	2015-11-11 19:23:25.748-03
956	conectar	903	Comando conectar OK	2015-11-11 19:23:25.751-03
957	conectar	902	Comando conectar OK	2015-11-11 19:23:25.754-03
958	conectar	911	Comando conectar OK	2015-11-11 19:23:25.756-03
959	conectar	910	Comando conectar OK	2015-11-11 19:23:25.759-03
960	conectar	909	Comando conectar OK	2015-11-11 19:23:25.775-03
961	conectar	908	Comando conectar OK	2015-11-11 19:23:25.776-03
962	conectar	907	Comando conectar OK	2015-11-11 19:23:25.778-03
963	conectar	913	Comando conectar OK	2015-11-11 19:23:25.779-03
964	conectar	912	Comando conectar OK	2015-11-11 19:23:25.781-03
965	conectar	914	Comando conectar OK	2015-11-11 19:23:25.79-03
966	conectar	919	Comando conectar OK	2015-11-11 19:23:25.796-03
967	conectar	918	Comando conectar OK	2015-11-11 19:23:25.797-03
968	conectar	917	Comando conectar OK	2015-11-11 19:23:25.799-03
969	conectar	916	Comando conectar OK	2015-11-11 19:23:25.8-03
970	conectar	915	Comando conectar OK	2015-11-11 19:23:25.801-03
971	conectar	920	Comando conectar OK	2015-11-11 19:23:25.802-03
972	conectar	923	Comando conectar OK	2015-11-11 19:23:25.817-03
973	conectar	925	Comando conectar OK	2015-11-11 19:23:25.819-03
974	conectar	924	Comando conectar OK	2015-11-11 19:23:25.82-03
975	conectar	922	Comando conectar OK	2015-11-11 19:23:25.823-03
976	conectar	927	Comando conectar OK	2015-11-11 19:23:25.827-03
977	conectar	921	Comando conectar OK	2015-11-11 19:23:25.829-03
978	conectar	926	Comando conectar OK	2015-11-11 19:23:25.831-03
979	conectar	928	Comando conectar OK	2015-11-11 19:23:25.832-03
980	conectar	929	Comando conectar OK	2015-11-11 19:23:25.835-03
981	conectar	930	Comando conectar OK	2015-11-11 19:23:25.838-03
982	conectar	931	Comando conectar OK	2015-11-11 19:23:25.841-03
983	conectar	932	Comando conectar OK	2015-11-11 19:23:25.844-03
984	conectar	933	Comando conectar OK	2015-11-11 19:23:25.846-03
985	conectar	934	Comando conectar OK	2015-11-11 19:23:25.849-03
986	conectar	935	Comando conectar OK	2015-11-11 19:23:25.852-03
987	conectar	936	Comando conectar OK	2015-11-11 19:23:25.855-03
988	conectar	937	Comando conectar OK	2015-11-11 19:23:25.859-03
989	conectar	938	Comando conectar OK	2015-11-11 19:23:25.861-03
990	conectar	939	Comando conectar OK	2015-11-11 19:23:25.863-03
991	conectar	940	Comando conectar OK	2015-11-11 19:23:25.865-03
992	conectar	941	Comando conectar OK	2015-11-11 19:23:25.868-03
993	conectar	946	Comando conectar OK	2015-11-11 19:23:25.879-03
994	conectar	945	Comando conectar OK	2015-11-11 19:23:25.895-03
995	conectar	944	Comando conectar OK	2015-11-11 19:23:25.896-03
996	conectar	943	Comando conectar OK	2015-11-11 19:23:25.899-03
997	conectar	942	Comando conectar OK	2015-11-11 19:23:25.901-03
998	conectar	951	Comando conectar OK	2015-11-11 19:23:25.905-03
999	conectar	950	Comando conectar OK	2015-11-11 19:23:25.908-03
1000	conectar	949	Comando conectar OK	2015-11-11 19:23:25.911-03
1001	conectar	948	Comando conectar OK	2015-11-11 19:23:25.913-03
1002	conectar	947	Comando conectar OK	2015-11-11 19:23:25.914-03
1003	conectar	956	Comando conectar OK	2015-11-11 19:23:25.918-03
1004	conectar	955	Comando conectar OK	2015-11-11 19:23:25.92-03
1005	conectar	958	Comando conectar OK	2015-11-11 19:23:25.922-03
1006	conectar	954	Comando conectar OK	2015-11-11 19:23:25.924-03
1007	conectar	960	Comando conectar OK	2015-11-11 19:23:25.925-03
1008	conectar	961	Comando conectar OK	2015-11-11 19:23:25.926-03
1009	conectar	962	Comando conectar OK	2015-11-11 19:23:25.927-03
1010	conectar	953	Comando conectar OK	2015-11-11 19:23:25.929-03
1011	conectar	952	Comando conectar OK	2015-11-11 19:23:25.93-03
1012	conectar	965	Comando conectar OK	2015-11-11 19:23:25.931-03
1013	conectar	966	Comando conectar OK	2015-11-11 19:23:25.932-03
1014	conectar	967	Comando conectar OK	2015-11-11 19:23:25.933-03
1015	conectar	968	Comando conectar OK	2015-11-11 19:23:25.935-03
1016	conectar	969	Comando conectar OK	2015-11-11 19:23:25.936-03
1017	conectar	964	Comando conectar OK	2015-11-11 19:23:25.938-03
1018	conectar	963	Comando conectar OK	2015-11-11 19:23:25.94-03
1019	conectar	959	Comando conectar OK	2015-11-11 19:23:25.941-03
1020	conectar	973	Comando conectar OK	2015-11-11 19:23:25.942-03
1021	conectar	974	Comando conectar OK	2015-11-11 19:23:25.943-03
1022	conectar	975	Comando conectar OK	2015-11-11 19:23:25.944-03
1023	conectar	976	Comando conectar OK	2015-11-11 19:23:25.946-03
1024	conectar	977	Comando conectar OK	2015-11-11 19:23:25.947-03
1025	conectar	978	Comando conectar OK	2015-11-11 19:23:25.948-03
1026	conectar	979	Comando conectar OK	2015-11-11 19:23:25.949-03
1027	conectar	980	Comando conectar OK	2015-11-11 19:23:25.95-03
1028	conectar	957	Comando conectar OK	2015-11-11 19:23:25.952-03
1029	conectar	982	Comando conectar OK	2015-11-11 19:23:25.956-03
1030	conectar	981	Comando conectar OK	2015-11-11 19:23:25.958-03
1031	conectar	972	Comando conectar OK	2015-11-11 19:23:25.961-03
1032	conectar	971	Comando conectar OK	2015-11-11 19:23:25.964-03
1033	conectar	970	Comando conectar OK	2015-11-11 19:23:25.967-03
1034	conectar	987	Comando conectar OK	2015-11-11 19:23:25.969-03
1035	conectar	986	Comando conectar OK	2015-11-11 19:23:25.973-03
1036	conectar	985	Comando conectar OK	2015-11-11 19:23:25.976-03
1037	conectar	984	Comando conectar OK	2015-11-11 19:23:25.979-03
1038	conectar	983	Comando conectar OK	2015-11-11 19:23:25.982-03
1039	conectar	992	Comando conectar OK	2015-11-11 19:23:25.985-03
1040	conectar	991	Comando conectar OK	2015-11-11 19:23:25.989-03
1041	conectar	990	Comando conectar OK	2015-11-11 19:23:25.991-03
1042	conectar	989	Comando conectar OK	2015-11-11 19:23:25.994-03
1043	conectar	988	Comando conectar OK	2015-11-11 19:23:25.996-03
1044	conectar	997	Comando conectar OK	2015-11-11 19:23:25.999-03
1045	conectar	996	Comando conectar OK	2015-11-11 19:23:26.002-03
1046	conectar	995	Comando conectar OK	2015-11-11 19:23:26.006-03
1047	conectar	994	Comando conectar OK	2015-11-11 19:23:26.01-03
1048	conectar	993	Comando conectar OK	2015-11-11 19:23:26.013-03
1049	conectar	1002	Comando conectar OK	2015-11-11 19:23:26.018-03
1050	conectar	1001	Comando conectar OK	2015-11-11 19:23:26.023-03
1051	conectar	1000	Comando conectar OK	2015-11-11 19:23:26.025-03
1052	conectar	999	Comando conectar OK	2015-11-11 19:23:26.027-03
1053	conectar	998	Comando conectar OK	2015-11-11 19:23:26.029-03
1054	conectar	1004	Comando conectar OK	2015-11-11 19:23:26.031-03
1055	conectar	1003	Comando conectar OK	2015-11-11 19:23:26.032-03
1056	fechaServidor		No esta conectado!	2015-11-11 19:23:52.347-03
1057	fechaServidor		No esta conectado!	2015-11-11 19:23:52.353-03
1058	fechaServidor		No esta conectado!	2015-11-11 19:23:52.354-03
1059	fechaServidor		No esta conectado!	2015-11-11 19:23:52.356-03
1060	fechaServidor		No esta conectado!	2015-11-11 19:23:52.358-03
1061	fechaServidor		No esta conectado!	2015-11-11 19:23:52.36-03
1062	fechaServidor		No esta conectado!	2015-11-11 19:23:52.364-03
1063	fechaServidor		No esta conectado!	2015-11-11 19:23:52.367-03
1064	fechaServidor		No esta conectado!	2015-11-11 19:23:52.37-03
1065	fechaServidor		No esta conectado!	2015-11-11 19:23:52.374-03
1066	fechaServidor		No esta conectado!	2015-11-11 19:23:52.378-03
1067	fechaServidor		No esta conectado!	2015-11-11 19:23:52.38-03
1068	fechaServidor		No esta conectado!	2015-11-11 19:23:52.386-03
1069	fechaServidor		No esta conectado!	2015-11-11 19:23:52.391-03
1070	fechaServidor		No esta conectado!	2015-11-11 19:23:52.404-03
1071	fechaServidor		No esta conectado!	2015-11-11 19:23:52.412-03
1072	fechaServidor		No esta conectado!	2015-11-11 19:23:52.437-03
1073	fechaServidor		No esta conectado!	2015-11-11 19:23:52.448-03
1074	fechaServidor		No esta conectado!	2015-11-11 19:23:52.456-03
1075	fechaServidor		No esta conectado!	2015-11-11 19:23:52.467-03
1076	fechaServidor		No esta conectado!	2015-11-11 19:23:52.477-03
1077	fechaServidor		No esta conectado!	2015-11-11 19:23:52.479-03
1078	fechaServidor		No esta conectado!	2015-11-11 19:23:52.481-03
1079	fechaServidor		No esta conectado!	2015-11-11 19:23:52.483-03
1080	fechaServidor		No esta conectado!	2015-11-11 19:23:52.486-03
1081	fechaServidor		No esta conectado!	2015-11-11 19:23:52.488-03
1082	fechaServidor		No esta conectado!	2015-11-11 19:23:52.49-03
1083	fechaServidor		No esta conectado!	2015-11-11 19:23:52.492-03
1084	fechaServidor		No esta conectado!	2015-11-11 19:23:52.494-03
1085	fechaServidor		No esta conectado!	2015-11-11 19:23:52.496-03
1086	fechaServidor		No esta conectado!	2015-11-11 19:23:52.498-03
1087	fechaServidor		No esta conectado!	2015-11-11 19:23:52.5-03
1088	fechaServidor		No esta conectado!	2015-11-11 19:23:52.502-03
1089	fechaServidor		No esta conectado!	2015-11-11 19:23:52.505-03
1090	fechaServidor		No esta conectado!	2015-11-11 19:23:52.507-03
1091	fechaServidor		No esta conectado!	2015-11-11 19:23:52.51-03
1092	fechaServidor		No esta conectado!	2015-11-11 19:23:52.552-03
1093	fechaServidor		No esta conectado!	2015-11-11 19:23:52.554-03
1094	fechaServidor		No esta conectado!	2015-11-11 19:23:52.557-03
1095	fechaServidor		No esta conectado!	2015-11-11 19:23:52.56-03
1096	fechaServidor		No esta conectado!	2015-11-11 19:23:52.563-03
1097	fechaServidor		No esta conectado!	2015-11-11 19:23:52.565-03
1098	fechaServidor		No esta conectado!	2015-11-11 19:23:52.568-03
1099	fechaServidor		No esta conectado!	2015-11-11 19:23:52.57-03
1100	fechaServidor		No esta conectado!	2015-11-11 19:23:52.572-03
1101	fechaServidor		No esta conectado!	2015-11-11 19:23:52.573-03
1102	fechaServidor		No esta conectado!	2015-11-11 19:23:52.576-03
1103	fechaServidor		No esta conectado!	2015-11-11 19:23:52.578-03
1104	fechaServidor		No esta conectado!	2015-11-11 19:23:52.58-03
1105	fechaServidor		No esta conectado!	2015-11-11 19:23:52.583-03
1106	fechaServidor		No esta conectado!	2015-11-11 19:23:52.587-03
1107	fechaServidor		No esta conectado!	2015-11-11 19:23:52.589-03
1108	fechaServidor		No esta conectado!	2015-11-11 19:23:52.593-03
1109	fechaServidor		No esta conectado!	2015-11-11 19:23:52.597-03
1110	fechaServidor		No esta conectado!	2015-11-11 19:23:52.6-03
1111	fechaServidor		No esta conectado!	2015-11-11 19:23:52.603-03
1112	fechaServidor		No esta conectado!	2015-11-11 19:23:52.605-03
1113	fechaServidor		No esta conectado!	2015-11-11 19:23:52.608-03
1114	fechaServidor		No esta conectado!	2015-11-11 19:23:52.612-03
1115	fechaServidor		No esta conectado!	2015-11-11 19:23:52.615-03
1116	fechaServidor		No esta conectado!	2015-11-11 19:23:52.617-03
1117	fechaServidor		No esta conectado!	2015-11-11 19:23:52.621-03
1118	fechaServidor		No esta conectado!	2015-11-11 19:23:52.624-03
1119	fechaServidor		No esta conectado!	2015-11-11 19:23:52.628-03
1120	fechaServidor		No esta conectado!	2015-11-11 19:23:52.631-03
1121	fechaServidor		No esta conectado!	2015-11-11 19:23:52.634-03
1122	fechaServidor		No esta conectado!	2015-11-11 19:23:52.638-03
1123	fechaServidor		No esta conectado!	2015-11-11 19:23:52.644-03
1124	fechaServidor		No esta conectado!	2015-11-11 19:23:52.649-03
1125	fechaServidor		No esta conectado!	2015-11-11 19:23:52.65-03
1126	fechaServidor		No esta conectado!	2015-11-11 19:23:52.652-03
1127	fechaServidor		No esta conectado!	2015-11-11 19:23:52.654-03
1128	fechaServidor		No esta conectado!	2015-11-11 19:23:52.655-03
1129	fechaServidor		No esta conectado!	2015-11-11 19:23:52.656-03
1130	fechaServidor		No esta conectado!	2015-11-11 19:23:52.657-03
1131	fechaServidor		No esta conectado!	2015-11-11 19:23:52.659-03
1132	fechaServidor		No esta conectado!	2015-11-11 19:23:52.66-03
1133	fechaServidor		No esta conectado!	2015-11-11 19:23:52.661-03
1134	fechaServidor		No esta conectado!	2015-11-11 19:23:52.662-03
1135	fechaServidor		No esta conectado!	2015-11-11 19:23:52.664-03
1136	fechaServidor		No esta conectado!	2015-11-11 19:23:52.665-03
1137	fechaServidor		No esta conectado!	2015-11-11 19:23:52.666-03
1138	fechaServidor		No esta conectado!	2015-11-11 19:23:52.667-03
1139	fechaServidor		No esta conectado!	2015-11-11 19:23:52.67-03
1140	fechaServidor		No esta conectado!	2015-11-11 19:23:52.671-03
1141	fechaServidor		No esta conectado!	2015-11-11 19:23:52.672-03
1142	fechaServidor		No esta conectado!	2015-11-11 19:23:52.674-03
1143	fechaServidor		No esta conectado!	2015-11-11 19:23:52.675-03
1144	fechaServidor		No esta conectado!	2015-11-11 19:23:52.676-03
1145	fechaServidor		No esta conectado!	2015-11-11 19:23:52.677-03
1146	fechaServidor		No esta conectado!	2015-11-11 19:23:52.682-03
1147	fechaServidor		No esta conectado!	2015-11-11 19:23:52.691-03
1148	fechaServidor		No esta conectado!	2015-11-11 19:23:52.694-03
1149	fechaServidor		No esta conectado!	2015-11-11 19:23:52.697-03
1150	fechaServidor		No esta conectado!	2015-11-11 19:23:52.701-03
1151	fechaServidor		No esta conectado!	2015-11-11 19:23:52.704-03
1152	fechaServidor		No esta conectado!	2015-11-11 19:23:52.708-03
1153	fechaServidor		No esta conectado!	2015-11-11 19:23:52.71-03
1154	fechaServidor		No esta conectado!	2015-11-11 19:23:52.712-03
1155	fechaServidor		No esta conectado!	2015-11-11 19:23:52.714-03
1156	fechaServidor		No esta conectado!	2015-11-11 19:23:52.717-03
1157	fechaServidor		No esta conectado!	2015-11-11 19:23:52.721-03
1158	fechaServidor		No esta conectado!	2015-11-11 19:23:52.723-03
1159	fechaServidor		No esta conectado!	2015-11-11 19:23:52.726-03
1160	fechaServidor		No esta conectado!	2015-11-11 19:23:52.729-03
1161	fechaServidor		No esta conectado!	2015-11-11 19:23:52.732-03
1162	fechaServidor		No esta conectado!	2015-11-11 19:23:52.735-03
1163	fechaServidor		No esta conectado!	2015-11-11 19:23:52.737-03
1164	fechaServidor		No esta conectado!	2015-11-11 19:23:52.739-03
1165	fechaServidor		No esta conectado!	2015-11-11 19:23:52.742-03
1166	fechaServidor		No esta conectado!	2015-11-11 19:23:52.743-03
1167	fechaServidor		No esta conectado!	2015-11-11 19:23:52.745-03
1168	fechaServidor		No esta conectado!	2015-11-11 19:23:52.75-03
1169	fechaServidor		No esta conectado!	2015-11-11 19:23:52.751-03
1170	fechaServidor		No esta conectado!	2015-11-11 19:23:52.754-03
1171	fechaServidor		No esta conectado!	2015-11-11 19:23:52.76-03
1172	fechaServidor		No esta conectado!	2015-11-11 19:23:52.766-03
1173	fechaServidor		No esta conectado!	2015-11-11 19:23:52.768-03
1174	fechaServidor		No esta conectado!	2015-11-11 19:23:52.771-03
1175	fechaServidor		No esta conectado!	2015-11-11 19:23:52.775-03
1176	fechaServidor		No esta conectado!	2015-11-11 19:23:52.778-03
1177	fechaServidor		No esta conectado!	2015-11-11 19:23:52.78-03
1178	fechaServidor		No esta conectado!	2015-11-11 19:23:52.781-03
1179	fechaServidor		No esta conectado!	2015-11-11 19:23:52.784-03
1180	fechaServidor		No esta conectado!	2015-11-11 19:23:52.787-03
1181	fechaServidor		No esta conectado!	2015-11-11 19:23:52.79-03
1182	fechaServidor		No esta conectado!	2015-11-11 19:23:52.792-03
1183	fechaServidor		No esta conectado!	2015-11-11 19:23:52.795-03
1184	fechaServidor		No esta conectado!	2015-11-11 19:23:52.797-03
1185	fechaServidor		No esta conectado!	2015-11-11 19:23:52.804-03
1186	fechaServidor		No esta conectado!	2015-11-11 19:23:52.807-03
1187	fechaServidor		No esta conectado!	2015-11-11 19:23:52.81-03
1188	fechaServidor		No esta conectado!	2015-11-11 19:23:52.812-03
1189	fechaServidor		No esta conectado!	2015-11-11 19:23:52.815-03
1190	fechaServidor		No esta conectado!	2015-11-11 19:23:52.816-03
1191	fechaServidor		No esta conectado!	2015-11-11 19:23:52.821-03
1192	fechaServidor		No esta conectado!	2015-11-11 19:23:52.822-03
1193	fechaServidor		No esta conectado!	2015-11-11 19:23:52.824-03
1194	fechaServidor		No esta conectado!	2015-11-11 19:23:52.825-03
1195	fechaServidor		No esta conectado!	2015-11-11 19:23:52.826-03
1196	fechaServidor		No esta conectado!	2015-11-11 19:23:52.827-03
1197	fechaServidor		No esta conectado!	2015-11-11 19:23:52.828-03
1198	fechaServidor		No esta conectado!	2015-11-11 19:23:52.829-03
1199	fechaServidor		No esta conectado!	2015-11-11 19:23:52.831-03
1200	fechaServidor		No esta conectado!	2015-11-11 19:23:52.833-03
1201	fechaServidor		No esta conectado!	2015-11-11 19:23:52.836-03
1202	fechaServidor		No esta conectado!	2015-11-11 19:23:52.839-03
1203	fechaServidor		No esta conectado!	2015-11-11 19:23:52.842-03
1204	fechaServidor		No esta conectado!	2015-11-11 19:23:52.844-03
1205	fechaServidor		No esta conectado!	2015-11-11 19:23:52.853-03
1206	fechaServidor		No esta conectado!	2015-11-11 19:23:52.859-03
1207	fechaServidor		No esta conectado!	2015-11-11 19:23:52.863-03
1208	fechaServidor		No esta conectado!	2015-11-11 19:23:52.873-03
1209	fechaServidor		No esta conectado!	2015-11-11 19:23:52.886-03
1210	fechaServidor		No esta conectado!	2015-11-11 19:23:52.891-03
1211	fechaServidor		No esta conectado!	2015-11-11 19:23:52.895-03
1212	fechaServidor		No esta conectado!	2015-11-11 19:23:52.897-03
1213	fechaServidor		No esta conectado!	2015-11-11 19:23:52.898-03
1214	fechaServidor		No esta conectado!	2015-11-11 19:23:52.904-03
1215	fechaServidor		No esta conectado!	2015-11-11 19:23:52.909-03
1216	fechaServidor		No esta conectado!	2015-11-11 19:23:52.911-03
1217	fechaServidor		No esta conectado!	2015-11-11 19:23:52.916-03
1218	fechaServidor		No esta conectado!	2015-11-11 19:23:52.92-03
1219	fechaServidor		No esta conectado!	2015-11-11 19:23:52.924-03
1220	fechaServidor		No esta conectado!	2015-11-11 19:23:52.928-03
1221	fechaServidor		No esta conectado!	2015-11-11 19:23:52.932-03
1222	fechaServidor		No esta conectado!	2015-11-11 19:23:52.937-03
1223	fechaServidor		No esta conectado!	2015-11-11 19:23:52.941-03
1224	fechaServidor		No esta conectado!	2015-11-11 19:23:52.946-03
1225	fechaServidor		No esta conectado!	2015-11-11 19:23:52.948-03
1226	fechaServidor		No esta conectado!	2015-11-11 19:23:52.953-03
1227	fechaServidor		No esta conectado!	2015-11-11 19:23:52.959-03
1228	fechaServidor		No esta conectado!	2015-11-11 19:23:52.962-03
1229	fechaServidor		No esta conectado!	2015-11-11 19:23:52.966-03
1230	fechaServidor		No esta conectado!	2015-11-11 19:23:52.969-03
1231	fechaServidor		No esta conectado!	2015-11-11 19:23:52.976-03
1232	fechaServidor		No esta conectado!	2015-11-11 19:23:52.98-03
1233	fechaServidor		No esta conectado!	2015-11-11 19:23:52.992-03
1234	fechaServidor		No esta conectado!	2015-11-11 19:23:52.996-03
1235	fechaServidor		No esta conectado!	2015-11-11 19:23:52.999-03
1236	fechaServidor		No esta conectado!	2015-11-11 19:23:53.008-03
1237	fechaServidor		No esta conectado!	2015-11-11 19:23:53.01-03
1238	fechaServidor		No esta conectado!	2015-11-11 19:23:53.014-03
1239	fechaServidor		No esta conectado!	2015-11-11 19:23:53.017-03
1240	fechaServidor		No esta conectado!	2015-11-11 19:23:53.02-03
1241	fechaServidor		No esta conectado!	2015-11-11 19:23:53.026-03
1242	fechaServidor		No esta conectado!	2015-11-11 19:23:53.03-03
1243	fechaServidor		No esta conectado!	2015-11-11 19:23:53.04-03
1244	fechaServidor		No esta conectado!	2015-11-11 19:23:53.048-03
1245	fechaServidor		No esta conectado!	2015-11-11 19:23:53.053-03
1246	fechaServidor		No esta conectado!	2015-11-11 19:23:53.058-03
1247	fechaServidor		No esta conectado!	2015-11-11 19:23:53.063-03
1248	fechaServidor		No esta conectado!	2015-11-11 19:23:53.067-03
1249	fechaServidor		No esta conectado!	2015-11-11 19:23:53.074-03
1250	fechaServidor		No esta conectado!	2015-11-11 19:23:53.08-03
1251	fechaServidor		No esta conectado!	2015-11-11 19:23:53.085-03
1252	fechaServidor		No esta conectado!	2015-11-11 19:23:53.091-03
1253	fechaServidor		No esta conectado!	2015-11-11 19:23:53.096-03
1254	fechaServidor		No esta conectado!	2015-11-11 19:23:53.1-03
1255	fechaServidor		No esta conectado!	2015-11-11 19:23:53.112-03
1256	fechaServidor		No esta conectado!	2015-11-11 19:23:53.117-03
1257	fechaServidor		No esta conectado!	2015-11-11 19:23:53.12-03
1258	fechaServidor		No esta conectado!	2015-11-11 19:23:53.128-03
1259	fechaServidor		No esta conectado!	2015-11-11 19:23:53.136-03
1260	fechaServidor		No esta conectado!	2015-11-11 19:23:53.142-03
1261	fechaServidor		No esta conectado!	2015-11-11 19:23:53.145-03
1262	fechaServidor		No esta conectado!	2015-11-11 19:23:53.152-03
1263	fechaServidor		No esta conectado!	2015-11-11 19:23:53.154-03
1264	fechaServidor		No esta conectado!	2015-11-11 19:23:53.168-03
1265	fechaServidor		No esta conectado!	2015-11-11 19:23:53.176-03
1266	fechaServidor		No esta conectado!	2015-11-11 19:23:53.183-03
1267	fechaServidor		No esta conectado!	2015-11-11 19:23:53.191-03
1268	fechaServidor		No esta conectado!	2015-11-11 19:23:53.198-03
1269	fechaServidor		No esta conectado!	2015-11-11 19:23:53.204-03
1270	fechaServidor		No esta conectado!	2015-11-11 19:23:53.214-03
1271	fechaServidor		No esta conectado!	2015-11-11 19:23:53.221-03
1272	fechaServidor		No esta conectado!	2015-11-11 19:23:53.228-03
1273	fechaServidor		No esta conectado!	2015-11-11 19:23:53.234-03
1274	fechaServidor		No esta conectado!	2015-11-11 19:23:53.252-03
1275	fechaServidor		No esta conectado!	2015-11-11 19:23:53.261-03
1276	fechaServidor		No esta conectado!	2015-11-11 19:23:53.268-03
1277	fechaServidor		No esta conectado!	2015-11-11 19:23:53.275-03
1278	fechaServidor		No esta conectado!	2015-11-11 19:23:53.282-03
1279	fechaServidor		No esta conectado!	2015-11-11 19:23:53.285-03
1280	fechaServidor		No esta conectado!	2015-11-11 19:23:53.288-03
1281	fechaServidor		No esta conectado!	2015-11-11 19:23:53.291-03
1282	fechaServidor		No esta conectado!	2015-11-11 19:23:53.294-03
1283	fechaServidor		No esta conectado!	2015-11-11 19:23:53.297-03
1284	fechaServidor		No esta conectado!	2015-11-11 19:23:53.3-03
1285	fechaServidor		No esta conectado!	2015-11-11 19:23:53.302-03
1286	fechaServidor		No esta conectado!	2015-11-11 19:23:53.306-03
1287	fechaServidor		No esta conectado!	2015-11-11 19:23:53.309-03
1288	fechaServidor		No esta conectado!	2015-11-11 19:23:53.311-03
1289	fechaServidor		No esta conectado!	2015-11-11 19:23:53.314-03
1290	fechaServidor		No esta conectado!	2015-11-11 19:23:53.317-03
1291	fechaServidor		No esta conectado!	2015-11-11 19:23:53.319-03
1292	fechaServidor		No esta conectado!	2015-11-11 19:23:53.323-03
1293	fechaServidor		No esta conectado!	2015-11-11 19:23:53.326-03
1294	fechaServidor		No esta conectado!	2015-11-11 19:23:53.328-03
1295	fechaServidor		No esta conectado!	2015-11-11 19:23:53.331-03
1296	fechaServidor		No esta conectado!	2015-11-11 19:23:53.333-03
1297	fechaServidor		No esta conectado!	2015-11-11 19:23:53.336-03
1298	fechaServidor		No esta conectado!	2015-11-11 19:23:53.342-03
1299	fechaServidor		No esta conectado!	2015-11-11 19:23:53.344-03
1300	fechaServidor		No esta conectado!	2015-11-11 19:23:53.345-03
1301	fechaServidor		No esta conectado!	2015-11-11 19:23:53.347-03
1302	fechaServidor		No esta conectado!	2015-11-11 19:23:53.348-03
1303	fechaServidor		No esta conectado!	2015-11-11 19:23:53.358-03
1304	fechaServidor		No esta conectado!	2015-11-11 19:23:53.36-03
1305	fechaServidor		No esta conectado!	2015-11-11 19:23:53.362-03
1306	fechaServidor		No esta conectado!	2015-11-11 19:23:53.364-03
1307	fechaServidor		No esta conectado!	2015-11-11 19:23:53.366-03
1308	fechaServidor		No esta conectado!	2015-11-11 19:23:53.367-03
1309	fechaServidor		No esta conectado!	2015-11-11 19:23:53.369-03
1310	fechaServidor		No esta conectado!	2015-11-11 19:23:53.372-03
1311	fechaServidor		No esta conectado!	2015-11-11 19:23:53.375-03
1312	fechaServidor		No esta conectado!	2015-11-11 19:23:53.378-03
1313	fechaServidor		No esta conectado!	2015-11-11 19:23:53.38-03
1314	fechaServidor		No esta conectado!	2015-11-11 19:23:53.383-03
1315	fechaServidor		No esta conectado!	2015-11-11 19:23:53.385-03
1316	fechaServidor		No esta conectado!	2015-11-11 19:23:53.388-03
1317	fechaServidor		No esta conectado!	2015-11-11 19:23:53.391-03
1318	fechaServidor		No esta conectado!	2015-11-11 19:23:53.393-03
1319	fechaServidor		No esta conectado!	2015-11-11 19:23:53.4-03
1320	fechaServidor		No esta conectado!	2015-11-11 19:23:53.404-03
1321	fechaServidor		No esta conectado!	2015-11-11 19:23:53.407-03
1322	fechaServidor		No esta conectado!	2015-11-11 19:23:53.41-03
1323	fechaServidor		No esta conectado!	2015-11-11 19:23:53.412-03
1324	fechaServidor		No esta conectado!	2015-11-11 19:23:53.415-03
1325	fechaServidor		No esta conectado!	2015-11-11 19:23:53.418-03
1326	fechaServidor		No esta conectado!	2015-11-11 19:23:53.419-03
1327	fechaServidor		No esta conectado!	2015-11-11 19:23:53.424-03
1328	fechaServidor		No esta conectado!	2015-11-11 19:23:53.426-03
1329	fechaServidor		No esta conectado!	2015-11-11 19:23:53.429-03
1330	fechaServidor		No esta conectado!	2015-11-11 19:23:53.432-03
1331	fechaServidor		No esta conectado!	2015-11-11 19:23:53.434-03
1332	fechaServidor		No esta conectado!	2015-11-11 19:23:53.437-03
1333	fechaServidor		No esta conectado!	2015-11-11 19:23:53.44-03
1334	fechaServidor		No esta conectado!	2015-11-11 19:23:53.444-03
1335	fechaServidor		No esta conectado!	2015-11-11 19:23:53.446-03
1336	fechaServidor		No esta conectado!	2015-11-11 19:23:53.453-03
1337	fechaServidor		No esta conectado!	2015-11-11 19:23:53.457-03
1338	fechaServidor		No esta conectado!	2015-11-11 19:23:53.461-03
1339	fechaServidor		No esta conectado!	2015-11-11 19:23:53.463-03
1340	fechaServidor		No esta conectado!	2015-11-11 19:23:53.468-03
1341	fechaServidor		No esta conectado!	2015-11-11 19:23:53.47-03
1342	fechaServidor		No esta conectado!	2015-11-11 19:23:53.473-03
1343	fechaServidor		No esta conectado!	2015-11-11 19:23:53.476-03
1344	fechaServidor		No esta conectado!	2015-11-11 19:23:53.479-03
1345	fechaServidor		No esta conectado!	2015-11-11 19:23:53.481-03
1346	fechaServidor		No esta conectado!	2015-11-11 19:23:53.484-03
1347	fechaServidor		No esta conectado!	2015-11-11 19:23:53.487-03
1348	fechaServidor		No esta conectado!	2015-11-11 19:23:53.49-03
1349	fechaServidor		No esta conectado!	2015-11-11 19:23:53.498-03
1350	fechaServidor		No esta conectado!	2015-11-11 19:23:53.504-03
1351	fechaServidor		No esta conectado!	2015-11-11 19:23:53.511-03
1352	fechaServidor		No esta conectado!	2015-11-11 19:23:53.516-03
1353	fechaServidor		No esta conectado!	2015-11-11 19:23:53.526-03
1354	fechaServidor		No esta conectado!	2015-11-11 19:23:53.532-03
1355	fechaServidor		No esta conectado!	2015-11-11 19:23:53.535-03
1356	fechaServidor		No esta conectado!	2015-11-11 19:23:53.538-03
1357	fechaServidor		No esta conectado!	2015-11-11 19:23:53.541-03
1358	fechaServidor		No esta conectado!	2015-11-11 19:23:53.544-03
1359	fechaServidor		No esta conectado!	2015-11-11 19:23:53.545-03
1360	fechaServidor		No esta conectado!	2015-11-11 19:23:53.546-03
1361	fechaServidor		No esta conectado!	2015-11-11 19:23:53.547-03
1362	fechaServidor		No esta conectado!	2015-11-11 19:23:53.548-03
1363	fechaServidor		No esta conectado!	2015-11-11 19:23:53.55-03
1364	fechaServidor		No esta conectado!	2015-11-11 19:23:53.551-03
1365	fechaServidor		No esta conectado!	2015-11-11 19:23:53.552-03
1366	fechaServidor		No esta conectado!	2015-11-11 19:23:53.555-03
1367	fechaServidor		No esta conectado!	2015-11-11 19:23:53.557-03
1368	fechaServidor		No esta conectado!	2015-11-11 19:23:53.558-03
1369	fechaServidor		No esta conectado!	2015-11-11 19:23:53.559-03
1370	fechaServidor		No esta conectado!	2015-11-11 19:23:53.56-03
1371	fechaServidor		No esta conectado!	2015-11-11 19:23:53.562-03
1372	fechaServidor		No esta conectado!	2015-11-11 19:23:53.563-03
1373	fechaServidor		No esta conectado!	2015-11-11 19:23:53.564-03
1374	fechaServidor		No esta conectado!	2015-11-11 19:23:53.566-03
1375	fechaServidor		No esta conectado!	2015-11-11 19:23:53.569-03
1376	fechaServidor		No esta conectado!	2015-11-11 19:23:53.578-03
1377	fechaServidor		No esta conectado!	2015-11-11 19:23:53.583-03
1378	fechaServidor		No esta conectado!	2015-11-11 19:23:53.591-03
1379	fechaServidor		No esta conectado!	2015-11-11 19:23:53.593-03
1380	fechaServidor		No esta conectado!	2015-11-11 19:23:53.595-03
1381	fechaServidor		No esta conectado!	2015-11-11 19:23:53.596-03
1382	fechaServidor		No esta conectado!	2015-11-11 19:23:53.598-03
1383	fechaServidor		No esta conectado!	2015-11-11 19:23:53.599-03
1384	fechaServidor		No esta conectado!	2015-11-11 19:23:53.606-03
1385	fechaServidor		No esta conectado!	2015-11-11 19:23:53.608-03
1386	fechaServidor		No esta conectado!	2015-11-11 19:23:53.609-03
1387	fechaServidor		No esta conectado!	2015-11-11 19:23:53.614-03
1388	fechaServidor		No esta conectado!	2015-11-11 19:23:53.616-03
1389	fechaServidor		No esta conectado!	2015-11-11 19:23:53.618-03
1390	fechaServidor		No esta conectado!	2015-11-11 19:23:53.637-03
1391	fechaServidor		No esta conectado!	2015-11-11 19:23:53.644-03
1392	fechaServidor		No esta conectado!	2015-11-11 19:23:53.647-03
1393	fechaServidor		No esta conectado!	2015-11-11 19:23:53.652-03
1394	fechaServidor		No esta conectado!	2015-11-11 19:23:53.653-03
1395	fechaServidor		No esta conectado!	2015-11-11 19:23:53.656-03
1396	fechaServidor		No esta conectado!	2015-11-11 19:23:53.659-03
1397	fechaServidor		No esta conectado!	2015-11-11 19:23:53.662-03
1398	fechaServidor		No esta conectado!	2015-11-11 19:23:53.664-03
1399	fechaServidor		No esta conectado!	2015-11-11 19:23:53.668-03
1400	fechaServidor		No esta conectado!	2015-11-11 19:23:53.67-03
1401	fechaServidor		No esta conectado!	2015-11-11 19:23:53.673-03
1402	fechaServidor		No esta conectado!	2015-11-11 19:23:53.677-03
1403	fechaServidor		No esta conectado!	2015-11-11 19:23:53.68-03
1404	fechaServidor		No esta conectado!	2015-11-11 19:23:53.682-03
1405	fechaServidor		No esta conectado!	2015-11-11 19:23:53.685-03
1406	fechaServidor		No esta conectado!	2015-11-11 19:23:53.687-03
1407	fechaServidor		No esta conectado!	2015-11-11 19:23:53.688-03
1408	fechaServidor		No esta conectado!	2015-11-11 19:23:53.693-03
1409	fechaServidor		No esta conectado!	2015-11-11 19:23:53.694-03
1410	fechaServidor		No esta conectado!	2015-11-11 19:23:53.696-03
1411	fechaServidor		No esta conectado!	2015-11-11 19:23:53.698-03
1412	fechaServidor		No esta conectado!	2015-11-11 19:23:53.701-03
1413	fechaServidor		No esta conectado!	2015-11-11 19:23:53.707-03
1414	fechaServidor		No esta conectado!	2015-11-11 19:23:53.71-03
1415	fechaServidor		No esta conectado!	2015-11-11 19:23:53.713-03
1416	fechaServidor		No esta conectado!	2015-11-11 19:23:53.723-03
1417	fechaServidor		No esta conectado!	2015-11-11 19:23:53.731-03
1418	fechaServidor		No esta conectado!	2015-11-11 19:23:53.739-03
1419	fechaServidor		No esta conectado!	2015-11-11 19:23:53.743-03
1420	fechaServidor		No esta conectado!	2015-11-11 19:23:53.745-03
1421	fechaServidor		No esta conectado!	2015-11-11 19:23:53.749-03
1422	fechaServidor		No esta conectado!	2015-11-11 19:23:53.751-03
1423	fechaServidor		No esta conectado!	2015-11-11 19:23:53.754-03
1424	fechaServidor		No esta conectado!	2015-11-11 19:23:53.756-03
1425	fechaServidor		No esta conectado!	2015-11-11 19:23:53.759-03
1426	fechaServidor		No esta conectado!	2015-11-11 19:23:53.761-03
1427	fechaServidor		No esta conectado!	2015-11-11 19:23:53.764-03
1428	fechaServidor		No esta conectado!	2015-11-11 19:23:53.768-03
1429	fechaServidor		No esta conectado!	2015-11-11 19:23:53.779-03
1430	fechaServidor		No esta conectado!	2015-11-11 19:23:53.785-03
1431	fechaServidor		No esta conectado!	2015-11-11 19:23:53.793-03
1432	fechaServidor		No esta conectado!	2015-11-11 19:23:53.801-03
1433	fechaServidor		No esta conectado!	2015-11-11 19:23:53.822-03
1434	fechaServidor		No esta conectado!	2015-11-11 19:23:53.828-03
1435	fechaServidor		No esta conectado!	2015-11-11 19:23:53.835-03
1436	fechaServidor		No esta conectado!	2015-11-11 19:23:53.841-03
1437	fechaServidor		No esta conectado!	2015-11-11 19:23:53.846-03
1438	fechaServidor		No esta conectado!	2015-11-11 19:23:53.849-03
1439	fechaServidor		No esta conectado!	2015-11-11 19:23:53.855-03
1440	fechaServidor		No esta conectado!	2015-11-11 19:23:53.86-03
1441	fechaServidor		No esta conectado!	2015-11-11 19:23:53.866-03
1442	fechaServidor		No esta conectado!	2015-11-11 19:23:53.871-03
1443	fechaServidor		No esta conectado!	2015-11-11 19:23:53.877-03
1444	fechaServidor		No esta conectado!	2015-11-11 19:23:53.882-03
1445	fechaServidor		No esta conectado!	2015-11-11 19:23:53.885-03
1446	fechaServidor		No esta conectado!	2015-11-11 19:23:53.888-03
1447	fechaServidor		No esta conectado!	2015-11-11 19:23:53.891-03
1448	fechaServidor		No esta conectado!	2015-11-11 19:23:53.894-03
1449	fechaServidor		No esta conectado!	2015-11-11 19:23:53.897-03
1450	fechaServidor		No esta conectado!	2015-11-11 19:23:53.899-03
1451	fechaServidor		No esta conectado!	2015-11-11 19:23:53.902-03
1452	fechaServidor		No esta conectado!	2015-11-11 19:23:53.905-03
1453	fechaServidor		No esta conectado!	2015-11-11 19:23:53.91-03
1454	fechaServidor		No esta conectado!	2015-11-11 19:23:53.912-03
1455	fechaServidor		No esta conectado!	2015-11-11 19:23:53.915-03
1456	fechaServidor		No esta conectado!	2015-11-11 19:23:53.918-03
1457	fechaServidor		No esta conectado!	2015-11-11 19:23:53.921-03
1458	fechaServidor		No esta conectado!	2015-11-11 19:23:53.923-03
1459	fechaServidor		No esta conectado!	2015-11-11 19:23:53.926-03
1460	fechaServidor		No esta conectado!	2015-11-11 19:23:53.929-03
1461	fechaServidor		No esta conectado!	2015-11-11 19:23:53.932-03
1462	fechaServidor		No esta conectado!	2015-11-11 19:23:53.934-03
1463	fechaServidor		No esta conectado!	2015-11-11 19:23:53.941-03
1464	fechaServidor		No esta conectado!	2015-11-11 19:23:53.943-03
1465	fechaServidor		No esta conectado!	2015-11-11 19:23:53.96-03
1466	fechaServidor		No esta conectado!	2015-11-11 19:23:53.962-03
1467	fechaServidor		No esta conectado!	2015-11-11 19:23:53.965-03
1468	fechaServidor		No esta conectado!	2015-11-11 19:23:53.967-03
1469	fechaServidor		No esta conectado!	2015-11-11 19:23:53.97-03
1470	fechaServidor		No esta conectado!	2015-11-11 19:23:53.972-03
1471	fechaServidor		No esta conectado!	2015-11-11 19:23:53.976-03
1472	fechaServidor		No esta conectado!	2015-11-11 19:23:53.979-03
1473	fechaServidor		No esta conectado!	2015-11-11 19:23:53.982-03
1474	fechaServidor		No esta conectado!	2015-11-11 19:23:53.985-03
1475	fechaServidor		No esta conectado!	2015-11-11 19:23:53.987-03
1476	fechaServidor		No esta conectado!	2015-11-11 19:23:53.99-03
1477	fechaServidor		No esta conectado!	2015-11-11 19:23:53.993-03
1478	fechaServidor		No esta conectado!	2015-11-11 19:23:53.996-03
1479	fechaServidor		No esta conectado!	2015-11-11 19:23:53.999-03
1480	fechaServidor		No esta conectado!	2015-11-11 19:23:54.001-03
1481	fechaServidor		No esta conectado!	2015-11-11 19:23:54.002-03
1482	fechaServidor		No esta conectado!	2015-11-11 19:23:54.006-03
1483	fechaServidor		No esta conectado!	2015-11-11 19:23:54.009-03
1484	fechaServidor		No esta conectado!	2015-11-11 19:23:54.012-03
1485	fechaServidor		No esta conectado!	2015-11-11 19:23:54.015-03
1486	fechaServidor		No esta conectado!	2015-11-11 19:23:54.017-03
1487	fechaServidor		No esta conectado!	2015-11-11 19:23:54.02-03
1488	fechaServidor		No esta conectado!	2015-11-11 19:23:54.022-03
1489	fechaServidor		No esta conectado!	2015-11-11 19:23:54.032-03
1490	fechaServidor		No esta conectado!	2015-11-11 19:23:54.033-03
1491	fechaServidor		No esta conectado!	2015-11-11 19:23:54.039-03
1492	fechaServidor		No esta conectado!	2015-11-11 19:23:54.045-03
1493	fechaServidor		No esta conectado!	2015-11-11 19:23:54.05-03
1494	fechaServidor		No esta conectado!	2015-11-11 19:23:54.055-03
1495	fechaServidor		No esta conectado!	2015-11-11 19:23:54.06-03
1496	fechaServidor		No esta conectado!	2015-11-11 19:23:54.075-03
1497	fechaServidor		No esta conectado!	2015-11-11 19:23:54.079-03
1498	fechaServidor		No esta conectado!	2015-11-11 19:23:54.08-03
1499	fechaServidor		No esta conectado!	2015-11-11 19:23:54.085-03
1500	fechaServidor		No esta conectado!	2015-11-11 19:23:54.087-03
1501	fechaServidor		No esta conectado!	2015-11-11 19:23:54.089-03
1502	fechaServidor		No esta conectado!	2015-11-11 19:23:54.094-03
1503	fechaServidor		No esta conectado!	2015-11-11 19:23:54.096-03
1504	fechaServidor		No esta conectado!	2015-11-11 19:23:54.097-03
1505	fechaServidor		No esta conectado!	2015-11-11 19:23:54.098-03
1506	fechaServidor		No esta conectado!	2015-11-11 19:23:54.099-03
1507	fechaServidor		No esta conectado!	2015-11-11 19:23:54.101-03
1508	fechaServidor		No esta conectado!	2015-11-11 19:23:54.102-03
1509	fechaServidor		No esta conectado!	2015-11-11 19:23:54.103-03
1510	fechaServidor		No esta conectado!	2015-11-11 19:23:54.104-03
1511	fechaServidor		No esta conectado!	2015-11-11 19:23:54.106-03
1512	fechaServidor		No esta conectado!	2015-11-11 19:23:54.107-03
1513	fechaServidor		No esta conectado!	2015-11-11 19:23:54.108-03
1514	fechaServidor		No esta conectado!	2015-11-11 19:23:54.11-03
1515	fechaServidor		No esta conectado!	2015-11-11 19:23:54.113-03
1516	fechaServidor		No esta conectado!	2015-11-11 19:23:54.115-03
1517	fechaServidor		No esta conectado!	2015-11-11 19:23:54.116-03
1518	fechaServidor		No esta conectado!	2015-11-11 19:23:54.117-03
1519	fechaServidor		No esta conectado!	2015-11-11 19:23:54.118-03
1520	fechaServidor		No esta conectado!	2015-11-11 19:23:54.12-03
1521	fechaServidor		No esta conectado!	2015-11-11 19:23:54.121-03
1522	fechaServidor		No esta conectado!	2015-11-11 19:23:54.122-03
1523	fechaServidor		No esta conectado!	2015-11-11 19:23:54.123-03
1524	fechaServidor		No esta conectado!	2015-11-11 19:23:54.124-03
1525	fechaServidor		No esta conectado!	2015-11-11 19:23:54.125-03
1526	fechaServidor		No esta conectado!	2015-11-11 19:23:54.134-03
1527	fechaServidor		No esta conectado!	2015-11-11 19:23:54.136-03
1528	fechaServidor		No esta conectado!	2015-11-11 19:23:54.139-03
1529	fechaServidor		No esta conectado!	2015-11-11 19:23:54.142-03
1530	fechaServidor		No esta conectado!	2015-11-11 19:23:54.147-03
1531	fechaServidor		No esta conectado!	2015-11-11 19:23:54.148-03
1532	fechaServidor		No esta conectado!	2015-11-11 19:23:54.149-03
1533	fechaServidor		No esta conectado!	2015-11-11 19:23:54.153-03
1534	fechaServidor		No esta conectado!	2015-11-11 19:23:54.156-03
1535	fechaServidor		No esta conectado!	2015-11-11 19:23:54.158-03
1536	fechaServidor		No esta conectado!	2015-11-11 19:23:54.162-03
1537	fechaServidor		No esta conectado!	2015-11-11 19:23:54.164-03
1538	fechaServidor		No esta conectado!	2015-11-11 19:23:54.167-03
1539	fechaServidor		No esta conectado!	2015-11-11 19:23:54.171-03
1540	fechaServidor		No esta conectado!	2015-11-11 19:23:54.172-03
1541	fechaServidor		No esta conectado!	2015-11-11 19:23:54.175-03
1542	fechaServidor		No esta conectado!	2015-11-11 19:23:54.18-03
1543	fechaServidor		No esta conectado!	2015-11-11 19:23:54.183-03
1544	fechaServidor		No esta conectado!	2015-11-11 19:23:54.185-03
1545	fechaServidor		No esta conectado!	2015-11-11 19:23:54.188-03
1546	fechaServidor		No esta conectado!	2015-11-11 19:23:54.19-03
1547	fechaServidor		No esta conectado!	2015-11-11 19:23:54.194-03
1548	fechaServidor		No esta conectado!	2015-11-11 19:23:54.197-03
1549	fechaServidor		No esta conectado!	2015-11-11 19:23:54.204-03
1550	fechaServidor		No esta conectado!	2015-11-11 19:23:54.207-03
1551	fechaServidor		No esta conectado!	2015-11-11 19:23:54.21-03
1552	fechaServidor		No esta conectado!	2015-11-11 19:23:54.213-03
1553	fechaServidor		No esta conectado!	2015-11-11 19:23:54.215-03
1554	fechaServidor		No esta conectado!	2015-11-11 19:23:54.218-03
1555	fechaServidor		No esta conectado!	2015-11-11 19:23:54.22-03
1556	fechaServidor		No esta conectado!	2015-11-11 19:23:54.225-03
1557	fechaServidor		No esta conectado!	2015-11-11 19:23:54.228-03
1558	fechaServidor		No esta conectado!	2015-11-11 19:23:54.231-03
1559	fechaServidor		No esta conectado!	2015-11-11 19:23:54.234-03
1560	fechaServidor		No esta conectado!	2015-11-11 19:23:54.237-03
1561	fechaServidor		No esta conectado!	2015-11-11 19:23:54.239-03
1562	fechaServidor		No esta conectado!	2015-11-11 19:23:54.241-03
1563	fechaServidor		No esta conectado!	2015-11-11 19:23:54.246-03
1564	fechaServidor		No esta conectado!	2015-11-11 19:23:54.247-03
1565	fechaServidor		No esta conectado!	2015-11-11 19:23:54.25-03
1566	fechaServidor		No esta conectado!	2015-11-11 19:23:54.256-03
1567	fechaServidor		No esta conectado!	2015-11-11 19:23:54.263-03
1568	fechaServidor		No esta conectado!	2015-11-11 19:23:54.265-03
1569	fechaServidor		No esta conectado!	2015-11-11 19:23:54.267-03
1570	fechaServidor		No esta conectado!	2015-11-11 19:23:54.27-03
1571	fechaServidor		No esta conectado!	2015-11-11 19:23:54.272-03
1572	fechaServidor		No esta conectado!	2015-11-11 19:23:54.275-03
1573	fechaServidor		No esta conectado!	2015-11-11 19:23:54.279-03
1574	fechaServidor		No esta conectado!	2015-11-11 19:23:54.281-03
1575	fechaServidor		No esta conectado!	2015-11-11 19:23:54.284-03
1576	fechaServidor		No esta conectado!	2015-11-11 19:23:54.286-03
1577	fechaServidor		No esta conectado!	2015-11-11 19:23:54.289-03
1578	fechaServidor		No esta conectado!	2015-11-11 19:23:54.291-03
1579	fechaServidor		No esta conectado!	2015-11-11 19:23:54.296-03
1580	fechaServidor		No esta conectado!	2015-11-11 19:23:54.298-03
1581	fechaServidor		No esta conectado!	2015-11-11 19:23:54.301-03
1582	fechaServidor		No esta conectado!	2015-11-11 19:23:54.303-03
1583	fechaServidor		No esta conectado!	2015-11-11 19:23:54.306-03
1584	fechaServidor		No esta conectado!	2015-11-11 19:23:54.308-03
1585	fechaServidor		No esta conectado!	2015-11-11 19:23:54.312-03
1586	fechaServidor		No esta conectado!	2015-11-11 19:23:54.315-03
1587	fechaServidor		No esta conectado!	2015-11-11 19:23:54.317-03
1588	fechaServidor		No esta conectado!	2015-11-11 19:23:54.32-03
1589	fechaServidor		No esta conectado!	2015-11-11 19:23:54.323-03
1590	fechaServidor		No esta conectado!	2015-11-11 19:23:54.326-03
1591	fechaServidor		No esta conectado!	2015-11-11 19:23:54.33-03
1592	fechaServidor		No esta conectado!	2015-11-11 19:23:54.332-03
1593	fechaServidor		No esta conectado!	2015-11-11 19:23:54.334-03
1594	fechaServidor		No esta conectado!	2015-11-11 19:23:54.339-03
1595	fechaServidor		No esta conectado!	2015-11-11 19:23:54.343-03
1596	fechaServidor		No esta conectado!	2015-11-11 19:23:54.347-03
1597	fechaServidor		No esta conectado!	2015-11-11 19:23:54.349-03
1598	fechaServidor		No esta conectado!	2015-11-11 19:23:54.351-03
1599	fechaServidor		No esta conectado!	2015-11-11 19:23:54.354-03
1600	fechaServidor		No esta conectado!	2015-11-11 19:23:54.356-03
1601	fechaServidor		No esta conectado!	2015-11-11 19:23:54.361-03
1602	fechaServidor		No esta conectado!	2015-11-11 19:23:54.364-03
1603	fechaServidor		No esta conectado!	2015-11-11 19:23:54.365-03
1604	fechaServidor		No esta conectado!	2015-11-11 19:23:54.366-03
1605	fechaServidor		No esta conectado!	2015-11-11 19:23:54.368-03
1606	fechaServidor		No esta conectado!	2015-11-11 19:23:54.369-03
1607	fechaServidor		No esta conectado!	2015-11-11 19:23:54.37-03
1608	fechaServidor		No esta conectado!	2015-11-11 19:23:54.371-03
1609	fechaServidor		No esta conectado!	2015-11-11 19:23:54.372-03
1610	fechaServidor		No esta conectado!	2015-11-11 19:23:54.373-03
1611	fechaServidor		No esta conectado!	2015-11-11 19:23:54.387-03
1612	fechaServidor		No esta conectado!	2015-11-11 19:23:54.394-03
1613	fechaServidor		No esta conectado!	2015-11-11 19:23:54.397-03
1614	fechaServidor		No esta conectado!	2015-11-11 19:23:54.398-03
1615	fechaServidor		No esta conectado!	2015-11-11 19:23:54.404-03
1616	fechaServidor		No esta conectado!	2015-11-11 19:23:54.409-03
1617	fechaServidor		No esta conectado!	2015-11-11 19:23:54.415-03
1618	fechaServidor		No esta conectado!	2015-11-11 19:23:54.421-03
1619	fechaServidor		No esta conectado!	2015-11-11 19:23:54.429-03
1620	fechaServidor		No esta conectado!	2015-11-11 19:23:54.435-03
1621	fechaServidor		No esta conectado!	2015-11-11 19:23:54.445-03
1622	fechaServidor		No esta conectado!	2015-11-11 19:23:54.451-03
1623	fechaServidor		No esta conectado!	2015-11-11 19:23:54.456-03
1624	fechaServidor		No esta conectado!	2015-11-11 19:23:54.461-03
1625	fechaServidor		No esta conectado!	2015-11-11 19:23:54.466-03
1626	fechaServidor		No esta conectado!	2015-11-11 19:23:54.472-03
1627	fechaServidor		No esta conectado!	2015-11-11 19:23:54.479-03
1628	fechaServidor		No esta conectado!	2015-11-11 19:23:54.483-03
1629	fechaServidor		No esta conectado!	2015-11-11 19:23:54.488-03
1630	fechaServidor		No esta conectado!	2015-11-11 19:23:54.495-03
1631	fechaServidor		No esta conectado!	2015-11-11 19:23:54.5-03
1632	fechaServidor		No esta conectado!	2015-11-11 19:23:54.506-03
1633	fechaServidor		No esta conectado!	2015-11-11 19:23:54.513-03
1634	fechaServidor		No esta conectado!	2015-11-11 19:23:54.519-03
1635	fechaServidor		No esta conectado!	2015-11-11 19:23:54.525-03
1636	fechaServidor		No esta conectado!	2015-11-11 19:23:54.532-03
1637	fechaServidor		No esta conectado!	2015-11-11 19:23:54.538-03
1638	fechaServidor		No esta conectado!	2015-11-11 19:23:54.544-03
1639	fechaServidor		No esta conectado!	2015-11-11 19:23:54.55-03
1640	fechaServidor		No esta conectado!	2015-11-11 19:23:54.555-03
1641	fechaServidor		No esta conectado!	2015-11-11 19:23:54.561-03
1642	fechaServidor		No esta conectado!	2015-11-11 19:23:54.566-03
1643	fechaServidor		No esta conectado!	2015-11-11 19:23:54.572-03
1644	fechaServidor		No esta conectado!	2015-11-11 19:23:54.577-03
1645	fechaServidor		No esta conectado!	2015-11-11 19:23:54.582-03
1646	fechaServidor		No esta conectado!	2015-11-11 19:23:54.584-03
1647	fechaServidor		No esta conectado!	2015-11-11 19:23:54.593-03
1648	fechaServidor		No esta conectado!	2015-11-11 19:23:54.596-03
1649	fechaServidor		No esta conectado!	2015-11-11 19:23:54.598-03
1650	fechaServidor		No esta conectado!	2015-11-11 19:23:54.6-03
1651	fechaServidor		No esta conectado!	2015-11-11 19:23:54.602-03
1652	fechaServidor		No esta conectado!	2015-11-11 19:23:54.604-03
1653	fechaServidor		No esta conectado!	2015-11-11 19:23:54.607-03
1654	fechaServidor		No esta conectado!	2015-11-11 19:23:54.609-03
1655	fechaServidor		No esta conectado!	2015-11-11 19:23:54.612-03
1656	fechaServidor		No esta conectado!	2015-11-11 19:23:54.615-03
1657	fechaServidor		No esta conectado!	2015-11-11 19:23:54.617-03
1658	fechaServidor		No esta conectado!	2015-11-11 19:23:54.63-03
1659	fechaServidor		No esta conectado!	2015-11-11 19:23:54.636-03
1660	fechaServidor		No esta conectado!	2015-11-11 19:23:54.644-03
1661	fechaServidor		No esta conectado!	2015-11-11 19:23:54.755-03
1662	fechaServidor		No esta conectado!	2015-11-11 19:23:54.76-03
1663	fechaServidor		No esta conectado!	2015-11-11 19:23:54.768-03
1664	fechaServidor		No esta conectado!	2015-11-11 19:23:54.77-03
1665	fechaServidor		No esta conectado!	2015-11-11 19:23:54.776-03
1666	fechaServidor		No esta conectado!	2015-11-11 19:23:54.785-03
1667	fechaServidor		No esta conectado!	2015-11-11 19:23:54.789-03
1668	fechaServidor		No esta conectado!	2015-11-11 19:23:54.793-03
1669	fechaServidor		No esta conectado!	2015-11-11 19:23:54.797-03
1670	fechaServidor		No esta conectado!	2015-11-11 19:23:54.805-03
1671	fechaServidor		No esta conectado!	2015-11-11 19:23:54.809-03
1672	fechaServidor		No esta conectado!	2015-11-11 19:23:54.812-03
1673	fechaServidor		No esta conectado!	2015-11-11 19:23:54.815-03
1674	fechaServidor		No esta conectado!	2015-11-11 19:23:54.817-03
1675	fechaServidor		No esta conectado!	2015-11-11 19:23:54.822-03
1676	fechaServidor		No esta conectado!	2015-11-11 19:23:54.824-03
1677	fechaServidor		No esta conectado!	2015-11-11 19:23:54.833-03
1678	fechaServidor		No esta conectado!	2015-11-11 19:23:54.839-03
1679	fechaServidor		No esta conectado!	2015-11-11 19:23:54.841-03
1680	fechaServidor		No esta conectado!	2015-11-11 19:23:54.843-03
1681	fechaServidor		No esta conectado!	2015-11-11 19:23:54.846-03
1682	fechaServidor		No esta conectado!	2015-11-11 19:23:54.849-03
1683	fechaServidor		No esta conectado!	2015-11-11 19:23:54.852-03
1684	fechaServidor		No esta conectado!	2015-11-11 19:23:54.855-03
1685	fechaServidor		No esta conectado!	2015-11-11 19:23:54.857-03
1686	fechaServidor		No esta conectado!	2015-11-11 19:23:54.859-03
1687	fechaServidor		No esta conectado!	2015-11-11 19:23:54.862-03
1688	fechaServidor		No esta conectado!	2015-11-11 19:23:54.865-03
1689	fechaServidor		No esta conectado!	2015-11-11 19:23:54.868-03
1690	fechaServidor		No esta conectado!	2015-11-11 19:23:54.87-03
1691	fechaServidor		No esta conectado!	2015-11-11 19:23:54.873-03
1692	fechaServidor		No esta conectado!	2015-11-11 19:23:54.876-03
1693	fechaServidor		No esta conectado!	2015-11-11 19:23:54.878-03
1694	fechaServidor		No esta conectado!	2015-11-11 19:23:54.882-03
1695	fechaServidor		No esta conectado!	2015-11-11 19:23:54.885-03
1696	fechaServidor		No esta conectado!	2015-11-11 19:23:54.887-03
1697	fechaServidor		No esta conectado!	2015-11-11 19:23:54.888-03
1698	fechaServidor		No esta conectado!	2015-11-11 19:23:54.889-03
1699	fechaServidor		No esta conectado!	2015-11-11 19:23:54.891-03
1700	fechaServidor		No esta conectado!	2015-11-11 19:23:54.892-03
1701	fechaServidor		No esta conectado!	2015-11-11 19:23:54.893-03
1702	fechaServidor		No esta conectado!	2015-11-11 19:23:54.894-03
1703	fechaServidor		No esta conectado!	2015-11-11 19:23:54.895-03
1704	fechaServidor		No esta conectado!	2015-11-11 19:23:54.896-03
1705	fechaServidor		No esta conectado!	2015-11-11 19:23:54.898-03
1706	fechaServidor		No esta conectado!	2015-11-11 19:23:54.9-03
1707	fechaServidor		No esta conectado!	2015-11-11 19:23:54.901-03
1708	fechaServidor		No esta conectado!	2015-11-11 19:23:54.902-03
1709	fechaServidor		No esta conectado!	2015-11-11 19:23:54.903-03
1710	fechaServidor		No esta conectado!	2015-11-11 19:23:54.905-03
1711	fechaServidor		No esta conectado!	2015-11-11 19:23:54.906-03
1712	fechaServidor		No esta conectado!	2015-11-11 19:23:54.907-03
1713	fechaServidor		No esta conectado!	2015-11-11 19:23:54.908-03
1714	fechaServidor		No esta conectado!	2015-11-11 19:23:54.91-03
1715	fechaServidor		No esta conectado!	2015-11-11 19:23:54.911-03
1716	fechaServidor		No esta conectado!	2015-11-11 19:23:54.912-03
1717	fechaServidor		No esta conectado!	2015-11-11 19:23:54.913-03
1718	fechaServidor		No esta conectado!	2015-11-11 19:23:54.915-03
1719	fechaServidor		No esta conectado!	2015-11-11 19:23:54.917-03
1720	fechaServidor		No esta conectado!	2015-11-11 19:23:54.918-03
1721	fechaServidor		No esta conectado!	2015-11-11 19:23:54.922-03
1722	fechaServidor		No esta conectado!	2015-11-11 19:23:54.925-03
1723	fechaServidor		No esta conectado!	2015-11-11 19:23:54.927-03
1724	fechaServidor		No esta conectado!	2015-11-11 19:23:54.93-03
1725	fechaServidor		No esta conectado!	2015-11-11 19:23:54.933-03
1726	fechaServidor		No esta conectado!	2015-11-11 19:23:54.935-03
1727	fechaServidor		No esta conectado!	2015-11-11 19:23:54.938-03
1728	fechaServidor		No esta conectado!	2015-11-11 19:23:54.941-03
1729	fechaServidor		No esta conectado!	2015-11-11 19:23:54.943-03
1730	fechaServidor		No esta conectado!	2015-11-11 19:23:54.946-03
1731	fechaServidor		No esta conectado!	2015-11-11 19:23:54.949-03
1732	fechaServidor		No esta conectado!	2015-11-11 19:23:54.952-03
1733	fechaServidor		No esta conectado!	2015-11-11 19:23:54.955-03
1734	fechaServidor		No esta conectado!	2015-11-11 19:23:54.957-03
1735	fechaServidor		No esta conectado!	2015-11-11 19:23:54.96-03
1736	fechaServidor		No esta conectado!	2015-11-11 19:23:54.962-03
1737	fechaServidor		No esta conectado!	2015-11-11 19:23:54.965-03
1738	fechaServidor		No esta conectado!	2015-11-11 19:23:54.968-03
1739	fechaServidor		No esta conectado!	2015-11-11 19:23:54.97-03
1740	fechaServidor		No esta conectado!	2015-11-11 19:23:54.973-03
1741	fechaServidor		No esta conectado!	2015-11-11 19:23:54.976-03
1742	fechaServidor		No esta conectado!	2015-11-11 19:23:54.978-03
1743	fechaServidor		No esta conectado!	2015-11-11 19:23:54.982-03
1744	fechaServidor		No esta conectado!	2015-11-11 19:23:54.984-03
1745	fechaServidor		No esta conectado!	2015-11-11 19:23:54.987-03
1746	fechaServidor		No esta conectado!	2015-11-11 19:23:54.99-03
1747	fechaServidor		No esta conectado!	2015-11-11 19:23:54.992-03
1748	fechaServidor		No esta conectado!	2015-11-11 19:23:54.994-03
1749	fechaServidor		No esta conectado!	2015-11-11 19:23:54.997-03
1750	fechaServidor		No esta conectado!	2015-11-11 19:23:55-03
1751	fechaServidor		No esta conectado!	2015-11-11 19:23:55.005-03
1752	fechaServidor		No esta conectado!	2015-11-11 19:23:55.01-03
1753	fechaServidor		No esta conectado!	2015-11-11 19:23:55.015-03
1754	fechaServidor		No esta conectado!	2015-11-11 19:23:55.019-03
1755	fechaServidor		No esta conectado!	2015-11-11 19:23:55.024-03
1756	fechaServidor		No esta conectado!	2015-11-11 19:23:55.029-03
1757	fechaServidor		No esta conectado!	2015-11-11 19:23:55.035-03
1758	fechaServidor		No esta conectado!	2015-11-11 19:23:55.037-03
1759	fechaServidor		No esta conectado!	2015-11-11 19:23:55.038-03
1760	fechaServidor		No esta conectado!	2015-11-11 19:23:55.039-03
1761	fechaServidor		No esta conectado!	2015-11-11 19:23:55.041-03
1762	fechaServidor		No esta conectado!	2015-11-11 19:23:55.042-03
1763	fechaServidor		No esta conectado!	2015-11-11 19:23:55.045-03
1764	fechaServidor		No esta conectado!	2015-11-11 19:23:55.047-03
1765	fechaServidor		No esta conectado!	2015-11-11 19:23:55.048-03
1766	fechaServidor		No esta conectado!	2015-11-11 19:23:55.051-03
1767	fechaServidor		No esta conectado!	2015-11-11 19:23:55.053-03
1768	fechaServidor		No esta conectado!	2015-11-11 19:23:55.055-03
1769	fechaServidor		No esta conectado!	2015-11-11 19:23:55.057-03
1770	fechaServidor		No esta conectado!	2015-11-11 19:23:55.06-03
1771	fechaServidor		No esta conectado!	2015-11-11 19:23:55.062-03
1772	fechaServidor		No esta conectado!	2015-11-11 19:23:55.066-03
1773	fechaServidor		No esta conectado!	2015-11-11 19:23:55.068-03
1774	fechaServidor		No esta conectado!	2015-11-11 19:23:55.07-03
1775	fechaServidor		No esta conectado!	2015-11-11 19:23:55.073-03
1776	fechaServidor		No esta conectado!	2015-11-11 19:23:55.076-03
1777	fechaServidor		No esta conectado!	2015-11-11 19:23:55.078-03
1778	fechaServidor		No esta conectado!	2015-11-11 19:23:55.08-03
1779	fechaServidor		No esta conectado!	2015-11-11 19:23:55.085-03
1780	fechaServidor		No esta conectado!	2015-11-11 19:23:55.089-03
1781	fechaServidor		No esta conectado!	2015-11-11 19:23:55.092-03
1782	fechaServidor		No esta conectado!	2015-11-11 19:23:55.094-03
1783	fechaServidor		No esta conectado!	2015-11-11 19:23:55.096-03
1784	fechaServidor		No esta conectado!	2015-11-11 19:23:55.099-03
1785	fechaServidor		No esta conectado!	2015-11-11 19:23:55.102-03
1786	fechaServidor		No esta conectado!	2015-11-11 19:23:55.105-03
1787	fechaServidor		No esta conectado!	2015-11-11 19:23:55.109-03
1788	fechaServidor		No esta conectado!	2015-11-11 19:23:55.114-03
1789	fechaServidor		No esta conectado!	2015-11-11 19:23:55.118-03
1790	fechaServidor		No esta conectado!	2015-11-11 19:23:55.125-03
1791	fechaServidor		No esta conectado!	2015-11-11 19:23:55.128-03
1792	fechaServidor		No esta conectado!	2015-11-11 19:23:55.132-03
1793	fechaServidor		No esta conectado!	2015-11-11 19:23:55.135-03
1794	fechaServidor		No esta conectado!	2015-11-11 19:23:55.138-03
1795	fechaServidor		No esta conectado!	2015-11-11 19:23:55.141-03
1796	fechaServidor		No esta conectado!	2015-11-11 19:23:55.146-03
1797	fechaServidor		No esta conectado!	2015-11-11 19:23:55.15-03
1798	fechaServidor		No esta conectado!	2015-11-11 19:23:55.154-03
1799	fechaServidor		No esta conectado!	2015-11-11 19:23:55.156-03
1800	fechaServidor		No esta conectado!	2015-11-11 19:23:55.16-03
1801	fechaServidor		No esta conectado!	2015-11-11 19:23:55.163-03
1802	fechaServidor		No esta conectado!	2015-11-11 19:23:55.167-03
1803	fechaServidor		No esta conectado!	2015-11-11 19:23:55.17-03
1804	fechaServidor		No esta conectado!	2015-11-11 19:23:55.173-03
1805	fechaServidor		No esta conectado!	2015-11-11 19:23:55.176-03
1806	fechaServidor		No esta conectado!	2015-11-11 19:23:55.177-03
1807	fechaServidor		No esta conectado!	2015-11-11 19:23:55.18-03
1808	fechaServidor		No esta conectado!	2015-11-11 19:23:55.181-03
1809	fechaServidor		No esta conectado!	2015-11-11 19:23:55.184-03
1810	fechaServidor		No esta conectado!	2015-11-11 19:23:55.184-03
1811	fechaServidor		No esta conectado!	2015-11-11 19:23:55.187-03
1812	fechaServidor		No esta conectado!	2015-11-11 19:23:55.191-03
1813	fechaServidor		No esta conectado!	2015-11-11 19:23:55.194-03
1814	fechaServidor		No esta conectado!	2015-11-11 19:23:55.197-03
1815	fechaServidor		No esta conectado!	2015-11-11 19:23:55.201-03
1816	fechaServidor		No esta conectado!	2015-11-11 19:23:55.205-03
1817	fechaServidor		No esta conectado!	2015-11-11 19:23:55.207-03
1818	fechaServidor		No esta conectado!	2015-11-11 19:23:55.211-03
1819	fechaServidor		No esta conectado!	2015-11-11 19:23:55.215-03
1820	fechaServidor		No esta conectado!	2015-11-11 19:23:55.219-03
1821	fechaServidor		No esta conectado!	2015-11-11 19:23:55.222-03
1822	fechaServidor		No esta conectado!	2015-11-11 19:23:55.225-03
1823	fechaServidor		No esta conectado!	2015-11-11 19:23:55.229-03
1824	fechaServidor		No esta conectado!	2015-11-11 19:23:55.231-03
1825	fechaServidor		No esta conectado!	2015-11-11 19:23:55.236-03
1826	fechaServidor		No esta conectado!	2015-11-11 19:23:55.24-03
1827	fechaServidor		No esta conectado!	2015-11-11 19:23:55.242-03
1828	fechaServidor		No esta conectado!	2015-11-11 19:23:55.249-03
1829	fechaServidor		No esta conectado!	2015-11-11 19:23:55.253-03
1830	fechaServidor		No esta conectado!	2015-11-11 19:23:55.258-03
1831	fechaServidor		No esta conectado!	2015-11-11 19:23:55.268-03
1832	fechaServidor		No esta conectado!	2015-11-11 19:23:55.27-03
1833	fechaServidor		No esta conectado!	2015-11-11 19:23:55.273-03
1834	fechaServidor		No esta conectado!	2015-11-11 19:23:55.275-03
1835	fechaServidor		No esta conectado!	2015-11-11 19:23:55.278-03
1836	fechaServidor		No esta conectado!	2015-11-11 19:23:55.283-03
1837	fechaServidor		No esta conectado!	2015-11-11 19:23:55.284-03
1838	fechaServidor		No esta conectado!	2015-11-11 19:23:55.287-03
1839	fechaServidor		No esta conectado!	2015-11-11 19:23:55.289-03
1840	fechaServidor		No esta conectado!	2015-11-11 19:23:55.292-03
1841	fechaServidor		No esta conectado!	2015-11-11 19:23:55.294-03
1842	fechaServidor		No esta conectado!	2015-11-11 19:23:55.297-03
1843	fechaServidor		No esta conectado!	2015-11-11 19:23:55.301-03
1844	fechaServidor		No esta conectado!	2015-11-11 19:23:55.304-03
1845	fechaServidor		No esta conectado!	2015-11-11 19:23:55.306-03
1846	fechaServidor		No esta conectado!	2015-11-11 19:23:55.309-03
1847	fechaServidor		No esta conectado!	2015-11-11 19:23:55.311-03
1848	fechaServidor		No esta conectado!	2015-11-11 19:23:55.314-03
1849	fechaServidor		No esta conectado!	2015-11-11 19:23:55.317-03
1850	fechaServidor		No esta conectado!	2015-11-11 19:23:55.32-03
1851	fechaServidor		No esta conectado!	2015-11-11 19:23:55.322-03
1852	fechaServidor		No esta conectado!	2015-11-11 19:23:55.323-03
1853	fechaServidor		No esta conectado!	2015-11-11 19:23:55.324-03
1854	fechaServidor		No esta conectado!	2015-11-11 19:23:55.326-03
1855	fechaServidor		No esta conectado!	2015-11-11 19:23:55.327-03
1856	fechaServidor		No esta conectado!	2015-11-11 19:23:55.328-03
1857	fechaServidor		No esta conectado!	2015-11-11 19:23:55.329-03
1858	fechaServidor		No esta conectado!	2015-11-11 19:23:55.33-03
1859	fechaServidor		No esta conectado!	2015-11-11 19:23:55.331-03
1860	fechaServidor		No esta conectado!	2015-11-11 19:23:55.333-03
1861	fechaServidor		No esta conectado!	2015-11-11 19:23:55.335-03
1862	fechaServidor		No esta conectado!	2015-11-11 19:23:55.336-03
1863	fechaServidor		No esta conectado!	2015-11-11 19:23:55.337-03
1864	fechaServidor		No esta conectado!	2015-11-11 19:23:55.337-03
1865	fechaServidor		No esta conectado!	2015-11-11 19:23:55.338-03
1866	fechaServidor		No esta conectado!	2015-11-11 19:23:55.34-03
1867	fechaServidor		No esta conectado!	2015-11-11 19:23:55.341-03
1868	fechaServidor		No esta conectado!	2015-11-11 19:23:55.343-03
1869	fechaServidor		No esta conectado!	2015-11-11 19:23:55.347-03
1870	fechaServidor		No esta conectado!	2015-11-11 19:23:55.353-03
1871	fechaServidor		No esta conectado!	2015-11-11 19:23:55.354-03
1872	fechaServidor		No esta conectado!	2015-11-11 19:23:55.362-03
1873	fechaServidor		No esta conectado!	2015-11-11 19:23:55.369-03
1874	fechaServidor		No esta conectado!	2015-11-11 19:23:55.371-03
1875	fechaServidor		No esta conectado!	2015-11-11 19:23:55.376-03
1876	fechaServidor		No esta conectado!	2015-11-11 19:23:55.377-03
1877	fechaServidor		No esta conectado!	2015-11-11 19:23:55.382-03
1878	fechaServidor		No esta conectado!	2015-11-11 19:23:55.386-03
1879	fechaServidor		No esta conectado!	2015-11-11 19:23:55.389-03
1880	fechaServidor		No esta conectado!	2015-11-11 19:23:55.392-03
1881	fechaServidor		No esta conectado!	2015-11-11 19:23:55.396-03
1882	fechaServidor		No esta conectado!	2015-11-11 19:23:55.398-03
1883	fechaServidor		No esta conectado!	2015-11-11 19:23:55.403-03
1884	fechaServidor		No esta conectado!	2015-11-11 19:23:55.411-03
1885	fechaServidor		No esta conectado!	2015-11-11 19:23:55.413-03
1886	fechaServidor		No esta conectado!	2015-11-11 19:23:55.416-03
1887	fechaServidor		No esta conectado!	2015-11-11 19:23:55.426-03
1888	fechaServidor		No esta conectado!	2015-11-11 19:23:55.432-03
1889	fechaServidor		No esta conectado!	2015-11-11 19:23:55.438-03
1890	fechaServidor		No esta conectado!	2015-11-11 19:23:55.444-03
1891	fechaServidor		No esta conectado!	2015-11-11 19:23:55.45-03
1892	fechaServidor		No esta conectado!	2015-11-11 19:23:55.455-03
1893	fechaServidor		No esta conectado!	2015-11-11 19:23:55.459-03
1894	fechaServidor		No esta conectado!	2015-11-11 19:23:55.462-03
1895	fechaServidor		No esta conectado!	2015-11-11 19:23:55.463-03
1896	fechaServidor		No esta conectado!	2015-11-11 19:23:55.469-03
1897	fechaServidor		No esta conectado!	2015-11-11 19:23:55.471-03
1898	fechaServidor		No esta conectado!	2015-11-11 19:23:55.475-03
1899	fechaServidor		No esta conectado!	2015-11-11 19:23:55.477-03
1900	fechaServidor		No esta conectado!	2015-11-11 19:23:55.479-03
1901	fechaServidor		No esta conectado!	2015-11-11 19:23:55.483-03
1902	fechaServidor		No esta conectado!	2015-11-11 19:23:55.485-03
1903	fechaServidor		No esta conectado!	2015-11-11 19:23:55.488-03
1904	fechaServidor		No esta conectado!	2015-11-11 19:23:55.49-03
1905	fechaServidor		No esta conectado!	2015-11-11 19:23:55.492-03
1906	fechaServidor		No esta conectado!	2015-11-11 19:23:55.493-03
1907	fechaServidor		No esta conectado!	2015-11-11 19:23:55.495-03
1908	fechaServidor		No esta conectado!	2015-11-11 19:23:55.497-03
1909	fechaServidor		No esta conectado!	2015-11-11 19:23:55.5-03
1910	fechaServidor		No esta conectado!	2015-11-11 19:23:55.507-03
1911	fechaServidor		No esta conectado!	2015-11-11 19:23:55.511-03
1912	fechaServidor		No esta conectado!	2015-11-11 19:23:55.516-03
1913	fechaServidor		No esta conectado!	2015-11-11 19:23:55.521-03
1914	fechaServidor		No esta conectado!	2015-11-11 19:23:55.524-03
1915	fechaServidor		No esta conectado!	2015-11-11 19:23:55.528-03
1916	fechaServidor		No esta conectado!	2015-11-11 19:23:55.53-03
1917	fechaServidor		No esta conectado!	2015-11-11 19:23:55.532-03
1918	fechaServidor		No esta conectado!	2015-11-11 19:23:55.534-03
1919	fechaServidor		No esta conectado!	2015-11-11 19:23:55.536-03
1920	fechaServidor		No esta conectado!	2015-11-11 19:23:55.538-03
1921	fechaServidor		No esta conectado!	2015-11-11 19:23:55.54-03
1922	fechaServidor		No esta conectado!	2015-11-11 19:23:55.542-03
1923	fechaServidor		No esta conectado!	2015-11-11 19:23:55.545-03
1924	fechaServidor		No esta conectado!	2015-11-11 19:23:55.547-03
1925	fechaServidor		No esta conectado!	2015-11-11 19:23:55.55-03
1926	fechaServidor		No esta conectado!	2015-11-11 19:23:55.553-03
1927	fechaServidor		No esta conectado!	2015-11-11 19:23:55.555-03
1928	fechaServidor		No esta conectado!	2015-11-11 19:23:55.558-03
1929	fechaServidor		No esta conectado!	2015-11-11 19:23:55.56-03
1930	fechaServidor		No esta conectado!	2015-11-11 19:23:55.562-03
1931	fechaServidor		No esta conectado!	2015-11-11 19:23:55.565-03
1932	fechaServidor		No esta conectado!	2015-11-11 19:23:55.568-03
1933	fechaServidor		No esta conectado!	2015-11-11 19:23:55.571-03
1934	fechaServidor		No esta conectado!	2015-11-11 19:23:55.573-03
1935	fechaServidor		No esta conectado!	2015-11-11 19:23:55.575-03
1936	fechaServidor		No esta conectado!	2015-11-11 19:23:55.578-03
1937	fechaServidor		No esta conectado!	2015-11-11 19:23:55.58-03
1938	fechaServidor		No esta conectado!	2015-11-11 19:23:55.582-03
1939	fechaServidor		No esta conectado!	2015-11-11 19:23:55.586-03
1940	fechaServidor		No esta conectado!	2015-11-11 19:23:55.589-03
1941	fechaServidor		No esta conectado!	2015-11-11 19:23:55.591-03
1942	fechaServidor		No esta conectado!	2015-11-11 19:23:55.597-03
1943	fechaServidor		No esta conectado!	2015-11-11 19:23:55.602-03
1944	fechaServidor		No esta conectado!	2015-11-11 19:23:55.606-03
1945	fechaServidor		No esta conectado!	2015-11-11 19:23:55.609-03
1946	fechaServidor		No esta conectado!	2015-11-11 19:23:55.613-03
1947	fechaServidor		No esta conectado!	2015-11-11 19:23:55.614-03
1948	fechaServidor		No esta conectado!	2015-11-11 19:23:55.618-03
1949	fechaServidor		No esta conectado!	2015-11-11 19:23:55.62-03
1950	fechaServidor		No esta conectado!	2015-11-11 19:23:55.623-03
1951	fechaServidor		No esta conectado!	2015-11-11 19:23:55.625-03
1952	fechaServidor		No esta conectado!	2015-11-11 19:23:55.627-03
1953	fechaServidor		No esta conectado!	2015-11-11 19:23:55.628-03
1954	fechaServidor		No esta conectado!	2015-11-11 19:23:55.629-03
1955	fechaServidor		No esta conectado!	2015-11-11 19:23:55.631-03
1956	fechaServidor		No esta conectado!	2015-11-11 19:23:55.632-03
1957	fechaServidor		No esta conectado!	2015-11-11 19:23:55.633-03
1958	fechaServidor		No esta conectado!	2015-11-11 19:23:55.635-03
1959	fechaServidor		No esta conectado!	2015-11-11 19:23:55.636-03
1960	fechaServidor		No esta conectado!	2015-11-11 19:23:55.637-03
1961	fechaServidor		No esta conectado!	2015-11-11 19:23:55.638-03
1962	fechaServidor		No esta conectado!	2015-11-11 19:23:55.639-03
1963	fechaServidor		No esta conectado!	2015-11-11 19:23:55.64-03
1964	fechaServidor		No esta conectado!	2015-11-11 19:23:55.642-03
1965	fechaServidor		No esta conectado!	2015-11-11 19:23:55.643-03
1966	fechaServidor		No esta conectado!	2015-11-11 19:23:55.646-03
1967	fechaServidor		No esta conectado!	2015-11-11 19:23:55.648-03
1968	fechaServidor		No esta conectado!	2015-11-11 19:23:55.651-03
1969	fechaServidor		No esta conectado!	2015-11-11 19:23:55.654-03
1970	fechaServidor		No esta conectado!	2015-11-11 19:23:55.656-03
1971	fechaServidor		No esta conectado!	2015-11-11 19:23:55.66-03
1972	fechaServidor		No esta conectado!	2015-11-11 19:23:55.666-03
1973	fechaServidor		No esta conectado!	2015-11-11 19:23:55.671-03
1974	fechaServidor		No esta conectado!	2015-11-11 19:23:55.676-03
1975	fechaServidor		No esta conectado!	2015-11-11 19:23:55.681-03
1976	fechaServidor		No esta conectado!	2015-11-11 19:23:55.686-03
1977	fechaServidor		No esta conectado!	2015-11-11 19:23:55.69-03
1978	fechaServidor		No esta conectado!	2015-11-11 19:23:55.696-03
1979	fechaServidor		No esta conectado!	2015-11-11 19:23:55.703-03
1980	fechaServidor		No esta conectado!	2015-11-11 19:23:55.72-03
1981	fechaServidor		No esta conectado!	2015-11-11 19:23:55.725-03
1982	fechaServidor		No esta conectado!	2015-11-11 19:23:55.73-03
1983	fechaServidor		No esta conectado!	2015-11-11 19:23:55.737-03
1984	fechaServidor		No esta conectado!	2015-11-11 19:23:55.742-03
1985	fechaServidor		No esta conectado!	2015-11-11 19:23:55.747-03
1986	fechaServidor		No esta conectado!	2015-11-11 19:23:55.753-03
1987	fechaServidor		No esta conectado!	2015-11-11 19:23:55.759-03
1988	fechaServidor		No esta conectado!	2015-11-11 19:23:55.76-03
1989	fechaServidor		No esta conectado!	2015-11-11 19:23:55.762-03
1990	fechaServidor		No esta conectado!	2015-11-11 19:23:55.766-03
1991	fechaServidor		No esta conectado!	2015-11-11 19:23:55.776-03
1992	fechaServidor		No esta conectado!	2015-11-11 19:23:55.777-03
1993	fechaServidor		No esta conectado!	2015-11-11 19:23:55.778-03
1994	fechaServidor		No esta conectado!	2015-11-11 19:23:55.782-03
1995	fechaServidor		No esta conectado!	2015-11-11 19:23:55.785-03
1996	fechaServidor		No esta conectado!	2015-11-11 19:23:55.786-03
1997	fechaServidor		No esta conectado!	2015-11-11 19:23:55.788-03
1998	fechaServidor		No esta conectado!	2015-11-11 19:23:55.789-03
1999	fechaServidor		No esta conectado!	2015-11-11 19:23:55.796-03
2000	fechaServidor		No esta conectado!	2015-11-11 19:23:55.801-03
2001	fechaServidor		No esta conectado!	2015-11-11 19:23:55.804-03
2002	fechaServidor		No esta conectado!	2015-11-11 19:23:55.806-03
2003	fechaServidor		No esta conectado!	2015-11-11 19:23:55.809-03
2004	fechaServidor		No esta conectado!	2015-11-11 19:23:55.81-03
2005	fechaServidor		No esta conectado!	2015-11-11 19:23:55.815-03
2006	fechaServidor		No esta conectado!	2015-11-11 19:23:55.821-03
2007	fechaServidor		No esta conectado!	2015-11-11 19:23:55.822-03
2008	fechaServidor		No esta conectado!	2015-11-11 19:23:55.824-03
2009	fechaServidor		No esta conectado!	2015-11-11 19:23:55.827-03
2010	fechaServidor		No esta conectado!	2015-11-11 19:23:55.83-03
2011	fechaServidor		No esta conectado!	2015-11-11 19:23:55.833-03
2012	fechaServidor		No esta conectado!	2015-11-11 19:23:55.835-03
2013	fechaServidor		No esta conectado!	2015-11-11 19:23:55.836-03
2014	fechaServidor		No esta conectado!	2015-11-11 19:23:55.837-03
2015	fechaServidor		No esta conectado!	2015-11-11 19:23:55.838-03
2016	fechaServidor		No esta conectado!	2015-11-11 19:23:55.839-03
2017	fechaServidor		No esta conectado!	2015-11-11 19:23:55.84-03
2018	fechaServidor		No esta conectado!	2015-11-11 19:23:55.841-03
2019	fechaServidor		No esta conectado!	2015-11-11 19:23:55.843-03
2020	fechaServidor		No esta conectado!	2015-11-11 19:23:55.844-03
2021	fechaServidor		No esta conectado!	2015-11-11 19:23:55.845-03
2022	fechaServidor		No esta conectado!	2015-11-11 19:23:55.846-03
2023	fechaServidor		No esta conectado!	2015-11-11 19:23:55.847-03
2024	fechaServidor		No esta conectado!	2015-11-11 19:23:55.849-03
2025	fechaServidor		No esta conectado!	2015-11-11 19:23:55.85-03
2026	fechaServidor		No esta conectado!	2015-11-11 19:23:55.853-03
2027	fechaServidor		No esta conectado!	2015-11-11 19:23:55.854-03
2028	fechaServidor		No esta conectado!	2015-11-11 19:23:55.857-03
2029	fechaServidor		No esta conectado!	2015-11-11 19:23:55.861-03
2030	fechaServidor		No esta conectado!	2015-11-11 19:23:55.863-03
2031	fechaServidor		No esta conectado!	2015-11-11 19:23:55.867-03
2032	fechaServidor		No esta conectado!	2015-11-11 19:23:55.87-03
2033	fechaServidor		No esta conectado!	2015-11-11 19:23:55.875-03
2034	fechaServidor		No esta conectado!	2015-11-11 19:23:55.877-03
2035	fechaServidor		No esta conectado!	2015-11-11 19:23:55.881-03
2036	fechaServidor		No esta conectado!	2015-11-11 19:23:55.883-03
2037	fechaServidor		No esta conectado!	2015-11-11 19:23:55.888-03
2038	fechaServidor		No esta conectado!	2015-11-11 19:23:55.891-03
2039	fechaServidor		No esta conectado!	2015-11-11 19:23:55.894-03
2040	fechaServidor		No esta conectado!	2015-11-11 19:23:55.897-03
2041	fechaServidor		No esta conectado!	2015-11-11 19:23:55.902-03
2042	fechaServidor		No esta conectado!	2015-11-11 19:23:55.904-03
2043	fechaServidor		No esta conectado!	2015-11-11 19:23:55.907-03
2044	fechaServidor		No esta conectado!	2015-11-11 19:23:55.911-03
2045	fechaServidor		No esta conectado!	2015-11-11 19:23:55.914-03
2046	fechaServidor		No esta conectado!	2015-11-11 19:23:55.924-03
2047	fechaServidor		No esta conectado!	2015-11-11 19:23:55.925-03
2048	fechaServidor		No esta conectado!	2015-11-11 19:23:55.928-03
2049	fechaServidor		No esta conectado!	2015-11-11 19:23:55.931-03
2050	fechaServidor		No esta conectado!	2015-11-11 19:23:55.935-03
2051	fechaServidor		No esta conectado!	2015-11-11 19:23:55.939-03
2052	fechaServidor		No esta conectado!	2015-11-11 19:23:55.94-03
2053	fechaServidor		No esta conectado!	2015-11-11 19:23:55.942-03
2054	fechaServidor		No esta conectado!	2015-11-11 19:23:55.944-03
2055	fechaServidor		No esta conectado!	2015-11-11 19:23:55.945-03
2056	conectar	1	Comando conectar OK	2015-11-11 19:27:35.337-03
2057	conectar	2	Comando conectar OK	2015-11-11 19:27:46.255-03
2058	fechaServidor		No esta conectado!	2015-11-11 19:28:00.576-03
2059	fechaServidor		cantidad de parametros incorrectos!	2015-11-11 19:28:07.528-03
2060	conectar	1	Comando conectar OK	2015-11-11 19:28:35.286-03
2061	estadoServidor		Id incorrecta	2015-11-11 19:28:45.917-03
2062	conectar	1	Comando conectar OK	2015-11-11 19:32:15.279-03
2063	estadoServidor	1	ACTIVO	2015-11-11 19:32:34.134-03
2064	conectar	1	Comando conectar OK	2015-11-11 19:38:05.801-03
2065	estadoServidor		Id incorrecta	2015-11-11 19:38:23.38-03
2066	estadoServidor		Id incorrecta	2015-11-11 19:38:52.944-03
2067	conectar	1	Comando conectar OK	2015-11-11 20:15:20.699-03
2068	estadoServidor		Id incorrecta	2015-11-11 20:15:27.627-03
2069	estadoServidor		Id incorrecta	2015-11-11 20:15:41.96-03
2070	estadoServidor		Id incorrecta	2015-11-11 20:15:46.422-03
2071	fechaServidor		No esta conectado!	2015-11-11 20:16:02.018-03
2072	fechaServidor		No esta conectado!	2015-11-11 20:16:06.167-03
2073	conectar	2	Comando conectar OK	2015-11-11 20:17:09.741-03
2074	estadoServidor		Id incorrecta	2015-11-11 20:17:18.576-03
2075	conectar	1	Comando conectar OK	2015-11-11 20:19:32.328-03
2076	estadoServidor		Parametro/s incorrecto/s	2015-11-11 20:19:40.045-03
2077	estadoServidor		No esta conectado!	2015-11-11 20:19:43.111-03
2078	conectar	1	Comando conectar OK	2015-11-11 20:26:40.782-03
2079	conectar	1	Ya esta conectado!	2015-11-11 20:26:50.079-03
2080	conectar	1	Ya esta conectado!	2015-11-11 20:27:07.054-03
2081	conectar	1	Ya esta conectado!	2015-11-11 20:27:26.939-03
2082	conectar	2	Comando conectar OK	2015-11-11 20:27:48.814-03
2083	estadoServidor	2	Id incorrecta	2015-11-11 20:28:03.853-03
2084	estadoServidor	2	Id incorrecta	2015-11-11 20:28:07.355-03
2085	estadoServidor	2	ACTIVO	2015-11-11 20:28:10.332-03
2086	estadoServidor	1	Id incorrecta	2015-11-11 20:28:16.621-03
2087	estadoServidor	1	ACTIVO	2015-11-11 20:28:20.726-03
2088	estadoServidor		No esta conectado!	2015-11-11 20:28:44.719-03
2089	conectar	3	Comando conectar OK	2015-11-11 20:29:46.226-03
2090	conectar	1	Comando conectar OK	2015-11-11 20:35:36.711-03
2091	conectar	1	Comando conectar OK	2015-11-11 20:36:38.118-03
2092	conectar	1	Comando conectar OK	2015-11-11 20:42:50.152-03
2093	conectar	2	Comando conectar OK	2015-11-11 20:42:52.356-03
2094	conectar	3	Comando conectar OK	2015-11-11 20:42:54.101-03
2095	estadoServidor		No esta conectado!	2015-11-11 20:44:28.254-03
\.


--
-- TOC entry 2033 (class 0 OID 0)
-- Dependencies: 172
-- Name: peticiones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('peticiones_id_seq', 2095, true);


--
-- TOC entry 2020 (class 0 OID 114725)
-- Dependencies: 177
-- Data for Name: solicitudes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY solicitudes (id, id_estado) FROM stdin;
1	1
2	1
4	1
5	1
6	1
7	1
8	1
9	1
10	1
11	1
12	1
13	1
3	2
\.


--
-- TOC entry 2034 (class 0 OID 0)
-- Dependencies: 176
-- Name: solicitudes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('solicitudes_id_seq', 13, true);


--
-- TOC entry 1900 (class 2606 OID 32776)
-- Name: peticiones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY peticiones
    ADD CONSTRAINT peticiones_pkey PRIMARY KEY (id);


--
-- TOC entry 1902 (class 2606 OID 73758)
-- Name: pk_estado; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estados
    ADD CONSTRAINT pk_estado PRIMARY KEY (id);


--
-- TOC entry 1904 (class 2606 OID 114731)
-- Name: pk_solicitudes; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY solicitudes
    ADD CONSTRAINT pk_solicitudes PRIMARY KEY (id);


--
-- TOC entry 1905 (class 2606 OID 114732)
-- Name: fk_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY solicitudes
    ADD CONSTRAINT fk_estado FOREIGN KEY (id_estado) REFERENCES estados(id);


--
-- TOC entry 2027 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-11-16 23:42:51

--
-- PostgreSQL database dump complete
--

