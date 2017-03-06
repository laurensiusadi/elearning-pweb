--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.4.4
-- Started on 2016-06-13 06:07:37

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 7 (class 2615 OID 44653)
-- Name: elearning; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA elearning;


ALTER SCHEMA elearning OWNER TO postgres;

--
-- TOC entry 205 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 205
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = elearning, pg_catalog;

--
-- TOC entry 218 (class 1255 OID 61256)
-- Name: tf_gettotal(); Type: FUNCTION; Schema: elearning; Owner: postgres
--

CREATE FUNCTION tf_gettotal() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
declare
	t_kumpulid elearning.pengumpulan.id%type;
	t_totaldurasi elearning.pengumpulan.totaldurasi%type;
	t_totalerrsyntax elearning.pengumpulan.totalerrsyntax%type;
	t_totalerrconvention elearning.pengumpulan.totalerrconvention%type;
	t_created_at elearning.pengumpulan.created_at%type;
	t_updated_at elearning.pengumpulan.updated_at%type;
begin
	t_kumpulid := new.kumpul_id;

	select created_at into t_created_at from elearning.pengumpulan where id = t_kumpulid;
	if(t_created_at IS NULL) then
		t_created_at := new.created_at;
	end if;

	--total durasi
	select sum(durasi) into t_totaldurasi from elearning.detail
	where kumpul_id = t_kumpulid;
		
	update elearning.pengumpulan set totaldurasi = t_totaldurasi where id = t_kumpulid;

	--total error syntax
	select sum(errsyntax) into t_totalerrsyntax from elearning.detail
	where kumpul_id = t_kumpulid;
		
	update elearning.pengumpulan set totalerrsyntax = t_totalerrsyntax where id = t_kumpulid;

	--total durasi
	select sum(errconvention) into t_totalerrconvention from elearning.detail
	where kumpul_id = t_kumpulid;
		
	update elearning.pengumpulan set totalerrconvention = t_totalerrconvention where id = t_kumpulid;

	--last code
	update elearning.pengumpulan set final = new.kode where id = t_kumpulid;
	
	--created at
	update elearning.pengumpulan set created_at = t_created_at where id = t_kumpulid;

	--updated at
	update elearning.pengumpulan set updated_at = new.updated_at where id = t_kumpulid;
	return null;

end;$$;


ALTER FUNCTION elearning.tf_gettotal() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 204 (class 1259 OID 69442)
-- Name: convention; Type: TABLE; Schema: elearning; Owner: postgres; Tablespace: 
--

CREATE TABLE convention (
    id integer NOT NULL,
    "for" character varying(50) NOT NULL,
    regex character varying(50),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    min integer,
    pesanmin character varying(200),
    deskripsi character varying(200)
);


ALTER TABLE convention OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 69440)
-- Name: convention_id_seq; Type: SEQUENCE; Schema: elearning; Owner: postgres
--

CREATE SEQUENCE convention_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE convention_id_seq OWNER TO postgres;

--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 203
-- Name: convention_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE convention_id_seq OWNED BY convention.id;


--
-- TOC entry 202 (class 1259 OID 44980)
-- Name: detail; Type: TABLE; Schema: elearning; Owner: postgres; Tablespace: 
--

CREATE TABLE detail (
    id integer NOT NULL,
    kumpul_id integer NOT NULL,
    durasi integer,
    errsyntax integer,
    errconvention integer,
    kode text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE detail OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 44978)
-- Name: detail_id_seq; Type: SEQUENCE; Schema: elearning; Owner: postgres
--

CREATE SEQUENCE detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detail_id_seq OWNER TO postgres;

--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 201
-- Name: detail_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE detail_id_seq OWNED BY detail.id;


--
-- TOC entry 196 (class 1259 OID 44925)
-- Name: enrollment; Type: TABLE; Schema: elearning; Owner: postgres; Tablespace: 
--

CREATE TABLE enrollment (
    id integer NOT NULL,
    kursus_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE enrollment OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 44923)
-- Name: enrollment_id_seq; Type: SEQUENCE; Schema: elearning; Owner: postgres
--

CREATE SEQUENCE enrollment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE enrollment_id_seq OWNER TO postgres;

--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 195
-- Name: enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE enrollment_id_seq OWNED BY enrollment.id;


--
-- TOC entry 194 (class 1259 OID 44907)
-- Name: kursus; Type: TABLE; Schema: elearning; Owner: postgres; Tablespace: 
--

CREATE TABLE kursus (
    id integer NOT NULL,
    periode_id integer NOT NULL,
    mk_id integer NOT NULL,
    nama character varying(40) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE kursus OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 44905)
-- Name: kursus_id_seq; Type: SEQUENCE; Schema: elearning; Owner: postgres
--

CREATE SEQUENCE kursus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kursus_id_seq OWNER TO postgres;

--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 193
-- Name: kursus_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE kursus_id_seq OWNED BY kursus.id;


--
-- TOC entry 190 (class 1259 OID 44890)
-- Name: matakuliah; Type: TABLE; Schema: elearning; Owner: postgres; Tablespace: 
--

CREATE TABLE matakuliah (
    id integer NOT NULL,
    kode character(8) NOT NULL,
    nama character varying(50) NOT NULL,
    sks smallint NOT NULL,
    kurikulum integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE matakuliah OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 44888)
-- Name: matakuliah_id_seq; Type: SEQUENCE; Schema: elearning; Owner: postgres
--

CREATE SEQUENCE matakuliah_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE matakuliah_id_seq OWNER TO postgres;

--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 189
-- Name: matakuliah_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE matakuliah_id_seq OWNED BY matakuliah.id;


--
-- TOC entry 200 (class 1259 OID 44959)
-- Name: pengumpulan; Type: TABLE; Schema: elearning; Owner: postgres; Tablespace: 
--

CREATE TABLE pengumpulan (
    id integer NOT NULL,
    enroll_id integer NOT NULL,
    tugas_id integer NOT NULL,
    totaldurasi integer,
    totalerrsyntax integer,
    totalerrconvention integer,
    des character varying(100),
    final text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE pengumpulan OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 44957)
-- Name: pengumpulan_id_seq; Type: SEQUENCE; Schema: elearning; Owner: postgres
--

CREATE SEQUENCE pengumpulan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pengumpulan_id_seq OWNER TO postgres;

--
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 199
-- Name: pengumpulan_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE pengumpulan_id_seq OWNED BY pengumpulan.id;


--
-- TOC entry 192 (class 1259 OID 44899)
-- Name: periode; Type: TABLE; Schema: elearning; Owner: postgres; Tablespace: 
--

CREATE TABLE periode (
    id integer NOT NULL,
    nama character varying(50) NOT NULL,
    tahun integer NOT NULL,
    semester smallint NOT NULL,
    mulai date,
    selesai date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE periode OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 44897)
-- Name: periode_id_seq; Type: SEQUENCE; Schema: elearning; Owner: postgres
--

CREATE SEQUENCE periode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE periode_id_seq OWNER TO postgres;

--
-- TOC entry 2221 (class 0 OID 0)
-- Dependencies: 191
-- Name: periode_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE periode_id_seq OWNED BY periode.id;


--
-- TOC entry 188 (class 1259 OID 44874)
-- Name: posting; Type: TABLE; Schema: elearning; Owner: postgres; Tablespace: 
--

CREATE TABLE posting (
    id integer NOT NULL,
    user_id integer NOT NULL,
    text text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    judul text NOT NULL
);


ALTER TABLE posting OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 44872)
-- Name: posting_id_seq; Type: SEQUENCE; Schema: elearning; Owner: postgres
--

CREATE SEQUENCE posting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE posting_id_seq OWNER TO postgres;

--
-- TOC entry 2223 (class 0 OID 0)
-- Dependencies: 187
-- Name: posting_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE posting_id_seq OWNED BY posting.id;


--
-- TOC entry 198 (class 1259 OID 44943)
-- Name: tugas; Type: TABLE; Schema: elearning; Owner: postgres; Tablespace: 
--

CREATE TABLE tugas (
    id integer NOT NULL,
    enroll_id integer NOT NULL,
    nama character varying(50) NOT NULL,
    wmulai timestamp(0) without time zone NOT NULL,
    wselesai timestamp(0) without time zone NOT NULL,
    des text NOT NULL,
    jwb text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE tugas OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 44941)
-- Name: tugas_id_seq; Type: SEQUENCE; Schema: elearning; Owner: postgres
--

CREATE SEQUENCE tugas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tugas_id_seq OWNER TO postgres;

--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 197
-- Name: tugas_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE tugas_id_seq OWNED BY tugas.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 173 (class 1259 OID 44555)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE migrations (
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE migrations OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 44571)
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE password_resets OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 44625)
-- Name: permission_role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE permission_role (
    id integer NOT NULL,
    permission_id integer NOT NULL,
    role_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE permission_role OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 44623)
-- Name: permission_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permission_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permission_role_id_seq OWNER TO postgres;

--
-- TOC entry 2229 (class 0 OID 0)
-- Dependencies: 183
-- Name: permission_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permission_role_id_seq OWNED BY permission_role.id;


--
-- TOC entry 186 (class 1259 OID 44645)
-- Name: permission_user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE permission_user (
    id integer NOT NULL,
    permission_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE permission_user OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 44643)
-- Name: permission_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permission_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permission_user_id_seq OWNER TO postgres;

--
-- TOC entry 2231 (class 0 OID 0)
-- Dependencies: 185
-- Name: permission_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permission_user_id_seq OWNED BY permission_user.id;


--
-- TOC entry 182 (class 1259 OID 44606)
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE permissions (
    id integer NOT NULL,
    inherit_id integer,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE permissions OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 44604)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_id_seq OWNER TO postgres;

--
-- TOC entry 2233 (class 0 OID 0)
-- Dependencies: 181
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;


--
-- TOC entry 180 (class 1259 OID 44596)
-- Name: role_user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE role_user (
    id integer NOT NULL,
    role_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE role_user OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 44594)
-- Name: role_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE role_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_user_id_seq OWNER TO postgres;

--
-- TOC entry 2235 (class 0 OID 0)
-- Dependencies: 179
-- Name: role_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE role_user_id_seq OWNED BY role_user.id;


--
-- TOC entry 178 (class 1259 OID 44581)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE roles OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 44579)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE roles_id_seq OWNER TO postgres;

--
-- TOC entry 2237 (class 0 OID 0)
-- Dependencies: 177
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- TOC entry 175 (class 1259 OID 44560)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE users OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 44558)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- TOC entry 2239 (class 0 OID 0)
-- Dependencies: 174
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


SET search_path = elearning, pg_catalog;

--
-- TOC entry 1999 (class 2604 OID 69445)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY convention ALTER COLUMN id SET DEFAULT nextval('convention_id_seq'::regclass);


--
-- TOC entry 1998 (class 2604 OID 44983)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY detail ALTER COLUMN id SET DEFAULT nextval('detail_id_seq'::regclass);


--
-- TOC entry 1995 (class 2604 OID 44928)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY enrollment ALTER COLUMN id SET DEFAULT nextval('enrollment_id_seq'::regclass);


--
-- TOC entry 1994 (class 2604 OID 44910)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY kursus ALTER COLUMN id SET DEFAULT nextval('kursus_id_seq'::regclass);


--
-- TOC entry 1992 (class 2604 OID 44893)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY matakuliah ALTER COLUMN id SET DEFAULT nextval('matakuliah_id_seq'::regclass);


--
-- TOC entry 1997 (class 2604 OID 44962)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY pengumpulan ALTER COLUMN id SET DEFAULT nextval('pengumpulan_id_seq'::regclass);


--
-- TOC entry 1993 (class 2604 OID 44902)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY periode ALTER COLUMN id SET DEFAULT nextval('periode_id_seq'::regclass);


--
-- TOC entry 1991 (class 2604 OID 44877)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY posting ALTER COLUMN id SET DEFAULT nextval('posting_id_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 44946)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY tugas ALTER COLUMN id SET DEFAULT nextval('tugas_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 1989 (class 2604 OID 44628)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_role ALTER COLUMN id SET DEFAULT nextval('permission_role_id_seq'::regclass);


--
-- TOC entry 1990 (class 2604 OID 44648)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_user ALTER COLUMN id SET DEFAULT nextval('permission_user_id_seq'::regclass);


--
-- TOC entry 1988 (class 2604 OID 44609)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions ALTER COLUMN id SET DEFAULT nextval('permissions_id_seq'::regclass);


--
-- TOC entry 1987 (class 2604 OID 44599)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_user ALTER COLUMN id SET DEFAULT nextval('role_user_id_seq'::regclass);


--
-- TOC entry 1986 (class 2604 OID 44584)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- TOC entry 1985 (class 2604 OID 44563)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = elearning, pg_catalog;

--
-- TOC entry 2200 (class 0 OID 69442)
-- Dependencies: 204
-- Data for Name: convention; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY convention (id, "for", regex, created_at, updated_at, min, pesanmin, deskripsi) FROM stdin;
5	alias	(([A-Z])([a-z]+))+	2016-06-07 19:17:17	2016-06-07 19:17:17	3	Identifier terlalu singkat	UpperCamelCase
4	function	(([A-Z])([a-z]+))+	2016-06-02 14:40:54	2016-06-07 19:39:22	3	Identifier terlalu singkat	UpperCamelCase
7	enum	(([A-Z])([a-z]+))+	2016-06-07 19:52:28	2016-06-07 19:52:28	3	Identifier terlalu singkat	UpperCamelCase
9	classdatamember	(([a-z]+_)+)?([a-z]+)_	2016-06-07 22:29:40	2016-06-07 22:29:40	3	Identifier terlalu singkat	lowercase (wajib diakhiri dengan underscore)
10	namespace	([a-z]+)	2016-06-07 22:33:26	2016-06-07 22:33:26	3	Identifier terlalu singkat	lowercase
3	commonvariable	(([a-z]+_)+)?([a-z]+)	2016-06-02 14:39:31	2016-06-07 23:20:21	3	Identifier terlalu singkat	lowercase (underscore sbg tanda hubung diperbolehkan)
6	enumerator	(([A-Z]+_)+)?([A-Z]+)	2016-06-07 19:38:31	2016-06-07 23:20:35	3	Identifier terlalu singkat	UPPERCASE (underscore sbg tanda hubung diperbolehkan)
8	structdatamember	(([a-z]+_)+)?([a-z]+)	2016-06-07 22:28:59	2016-06-07 23:20:46	3	Identifier terlalu singkat	lowercase (underscore sbg tanda hubung diperbolehkan)
11	typedef	(([A-Z])([a-z]+))+	2016-06-08 08:14:49	2016-06-08 08:14:49	3	Identifier terlalu singkat	UpperCamelCase
12	constant	k(([A-Z])([a-z]+))+	2016-06-08 08:41:28	2016-06-08 08:41:28	3	Identifier terlalu singkat	UpperCamelCase (dengan prefix k)
14	classandstruct	(([A-Z])([a-z]+))+	2016-06-12 06:17:29	2016-06-12 06:17:29	3	Identifier terlalu singkat	UpperCamelCase
\.


--
-- TOC entry 2240 (class 0 OID 0)
-- Dependencies: 203
-- Name: convention_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('convention_id_seq', 14, true);


--
-- TOC entry 2198 (class 0 OID 44980)
-- Dependencies: 202
-- Data for Name: detail; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY detail (id, kumpul_id, durasi, errsyntax, errconvention, kode, created_at, updated_at) FROM stdin;
30	9	45	3	0	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 07:54:40	2016-06-12 07:54:40
31	9	48	0	0	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 07:55:44	2016-06-12 07:55:44
32	9	26	0	0	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 07:58:29	2016-06-12 07:58:29
33	10	60	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nint main() {\r\n    cout << "Hello World!" << endl;\r\n    return 0;\r\n}	2016-06-12 08:43:54	2016-06-12 08:43:54
34	9	43	0	0	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 09:00:38	2016-06-12 09:00:38
\.


--
-- TOC entry 2241 (class 0 OID 0)
-- Dependencies: 201
-- Name: detail_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('detail_id_seq', 34, true);


--
-- TOC entry 2192 (class 0 OID 44925)
-- Dependencies: 196
-- Data for Name: enrollment; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY enrollment (id, kursus_id, user_id, created_at, updated_at) FROM stdin;
19	10	2	2016-06-12 06:44:34	2016-06-12 06:44:34
20	10	3	2016-06-12 06:59:13	2016-06-12 06:59:13
21	12	3	2016-06-12 07:02:08	2016-06-12 07:02:08
22	12	2	2016-06-12 07:02:08	2016-06-12 07:02:08
\.


--
-- TOC entry 2242 (class 0 OID 0)
-- Dependencies: 195
-- Name: enrollment_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('enrollment_id_seq', 22, true);


--
-- TOC entry 2190 (class 0 OID 44907)
-- Dependencies: 194
-- Data for Name: kursus; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY kursus (id, periode_id, mk_id, nama, created_at, updated_at) FROM stdin;
10	3	3	Pemrograman Terstruktur A	2016-06-12 06:23:46	2016-06-12 06:23:46
12	3	4	Pemrograman Berorientasi Objek A	2016-06-12 07:02:00	2016-06-12 07:02:00
\.


--
-- TOC entry 2243 (class 0 OID 0)
-- Dependencies: 193
-- Name: kursus_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('kursus_id_seq', 12, true);


--
-- TOC entry 2186 (class 0 OID 44890)
-- Dependencies: 190
-- Data for Name: matakuliah; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY matakuliah (id, kode, nama, sks, kurikulum, created_at, updated_at) FROM stdin;
3	KI091302	Pemrograman Terstruktur	4	2014	2016-06-12 06:19:33	2016-06-12 06:19:33
4	KI091311	Pemrograman Berorientasi Objek	4	2014	2016-06-12 06:20:20	2016-06-12 06:20:20
\.


--
-- TOC entry 2244 (class 0 OID 0)
-- Dependencies: 189
-- Name: matakuliah_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('matakuliah_id_seq', 4, true);


--
-- TOC entry 2196 (class 0 OID 44959)
-- Dependencies: 200
-- Data for Name: pengumpulan; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY pengumpulan (id, enroll_id, tugas_id, totaldurasi, totalerrsyntax, totalerrconvention, des, final, created_at, updated_at) FROM stdin;
9	20	10	162	3	0	\N	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 07:54:40	2016-06-12 09:00:38
10	20	12	60	0	0	\N	#include<iostream>\r\nusing namespace std;\r\n\r\nint main() {\r\n    cout << "Hello World!" << endl;\r\n    return 0;\r\n}	2016-06-12 08:43:54	2016-06-12 08:43:54
\.


--
-- TOC entry 2245 (class 0 OID 0)
-- Dependencies: 199
-- Name: pengumpulan_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('pengumpulan_id_seq', 10, true);


--
-- TOC entry 2188 (class 0 OID 44899)
-- Dependencies: 192
-- Data for Name: periode; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY periode (id, nama, tahun, semester, mulai, selesai, created_at, updated_at) FROM stdin;
1	Semester Genap 2015/2016	2016	2	2016-02-08	2016-05-27	2016-04-22 17:30:18	2016-04-22 17:45:51
3	Semester Ganjil 2016/2017	2016	1	2016-09-05	2016-12-30	2016-04-23 06:31:08	2016-04-23 06:31:08
19	Semester Genap 2016/2017	2017	2	2016-02-01	2016-05-27	2016-05-04 16:28:16	2016-06-12 06:23:18
\.


--
-- TOC entry 2246 (class 0 OID 0)
-- Dependencies: 191
-- Name: periode_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('periode_id_seq', 20, true);


--
-- TOC entry 2184 (class 0 OID 44874)
-- Dependencies: 188
-- Data for Name: posting; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY posting (id, user_id, text, created_at, updated_at, judul) FROM stdin;
3	1	Selamat datang di Elearning. Selamat belajar.	2016-05-12 16:45:47	2016-06-11 19:28:12	Selamat Datang
6	1	Maaf atas ketidaknyamanan anda. Sistem akan segera dibangkitkan kembali sesegera mungkin.	2016-05-20 16:27:49	2016-06-11 19:42:42	Sistem Sedang Maintenance
7	1	Sistem telah selesai di-maintenance. Selamat beraktifitas.	2016-05-20 17:58:13	2016-06-11 19:43:31	Sistem Up
\.


--
-- TOC entry 2247 (class 0 OID 0)
-- Dependencies: 187
-- Name: posting_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('posting_id_seq', 7, true);


--
-- TOC entry 2194 (class 0 OID 44943)
-- Dependencies: 198
-- Data for Name: tugas; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY tugas (id, enroll_id, nama, wmulai, wselesai, des, jwb, created_at, updated_at) FROM stdin;
12	19	Fungsi Hello World!	2016-06-06 10:00:00	2016-06-08 23:55:00	Buatlah fungsi sederhana yang dapat mencetak kalimat "Hello World!" pada console.	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    Print();\r\n    return 0;\r\n}	2016-06-12 07:37:15	2016-06-12 07:37:15
10	19	Hello World!	2016-06-01 10:00:00	2016-06-03 23:55:00	Buatlah kode program sederhana yang bisa mencetak kalimat "Hello World!" pada console.	#include<iostream>\r\nusing namespace std;\r\n\r\nint main() {\r\n    cout << "Hello World!" << endl;\r\n    return 0;\r\n}	2016-06-12 07:12:21	2016-06-12 07:12:55
\.


--
-- TOC entry 2248 (class 0 OID 0)
-- Dependencies: 197
-- Name: tugas_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('tugas_id_seq', 14, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 2169 (class 0 OID 44555)
-- Dependencies: 173
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY migrations (migration, batch) FROM stdin;
2014_10_12_000000_create_users_table	1
2014_10_12_100000_create_password_resets_table	1
2015_02_07_172606_create_roles_table	1
2015_02_07_172633_create_role_user_table	1
2015_02_07_172649_create_permissions_table	1
2015_02_07_172657_create_permission_role_table	1
2015_02_17_152439_create_permission_user_table	1
\.


--
-- TOC entry 2172 (class 0 OID 44571)
-- Dependencies: 176
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY password_resets (email, token, created_at) FROM stdin;
admin@its.ac.id	03473469649752bc91d5b5c11580d4bd2bd1bc4410551aae84f36e5b2314fcd0	2016-04-03 15:56:15
\.


--
-- TOC entry 2180 (class 0 OID 44625)
-- Dependencies: 184
-- Data for Name: permission_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permission_role (id, permission_id, role_id, created_at, updated_at) FROM stdin;
37	89	36	2016-05-12 17:08:34	2016-05-12 17:08:34
38	90	36	2016-05-12 17:08:34	2016-05-12 17:08:34
39	91	36	2016-05-12 17:08:34	2016-05-12 17:08:34
40	92	36	2016-05-12 17:08:34	2016-05-12 17:08:34
41	93	36	2016-05-12 17:08:34	2016-05-12 17:08:34
42	94	36	2016-05-12 17:08:34	2016-05-12 17:08:34
43	95	36	2016-05-12 17:08:34	2016-05-12 17:08:34
44	96	37	2016-05-12 17:42:46	2016-05-12 17:42:46
45	97	37	2016-05-12 17:42:46	2016-05-12 17:42:46
46	98	37	2016-05-12 17:42:46	2016-05-12 17:42:46
47	99	37	2016-05-12 17:42:46	2016-05-12 17:42:46
48	100	37	2016-05-12 17:42:46	2016-05-12 17:42:46
49	101	37	2016-05-12 17:42:46	2016-05-12 17:42:46
50	102	37	2016-05-12 17:42:46	2016-05-12 17:42:46
65	117	41	2016-06-11 19:33:07	2016-06-11 19:33:07
66	118	41	2016-06-11 19:33:07	2016-06-11 19:33:07
67	119	41	2016-06-11 19:33:07	2016-06-11 19:33:07
68	120	41	2016-06-11 19:33:07	2016-06-11 19:33:07
69	121	41	2016-06-11 19:33:07	2016-06-11 19:33:07
70	122	41	2016-06-11 19:33:07	2016-06-11 19:33:07
71	123	41	2016-06-11 19:33:07	2016-06-11 19:33:07
\.


--
-- TOC entry 2249 (class 0 OID 0)
-- Dependencies: 183
-- Name: permission_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permission_role_id_seq', 71, true);


--
-- TOC entry 2182 (class 0 OID 44645)
-- Dependencies: 186
-- Data for Name: permission_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permission_user (id, permission_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2250 (class 0 OID 0)
-- Dependencies: 185
-- Name: permission_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permission_user_id_seq', 7, true);


--
-- TOC entry 2178 (class 0 OID 44606)
-- Dependencies: 182
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permissions (id, inherit_id, name, slug, description, created_at, updated_at) FROM stdin;
1	\N	role	{"create":true,"view":true,"update":true,"delete":true}	manage role permissions	2016-04-10 12:10:54	2016-04-10 12:10:54
2	\N	permission	{"create":true,"view":true,"update":true,"delete":true}	manage permission permissions	2016-04-10 12:11:59	2016-04-10 12:11:59
3	\N	user	{"create":true,"view":true,"update":true,"delete":true}	manage user permissions	2016-04-10 12:12:21	2016-04-10 12:12:21
4	\N	post	{"create":true,"view":true,"update":true,"delete":true}	manage post permissions	2016-04-10 12:13:01	2016-04-10 12:13:01
5	\N	quiz	{"create":true,"view":true,"update":true,"delete":true}	manage quiz permissions	2016-04-10 12:13:20	2016-04-10 12:13:20
7	\N	course	{"create":true,"view":true,"update":true,"delete":true}	manage course permissions	2016-04-10 12:16:05	2016-04-10 12:16:05
6	\N	answer	{"create":true,"delete":true,"update":true,"view":true}	manage answer permissions	2016-04-10 12:15:38	2016-05-21 18:11:31
101	6	answer.mhs	{"create":true,"delete":true,"update":true,"view":true}	manage answer permissions for mhs	2016-05-12 17:42:46	2016-05-22 14:16:59
102	7	course.mhs	{"create":false,"delete":false,"update":false,"view":true}	manage course permissions for mhs	2016-05-12 17:42:46	2016-05-22 14:16:59
99	4	post.mhs	{"create":false,"delete":false,"update":false,"view":false}	manage post permissions for mhs	2016-05-12 17:42:46	2016-05-22 14:16:59
117	1	role.dosen	{"create":false,"view":false,"update":false,"delete":false}	manage role permissions for dosen	2016-06-11 19:33:07	2016-06-11 19:33:07
118	2	permission.dosen	{"create":false,"view":false,"update":false,"delete":false}	manage permission permissions for dosen	2016-06-11 19:33:07	2016-06-11 19:33:07
119	3	user.dosen	{"create":false,"view":false,"update":false,"delete":false}	manage user permissions for dosen	2016-06-11 19:33:07	2016-06-11 19:33:07
120	4	post.dosen	{"create":false,"view":false,"update":false,"delete":false}	manage post permissions for dosen	2016-06-11 19:33:07	2016-06-11 19:33:07
121	5	quiz.dosen	{"create":false,"view":false,"update":false,"delete":false}	manage quiz permissions for dosen	2016-06-11 19:33:07	2016-06-11 19:33:07
122	7	course.dosen	{"create":false,"view":false,"update":false,"delete":false}	manage course permissions for dosen	2016-06-11 19:33:07	2016-06-11 19:33:07
123	6	answer.dosen	{"create":false,"view":false,"update":false,"delete":false}	manage answer permissions for dosen	2016-06-11 19:33:07	2016-06-11 19:33:07
96	1	role.mhs	{"create":false,"delete":false,"update":false,"view":false}	manage role permissions for mhs	2016-05-12 17:42:46	2016-05-12 17:43:09
97	2	permission.mhs	{"create":false,"delete":false,"update":false,"view":false}	manage permission permissions for mhs	2016-05-12 17:42:46	2016-05-12 17:43:09
98	3	user.mhs	{"create":false,"delete":false,"update":false,"view":false}	manage user permissions for mhs	2016-05-12 17:42:46	2016-05-12 17:43:09
100	5	quiz.mhs	{"create":false,"delete":false,"update":false,"view":false}	manage quiz permissions for mhs	2016-05-12 17:42:46	2016-05-12 17:43:09
92	4	post.admin	{"create":true,"delete":true,"update":true,"view":true}	manage post permissions for admin	2016-05-12 17:08:34	2016-05-12 17:45:33
91	3	user.admin	{"create":true,"delete":true,"update":true,"view":true}	manage user permissions for admin	2016-05-12 17:08:34	2016-05-12 17:45:33
94	6	answer.admin	{"create":true,"delete":true,"update":true,"view":true}	manage answer permissions for admin	2016-05-12 17:08:34	2016-05-22 14:16:12
95	7	course.admin	{"create":true,"delete":true,"update":true,"view":true}	manage course permissions for admin	2016-05-12 17:08:34	2016-05-22 14:16:12
93	5	quiz.admin	{"create":true,"delete":true,"update":true,"view":true}	manage quiz permissions for admin	2016-05-12 17:08:34	2016-05-22 14:16:12
89	1	role.admin	{"create":true,"delete":true,"update":true,"view":true}	manage role permissions for admin	2016-05-12 17:08:34	2016-05-12 17:08:58
90	2	permission.admin	{"create":true,"delete":true,"update":true,"view":true}	manage permission permissions for admin	2016-05-12 17:08:34	2016-05-12 17:08:58
\.


--
-- TOC entry 2251 (class 0 OID 0)
-- Dependencies: 181
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permissions_id_seq', 123, true);


--
-- TOC entry 2176 (class 0 OID 44596)
-- Dependencies: 180
-- Data for Name: role_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY role_user (id, role_id, user_id, created_at, updated_at) FROM stdin;
15	35	7	2016-05-12 14:43:22	2016-05-12 14:43:22
17	37	3	2016-05-12 17:47:08	2016-05-12 17:47:08
20	36	1	2016-05-21 10:30:39	2016-05-21 10:30:39
33	41	2	2016-06-12 06:44:18	2016-06-12 06:44:18
\.


--
-- TOC entry 2252 (class 0 OID 0)
-- Dependencies: 179
-- Name: role_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('role_user_id_seq', 33, true);


--
-- TOC entry 2174 (class 0 OID 44581)
-- Dependencies: 178
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roles (id, name, slug, description, created_at, updated_at) FROM stdin;
36	Administrator	admin	Administrator	2016-05-12 17:08:34	2016-05-12 17:08:34
37	Mahasiswa	mhs	Mahasiswa	2016-05-12 17:42:46	2016-05-12 17:42:46
41	Dosen	dosen	Dosen	2016-06-11 19:33:07	2016-06-11 19:33:07
\.


--
-- TOC entry 2253 (class 0 OID 0)
-- Dependencies: 177
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_id_seq', 41, true);


--
-- TOC entry 2171 (class 0 OID 44560)
-- Dependencies: 175
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, name, email, password, remember_token, created_at, updated_at) FROM stdin;
1	Administrator	admin@its.ac.id	$2y$10$T3zm5UqHrSBlvr9HqbhSw.mS6kTBqIWDEN3B1rCSaBlyx3kc/UKtK	Ty2efkOIogz9NGU8P6T4bVZsyv9leRBF4ZfZrnGslRKWY8SJ0UZT22T6FspT	2016-04-03 14:41:24	2016-06-12 21:52:24
3	Mahasiswa	mahasiswa@its.ac.id	$2y$10$hDUUO2LlMka9veSETQb.Me/9pdsvZpF94k407u4.XJUqSZoGhx4NK	79xVl4BRlidxmpUFn8KHx0e2NwaSyRF5shP1bA3q8etRNzMxCsijSdL262Lt	2016-04-10 12:02:16	2016-06-12 23:05:41
2	Dosen	dosen@its.ac.id	$2y$10$A9BZ1GR5aoiipOmTrgBVbeE/1/xPHHeG7aVibK8s97JACfvcj4ts2	yoxVayOdTYBPHekZK8R5lfeA4c9gaFirNiZM2fuekReswkqcPaFZoWcSDnVs	2016-04-10 12:01:33	2016-06-12 23:06:06
\.


--
-- TOC entry 2254 (class 0 OID 0)
-- Dependencies: 174
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 9, true);


SET search_path = elearning, pg_catalog;

--
-- TOC entry 2044 (class 2606 OID 44988)
-- Name: detail_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY detail
    ADD CONSTRAINT detail_pkey PRIMARY KEY (id);


--
-- TOC entry 2038 (class 2606 OID 44930)
-- Name: enrollment_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (id);


--
-- TOC entry 2036 (class 2606 OID 44912)
-- Name: kursus_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY kursus
    ADD CONSTRAINT kursus_pkey PRIMARY KEY (id);


--
-- TOC entry 2032 (class 2606 OID 44895)
-- Name: matakuliah_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY matakuliah
    ADD CONSTRAINT matakuliah_pkey PRIMARY KEY (id);


--
-- TOC entry 2042 (class 2606 OID 44967)
-- Name: pengumpulan_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pengumpulan
    ADD CONSTRAINT pengumpulan_pkey PRIMARY KEY (id);


--
-- TOC entry 2034 (class 2606 OID 44904)
-- Name: periode_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT periode_pkey PRIMARY KEY (id);


--
-- TOC entry 2046 (class 2606 OID 69447)
-- Name: pk_convention; Type: CONSTRAINT; Schema: elearning; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY convention
    ADD CONSTRAINT pk_convention PRIMARY KEY (id);


--
-- TOC entry 2030 (class 2606 OID 44882)
-- Name: posting_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY posting
    ADD CONSTRAINT posting_pkey PRIMARY KEY (id);


--
-- TOC entry 2040 (class 2606 OID 44951)
-- Name: tugas_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tugas
    ADD CONSTRAINT tugas_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2023 (class 2606 OID 44630)
-- Name: permission_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permission_role
    ADD CONSTRAINT permission_role_pkey PRIMARY KEY (id);


--
-- TOC entry 2027 (class 2606 OID 44650)
-- Name: permission_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permission_user
    ADD CONSTRAINT permission_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2019 (class 2606 OID 44614)
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2013 (class 2606 OID 44601)
-- Name: role_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role_user
    ADD CONSTRAINT role_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2007 (class 2606 OID 44591)
-- Name: roles_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_name_unique UNIQUE (name);


--
-- TOC entry 2009 (class 2606 OID 44589)
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2011 (class 2606 OID 44593)
-- Name: roles_slug_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_slug_unique UNIQUE (slug);


--
-- TOC entry 2001 (class 2606 OID 44570)
-- Name: users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 2003 (class 2606 OID 44568)
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2004 (class 1259 OID 44577)
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX password_resets_email_index ON password_resets USING btree (email);


--
-- TOC entry 2005 (class 1259 OID 44578)
-- Name: password_resets_token_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX password_resets_token_index ON password_resets USING btree (token);


--
-- TOC entry 2021 (class 1259 OID 44641)
-- Name: permission_role_permission_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX permission_role_permission_id_index ON permission_role USING btree (permission_id);


--
-- TOC entry 2024 (class 1259 OID 44642)
-- Name: permission_role_role_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX permission_role_role_id_index ON permission_role USING btree (role_id);


--
-- TOC entry 2025 (class 1259 OID 44651)
-- Name: permission_user_permission_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX permission_user_permission_id_index ON permission_user USING btree (permission_id);


--
-- TOC entry 2028 (class 1259 OID 44652)
-- Name: permission_user_user_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX permission_user_user_id_index ON permission_user USING btree (user_id);


--
-- TOC entry 2016 (class 1259 OID 44620)
-- Name: permissions_inherit_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX permissions_inherit_id_index ON permissions USING btree (inherit_id);


--
-- TOC entry 2017 (class 1259 OID 44621)
-- Name: permissions_name_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX permissions_name_index ON permissions USING btree (name);


--
-- TOC entry 2020 (class 1259 OID 44622)
-- Name: permissions_slug_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX permissions_slug_index ON permissions USING btree (slug);


--
-- TOC entry 2014 (class 1259 OID 44602)
-- Name: role_user_role_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX role_user_role_id_index ON role_user USING btree (role_id);


--
-- TOC entry 2015 (class 1259 OID 44603)
-- Name: role_user_user_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX role_user_user_id_index ON role_user USING btree (user_id);


SET search_path = elearning, pg_catalog;

--
-- TOC entry 2059 (class 2620 OID 61257)
-- Name: t_total; Type: TRIGGER; Schema: elearning; Owner: postgres
--

CREATE TRIGGER t_total AFTER INSERT OR UPDATE ON detail FOR EACH ROW EXECUTE PROCEDURE tf_gettotal();


--
-- TOC entry 2056 (class 2606 OID 44968)
-- Name: enroll_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY pengumpulan
    ADD CONSTRAINT enroll_id_foreign FOREIGN KEY (enroll_id) REFERENCES enrollment(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2055 (class 2606 OID 61248)
-- Name: enrollment_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY tugas
    ADD CONSTRAINT enrollment_id_foreign FOREIGN KEY (enroll_id) REFERENCES enrollment(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2053 (class 2606 OID 44931)
-- Name: kursus_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY enrollment
    ADD CONSTRAINT kursus_id_foreign FOREIGN KEY (kursus_id) REFERENCES kursus(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2051 (class 2606 OID 44913)
-- Name: mk_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY kursus
    ADD CONSTRAINT mk_id_foreign FOREIGN KEY (mk_id) REFERENCES matakuliah(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2058 (class 2606 OID 44989)
-- Name: pengumpulan_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY detail
    ADD CONSTRAINT pengumpulan_id_foreign FOREIGN KEY (kumpul_id) REFERENCES pengumpulan(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2052 (class 2606 OID 44918)
-- Name: periode_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY kursus
    ADD CONSTRAINT periode_id_foreign FOREIGN KEY (periode_id) REFERENCES periode(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2057 (class 2606 OID 44973)
-- Name: tugas_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY pengumpulan
    ADD CONSTRAINT tugas_id_foreign FOREIGN KEY (tugas_id) REFERENCES tugas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2054 (class 2606 OID 53056)
-- Name: user_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY enrollment
    ADD CONSTRAINT user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2050 (class 2606 OID 53061)
-- Name: user_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY posting
    ADD CONSTRAINT user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


SET search_path = public, pg_catalog;

--
-- TOC entry 2048 (class 2606 OID 44631)
-- Name: permission_role_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_role
    ADD CONSTRAINT permission_role_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE;


--
-- TOC entry 2049 (class 2606 OID 44636)
-- Name: permission_role_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_role
    ADD CONSTRAINT permission_role_role_id_foreign FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE;


--
-- TOC entry 2047 (class 2606 OID 44615)
-- Name: permissions_inherit_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_inherit_id_foreign FOREIGN KEY (inherit_id) REFERENCES permissions(id);


--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = elearning, pg_catalog;

--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 202
-- Name: detail; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE detail FROM PUBLIC;
REVOKE ALL ON TABLE detail FROM postgres;
GRANT ALL ON TABLE detail TO postgres;
GRANT ALL ON TABLE detail TO PUBLIC;


--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 196
-- Name: enrollment; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE enrollment FROM PUBLIC;
REVOKE ALL ON TABLE enrollment FROM postgres;
GRANT ALL ON TABLE enrollment TO postgres;
GRANT ALL ON TABLE enrollment TO PUBLIC;


--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 194
-- Name: kursus; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE kursus FROM PUBLIC;
REVOKE ALL ON TABLE kursus FROM postgres;
GRANT ALL ON TABLE kursus TO postgres;
GRANT ALL ON TABLE kursus TO PUBLIC;


--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 190
-- Name: matakuliah; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE matakuliah FROM PUBLIC;
REVOKE ALL ON TABLE matakuliah FROM postgres;
GRANT ALL ON TABLE matakuliah TO postgres;
GRANT ALL ON TABLE matakuliah TO PUBLIC;


--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 200
-- Name: pengumpulan; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE pengumpulan FROM PUBLIC;
REVOKE ALL ON TABLE pengumpulan FROM postgres;
GRANT ALL ON TABLE pengumpulan TO postgres;
GRANT ALL ON TABLE pengumpulan TO PUBLIC;


--
-- TOC entry 2220 (class 0 OID 0)
-- Dependencies: 192
-- Name: periode; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE periode FROM PUBLIC;
REVOKE ALL ON TABLE periode FROM postgres;
GRANT ALL ON TABLE periode TO postgres;
GRANT ALL ON TABLE periode TO PUBLIC;


--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 188
-- Name: posting; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE posting FROM PUBLIC;
REVOKE ALL ON TABLE posting FROM postgres;
GRANT ALL ON TABLE posting TO postgres;
GRANT ALL ON TABLE posting TO PUBLIC;


--
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 198
-- Name: tugas; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE tugas FROM PUBLIC;
REVOKE ALL ON TABLE tugas FROM postgres;
GRANT ALL ON TABLE tugas TO postgres;
GRANT ALL ON TABLE tugas TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 173
-- Name: migrations; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE migrations FROM PUBLIC;
REVOKE ALL ON TABLE migrations FROM postgres;
GRANT ALL ON TABLE migrations TO postgres;
GRANT ALL ON TABLE migrations TO PUBLIC;


--
-- TOC entry 2227 (class 0 OID 0)
-- Dependencies: 176
-- Name: password_resets; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE password_resets FROM PUBLIC;
REVOKE ALL ON TABLE password_resets FROM postgres;
GRANT ALL ON TABLE password_resets TO postgres;
GRANT ALL ON TABLE password_resets TO PUBLIC;


--
-- TOC entry 2228 (class 0 OID 0)
-- Dependencies: 184
-- Name: permission_role; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE permission_role FROM PUBLIC;
REVOKE ALL ON TABLE permission_role FROM postgres;
GRANT ALL ON TABLE permission_role TO postgres;
GRANT ALL ON TABLE permission_role TO PUBLIC;


--
-- TOC entry 2230 (class 0 OID 0)
-- Dependencies: 186
-- Name: permission_user; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE permission_user FROM PUBLIC;
REVOKE ALL ON TABLE permission_user FROM postgres;
GRANT ALL ON TABLE permission_user TO postgres;
GRANT ALL ON TABLE permission_user TO PUBLIC;


--
-- TOC entry 2232 (class 0 OID 0)
-- Dependencies: 182
-- Name: permissions; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE permissions FROM PUBLIC;
REVOKE ALL ON TABLE permissions FROM postgres;
GRANT ALL ON TABLE permissions TO postgres;
GRANT ALL ON TABLE permissions TO PUBLIC;


--
-- TOC entry 2234 (class 0 OID 0)
-- Dependencies: 180
-- Name: role_user; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE role_user FROM PUBLIC;
REVOKE ALL ON TABLE role_user FROM postgres;
GRANT ALL ON TABLE role_user TO postgres;
GRANT ALL ON TABLE role_user TO PUBLIC;


--
-- TOC entry 2236 (class 0 OID 0)
-- Dependencies: 178
-- Name: roles; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE roles FROM PUBLIC;
REVOKE ALL ON TABLE roles FROM postgres;
GRANT ALL ON TABLE roles TO postgres;
GRANT ALL ON TABLE roles TO PUBLIC;


--
-- TOC entry 2238 (class 0 OID 0)
-- Dependencies: 175
-- Name: users; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM postgres;
GRANT ALL ON TABLE users TO postgres;
GRANT ALL ON TABLE users TO PUBLIC;


-- Completed on 2016-06-13 06:07:39

--
-- PostgreSQL database dump complete
--

