--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

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
-- Name: payment_method; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_method AS ENUM (
    'UPI',
    'COD'
);


ALTER TYPE public.payment_method OWNER TO postgres;

--
-- Name: payment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_status AS ENUM (
    'pending',
    'completed'
);


ALTER TYPE public.payment_status OWNER TO postgres;

--
-- Name: status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status AS ENUM (
    'pending',
    'completed',
    'canceled'
);


ALTER TYPE public.status OWNER TO postgres;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'customer',
    'admin'
);


ALTER TYPE public.user_role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Cancel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cancel" (
    "cancelId" bigint NOT NULL,
    "orderId" bigint NOT NULL,
    reason character varying(100) NOT NULL,
    "canceledAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Cancel" OWNER TO postgres;

--
-- Name: Cancel_cancelId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Cancel_cancelId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Cancel_cancelId_seq" OWNER TO postgres;

--
-- Name: Cancel_cancelId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Cancel_cancelId_seq" OWNED BY public."Cancel"."cancelId";


--
-- Name: Cancel_orderId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Cancel_orderId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Cancel_orderId_seq" OWNER TO postgres;

--
-- Name: Cancel_orderId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Cancel_orderId_seq" OWNED BY public."Cancel"."orderId";


--
-- Name: Cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cart" (
    "cartId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Cart" OWNER TO postgres;

--
-- Name: CartItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CartItem" (
    "cartItemId" bigint NOT NULL,
    "cartId" bigint NOT NULL,
    "productId" bigint NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public."CartItem" OWNER TO postgres;

--
-- Name: CartItem_cartId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CartItem_cartId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CartItem_cartId_seq" OWNER TO postgres;

--
-- Name: CartItem_cartId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CartItem_cartId_seq" OWNED BY public."CartItem"."cartId";


--
-- Name: CartItem_cartItemId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CartItem_cartItemId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CartItem_cartItemId_seq" OWNER TO postgres;

--
-- Name: CartItem_cartItemId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CartItem_cartItemId_seq" OWNED BY public."CartItem"."cartItemId";


--
-- Name: CartItem_productId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CartItem_productId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CartItem_productId_seq" OWNER TO postgres;

--
-- Name: CartItem_productId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CartItem_productId_seq" OWNED BY public."CartItem"."productId";


--
-- Name: Cart_cartId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Cart_cartId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Cart_cartId_seq" OWNER TO postgres;

--
-- Name: Cart_cartId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Cart_cartId_seq" OWNED BY public."Cart"."cartId";


--
-- Name: Cart_userId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Cart_userId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Cart_userId_seq" OWNER TO postgres;

--
-- Name: Cart_userId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Cart_userId_seq" OWNED BY public."Cart"."userId";


--
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    "orderId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "totalAmount" numeric(10,2) NOT NULL,
    "orderDate" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status public.status NOT NULL
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- Name: OrderItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderItem" (
    "orderItemId" bigint NOT NULL,
    "orderId" bigint NOT NULL,
    "productId" bigint NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL
);


ALTER TABLE public."OrderItem" OWNER TO postgres;

--
-- Name: OrderItem_orderId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OrderItem_orderId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OrderItem_orderId_seq" OWNER TO postgres;

--
-- Name: OrderItem_orderId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderItem_orderId_seq" OWNED BY public."OrderItem"."orderId";


--
-- Name: OrderItem_orderItemId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OrderItem_orderItemId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OrderItem_orderItemId_seq" OWNER TO postgres;

--
-- Name: OrderItem_orderItemId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderItem_orderItemId_seq" OWNED BY public."OrderItem"."orderItemId";


--
-- Name: OrderItem_productId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OrderItem_productId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OrderItem_productId_seq" OWNER TO postgres;

--
-- Name: OrderItem_productId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderItem_productId_seq" OWNED BY public."OrderItem"."productId";


--
-- Name: Order_orderId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_orderId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Order_orderId_seq" OWNER TO postgres;

--
-- Name: Order_orderId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_orderId_seq" OWNED BY public."Order"."orderId";


--
-- Name: Order_userId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_userId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Order_userId_seq" OWNER TO postgres;

--
-- Name: Order_userId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_userId_seq" OWNED BY public."Order"."userId";


--
-- Name: Payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Payment" (
    "paymentId" bigint NOT NULL,
    "orderId" bigint NOT NULL,
    "paymentMethod" public.payment_method NOT NULL,
    "paymentStatus" public.payment_status NOT NULL,
    "paymentDate" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Payment" OWNER TO postgres;

--
-- Name: Payment_orderId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Payment_orderId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Payment_orderId_seq" OWNER TO postgres;

--
-- Name: Payment_orderId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Payment_orderId_seq" OWNED BY public."Payment"."orderId";


--
-- Name: Payment_paymentId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Payment_paymentId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Payment_paymentId_seq" OWNER TO postgres;

--
-- Name: Payment_paymentId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Payment_paymentId_seq" OWNED BY public."Payment"."paymentId";


--
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    "productId" bigint NOT NULL,
    "productName" character varying NOT NULL,
    description text NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    "stockQuantity" integer NOT NULL,
    "categoryId" bigint NOT NULL
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- Name: ProductCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductCategory" (
    "categoryId" bigint NOT NULL,
    "categoryName" character varying NOT NULL
);


ALTER TABLE public."ProductCategory" OWNER TO postgres;

--
-- Name: ProductCategory_categoryId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductCategory_categoryId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ProductCategory_categoryId_seq" OWNER TO postgres;

--
-- Name: ProductCategory_categoryId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductCategory_categoryId_seq" OWNED BY public."ProductCategory"."categoryId";


--
-- Name: Product_categoryId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_categoryId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Product_categoryId_seq" OWNER TO postgres;

--
-- Name: Product_categoryId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_categoryId_seq" OWNED BY public."Product"."categoryId";


--
-- Name: Product_productId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_productId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Product_productId_seq" OWNER TO postgres;

--
-- Name: Product_productId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_productId_seq" OWNED BY public."Product"."productId";


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    "userId" bigint NOT NULL,
    "userName" character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(100) NOT NULL,
    "phoneNumber" character varying(15) NOT NULL,
    "userRole" public.user_role NOT NULL,
    address_line character varying(255) NOT NULL,
    city character varying(100) NOT NULL,
    state character varying(100) NOT NULL,
    pincode character varying(20) NOT NULL,
    country character varying(100) NOT NULL,
    hint character varying(50) NOT NULL,
    "DOB" date NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id OWNER TO postgres;

--
-- Name: user_userId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."user_userId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."user_userId_seq" OWNER TO postgres;

--
-- Name: user_userId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."user_userId_seq" OWNED BY public."user"."userId";


--
-- Name: Cancel cancelId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cancel" ALTER COLUMN "cancelId" SET DEFAULT nextval('public."Cancel_cancelId_seq"'::regclass);


--
-- Name: Cancel orderId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cancel" ALTER COLUMN "orderId" SET DEFAULT nextval('public."Cancel_orderId_seq"'::regclass);


--
-- Name: Cart cartId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart" ALTER COLUMN "cartId" SET DEFAULT nextval('public."Cart_cartId_seq"'::regclass);


--
-- Name: Cart userId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart" ALTER COLUMN "userId" SET DEFAULT nextval('public."Cart_userId_seq"'::regclass);


--
-- Name: CartItem cartItemId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem" ALTER COLUMN "cartItemId" SET DEFAULT nextval('public."CartItem_cartItemId_seq"'::regclass);


--
-- Name: CartItem cartId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem" ALTER COLUMN "cartId" SET DEFAULT nextval('public."CartItem_cartId_seq"'::regclass);


--
-- Name: CartItem productId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem" ALTER COLUMN "productId" SET DEFAULT nextval('public."CartItem_productId_seq"'::regclass);


--
-- Name: Order orderId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN "orderId" SET DEFAULT nextval('public."Order_orderId_seq"'::regclass);


--
-- Name: Order userId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN "userId" SET DEFAULT nextval('public."Order_userId_seq"'::regclass);


--
-- Name: OrderItem orderItemId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem" ALTER COLUMN "orderItemId" SET DEFAULT nextval('public."OrderItem_orderItemId_seq"'::regclass);


--
-- Name: OrderItem orderId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem" ALTER COLUMN "orderId" SET DEFAULT nextval('public."OrderItem_orderId_seq"'::regclass);


--
-- Name: OrderItem productId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem" ALTER COLUMN "productId" SET DEFAULT nextval('public."OrderItem_productId_seq"'::regclass);


--
-- Name: Payment paymentId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment" ALTER COLUMN "paymentId" SET DEFAULT nextval('public."Payment_paymentId_seq"'::regclass);


--
-- Name: Payment orderId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment" ALTER COLUMN "orderId" SET DEFAULT nextval('public."Payment_orderId_seq"'::regclass);


--
-- Name: Product productId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN "productId" SET DEFAULT nextval('public."Product_productId_seq"'::regclass);


--
-- Name: Product categoryId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN "categoryId" SET DEFAULT nextval('public."Product_categoryId_seq"'::regclass);


--
-- Name: ProductCategory categoryId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategory" ALTER COLUMN "categoryId" SET DEFAULT nextval('public."ProductCategory_categoryId_seq"'::regclass);


--
-- Name: user userId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN "userId" SET DEFAULT nextval('public."user_userId_seq"'::regclass);


--
-- Data for Name: Cancel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cancel" ("cancelId", "orderId", reason, "canceledAt") FROM stdin;
13	54	hanging issue	2024-10-27 15:06:37.213+05:30
14	55	don't like it	2024-10-27 19:30:37.527+05:30
15	56	over priced	2024-10-28 05:59:13.543+05:30
16	57	over price	2024-10-28 12:47:31.673+05:30
17	59	not looking good	2024-10-28 13:16:23.995+05:30
18	61	looks bad	2024-10-28 13:24:28.394+05:30
19	65	don't like it	2024-10-28 18:44:37.15+05:30
20	64	too pricee	2024-10-28 18:44:53.676+05:30
21	69	no money	2024-10-28 19:19:03.239+05:30
22	66	don't like it	2024-10-28 20:05:22.054996+05:30
23	71	over price	2024-10-28 23:32:25.508395+05:30
24	67	don't know	2024-10-28 23:57:01.069075+05:30
25	68	not worth for the price	2024-10-29 06:09:41.939416+05:30
26	76	-	2024-10-29 07:09:42.72952+05:30
27	70	used it	2024-10-29 10:07:43.27+05:30
28	81	don't kno	2024-10-29 10:09:24.677939+05:30
30	104	bad product	2024-11-24 07:29:57.236918+05:30
\.


--
-- Data for Name: Cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cart" ("cartId", "userId", "createdAt") FROM stdin;
7	15	2024-10-26 09:13:34.567+05:30
8	20	2024-10-27 19:22:35.392+05:30
9	19	2024-10-28 13:16:05.032+05:30
13	25	2024-10-28 20:21:18.205023+05:30
14	13	2024-11-02 10:56:24.405862+05:30
15	36	2024-11-02 21:46:33.538238+05:30
16	37	2024-11-02 21:50:04.513571+05:30
17	40	2024-11-02 21:52:11.54928+05:30
18	45	2024-11-02 22:22:54.715125+05:30
19	46	2024-11-02 23:31:46.753036+05:30
20	50	2024-11-03 16:14:39.528055+05:30
21	4	2024-11-15 10:30:55.58229+05:30
22	7	2024-11-15 11:33:35.696102+05:30
23	52	2024-11-24 09:35:50.393003+05:30
\.


--
-- Data for Name: CartItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CartItem" ("cartItemId", "cartId", "productId", quantity) FROM stdin;
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" ("orderId", "userId", "totalAmount", "orderDate", status) FROM stdin;
54	15	30000.00	2024-10-27 15:05:13.057+05:30	canceled
55	15	100000.00	2024-10-27 19:30:14.869+05:30	canceled
56	15	500.00	2024-10-28 05:58:45.136+05:30	canceled
57	15	100000.00	2024-10-28 12:46:57.208+05:30	canceled
58	15	500.00	2024-10-28 12:47:39.483+05:30	completed
59	19	50000.00	2024-10-28 13:15:30.975+05:30	canceled
60	19	500.00	2024-10-28 13:16:57.094+05:30	completed
61	19	34.00	2024-10-28 13:23:30.012+05:30	canceled
62	19	120500.00	2024-10-28 13:24:35.283+05:30	completed
65	19	500.00	2024-10-28 18:43:34.308+05:30	canceled
64	19	120000.00	2024-10-28 18:37:55.063+05:30	canceled
69	19	201400.00	2024-10-28 19:18:22.18+05:30	canceled
66	19	120000.00	2024-10-28 18:57:29.628+05:30	canceled
71	19	50500.00	2024-10-28 23:32:08.323783+05:30	canceled
72	19	100000.00	2024-10-28 23:38:39.63337+05:30	completed
67	19	500.00	2024-10-28 18:58:29.365+05:30	canceled
68	19	600000.00	2024-10-28 19:04:50.193+05:30	canceled
63	15	500.00	2024-10-28 16:57:59.025847+05:30	completed
76	19	120000.00	2024-10-29 07:09:23.275809+05:30	canceled
74	19	30000.00	2024-10-29 06:08:42.279752+05:30	completed
70	19	34.00	2024-10-28 23:27:36.003913+05:30	canceled
109	50	50001.00	2024-11-03 17:03:56.683162+05:30	canceled
81	19	100000.00	2024-10-29 10:09:04.049767+05:30	canceled
80	19	11000.00	2024-10-29 10:08:29.994476+05:30	completed
73	19	79900.00	2024-10-28 23:56:54.147279+05:30	canceled
75	19	50000.00	2024-10-29 06:09:58.557066+05:30	canceled
78	19	50000.00	2024-10-29 08:36:04.888803+05:30	canceled
77	19	79900.00	2024-10-29 08:30:53.994204+05:30	canceled
79	19	100000.00	2024-10-29 08:36:31.880571+05:30	canceled
83	19	50000.00	2024-11-02 09:10:55.649035+05:30	canceled
82	19	500.00	2024-10-29 10:49:03.758208+05:30	canceled
84	19	500.00	2024-11-02 09:12:25.581022+05:30	canceled
86	19	100000.00	2024-11-02 09:13:55.787372+05:30	canceled
87	19	34.00	2024-11-02 09:15:14.78453+05:30	canceled
85	19	50000.00	2024-11-02 09:13:48.7268+05:30	canceled
89	19	1000.00	2024-11-02 09:17:41.226819+05:30	canceled
88	19	120000.00	2024-11-02 09:17:33.403076+05:30	canceled
90	19	11000.00	2024-11-02 11:17:56.907969+05:30	completed
91	19	100000.00	2024-11-02 18:24:52.290948+05:30	canceled
92	19	500.00	2024-11-02 18:25:04.723818+05:30	canceled
93	19	500.00	2024-11-02 18:33:51.303671+05:30	canceled
94	19	30000.00	2024-11-02 18:33:56.391969+05:30	canceled
96	19	500.00	2024-11-02 18:35:25.842592+05:30	canceled
95	19	50000.00	2024-11-02 18:35:18.689097+05:30	canceled
97	19	1000.00	2024-11-02 18:35:33.45604+05:30	canceled
98	19	500.00	2024-11-02 18:38:28.390879+05:30	canceled
99	19	500.00	2024-11-02 18:52:21.902468+05:30	canceled
101	25	1000.00	2024-11-03 12:01:35.200397+05:30	canceled
100	25	50000.00	2024-11-03 11:59:32.164991+05:30	canceled
102	25	500.00	2024-11-03 12:02:18.709564+05:30	completed
103	50	50000.00	2024-11-03 16:36:00.196027+05:30	completed
104	50	50000.00	2024-11-03 16:45:58.51392+05:30	canceled
105	50	1.00	2024-11-03 16:50:47.46391+05:30	pending
106	50	100.00	2024-11-03 16:51:01.298502+05:30	pending
110	50	100001.00	2024-11-03 17:21:13.762774+05:30	completed
111	50	50001.00	2024-11-04 08:12:37.499613+05:30	canceled
113	50	50001.00	2024-11-04 10:41:56.613491+05:30	pending
107	50	100000.00	2024-11-03 16:58:46.009579+05:30	canceled
114	50	50000.00	2024-11-06 20:07:20.772639+05:30	pending
116	52	100.34	2024-11-24 13:42:03.733642+05:30	pending
108	50	180000.00	2024-11-03 17:00:19.937295+05:30	canceled
112	50	50000.00	2024-11-04 10:40:47.403511+05:30	completed
\.


--
-- Data for Name: OrderItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OrderItem" ("orderItemId", "orderId", "productId", quantity, price) FROM stdin;
35	54	5	5	30000.00
36	55	30	30	100000.00
37	56	21	21	500.00
38	57	30	30	100000.00
39	58	21	21	500.00
40	59	31	31	50000.00
41	60	21	21	500.00
42	61	32	32	34.00
44	62	1	1	120000.00
45	64	1	1	120000.00
46	65	21	21	500.00
47	66	1	1	120000.00
48	67	21	21	500.00
49	68	1	1	120000.00
53	69	29	29	1000.00
54	70	32	32	34.00
56	71	21	21	500.00
57	72	30	30	100000.00
58	73	11	11	79900.00
59	74	5	5	30000.00
60	75	9	9	50000.00
61	76	1	1	120000.00
63	77	11	1	79900.00
64	78	31	1	50000.00
65	79	30	1	100000.00
67	80	4	1	11000.00
68	81	34	1	100000.00
71	82	21	1	500.00
72	83	3	1	50000.00
73	84	21	1	500.00
74	85	31	1	50000.00
75	86	30	1	100000.00
76	87	32	1	34.00
77	88	1	1	120000.00
78	89	28	1	1000.00
79	90	4	1	11000.00
80	91	34	1	100000.00
81	92	21	1	500.00
82	93	21	1	500.00
83	94	5	1	30000.00
84	95	3	1	50000.00
85	96	21	1	500.00
86	97	29	1	1000.00
87	98	21	1	500.00
88	99	21	1	500.00
89	100	31	1	50000.00
90	101	29	1	1000.00
91	102	21	1	500.00
92	103	31	1	50000.00
93	104	31	1	50000.00
94	105	41	1	1.00
95	106	40	1	100.00
96	107	30	1	100000.00
99	108	3	1	50000.00
100	109	41	1	1.00
102	110	41	1	1.00
104	111	41	1	1.00
106	112	31	1	50000.00
107	113	31	1	50000.00
109	114	31	1	50000.00
110	112	1	3	0.00
111	112	1	3	100.40
112	112	1	3	10009.40
\.


--
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Payment" ("paymentId", "orderId", "paymentMethod", "paymentStatus", "paymentDate") FROM stdin;
44	54	UPI	completed	2024-10-27 15:05:16.049+05:30
45	55	UPI	completed	2024-10-27 19:30:16.23+05:30
46	56	COD	pending	2024-10-28 05:58:48.708+05:30
47	57	UPI	completed	2024-10-28 12:46:58.809+05:30
48	58	COD	completed	2024-10-28 12:47:41.746+05:30
49	59	UPI	completed	2024-10-28 13:15:35.798+05:30
50	60	COD	completed	2024-10-28 13:17:00.774+05:30
51	61	UPI	completed	2024-10-28 13:23:31.196+05:30
52	62	COD	completed	2024-10-28 13:24:39.213+05:30
53	62	UPI	pending	2024-10-28 16:59:34.331773+05:30
54	64	UPI	completed	2024-10-28 18:37:56.898+05:30
55	65	UPI	completed	2024-10-28 18:43:36.529+05:30
56	67	UPI	completed	2024-10-28 18:58:30.745436+05:30
57	68	UPI	completed	2024-10-28 19:04:59.451262+05:30
58	69	UPI	completed	2024-10-28 19:18:26.682974+05:30
59	70	UPI	completed	2024-10-28 23:27:37.387274+05:30
60	71	COD	pending	2024-10-28 23:32:10.26308+05:30
61	72	UPI	completed	2024-10-28 23:38:41.916682+05:30
62	73	UPI	completed	2024-10-28 23:56:54.702397+05:30
63	74	UPI	completed	2024-10-29 06:08:44.057036+05:30
64	75	COD	pending	2024-10-29 06:10:02.351309+05:30
65	76	UPI	completed	2024-10-29 07:09:24.975558+05:30
66	77	UPI	completed	2024-10-29 08:30:55.591046+05:30
67	78	UPI	completed	2024-10-29 08:36:06.493773+05:30
68	79	COD	pending	2024-10-29 08:36:35.598097+05:30
69	80	UPI	completed	2024-10-29 10:08:31.528218+05:30
70	81	UPI	completed	2024-10-29 10:09:05.972613+05:30
71	82	UPI	completed	2024-10-29 10:49:04.874584+05:30
72	83	UPI	completed	2024-11-02 09:10:56.394692+05:30
73	84	UPI	completed	2024-11-02 09:12:25.9278+05:30
74	85	UPI	completed	2024-11-02 09:13:49.336577+05:30
75	86	UPI	completed	2024-11-02 09:14:00.811948+05:30
76	87	UPI	completed	2024-11-02 09:15:15.638739+05:30
77	88	UPI	completed	2024-11-02 09:17:34.147263+05:30
78	89	UPI	completed	2024-11-02 09:17:41.737802+05:30
79	90	UPI	completed	2024-11-02 11:17:58.180086+05:30
80	91	UPI	completed	2024-11-02 18:24:55.263597+05:30
81	92	UPI	completed	2024-11-02 18:25:05.39189+05:30
82	93	UPI	completed	2024-11-02 18:33:52.358145+05:30
83	94	UPI	completed	2024-11-02 18:33:56.591475+05:30
84	95	UPI	completed	2024-11-02 18:35:21.191826+05:30
85	96	UPI	completed	2024-11-02 18:35:28.804066+05:30
86	97	UPI	completed	2024-11-02 18:35:35.915593+05:30
87	98	UPI	completed	2024-11-02 18:38:29.352949+05:30
88	99	UPI	completed	2024-11-02 18:52:23.052976+05:30
89	100	UPI	completed	2024-11-03 11:59:32.321684+05:30
90	101	COD	pending	2024-11-03 12:01:35.366444+05:30
91	102	COD	pending	2024-11-03 12:02:18.880137+05:30
92	103	UPI	completed	2024-11-03 16:36:01.606512+05:30
93	104	UPI	completed	2024-11-03 16:45:58.664517+05:30
94	105	UPI	completed	2024-11-03 16:50:47.620771+05:30
96	110	UPI	completed	2024-11-03 17:21:14.354618+05:30
97	111	UPI	completed	2024-11-04 08:12:38.098581+05:30
98	112	UPI	completed	2024-11-04 10:40:47.605819+05:30
99	113	UPI	completed	2024-11-04 10:41:57.284196+05:30
100	114	UPI	completed	2024-11-06 20:07:21.092694+05:30
101	54	UPI	completed	2024-11-24 09:50:21.717418+05:30
102	54	UPI	completed	2024-11-24 09:50:51.292216+05:30
103	54	UPI	completed	2024-11-24 09:51:07.847142+05:30
104	54	UPI	completed	2024-11-24 09:51:47.348144+05:30
105	54	UPI	completed	2024-11-24 09:51:54.409292+05:30
106	54	UPI	completed	2024-11-24 09:53:39.36303+05:30
95	106	COD	completed	2024-11-03 16:51:01.454759+05:30
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Product" ("productId", "productName", description, unit_price, "stockQuantity", "categoryId") FROM stdin;
13	cotton	day to day use	1000.00	100	4
14	hand made	hand made saree	79900.00	10	4
15	dothi shirt	marriage oriented	50000.00	120	5
16	cotton shirt	day to day use	1000.00	100	5
17	hand made	hand made shirt	79900.00	10	5
18	colar t-shirt	top notch t-shirt	500.00	120	6
19	cotton t-shirt	day to day use	1000.00	100	6
20	polo t-shirt	best polo t-shirt	900.00	10	6
24	boat headphone	good fit in ear	500.00	120	8
25	bluetooth headphone	low latency	1000.00	100	8
26	Air Pod	premium quality 	1000.00	10	8
21	casual shoe	leather material	500.00	210	7
29	cushan chair	lead a comfort life with us	1000.00	38	9
33	plastic	best plastic	10.00	10	10
31	dell-x34	one best laptop at affordable price	50000.00	160	1
1	DELL-236	most power ful laptop	120000.00	67	1
41	dfd	dafdf	1.00	3	1
9	moto	slim phone	50000.00	1009	3
35	moto-gen9	best smartphone	30000.00	10	3
22	formal shoe	black color with white line	1000.00	1	7
23	brown formal shoe	brown color with red line	900.00	1	7
30	mac book	premium product	100000.00	156	1
42	levono-txs-1000	best laptop	50000.00	50	1
36	d	dfdf	3.00	4	16
37	df	dfd	34.00	2	16
3	hp-236	slim laptop	50000.00	1100	1
11	iphone 16	best for gaming	79900.00	158	3
44	dell gaming laptop	beast device	20000.00	23	20
10	nokia	affordable	11000.00	5	3
27	plastic chair	long lastic	500.00	120	9
32	dfd	df	34.00	62	1
28	office chair	good comfort	1000.00	99	9
4	lenovo-d34	affordable to work	11000.00	87	1
38	df	dfdfd	333.00	22	1
39	kid chair	best kid chair at affordable price	100.00	10	9
40	gym chair	best comfortable	100.00	10	9
34	hp elite book	slim laptop ever	100000.00	1000	1
5	lenovo-trx	best for gaming	30000.00	52	1
\.


--
-- Data for Name: ProductCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ProductCategory" ("categoryId", "categoryName") FROM stdin;
1	laptop
3	mobile
4	saree
5	shirt
6	t-shirt
7	shoe
8	headphone
9	chair
10	makeup
11	car
12	keyboard
13	grinder
14	juicer mixer
15	plastic
16	cap
17	back case
18	dfd
19	bowl
20	helo
21	okok
22	fdsdfdfsa
23	desk
24	pravee_post_category
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" ("userId", "userName", password, email, "phoneNumber", "userRole", address_line, city, state, pincode, country, hint, "DOB") FROM stdin;
29	kumar	3befd1d26ccf5f8aacaaffc6f7fd2804c96653e0a8775f7562f78c789f882608	kumar@gmail.com	1122334455	customer	2nd street	chennai	tamil nadu	343434	india	three digit with name	2000-05-20
37	guest	fb92263a22392840b22e09bbfe45ac21a0b51c68f36e3b70727784c164f13dfd	guest@gmail.com	1234567890	customer	4th street, mount road	chennai	tamil nadu	123	india	Invalid Date	2000-03-22
41	random	7b9ad265db867dccccf1b1aa0b667627a4c683d88dc04e71c6a3f4bd007601ef	random@gmail.com	0293848292	customer	sjd	dfdf	kkkh	34343	kjhjh	Invalid Date	2000-03-22
43	fefdfdfd	ac1c2bd20e70788c96acdf4f058731274263712eedb00f1c07fd8024d22340e6	dffdfd@gmail.com	9384920193	customer	ddfadf	dfd	dfdf	3434	dfdf	Invalid Date	2000-03-22
47	dfdsfd	16646e04c319d8def0e49c80c8fddc866d9c630842d09ab90336c2731294a8ae	dadfdfd@gmail.com	8493029483	customer	ddfd	ddfddd	dfd	334	fdfdf	dfdfa	1993-06-09
45	one	fba0d166bdeef8243b5eb0d09c66d8ff3e8932023a64bfa4add8267c9b55c17b	one@gmail.com	0194829302	customer	2nd street, hello nagar	chennai	tamil nadu	2349382	india	code word	2000-03-22
33	dsdf	bc042e523408872e3abf9a3a19c15f121297173972fad71391182b770188c608	dfd@gmail.com	4782017583	admin	fdfdf	ddfd	ddf	34343	dfdf	dfdfd	1999-05-20
49	dfdsfd	16646e04c319d8def0e49c80c8fddc866d9c630842d09ab90336c2731294a8ae	dadfdfds@gmail.com	8493022483	admin	ddfd	ddfddd	dfd	334	fdfdf	dfdfa	1993-06-09
13	praveen kumar	201eca3e874a31ced6cd70eb0a022dfa3ee4516154f034a17cad73aa4f3ec930	praveenkumar@gmail.com	0987654321	admin	2nd street, sathya nagar	chennai	tamil nadu	3345	india	my name with digit	2000-05-20
53	postpraveen	f4204705a8bf0516d1662537785ad9fe45169b78a8bba206d1db2b26f8ee4e98	postpraveen@gmail.com	8461058349	customer	2nd street, sathya nagar	chennai	tamil nadu	123	india	code word	2000-05-24
16	admin	8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918	admin@gmail.com	1234567888	customer	mount road	chennai	andhra	49494	india	my name with digit	2000-05-20
15	praveen	201eca3e874a31ced6cd70eb0a022dfa3ee4516154f034a17cad73aa4f3ec930	praveens@gmail.com	0192837465	admin	2nd street	chennai	tamil nadu	23232	india	my name with digit	2000-05-20
14	praveen kumar	95f32758d7c0bd8bb3d2aa8b6445ae9544fed79549fd665f23ec085e97d8dd70	praveen34@gmail.com	1234567891	customer	2nd street, sathya nagar	chennai	tamil nadu	3433	india	my name with digit	2000-05-20
17	praveen	201eca3e874a31ced6cd70eb0a022dfa3ee4516154f034a17cad73aa4f3ec930	praveen123@gmail.com	1234512345	customer	porur main road	chennai	tamil nadu	3443	india	my name with digit	2000-05-20
50	kumaran	eb3004056107e34fa15a739d317aa63b8ef2e7dc3903877f8a2ed945f63be42c	kumaran@gmail.com	0372946205	customer	2nd street, sathya nagar	chennai	bangalore	20000	USA	My first pet's name	2001-01-01
36	hello	134563d4e440f0e418b0f382f23a2cf301af6d7f648ccfae9895018345d779a3	hellos@gmail.com	0918940293	admin	ddfd	fdfdf	fdfdfd	3343	dfdf	Invalid Date	2000-03-22
20	kumaran	eb3004056107e34fa15a739d317aa63b8ef2e7dc3903877f8a2ed945f63be42c	kumaran@gamil.com	1020304050	customer	railway station	chennai	tamil nadu	343433	australia	3 digit code	2000-05-20
30	guru	8633f0be601d0d1c196d531a823e8f7dd413d5347d43e9347971ae1ad5f5d211	guru@gmail.com	0099887766	customer	mount road	chennai	tamil nadu	393939	india	four digit	1999-06-20
32	hello	3db64b3e9fa0e23858b5b95ffe14dbd83b447ae2126277062eb6f8d5c4213c87	hello@gmail.com	1029847382	admin	dfd	dfd	dfdf	223	dfd	dfd	1992-03-20
40	ok	8f74d8fb58b1344e1fce8a4b014936d6f3a2ee9c00827aa9b9d60d220f502c89	okay1234@gmail.com	1234567899	customer	dfdf	dfdf	dfdf	334	dfdfd	Invalid Date	2000-03-22
42	dff	ca6f67e9fca150bd55f499ae75363c89e224078c26a00a9f61251a8b561d52db	dfdfdfd@gmail.com	8393929294	customer	fdfd	fdfd	fdfdf	343	dfdfd	Invalid Date	2000-03-22
46	newer	aec3e503bec90ec2d479694fbb3fcf42b2043cae6ebec649726ca42ad9fe9735	newer@gmail.com	9483920384	customer	ljld	ddff	lkjlkfds	343	jd	accepted	1995-11-14
19	praveen	2f3caffd6aeec967a7d71eb7abec0993d036430691e668a8710248df4541111e	praveen2000@gmail.com	6789009876	customer	2nd street	chennai	tamil nadu	34343	india	born city	2000-05-20
18	praveen	201eca3e874a31ced6cd70eb0a022dfa3ee4516154f034a17cad73aa4f3ec930	praveen1234@gmail.com	1231231231	admin	2nd street	chennai	tamil nadu	343434	india china	my name with digit	2000-05-20
23	praveen kumar	fba0d166bdeef8243b5eb0d09c66d8ff3e8932023a64bfa4add8267c9b55c17b	praveenkumar92@zoho.com	9080706050	customer	mount road	chennai	tamil nadu	600001	india	name with digit	2000-05-20
28	praveen	4f4a4dec44a0a1642f77f0da29f34a9f70eca88813a2a688028fc44a2fb0cd66	newpraveen@gmail.com	7565859505	customer	2nd street, sathya nagar	chennai	tamil nadu	343434	india	three digit code	2000-05-20
25	praveen kumar	fba0d166bdeef8243b5eb0d09c66d8ff3e8932023a64bfa4add8267c9b55c17b	praveenkumar92@gmail.com	1234560708	customer	2nd street, sathya nagar	chennai	tamil nadu	343434	india	three digit code	2000-05-20
52	ranjith	571fdee0087b2eb1496f55d6d6482cf52fe073dac8458908b4df3a78dc07fc88	ranjith@gmail.com	8362018492	customer	mount road	chennai	tamil nadu	2343	india	name with three code word	1992-12-29
\.


--
-- Name: Cancel_cancelId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cancel_cancelId_seq"', 30, true);


--
-- Name: Cancel_orderId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cancel_orderId_seq"', 1, false);


--
-- Name: CartItem_cartId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CartItem_cartId_seq"', 1, false);


--
-- Name: CartItem_cartItemId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CartItem_cartItemId_seq"', 141, true);


--
-- Name: CartItem_productId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CartItem_productId_seq"', 1, false);


--
-- Name: Cart_cartId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cart_cartId_seq"', 23, true);


--
-- Name: Cart_userId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cart_userId_seq"', 1, false);


--
-- Name: OrderItem_orderId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderItem_orderId_seq"', 1, false);


--
-- Name: OrderItem_orderItemId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderItem_orderItemId_seq"', 112, true);


--
-- Name: OrderItem_productId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderItem_productId_seq"', 1, false);


--
-- Name: Order_orderId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_orderId_seq"', 116, true);


--
-- Name: Order_userId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_userId_seq"', 1, false);


--
-- Name: Payment_orderId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Payment_orderId_seq"', 1, false);


--
-- Name: Payment_paymentId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Payment_paymentId_seq"', 106, true);


--
-- Name: ProductCategory_categoryId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductCategory_categoryId_seq"', 24, true);


--
-- Name: Product_categoryId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_categoryId_seq"', 1, false);


--
-- Name: Product_productId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_productId_seq"', 45, true);


--
-- Name: user_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id', 3, true);


--
-- Name: user_userId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."user_userId_seq"', 53, true);


--
-- Name: Cancel Cancel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cancel"
    ADD CONSTRAINT "Cancel_pkey" PRIMARY KEY ("cancelId");


--
-- Name: CartItem CartItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_pkey" PRIMARY KEY ("cartItemId");


--
-- Name: Cart Cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_pkey" PRIMARY KEY ("cartId");


--
-- Name: OrderItem OrderItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_pkey" PRIMARY KEY ("orderItemId");


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY ("orderId");


--
-- Name: Payment Payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY ("paymentId");


--
-- Name: ProductCategory ProductCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategory"
    ADD CONSTRAINT "ProductCategory_pkey" PRIMARY KEY ("categoryId");


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY ("productId");


--
-- Name: ProductCategory categoryName; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategory"
    ADD CONSTRAINT "categoryName" UNIQUE ("categoryName") INCLUDE ("categoryName");


--
-- Name: user email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT email UNIQUE (email) INCLUDE (email);


--
-- Name: user phoneNumber; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "phoneNumber" UNIQUE ("phoneNumber") INCLUDE ("phoneNumber");


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY ("userId");


--
-- Name: CartItem cartId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "cartId" FOREIGN KEY ("cartId") REFERENCES public."Cart"("cartId");


--
-- Name: Product categoryId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "categoryId" FOREIGN KEY ("categoryId") REFERENCES public."ProductCategory"("categoryId");


--
-- Name: OrderItem orderId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "orderId" FOREIGN KEY ("orderId") REFERENCES public."Order"("orderId");


--
-- Name: Payment orderId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "orderId" FOREIGN KEY ("orderId") REFERENCES public."Order"("orderId");


--
-- Name: Cancel orderId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cancel"
    ADD CONSTRAINT "orderId" FOREIGN KEY ("orderId") REFERENCES public."Order"("orderId");


--
-- Name: CartItem productId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "productId" FOREIGN KEY ("productId") REFERENCES public."Product"("productId");


--
-- Name: OrderItem productId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "productId" FOREIGN KEY ("productId") REFERENCES public."Product"("productId");


--
-- Name: Order userId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "userId" FOREIGN KEY ("userId") REFERENCES public."user"("userId");


--
-- PostgreSQL database dump complete
--

