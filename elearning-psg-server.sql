--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.10
-- Dumped by pg_dump version 9.5.6

-- Started on 2017-02-10 09:46:00

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 57345)
-- Name: elearning; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA elearning;


ALTER SCHEMA elearning OWNER TO postgres;

--
-- TOC entry 1 (class 3079 OID 11787)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2223 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = elearning, pg_catalog;

--
-- TOC entry 221 (class 1255 OID 57346)
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
-- TOC entry 172 (class 1259 OID 57347)
-- Name: convention; Type: TABLE; Schema: elearning; Owner: postgres
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
-- TOC entry 173 (class 1259 OID 57353)
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
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 173
-- Name: convention_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE convention_id_seq OWNED BY convention.id;


--
-- TOC entry 174 (class 1259 OID 57355)
-- Name: detail; Type: TABLE; Schema: elearning; Owner: postgres
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
-- TOC entry 175 (class 1259 OID 57361)
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
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 175
-- Name: detail_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE detail_id_seq OWNED BY detail.id;


--
-- TOC entry 176 (class 1259 OID 57363)
-- Name: enrollment; Type: TABLE; Schema: elearning; Owner: postgres
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
-- TOC entry 177 (class 1259 OID 57366)
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
-- TOC entry 2228 (class 0 OID 0)
-- Dependencies: 177
-- Name: enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE enrollment_id_seq OWNED BY enrollment.id;


--
-- TOC entry 178 (class 1259 OID 57368)
-- Name: kursus; Type: TABLE; Schema: elearning; Owner: postgres
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
-- TOC entry 179 (class 1259 OID 57371)
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
-- TOC entry 2230 (class 0 OID 0)
-- Dependencies: 179
-- Name: kursus_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE kursus_id_seq OWNED BY kursus.id;


--
-- TOC entry 180 (class 1259 OID 57373)
-- Name: matakuliah; Type: TABLE; Schema: elearning; Owner: postgres
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
-- TOC entry 181 (class 1259 OID 57376)
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
-- TOC entry 2232 (class 0 OID 0)
-- Dependencies: 181
-- Name: matakuliah_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE matakuliah_id_seq OWNED BY matakuliah.id;


--
-- TOC entry 182 (class 1259 OID 57378)
-- Name: pengumpulan; Type: TABLE; Schema: elearning; Owner: postgres
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
-- TOC entry 183 (class 1259 OID 57384)
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
-- TOC entry 2234 (class 0 OID 0)
-- Dependencies: 183
-- Name: pengumpulan_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE pengumpulan_id_seq OWNED BY pengumpulan.id;


--
-- TOC entry 184 (class 1259 OID 57386)
-- Name: periode; Type: TABLE; Schema: elearning; Owner: postgres
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
-- TOC entry 185 (class 1259 OID 57389)
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
-- TOC entry 2236 (class 0 OID 0)
-- Dependencies: 185
-- Name: periode_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE periode_id_seq OWNED BY periode.id;


--
-- TOC entry 186 (class 1259 OID 57391)
-- Name: posting; Type: TABLE; Schema: elearning; Owner: postgres
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
-- TOC entry 187 (class 1259 OID 57397)
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
-- TOC entry 2238 (class 0 OID 0)
-- Dependencies: 187
-- Name: posting_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE posting_id_seq OWNED BY posting.id;


--
-- TOC entry 188 (class 1259 OID 57399)
-- Name: tugas; Type: TABLE; Schema: elearning; Owner: postgres
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
-- TOC entry 189 (class 1259 OID 57405)
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
-- TOC entry 2240 (class 0 OID 0)
-- Dependencies: 189
-- Name: tugas_id_seq; Type: SEQUENCE OWNED BY; Schema: elearning; Owner: postgres
--

ALTER SEQUENCE tugas_id_seq OWNED BY tugas.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 190 (class 1259 OID 57407)
-- Name: db_sequence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE db_sequence (
    id_seq character varying(255) NOT NULL,
    extension character varying(255),
    file_name character varying(255),
    hashcode character varying(255),
    kelas character varying(255),
    kode_soal character varying(255),
    last_modified character varying(255),
    level_sequence text,
    nrp character varying(255),
    path character varying(255),
    sequence text,
    size double precision NOT NULL
);


ALTER TABLE db_sequence OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 57413)
-- Name: db_similarity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE db_similarity (
    id_sim character varying(255) NOT NULL,
    id1 character varying(255),
    id2 character varying(255),
    kelas character varying(255),
    kode_soal character varying(255),
    levenshtein_similarity double precision NOT NULL,
    similarity_value double precision NOT NULL
);


ALTER TABLE db_similarity OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 57419)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE migrations (
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE migrations OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 57422)
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE password_resets OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 57428)
-- Name: permission_role; Type: TABLE; Schema: public; Owner: postgres
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
-- TOC entry 195 (class 1259 OID 57431)
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
-- TOC entry 2244 (class 0 OID 0)
-- Dependencies: 195
-- Name: permission_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permission_role_id_seq OWNED BY permission_role.id;


--
-- TOC entry 196 (class 1259 OID 57433)
-- Name: permission_user; Type: TABLE; Schema: public; Owner: postgres
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
-- TOC entry 197 (class 1259 OID 57436)
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
-- TOC entry 2246 (class 0 OID 0)
-- Dependencies: 197
-- Name: permission_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permission_user_id_seq OWNED BY permission_user.id;


--
-- TOC entry 198 (class 1259 OID 57438)
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
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
-- TOC entry 199 (class 1259 OID 57444)
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
-- TOC entry 2248 (class 0 OID 0)
-- Dependencies: 199
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;


--
-- TOC entry 200 (class 1259 OID 57446)
-- Name: role_user; Type: TABLE; Schema: public; Owner: postgres
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
-- TOC entry 201 (class 1259 OID 57449)
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
-- TOC entry 2250 (class 0 OID 0)
-- Dependencies: 201
-- Name: role_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE role_user_id_seq OWNED BY role_user.id;


--
-- TOC entry 202 (class 1259 OID 57451)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
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
-- TOC entry 203 (class 1259 OID 57457)
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
-- TOC entry 2252 (class 0 OID 0)
-- Dependencies: 203
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- TOC entry 204 (class 1259 OID 57459)
-- Name: sc_dosen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sc_dosen (
    id_seq_dosen character varying(255) NOT NULL,
    extension character varying(255),
    file_name character varying(255),
    hashcode character varying(255),
    kelas character varying(255),
    kodesoal character varying(255),
    last_modified character varying(255),
    level_seq text,
    line text,
    path text,
    sequence text,
    size double precision NOT NULL
);


ALTER TABLE sc_dosen OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 57465)
-- Name: sc_sequence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sc_sequence (
    id_seq_mhs character varying(255) NOT NULL,
    extension_mhs character varying(255),
    file_name_mhs character varying(255),
    hashcode_mhs character varying(255),
    kelas_mhs character varying(255),
    kodesoal character varying(255),
    last_modified_mhs character varying(255),
    level_mhs text,
    line_mhs text,
    nrp_mhs character varying(255),
    path_mhs text,
    sequence_mhs text,
    size_mhs double precision NOT NULL
);


ALTER TABLE sc_sequence OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 57471)
-- Name: sc_similarity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sc_similarity (
    id_similarity character varying(255) NOT NULL,
    file_dosen character varying(255),
    nrp character varying(255),
    similarity_value_modif double precision NOT NULL,
    similarity_value_smith double precision NOT NULL,
    kelas character varying(255),
    kodesoal character varying(255)
);


ALTER TABLE sc_similarity OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 57477)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    nomorinduk character varying(50)
);


ALTER TABLE users OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 57483)
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
-- TOC entry 2254 (class 0 OID 0)
-- Dependencies: 208
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


SET search_path = elearning, pg_catalog;

--
-- TOC entry 1987 (class 2604 OID 57485)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY convention ALTER COLUMN id SET DEFAULT nextval('convention_id_seq'::regclass);


--
-- TOC entry 1988 (class 2604 OID 57486)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY detail ALTER COLUMN id SET DEFAULT nextval('detail_id_seq'::regclass);


--
-- TOC entry 1989 (class 2604 OID 57487)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY enrollment ALTER COLUMN id SET DEFAULT nextval('enrollment_id_seq'::regclass);


--
-- TOC entry 1990 (class 2604 OID 57488)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY kursus ALTER COLUMN id SET DEFAULT nextval('kursus_id_seq'::regclass);


--
-- TOC entry 1991 (class 2604 OID 57489)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY matakuliah ALTER COLUMN id SET DEFAULT nextval('matakuliah_id_seq'::regclass);


--
-- TOC entry 1992 (class 2604 OID 57490)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY pengumpulan ALTER COLUMN id SET DEFAULT nextval('pengumpulan_id_seq'::regclass);


--
-- TOC entry 1993 (class 2604 OID 57491)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY periode ALTER COLUMN id SET DEFAULT nextval('periode_id_seq'::regclass);


--
-- TOC entry 1994 (class 2604 OID 57492)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY posting ALTER COLUMN id SET DEFAULT nextval('posting_id_seq'::regclass);


--
-- TOC entry 1995 (class 2604 OID 57493)
-- Name: id; Type: DEFAULT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY tugas ALTER COLUMN id SET DEFAULT nextval('tugas_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 1996 (class 2604 OID 57494)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_role ALTER COLUMN id SET DEFAULT nextval('permission_role_id_seq'::regclass);


--
-- TOC entry 1997 (class 2604 OID 57495)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_user ALTER COLUMN id SET DEFAULT nextval('permission_user_id_seq'::regclass);


--
-- TOC entry 1998 (class 2604 OID 57496)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions ALTER COLUMN id SET DEFAULT nextval('permissions_id_seq'::regclass);


--
-- TOC entry 1999 (class 2604 OID 57497)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_user ALTER COLUMN id SET DEFAULT nextval('role_user_id_seq'::regclass);


--
-- TOC entry 2000 (class 2604 OID 57498)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- TOC entry 2001 (class 2604 OID 57499)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = elearning, pg_catalog;

--
-- TOC entry 2179 (class 0 OID 57347)
-- Dependencies: 172
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
15	classandstruct	(([A-Z])([a-z]+))+	2016-06-18 06:29:13	2016-06-18 06:29:13	3	Identifier terlalu singkat	UpperCamelCase
\.


--
-- TOC entry 2255 (class 0 OID 0)
-- Dependencies: 173
-- Name: convention_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('convention_id_seq', 19, true);


--
-- TOC entry 2181 (class 0 OID 57355)
-- Dependencies: 174
-- Data for Name: detail; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY detail (id, kumpul_id, durasi, errsyntax, errconvention, kode, created_at, updated_at) FROM stdin;
30	9	45	3	0	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 07:54:40	2016-06-12 07:54:40
31	9	48	0	0	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 07:55:44	2016-06-12 07:55:44
32	9	26	0	0	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 07:58:29	2016-06-12 07:58:29
33	10	60	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nint main() {\r\n    cout << "Hello World!" << endl;\r\n    return 0;\r\n}	2016-06-12 08:43:54	2016-06-12 08:43:54
34	9	43	0	0	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 09:00:38	2016-06-12 09:00:38
36	12	6	1	0	hehe	2016-06-16 05:36:32	2016-06-16 05:36:32
37	12	6	1	0	hehe	2016-06-16 05:38:53	2016-06-16 05:38:53
38	12	2	1	0	hehe	2016-06-16 05:45:05	2016-06-16 05:45:05
39	12	5	1	0	hehehoho	2016-06-16 05:48:45	2016-06-16 05:48:45
40	12	7	1	0	ehe	2016-06-16 06:11:37	2016-06-16 06:11:37
41	12	10	0	0	#include<iostream>	2016-06-16 06:33:17	2016-06-16 06:33:17
42	10	2	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nint main() {\r\n    cout << "Hello World!" << endl;\r\n    return 0;\r\n}	2016-06-17 19:35:42	2016-06-17 19:35:42
43	10	2	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nint main() {\r\n    cout << "Hello World!" << endl;\r\n    return 0;\r\n}	2016-06-17 19:36:34	2016-06-17 19:36:34
44	13	39	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int a = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 06:41:16	2016-06-18 06:41:16
45	13	92	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int ahh = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 06:43:26	2016-06-18 06:43:26
46	14	51	0	2	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int a = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 07:18:39	2016-06-18 07:18:39
47	14	109	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int aaaa = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 07:21:47	2016-06-18 07:21:47
48	15	40	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int a = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 13:50:44	2016-06-18 13:50:44
49	15	113	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int ans = 2;\r\n    Print();\r\n    return 0;\r\n}	2016-06-18 13:53:03	2016-06-18 13:53:03
50	16	50	0	2	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int a = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 14:42:13	2016-06-18 14:42:13
51	16	105	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int aku = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 14:45:11	2016-06-18 14:45:11
52	17	32	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int a = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 20:51:57	2016-06-18 20:51:57
53	17	85	0	0	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int abc = 2;\r\n    Print();\r\n    return 0;\r\n}	2016-06-18 20:53:48	2016-06-18 20:53:48
\.


--
-- TOC entry 2256 (class 0 OID 0)
-- Dependencies: 175
-- Name: detail_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('detail_id_seq', 53, true);


--
-- TOC entry 2183 (class 0 OID 57363)
-- Dependencies: 176
-- Data for Name: enrollment; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY enrollment (id, kursus_id, user_id, created_at, updated_at) FROM stdin;
19	10	2	2016-06-12 06:44:34	2016-06-12 06:44:34
20	10	3	2016-06-12 06:59:13	2016-06-12 06:59:13
21	12	3	2016-06-12 07:02:08	2016-06-12 07:02:08
22	12	2	2016-06-12 07:02:08	2016-06-12 07:02:08
29	18	3	2016-06-16 05:32:30	2016-06-16 05:32:30
30	18	2	2016-06-16 05:32:30	2016-06-16 05:32:30
31	10	10	2016-06-18 06:33:14	2016-06-18 06:33:14
32	10	11	2016-06-18 07:12:24	2016-06-18 07:12:24
33	10	12	2016-06-18 13:45:04	2016-06-18 13:45:04
34	10	13	2016-06-18 14:35:05	2016-06-18 14:35:05
35	10	14	2016-06-18 20:48:20	2016-06-18 20:48:20
36	24	2	2016-06-20 05:51:40	2016-06-20 05:51:40
\.


--
-- TOC entry 2257 (class 0 OID 0)
-- Dependencies: 177
-- Name: enrollment_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('enrollment_id_seq', 37, true);


--
-- TOC entry 2185 (class 0 OID 57368)
-- Dependencies: 178
-- Data for Name: kursus; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY kursus (id, periode_id, mk_id, nama, created_at, updated_at) FROM stdin;
12	3	4	Pemrograman Berorientasi Objek A	2016-06-12 07:02:00	2016-06-12 07:02:00
18	3	3	Pemrograman Terstruktur B	2016-06-16 05:32:18	2016-06-16 05:32:18
24	1	4	PBO C	2016-06-20 05:51:24	2016-06-20 05:51:24
10	3	4	PBO E	2016-06-12 06:23:46	2016-06-20 13:16:59
\.


--
-- TOC entry 2258 (class 0 OID 0)
-- Dependencies: 179
-- Name: kursus_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('kursus_id_seq', 24, true);


--
-- TOC entry 2187 (class 0 OID 57373)
-- Dependencies: 180
-- Data for Name: matakuliah; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY matakuliah (id, kode, nama, sks, kurikulum, created_at, updated_at) FROM stdin;
3	KI091302	Pemrograman Terstruktur	4	2014	2016-06-12 06:19:33	2016-06-12 06:19:33
4	KI091311	Pemrograman Berorientasi Objek	4	2014	2016-06-12 06:20:20	2016-06-12 06:20:20
\.


--
-- TOC entry 2259 (class 0 OID 0)
-- Dependencies: 181
-- Name: matakuliah_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('matakuliah_id_seq', 4, true);


--
-- TOC entry 2189 (class 0 OID 57378)
-- Dependencies: 182
-- Data for Name: pengumpulan; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY pengumpulan (id, enroll_id, tugas_id, totaldurasi, totalerrsyntax, totalerrconvention, des, final, created_at, updated_at) FROM stdin;
14	32	12	160	0	2	\N	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int aaaa = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 07:18:39	2016-06-18 07:21:47
12	29	17	36	5	0	\N	#include<iostream>	2016-06-16 05:36:32	2016-06-16 06:33:17
9	20	10	162	3	0	\N	#include<stdio.h>\r\n\r\nint main() {\r\n    printf("Hello World!");\r\n    return 0;\r\n}	2016-06-12 07:54:40	2016-06-12 09:00:38
17	35	12	117	0	0	\N	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int abc = 2;\r\n    Print();\r\n    return 0;\r\n}	2016-06-18 20:51:57	2016-06-18 20:53:48
10	20	12	64	0	0	\N	#include<iostream>\r\nusing namespace std;\r\n\r\nint main() {\r\n    cout << "Hello World!" << endl;\r\n    return 0;\r\n}	2016-06-12 08:43:54	2016-06-17 19:36:34
15	33	12	153	0	0	\N	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int ans = 2;\r\n    Print();\r\n    return 0;\r\n}	2016-06-18 13:50:44	2016-06-18 13:53:03
13	31	12	131	0	0	\N	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int ahh = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 06:41:15	2016-06-18 06:43:26
16	34	12	155	0	2	\N	#include<iostream>\r\nusing namespace std;\r\n\r\nvoid Print() {\r\n    cout << "Hello World!" << endl;\r\n}\r\n\r\nint main() {\r\n    int aku = 2;\r\n    print();\r\n    return 0;\r\n}	2016-06-18 14:42:13	2016-06-18 14:45:11
\.


--
-- TOC entry 2260 (class 0 OID 0)
-- Dependencies: 183
-- Name: pengumpulan_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('pengumpulan_id_seq', 17, true);


--
-- TOC entry 2191 (class 0 OID 57386)
-- Dependencies: 184
-- Data for Name: periode; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY periode (id, nama, tahun, semester, mulai, selesai, created_at, updated_at) FROM stdin;
1	Semester Genap 2015/2016	2016	2	2016-02-08	2016-05-27	2016-04-22 17:30:18	2016-04-22 17:45:51
3	Semester Ganjil 2016/2017	2016	1	2016-09-05	2016-12-30	2016-04-23 06:31:08	2016-04-23 06:31:08
19	Semester Genap 2016/2017	2017	2	2016-02-01	2016-05-27	2016-05-04 16:28:16	2016-06-12 06:23:18
\.


--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 185
-- Name: periode_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('periode_id_seq', 20, true);


--
-- TOC entry 2193 (class 0 OID 57391)
-- Dependencies: 186
-- Data for Name: posting; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY posting (id, user_id, text, created_at, updated_at, judul) FROM stdin;
3	1	Selamat datang di Elearning. Selamat belajar.	2016-05-12 16:45:47	2016-06-11 19:28:12	Selamat Datang
6	1	Maaf atas ketidaknyamanan anda. Sistem akan segera dibangkitkan kembali sesegera mungkin.	2016-05-20 16:27:49	2016-06-11 19:42:42	Sistem Sedang Maintenance
7	1	Sistem telah selesai di-maintenance. Selamat beraktifitas.	2016-05-20 17:58:13	2016-06-11 19:43:31	Sistem Up
8	1	ELearning bisa diakses melalui 10.151.44.20/elearning/public	2016-06-20 13:05:55	2016-06-20 13:09:13	ELearning Live
\.


--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 187
-- Name: posting_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('posting_id_seq', 8, true);


--
-- TOC entry 2195 (class 0 OID 57399)
-- Dependencies: 188
-- Data for Name: tugas; Type: TABLE DATA; Schema: elearning; Owner: postgres
--

COPY tugas (id, enroll_id, nama, wmulai, wselesai, des, jwb, created_at, updated_at) FROM stdin;
17	30	Penugasan Modular	2016-06-16 00:00:00	2016-06-16 23:59:00	Penugasan Modular	#include<stdio.h>\r\n\r\nmain() {\r\n    int coba;\r\n    return 0;\r\n}	2016-06-16 05:34:53	2016-06-16 19:36:25
10	19	Hello World!	2016-06-01 10:00:00	2016-06-03 23:55:00	Buatlah kode program sederhana yang bisa mencetak kalimat "Hello World!" pada console.	#include<iostream>\r\nusing namespace std;\r\n\r\nint main() {\r\n    cout << "Hello World!" << endl;\r\n    return 0;\r\n}	2016-06-12 07:12:21	2016-06-12 07:12:55
24	36	Bouncing Ball	2016-06-20 00:00:00	2016-06-20 23:59:00	Buatlah animasi bouncing		2016-06-20 05:52:51	2016-06-20 05:52:51
12	19	Class Account	2016-06-06 10:00:00	2016-06-08 23:55:00	Buatlah implementasi dan contoh sederhana penggunaan dari kelas	#include<cstdio>\r\n#include <cstdlib>\r\n#include <iostream>\r\n \r\nusing namespace std;\r\n \r\n//membuat Account class\r\nclass Account\r\n{\r\n\tpublic:\r\n\t\tAccount(int initialBalance)\r\n   \t\t{\r\n      \t\tif (initialBalance<0)\r\n  \t\t\t{\r\n     \t\t\tbalance=0;\r\n     \t\t\tcout << "Account balance is invalid" << endl;\r\n   \t\t\t} else setBalance(initialBalance);\r\n\t\t}\r\n\t\t\r\n\t\tvoid setBalance(int initialBalance)\r\n  \t\t{\r\n \t\t\t balance=initialBalance;\r\n\t\t}\r\n  \t\t\r\n\t\tint debit(int debitAmount)\r\n  \t\t{\r\n  \t\t\tif (debitAmount>balance) cout<<"Your balance is not enough.."<<endl; \r\n\t\t\t  else balance-=debitAmount;\r\n\t\t}\r\n  \t\t\r\n\t\tint credit(int creditAmount)\r\n  \t\t{\r\n  \t\t\tbalance+=creditAmount;\r\n\t\t}\r\n\t\t\r\n\t\tint getBalance()\r\n\t\t{\r\n\t\t\treturn balance;\r\n\t\t}  \t\t\r\n\t\r\n\tprivate:\r\n  \t\tint balance;\r\n};\r\n\r\nint main()\r\n{\r\nreturn 0;\r\n}	2016-06-12 07:37:15	2016-06-20 13:19:50
25	36	Header Ball	2016-06-27 00:00:00	2016-06-27 23:59:00	Header Ball		2016-06-27 13:46:04	2016-06-27 13:46:04
26	36	Tamagochi	2016-06-27 00:00:00	2016-06-27 23:59:00	Tamagochi		2016-06-27 13:46:17	2016-06-27 13:46:17
13	19	Single Invoice	2016-06-27 00:00:00	2016-06-27 00:00:00	Single Invoice		\N	\N
\.


--
-- TOC entry 2263 (class 0 OID 0)
-- Dependencies: 189
-- Name: tugas_id_seq; Type: SEQUENCE SET; Schema: elearning; Owner: postgres
--

SELECT pg_catalog.setval('tugas_id_seq', 26, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 2197 (class 0 OID 57407)
-- Dependencies: 190
-- Data for Name: db_sequence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY db_sequence (id_seq, extension, file_name, hashcode, kelas, kode_soal, last_modified, level_sequence, nrp, path, sequence, size) FROM stdin;
ff808181559758460155975846d70000	cpp	Circle.cpp	-635500370	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 2 2 2 3 4 4 4 4 3 3 4 4 3 3 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 3 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 4 4 4 4 3 3 3 5 6 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 8 7 7 8 8 8 7 7 7 9 10 10 10 9 9 10 10 10 9 9 10 10 10 9 9 10 10 10 9 9 10 10 10 9 9 9 11 12 12 12 11 11 12 12 12 11 11 12 12 12 11 11 11 13 14 14 14 13 13 14 14 14 13 13 14 14 14 13 13 13 15 16 16 16 15 15 16 16 16 15 15 16 16 16 15 15 15 17 18 18 18 17 17 18 18 18 17 17 18 18 18 17 17 18 18 18 17 17 18 18 18 17 17 17 19 20 20 20 19 19 20 20 20 19 19 20 20 20 19 19 19 21 22 22 22 21 21 22 22 22 21 21 22 22 22 21 21 22 22 22 21 21 22 22 22 21 21 21 23 24 24 24 23 23 24 24 24 23 23 24 24 24 23 23 23 25 26 26 26 25 25 26 26 26 25 25 26 26 26 25 25 25 27 28 28 28 27 27 28 28 28 27 27 28 28 28 27 27 28 28 28 27 27 28 28 28 27 27 27 29 30 30 30 29 29 30 30 30 29 29 30 30 30 29 27 25 23 21 19 17 15 13 11 9 7 5 3 2 1 0 @	5113100091	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100091--Circle.cpp	A ( C ( B:Circle D ( B:int B:int ) E ( ( =V =% =VO =30 ) ( =V =V ) ( =V =V ) ( =V =% =VO =255 ) ( =V =% =VO =255 ) ( =V =% =VO =255 ) ( =V =% =VO =10 ) ( =V =% =VO =10 ) ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( ) E ( ( +=V +=V ) ( +=V +=V ) ) ) ) A ( C ( B:void D ( ) E ( B:int B:int B:int B:int ( =V =V ) ( =V =V ) ( =V =500 ) ( =V =300 ) H:if ( ( J+ J> J|| J- J< JV JV JV JV JV J0 ) ( *=V *=- *=1 ) ) H:if ( ( J+ J> J|| J- J< JV JV JV JV JV J0 ) ( *=V *=- *=1 ) ) ) ) ) A ( C ( B:void D ( B:Circle* ) E ( B:int ( =V ) B:int ( =V-> ) B:int ( =V ) B:int ( =V-> ) B:int ( =- =V =V ) B:int ( =- =V =V ) B:float ( =* =+ =* =V =V =V =V ) ( =V =VO =PVO =PV ) H:if ( ( J< J+ JV JV JV-> ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) @	2470
ff808181559758460155975847950001	cpp	Ball.cpp	-457934201	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100187	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100187--Ball.cpp	A ( C ( B:void D ( B:wxDc* ) E ( V->O PV V->O Pthis-> ( =V =+ =V =V ) ( =V =+ =V =V ) ( =V =VO =PV =PV =PV ) ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	797
ff808181559758460155975847db0002	cpp	Bounce.cpp	-1310382964	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 2 2 2 3 4 3 3 4 3 3 4 4 3 3 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 4 4 4 4 3 3 4 4 4 4 3 2 1 0 @	5113100020	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100020--Bounce.cpp	A ( C ( B:Bounce D ( B:float B:float ) E ( ( =this-> ) ( =this-> ) ( =V =20 ) ( =V =10 ) ( =V =10 ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Bounce* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) A ( C ( B:void D ( ) E ( ( =V =+ =V =V ) ( =V =+ =V =V ) ) ) ) @	755
ff808181559758460155975848140003	cpp	ballball.cpp	-105970687	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100050	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100050--ballball.cpp	A ( C ( B:Bounce D ( ) E ( ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDc* ) E ( V->O PV V->O Pthis-> ( =V =+ =V =V ) ( =V =+ =V =V ) ( =V =VO =PV =PV =PV ) ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	943
ff808181559758460155975848440004	cpp	Ball.cpp	-498256242	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 3 3 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100009	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100009--Ball.cpp	A ( C ( B:Ball D ( ) E ( ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =* =V =V ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) A ( C ( B:void D ( B:wxDC* ) E ( V->O PV V->O Pthis-> ( =V =+ =V =V ) ( =V =+ =V =V ) V->O PV PV PV ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) @	830
ff8081815597584601559758487c0005	cpp	ball.cpp	-739994490	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 2 2 2 3 4 3 3 4 3 3 4 4 3 3 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 4 4 4 4 3 3 4 4 4 4 3 2 1 0 @	5113100012	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100012--ball.cpp	A ( C ( B:ball D ( B:float B:float ) E ( ( =this-> ) ( =this-> ) ( =V =20 ) ( =V =10 ) ( =V =10 ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) A ( C ( B:void D ( ) E ( ( =V =+ =V =V ) ( =V =+ =V =V ) ) ) ) @	743
ff808181559758460155975848be0006	cpp	bounce.cpp	363603385	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100119	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100119--bounce.cpp	A ( C ( B:Bounce D ( ) E ( ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDc* ) E ( V->O PV V->O Pthis-> ( =V =+ =V =V ) ( =V =+ =V =V ) ( =V =VO =PV =PV =PV ) ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	943
ff808181559758460155975848e80007	cpp	Ball.cpp	-101011253	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 3 3 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 5 3 2 1 0 @	5113100004	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100004--Ball.cpp	A ( C ( B:Ball D ( ) E ( ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDC* ) E ( V->O PV V->O Pthis-> ( =V =+ =* =V =0.5 =V ) ( =V =+ =V =V ) ( =V =+ =V =V ) V->O PV PV PV ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =* =V =V ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=1 ) ) ) ) ) @	820
ff8081815597584601559758492a0008	cpp	Ball.cpp	-1153298909	24	24	2016 05 17 19:45:52	0 0 0 0 0 1 1 2 2 2 4 4 4 2 2 2 3 3 3 3 3 3 3 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 4 4 4 3 3 4 4 4 3 3 4 4 4 3 3 3 5 6 6 6 6 5 5 6 6 5 5 5 7 8 8 8 8 7 7 8 8 7 5 3 3 3 5 6 6 6 6 5 5 6 6 5 5 5 7 8 8 8 8 7 7 8 8 7 5 3 3 3 5 6 6 6 5 5 6 6 5 5 6 6 5 3 3 3 5 6 6 6 5 5 6 6 5 5 6 6 5 3 3 3 3 3 2 1 0 @	5113100150	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100150--Ball.cpp	A ( ) A ( C ( B:Ball D ( B:int B:int B:int ) E ( V->O PV V->O PV V->O PV ( =this-> =0 ) ( =this-> =1 ) ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:int ) E ( ( =this-> ) ) ) ) A ( C ( B:int D ( ) E ( returnthis->x ) ) ) A ( C ( B:void D ( B:int ) E ( ( =this-> ) ) ) ) A ( C ( B:int D ( ) E ( returnthis->y ) ) ) A ( C ( B:void D ( B:int ) E ( ( =this-> ) ) ) ) A ( C ( B:int D ( ) E ( returnthis->size ) ) ) A ( C ( B:void D ( ) E ( B:int B:int B:int ( =V =this->O =V->O ) ( =V =this->O =V->O ) ( =V =this->O =V->O ) H:if ( ( J+ J>= JV J625 ) ( =this-> =1 ) H:if ( ( J- J<= JV J0 ) ( =this-> =0 ) ) ) H:if ( ( J+ J>= JV J455 ) ( =this-> =1 ) H:if ( ( J- J<= JV J0 ) ( =this-> =0 ) ) ) H:if ( ( J== Jthis-> J0 ) ( +=V +=4 ) ( -=V -=4 ) ) H:if ( ( J== Jthis-> J0 ) ( +=V +=4 ) ( -=V -=4 ) ) V->O PV V->O PV ) ) ) @	915
ff808181559758460155975849740009	cpp	Header1.cpp	2020217127	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 4 2 2 2 3 3 3 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 3 3 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100045	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100045--Header1.cpp	A ( C ( B:Balls D ( B:int B:int B:int ) E ( PV PV PV ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDC* ) E ( V->O PV V->O PV ( =this-> =+ =* =this-> =0.5 =V ) ( =V =+ =V =V ) ( =V =+ =V =V ) V->O PV PV Pthis-> ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> Jthis-> JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Balls* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =* =V =V ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	1341
ff80818155975846015597584999000a	cpp	Ball.cpp	-1897935478	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 4 4 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 3 3 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100005	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100005--Ball.cpp	A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =* =V =V ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) A ( C ( B:void D ( B:wxDC* ) E ( ( =V =+ =* =V =0.5 =V ) ( =V =+ =V =V ) ( =V =+ =V =V ) V->O PV PV PV ( +=V +=0 ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV J2 ) ( =V =- =V ) ) ) ) ) @	687
ff808181559765b101559765b2db0001	cpp	Source.cpp	-370688262	24	26	2015 10 01 16:30:42	0 0 0 0 0 1 0 0 0 1 1 2 2 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 4 5 5 4 4 4 6 7 7 7 6 6 6 6 6 8 9 9 9 8 8 8 8 8 10 11 11 11 10 10 10 8 6 4 4 3 3 2 1 0 @	5114100062	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100062--Source.cpp	A ( ) A ( B:int ) A ( K:class ( L:public ( B:string B:int B:int B:int C ( B:void D ( ) E ( ) ) C ( B:void D ( B:int ) E ( ( +=V +=V ) ( -=V -=V ) V++ ) ) C ( B:void D ( B:int ) E ( ( -=V -=V ) ( +=V +=V ) V-- ) ) C ( B:void D ( B:int ) E ( ( -=V -=V ) ( -=V -=V ) V++ ) ) ) ) ) A ( C ( B:int D ( ) E ( B:pet ( =V. =String ) ( =V =100 ) ( =V. =0 ) ( =V. =100 ) I:while ( ( J!= J0 ) H:if ( ( J== JV J1 ) V.O P10 H:if ( ( J== JV J2 ) V.O P10 H:if ( ( J== JV J3 ) V.O P10 ) ) ) V.O ) return0 ) ) ) @	1115
ff808181559758460155975849c7000b	cpp	Bounces.cpp	-613215095	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100039	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100039--Bounces.cpp	A ( C ( B:Bounces D ( ) E ( ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDc* ) E ( V->O PV V->O Pthis-> ( =V =+ =V =V ) ( =V =+ =V =V ) ( =V =VO =PV =PV =PV ) ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	951
ff808181559758460155975849d5000c	cpp	Bulat.cpp	-107654738	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 2 2 2 3 4 3 3 4 3 3 4 4 3 3 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 @	5113100121	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100121--Bulat.cpp	A ( C ( B:Bulat D ( B:int B:int ) E ( ( =this-> ) ( =this-> ) ( =this-> =10 ) ( =this-> =5 ) ( =this-> =5 ) ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) @	173
ff80818155975846015597584a15000d	cpp	Balls.cpp	-960012515	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 4 2 2 2 3 3 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 3 3 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100061	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100061--Balls.cpp	A ( C ( B:Balls D ( B:int B:int B:int ) E ( PV PV ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDC* ) E ( V->O PV V->O PV ( =this-> =+ =* =this-> =0.5 =V ) ( =V =+ =V =V ) ( =V =+ =V =V ) V->O PV PV Pthis-> ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> Jthis-> JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Balls* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =* =V =V ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	802
ff80818155975846015597584a45000e	cpp	bounce.cpp	-401380180	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100163	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100163--bounce.cpp	A ( C ( B:Bounce D ( ) E ( ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDc* ) E ( V->O PV V->O Pthis-> ( =V =+ =V =V ) ( =V =+ =V =V ) ( =V =VO =PV =PV =PV ) ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	943
ff80818155975846015597584adc000f	cpp	Bola.cpp	166069319	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 2 2 2 3 4 3 3 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 4 4 4 4 4 4 3 3 4 4 4 4 4 4 3 3 4 4 4 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 5 6 6 6 5 5 6 6 6 6 6 6 6 6 6 5 3 3 3 5 6 6 6 5 5 6 6 6 6 6 6 6 6 6 5 3 3 3 5 6 6 6 5 5 6 6 6 6 6 6 6 6 6 6 5 3 3 3 5 6 6 6 5 5 6 6 6 6 6 6 6 6 6 6 5 3 3 3 5 6 6 6 5 5 6 6 5 5 6 6 5 5 6 6 6 5 5 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100184	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100184--Bola.cpp	A ( C ( B:Bola D ( B:int B:int ) E ( ( =this-> ) ( =this-> ) ( =V =10 ) ( =V =10 ) ( =V =0 ) ( =V =9.8 ) ( =V =0.1 ) ( =V =50.0 ) ( =V =5000.0 ) ) ) ) A ( C ( B:void D ( ) E ( ( =V =+ =* =V =V =V ) ( =V =+ =* =V =V =V ) ( =V =+ =* =+ =* =* =* =V =V =V ) ) ) ) A ( C ( B:void D ( ) E ( H:if ( ( J> JV J430 ) ( =V =* =- =/ =+ =VO =PV =V =V ) ) H:if ( ( J> JV J690 ) ( =V =* =- =/ =+ =VO =PV =V =V ) ) H:if ( ( J< JV J10 ) ( =V =- =* =- =/ =+ =VO =PV =V =V ) ) H:if ( ( J< JV J10 ) ( =V =- =* =- =/ =+ =VO =PV =V =V ) ) H:if ( ( J> JV J480 ) ( =V =0 ) ( =V =0 ) ( =V =- =10 ) ( =V =0 ) ) ) ) ) A ( C ( B:void D ( B:Bola* ) E ( B:float ( =- =V =V-> ) B:float ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =* =V =V ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	1162
ff80818155975846015597584b0b0010	cpp	Bounce.cpp	-1906306900	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100152	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100152--Bounce.cpp	A ( C ( B:Bounce D ( ) E ( ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDc* ) E ( V->O PV V->O Pthis-> ( =V =+ =V =V ) ( =V =+ =V =V ) ( =V =VO =PV =PV =PV ) ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	903
ff80818155975846015597584ba60011	cpp	Circle.cpp	1125115256	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 2 2 2 3 4 4 4 4 3 3 4 4 3 3 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 3 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 4 4 4 4 3 3 3 5 6 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 8 7 7 8 8 8 7 7 7 9 10 10 10 9 9 10 10 10 9 9 10 10 10 9 9 10 10 10 9 9 10 10 10 9 9 9 11 12 12 12 11 11 12 12 12 11 11 12 12 12 11 11 11 13 14 14 14 13 13 14 14 14 13 13 14 14 14 13 13 13 15 16 16 16 15 15 16 16 16 15 15 16 16 16 15 15 15 17 18 18 18 17 17 18 18 18 17 17 18 18 18 17 17 18 18 18 17 17 18 18 18 17 17 17 19 20 20 20 19 19 20 20 20 19 19 20 20 20 19 19 19 21 22 22 22 21 21 22 22 22 21 21 22 22 22 21 21 22 22 22 21 21 22 22 22 21 21 21 23 24 24 24 23 23 24 24 24 23 23 24 24 24 23 23 23 25 26 26 26 25 25 26 26 26 25 25 26 26 26 25 25 25 27 28 28 28 27 27 28 28 28 27 27 28 28 28 27 27 28 28 28 27 27 28 28 28 27 27 27 29 30 30 30 29 29 30 30 30 29 29 30 30 30 29 27 25 23 21 19 17 15 13 11 9 7 5 3 2 1 0 @	5113100101	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100101--Circle.cpp	A ( C ( B:Circle D ( B:int B:int ) E ( ( =V =% =VO =30 ) ( =V =V ) ( =V =V ) ( =V =% =VO =255 ) ( =V =% =VO =255 ) ( =V =% =VO =255 ) ( =V =% =VO =10 ) ( =V =% =VO =10 ) ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( ) E ( ( +=V +=V ) ( +=V +=V ) ) ) ) A ( C ( B:void D ( ) E ( B:int B:int B:int B:int ( =V =V ) ( =V =V ) ( =V =500 ) ( =V =300 ) H:if ( ( J+ J> J|| J- J< JV JV JV JV JV J0 ) ( *=V *=- *=1 ) ) H:if ( ( J+ J> J|| J- J< JV JV JV JV JV J0 ) ( *=V *=- *=1 ) ) ) ) ) A ( C ( B:void D ( B:Circle* ) E ( B:int ( =V ) B:int ( =V-> ) B:int ( =V ) B:int ( =V-> ) B:int ( =- =V =V ) B:int ( =- =V =V ) B:float ( =* =+ =* =V =V =V =V ) ( =V =VO =PVO =PV ) H:if ( ( J< J+ JV JV JV-> ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) H:if ( ( J&& JV JV ) ( *=V *=- *=1 ) ( *=V-> *=- *=1 ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) @	2205
ff80818155975846015597584bd50012	cpp	Bounce.cpp	-1481643376	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100134	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100134--Bounce.cpp	A ( C ( B:Bounce D ( ) E ( ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDc* ) E ( V->O PV V->O Pthis-> ( =V =+ =V =V ) ( =V =+ =V =V ) ( =V =VO =PV =PV =PV ) ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Ball* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	943
ff80818155975846015597584c010013	cpp	Balls.cpp	2115333727	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 4 2 2 2 3 3 3 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 3 3 3 4 4 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 3 3 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 @	5113100180	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100180--Balls.cpp	A ( C ( B:Balls D ( B:int B:int B:int ) E ( PV PV PV ) ) ) A ( C ( B:NN D ( ) E ( ) ) ) A ( C ( B:void D ( B:wxDC* ) E ( V->O PV V->O PV ( =this-> =+ =* =this-> =0.5 =V ) ( =V =+ =V =V ) ( =V =+ =V =V ) V->O PV PV Pthis-> ( +=V +=0.01f ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> Jthis-> JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Balls* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =* =V =V ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) @	802
ff80818155975846015597584c3f0014	cpp	Bounce.cpp	-1097861010	24	24	2016 05 17 19:45:52	0 0 1 1 2 2 2 4 4 2 2 2 3 4 3 3 4 3 3 4 4 3 3 4 4 3 3 4 4 3 2 1 0 0 0 1 1 2 2 2 4 4 4 4 2 2 2 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 3 3 5 6 6 6 6 6 6 6 6 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 4 3 3 3 4 4 5 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 4 4 4 4 3 3 4 4 4 4 3 2 1 0 @	5113100011	/var/www/html/elearning/public/plagiarism_plugin/input/24/24/24 24 5113100011--Bounce.cpp	A ( C ( B:Bounce D ( B:float B:float ) E ( ( =this-> ) ( =this-> ) ( =V =30 ) ( =V =20 ) ( =V =20 ) ) ) ) A ( C ( B:void D ( B:int B:int B:int B:int ) E ( H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) H:if ( ( J- J< J|| J+ J> JV JV JV JV JV JV ) ( =V =- =V ) ) ) ) ) A ( C ( B:void D ( B:Bounce* ) E ( B:int ( =- =V =V-> ) B:int ( =- =V =V-> ) B:float ( =+ =V =V-> ) B:float ( =V ( =V =* =V =V ) ) B:float ( =* =+ =* =V =V =V =V ) H:if ( ( J<= JV JV ) ( *=V *=- *=1 ) ( *=V *=- *=1 ) ) ) ) ) A ( C ( B:void D ( ) E ( ( =V =+ =V =V ) ( =V =+ =V =V ) ) ) ) @	757
ff808181559765b101559765b2040000	cpp	mainsource.cpp	-1510459624	24	26	2015 10 01 22:07:50	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 3 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 8 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 5 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 6 6 5 5 6 6 6 6 5 5 6 6 6 6 5 5 6 6 5 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 7 8 8 8 8 7 5 5 5 7 8 8 8 8 8 7 7 7 7 7 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 6 6 6 6 5 5 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 4 3 3 3 4 4 4 4 4 4 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 4 4 6 7 7 7 6 6 4 4 4 6 7 7 7 6 6 4 4 4 6 7 7 7 6 6 4 4 4 6 7 7 7 6 6 4 4 4 6 7 7 7 6 6 4 4 5 5 5 4 3 3 2 1 0 @	5114100089	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100089--mainsource.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int B:int B:int B:int ( =0 ) C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ( =V =+ =V =15 ) ( =V =- =V =25 ) H:if ( ( J> J&& J< JV J100 JV J0 ) ( =V =100 ) ( =V =0 ) ) VO PString VO PString ) ) C ( B:void D ( ) E ( ( =V =- =* =V =0.1 =V ) ( =V =+ =V =12 ) ( =V =+ =V =20 ) ( +=V +=V ) H:if ( ( J> JV J60 ) ) H:if ( ( J> JV J50 ) ( =V =- =V =10 ) ) H:if ( ( J% J== JV J600 J0 ) V++ VO PString VO PString ) ) ) C ( B:void D ( ) E ( ( =V =+ =V =15 ) ( =V =- =V =5 ) VO PString ) ) C ( B:void D ( ) E ( ( =V =- =V =45 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) VO PString ) ) C ( B:void D ( ) E ( PString ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:char B:tama ( =V. =150 ) ( =V. =0 ) ( =V. =100 ) ( =V. =0 ) ( =V. =100 ) ( =V. =0 ) I:do ( H:if ( ( J== JV J1 ) V.O ) H:if ( ( J== JV J2 ) V.O ) H:if ( ( J== JV J3 ) V.O ) H:if ( ( J== JV J4 ) V.O ) H:if ( ( J== JV J5 ) V.O ) ( J!= JV J0 ) ) return0 ) ) ) @	2595
ff808181559765b101559765b4510002	cpp	Source.cpp	-957764100	24	26	2015 10 01 13:07:08	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 4 3 3 3 3 3 3 3 4 5 5 5 4 4 4 6 7 7 7 6 6 6 6 6 6 8 9 9 9 8 8 8 8 8 8 10 11 11 11 10 10 10 10 10 10 12 13 13 13 12 12 12 12 10 8 6 4 3 2 1 0 @	5114100064	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100064--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ( =V =+ =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =+ =V =2 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =- =V =2 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =+ =V =2 ) H:if ( ( J> JV J2 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( ( =V =- =V =3 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =+ =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =- =V =3 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =- =V =3 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( ( =V =- =V =3 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =- =V =3 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =+ =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =+ =V =3 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( ( =V =- =V =3 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =- =V =3 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =- =V =3 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =+ =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( VO PString ) ) C ( B:void D ( ) E ( H:if ( ( J== JV J0 ) ) H:if ( ( J== JV J0 ) ) H:if ( ( J== JV J0 ) ) H:if ( ( J== JV J0 ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet ( =V =100 ) ( =V. =100 ) ( =V. =100 ) ( =V. =100 ) B:int ( =1 ) V->O PV PV PV I:while ( ( J!= JV J0 ) H:if ( ( J== JV J1 ) V.O V.O V.O H:if ( ( J== JV J2 ) V.O V.O V.O H:if ( ( J== JV J3 ) V.O V.O V.O H:if ( ( J== JV J4 ) V.O V.O V.O ) ) ) ) ) ) ) ) @	2489
ff808181559765b101559765b4bd0003	cpp	Source.cpp	-1420748477	24	26	2015 10 01 16:52:56	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 3 4 5 5 5 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 12 10 8 6 4 3 3 2 1 0 @	5114100179	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100179--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( -=V -=7 ) V++ V-- ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( -=V -=7 ) V++ V-- ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( -=V -=7 ) ( -=V -=7 ) V-- ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( -=V -=7 ) ( -=V -=7 ) V++ ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int ( =0 ) B:Pet ( =V. =% =VO =100 ) ( =V. =% =VO =100 ) ( =V. =% =VO =100 ) ( =V. =% =VO =100 ) I:while ( ( J!= JV J6 ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) V.O ) ) ) ) ) ) V.O ) ) ) @	1575
ff808181559765b101559765b5060004	cpp	Source.cpp	561040897	24	26	2015 10 01 22:14:30	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 4 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 4 4 4 7 8 7 7 7 7 7 7 7 7 7 7 7 4 3 3 3 3 2 1 0 @	5114100034	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100034--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ( =V =50 ) ( =V =50 ) ( =V =50 ) ( =V =50 ) ) ) C ( B:void D ( ) E ( ( +=V +=3 ) ( -=V -=2 ) ( -=V -=2 ) ( +=V +=2 ) ) ) C ( B:void D ( ) E ( ( -=V -=3 ) ( -=V -=2 ) ( -=V -=2 ) ( -=V -=2 ) ) ) C ( B:void D ( ) E ( ( +=V +=3 ) ( -=V -=2 ) ( -=V -=2 ) ( +=V +=2 ) ) ) C ( B:void D ( ) E ( ( +=V +=3 ) ( -=V -=2 ) ( -=V -=2 ) ( +=V +=2 ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:Pet V.O I:while ( ( J> J&& J> J&& J> J&& J> JV. J30 JV. J30 JV. J30 JV. J30 ) H:switch ( ( JV ) G1V.O G1break G2V.O G2break G3V.O G3break G4V.O G4break G5V.O G5break ) ) VO PString return0 ) ) ) @	1860
ff808181559765b101559765b6790005	cpp	TUGAS2_C_5114100151.cpp	-1647184124	24	26	2015 10 01 23:10:26	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 5 6 5 5 5 7 8 8 8 7 7 7 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 9 11 12 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 5 5 7 8 8 8 7 7 7 7 9 10 10 10 9 9 9 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 5 6 6 6 5 5 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 5 5 5 7 8 8 8 7 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 7 7 9 10 10 10 9 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 9 9 9 11 12 12 12 11 11 11 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 11 11 9 7 5 3 3 3 2 1 0 @	5114100151	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100151--TUGAS2_C_5114100151.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( B:int B:int ( =0 ) H:if ( ( J== JV J1 ) VO VO VO ) ) ) C ( B:void D ( ) E ( ( +=V +=20 ) ( -=V -=20 ) ( +=V +=20 ) ( +=V +=10 ) ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( -=V -=5 ) ( +=V +=15 ) ( +=V +=30 ) ) ) C ( B:void D ( ) E ( ( +=V +=20 ) ( +=V +=10 ) ( -=V -=20 ) ( -=V -=10 ) ) ) C ( B:void D ( ) E ( B:int H:if ( ( J== JV J1 ) ( +=V +=20 ) ( +=V +=10 ) ( -=V -=20 ) ( -=V -=10 ) H:if ( ( J== JV J2 ) ( +=V +=20 ) ( -=V -=20 ) ( +=V +=20 ) ( +=V +=10 ) H:if ( ( J== JV J3 ) ( +=V +=10 ) ( -=V -=5 ) ( +=V +=15 ) ( +=V +=30 ) ) ) ) ) ) C ( B:void D ( ) E ( B:int B:int PString PV H:if ( ( J== JV J1 ) VO H:if ( ( J== JV J2 ) VO VO ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:int B:char H:if ( ( J== JV J1 ) B:Jenis ( =V. =String ) ( =V. =30 ) ( =V. =10 ) ( =V. =40 ) ( =V. =20 ) V.O V.O H:if ( ( J== JV J2 ) B:Jenis ( =V. =String ) ( =V. =70 ) ( =V. =20 ) ( =V. =50 ) ( =V. =20 ) V.O V.O H:if ( ( J== JV J3 ) B:Jenis ( =V. =String ) ( =V. =60 ) ( =V. =20 ) ( =V. =30 ) ( =V. =20 ) V.O V.O H:if ( ( J== JV J4 ) B:Jenis ( =V. =String ) ( =V. =90 ) ( =V. =10 ) ( =V. =40 ) ( =V. =20 ) V.O V.O ) ) ) ) V.O return0 ) ) ) @	3055
ff808181559765b101559765b96d0006	cpp	Source.cpp	428232410	24	26	2015 10 01 23:09:06	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 9 11 12 12 12 11 11 12 12 11 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 9 11 12 12 12 11 11 12 12 11 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 5 4 3 3 3 4 4 4 6 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 9 11 12 12 12 11 11 11 13 14 14 14 14 14 14 14 13 13 13 15 16 16 16 16 16 16 16 15 13 11 9 7 7 7 9 10 10 10 9 9 9 11 12 12 12 11 11 9 9 9 11 12 12 12 11 11 11 13 14 14 14 14 14 14 14 13 13 13 15 16 16 16 16 16 16 16 15 13 11 9 9 9 11 12 12 12 11 11 11 13 14 14 14 13 13 13 15 16 16 16 16 16 16 16 15 15 15 17 18 18 18 18 18 18 18 17 15 13 11 9 7 5 5 4 3 3 3 4 4 4 4 4 4 5 5 5 6 7 7 6 6 7 7 7 6 6 5 5 5 5 5 6 7 7 6 6 7 7 7 6 6 5 5 5 5 5 6 7 7 6 6 7 7 7 6 6 5 5 5 5 5 7 8 8 7 7 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 3 3 3 4 5 4 4 4 4 4 6 7 7 7 7 7 7 7 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 12 10 8 6 6 6 8 9 9 9 8 8 6 4 4 4 6 7 6 6 6 4 3 3 2 1 0 @	5114100051	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100051--Source.cpp	A ( ) A ( K:class ( L:public ( B:int B:int B:int B:string C ( B:string D ( ) E ( ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J10 ) ( +=V +=1 ) ) H:if ( ( J> JV J0 ) ( -=V -=1 ) ) H:if ( ( J< JV J9 ) ( +=V +=2 ) H:if ( ( J== JV J10 ) ( -=V -=3 ) H:if ( ( J== JV J9 ) ( +=V +=1 ) ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J0 ) ( -=V -=1 ) ) H:if ( ( J< JV J10 ) ( +=V +=1 ) ) H:if ( ( J== JV J10 ) ( -=V -=3 ) ( -=V -=2 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J0 ) ( -=V -=1 ) ) H:if ( ( J< JV J9 ) ( +=V +=2 ) ) H:if ( ( J== JV J10 ) ( -=V -=3 ) H:if ( ( J< JV J9 ) ( +=V +=2 ) H:if ( ( J== JV J9 ) ( +=V +=1 ) ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J0 ) ( -=V -=1 ) ) H:if ( ( J> JV J0 ) ( -=V -=1 ) ) H:if ( ( J== JV J10 ) ( -=V -=3 ) H:if ( ( J< JV J10 ) ( +=V +=1 ) ) ) ) ) C ( B:int D ( B:int ) E ( H:if ( ( J== JV J1 ) H:if ( ( J== JV J0 ) H:if ( ( J< JV J4 ) H:if ( ( J>= J&& J< JV J4 JV J8 ) H:if ( ( J<= J&& J>= JV J10 JV J8 ) ) ) ) ) H:if ( ( J== JV J2 ) H:if ( ( J<= JV J0 ) return0 ) H:if ( ( J< JV J4 ) H:if ( ( J>= J&& J< JV J4 JV J8 ) H:if ( ( J<= J&& J>= JV J10 JV J8 ) ) ) ) H:if ( ( J== JV J3 ) H:if ( ( J< JV J4 ) H:if ( ( J>= J&& J< JV J4 JV J8 ) H:if ( ( J<= J&& J>= JV J10 JV J8 ) ) ) ) ) ) ) return1 ) ) C ( B:int D ( ) E ( B:int I:for ( ( =V =1 ) ( J<= JV JV ) V++ ) VO P1 I:for ( ( =V =1 ) ( J<= JV JV ) V++ ) VO P2 I:for ( ( =V =1 ) ( J<= JV JV ) V++ ) VO P3 H:if ( ( JV JP2 ) return1 return0 ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:tama ( =V. =10 ) ( =V. =10 ) ( =V. =1 ) B:int B:int V.O I:while ( ( J1 ) VO PString H:if ( ( J< J&& J> JV J5 JV J0 ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O ) ) ) ) H:if ( ( J== JV J5 ) break ) ) H:if ( ( JV.O ) continue break ) ) return0 ) ) ) @	3554
ff808181559765b101559765bbe10007	cpp	ConsoleApplication1.cpp	-1851417983	24	26	2015 10 01 19:27:32	0 0 0 0 0 1 1 2 2 3 3 3 2 1 0 0 0 1 1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 5 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 5 6 6 6 5 5 6 6 6 6 6 6 6 6 6 5 5 5 6 7 6 6 6 7 7 7 6 6 7 7 7 6 6 7 7 7 6 6 7 7 7 6 6 7 7 7 6 6 7 7 7 7 7 7 7 7 6 6 6 8 9 9 9 8 8 9 9 8 8 8 10 11 11 11 11 11 10 10 11 11 10 10 11 11 10 8 8 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 5 7 8 8 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 7 8 8 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 4 5 4 4 4 4 4 6 7 7 7 6 6 6 6 6 8 9 9 9 8 8 8 8 8 8 10 11 11 11 10 10 10 10 10 10 12 13 13 13 12 12 12 12 12 12 14 15 15 15 14 14 14 14 14 14 16 17 17 17 16 16 14 12 10 8 6 4 4 4 3 3 2 1 0 @	5114100020	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100020--ConsoleApplication1.cpp	A ( ) A ( K:class ( L:public ( B:int B:int B:int ) ) ) A ( K:class ( L:public ( B:int B:int B:int B:int B:char C ( B:void D ( ) E ( H:if ( ( J== JV J0 ) ) ) ) C ( B:void D ( ) E ( ( =V =60 ) ( =V =50 ) ( =V =0 ) ( =V =0 ) ) ) C ( B:void D ( ) E ( H:if ( ( J+ J> JV J20 JV ) ( =V =V ) ( +=V +=20 ) ) ) ) C ( B:void D ( ) E ( B:waktu B:waktu B:int B:int B:time_t ( VO =V =P0 ) ( =V =V =PV ) ( =V =V =V ) ( =V =V =V ) ( =V =V =V ) ( =V =* =+ =* =+ =+ =V =V =3600 ) I:while ( ( J1 ) B:time_t ( VO =V =P0 ) ( =V =V =PV ) ( =V =V =V ) ( =V =V =V ) ( =V =V =V ) ( =V =* =+ =* =+ =V =V =3600 ) H:if ( ( J<= JV JV ) ( =V =0 ) H:if ( ( J+ J> JV J5 J100 ) ( =V =100 ) ( +=V +=5 ) ) break ) ) ) ) C ( B:void D ( ) E ( ( =V =0 ) H:if ( ( J+ J> JV J5 JV ) ( =V =V ) ( +=V +=5 ) ) H:if ( ( J+ J> JV J5 JV ) ( =V =V ) ( +=V +=5 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J+ J> JV J5 JV ) ( =V =V ) ( +=V +=5 ) ) H:if ( ( J+ J> JV J5 JV ) ( =V =V ) ( +=V +=5 ) ) H:if ( ( J+ J> JV J2 JV ) ( =V =V ) ( +=V +=2 ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:tamagochi B:int V.O I:while ( ( J1 ) VO PString H:if ( ( J== JV J1 ) PString V.O H:if ( ( J== JV J2 ) VO PString V.O H:if ( ( J== JV J3 ) VO PString V.O H:if ( ( J== JV J4 ) VO PString V.O H:if ( ( J== JV J5 ) VO PString V.O H:if ( ( J== JV J0 ) break ) ) ) ) ) ) VO PString ) return0 ) ) ) @	3297
ff808181559765b101559765bd510008	cpp	Source.cpp	-43578082	24	26	2015 10 01 08:29:52	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 5 5 6 6 6 6 6 6 5 5 6 6 6 6 5 5 6 6 6 6 6 6 5 5 6 6 6 6 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 6 6 6 6 5 5 6 6 6 6 5 5 6 6 6 6 6 6 5 5 6 6 6 6 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 6 6 6 6 5 5 6 6 6 6 5 5 6 6 6 6 6 6 5 5 6 6 6 6 6 6 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 6 6 6 6 5 5 6 6 6 6 6 6 5 5 6 6 6 6 5 5 6 6 6 6 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 3 3 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 3 3 4 5 5 5 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 15 15 14 12 10 8 6 4 4 4 4 6 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 6 6 7 7 6 4 3 3 3 3 2 1 0 @	5114100110	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100110--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:string B:int B:int B:int B:int B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( VO PVO PV ( =V =% =+ =VO =50 =50 ) ( =V =% =VO =21 ) ( =V =% =+ =VO =30 =20 ) ( =V =% =VO =21 ) ( -=V -=V ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( -=V -=V ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( +=V +=V ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( -=V -=V ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( VO PVO PV ( =V =% =VO =21 ) ( =V =% =VO =21 ) ( =V =% =+ =VO =50 =50 ) ( =V =% =VO =21 ) ( +=V +=V ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( -=V -=V ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( +=V +=V ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( -=V -=V ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( VO PVO PV ( =V =% =VO =21 ) ( =V =% =VO =21 ) ( =V =% =+ =VO =20 =30 ) ( =V =% =+ =VO =50 =50 ) ( +=V +=V ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( -=V -=V ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( +=V +=V ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( +=V +=V ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( VO PVO PV ( =V =% =VO =21 ) ( =V =% =+ =VO =50 =50 ) ( =V =% =VO =21 ) ( =V =% =VO =21 ) ( +=V +=V ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( +=V +=V ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( -=V -=V ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( -=V -=V ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J<= JV J50 ) ) H:if ( ( J>= JV J50 ) ) H:if ( ( J<= JV J50 ) ) H:if ( ( J<= JV J50 ) ) return ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int ( =1 ) B:int B:Pet VO PVO PV ( =V. =% =VO =101 ) ( =V. =% =VO =101 ) ( =V. =% =VO =101 ) ( =V. =% =VO =101 ) V.O I:while ( ( J== JV J1 ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) ( =V =0 ) ) ) ) ) ) V.O H:if ( ( J>= J&& J>= J&& J<= J&& J>= JV. J80 JV. J80 JV. J20 JV. J80 ) ( =V =0 ) ) ) VO PString return0 ) ) ) @	4222
ff808181559765b101559765bd890009	cpp	TamagochiBerkelas.cpp	-1140452680	24	26	2015 10 01 23:27:36	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 4 5 5 5 6 6 6 7 7 6 6 6 7 8 8 8 8 8 8 8 8 8 8 8 7 7 7 10 11 11 10 10 10 10 10 10 10 10 10 10 10 10 10 10 7 6 6 6 6 5 4 3 @	5114100063	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100063--TamagochiBerkelas.cpp	A ( ) A ( K:class ( L:public ( B:int B:int B:int B:int B:char C ( B:N D ( ) E ( ) ) C ( B:void D ( ) E ( ( +=V +=3 ) ) ) C ( B:void D ( ) E ( ( +=V +=3 ) ) ) C ( B:void D ( ) E ( ( +=V +=3 ) ) ) C ( B:void D ( ) E ( ( +=V +=3 ) ) ) C ( B:void D ( ) E ( ( -=V -=1 ) ( -=V -=1 ) ( -=V -=1 ) ) ) ) ) ) A ( C ( B:int D ( B:char ) E ( B:int returnangka ) ) ) A ( C ( B:int D ( ) E ( B:Pet ( =V. =V. ( =Vnull =V. ( =Vnull =V. ( =Vnull =10 ) I:while ( ( J!= J&& J!= J&& J!= JV. J0 JV. J0 JV. J0 ) H:switch ( ( JV JPV. ) G1break G2V.O G2V.O G2break G3V.O G3V.O G3break G4V.O G4V.O G4break G5V.O G5V.O G5break ) ) VO PString return0 ) ) ) @	1970
ff808181559765b101559765bea2000a	cpp	Source.cpp	-1508496251	24	26	2015 10 01 12:41:44	0 0 0 0 0 1 1 2 2 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 7 8 8 8 8 7 7 8 8 8 8 7 7 8 8 8 8 7 7 7 9 10 10 10 9 9 9 11 12 12 12 11 11 11 13 14 14 14 13 13 13 15 16 16 16 15 13 11 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 8 8 7 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 4 5 4 4 4 6 7 7 7 6 6 6 8 9 9 9 8 8 8 10 11 11 11 11 10 10 8 8 8 10 11 11 11 10 10 10 12 13 13 13 12 12 12 14 15 15 15 14 14 14 16 17 17 17 16 16 14 12 10 8 6 4 3 3 2 1 0 @	5114100115	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100115--Source.cpp	A ( ) A ( K:class ( L:public ( B:char B:int ( =100 ) B:int ( =100 ) B:int ( =100 ) B:int ( =0 ) C ( B:N D ( ) E ( ) ) C ( B:void D ( ) E ( H:if ( ( J== JV J100 ) ( =V =+ =V =10 ) ) ) ) C ( B:int D ( ) E ( H:if ( ( J== JV J0 ) return1 ( =V =- =V =10 ) ( =V =- =V =10 ) ( =V =+ =V =10 ) H:if ( ( J> JV J100 ) H:if ( ( J> JV J200 ) H:if ( ( J> JV J300 ) H:if ( ( J> JV J400 ) ) ) ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J== JV J100 ) ( =V =+ =V =10 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J== JV J100 ) ( =V =+ =V =10 ) ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:pet I:while ( ( Jtrue ) H:if ( ( J== JV J1 ) H:if ( ( J== JV J2 ) H:if ( ( J== JV JV J1 ) return0 ) H:if ( ( J== JV J3 ) H:if ( ( J== JV J4 ) H:if ( ( J== JV J5 ) H:if ( ( J== JV J6 ) break ) ) ) ) ) ) ) return0 ) ) ) @	3776
ff808181559765b101559765bfc2000b	cpp	Source.cpp	346950463	24	26	2015 10 01 22:07:32	0 0 0 0 0 1 1 2 2 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 4 3 2 2 2 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 3 3 3 4 5 4 4 4 4 4 6 7 7 7 7 6 6 6 6 8 9 9 9 9 9 9 9 9 9 8 8 8 8 10 11 11 11 11 10 10 10 10 12 13 13 13 13 12 12 12 12 14 15 15 15 15 14 14 14 14 16 17 17 17 17 16 16 16 16 18 19 19 19 19 18 18 18 18 20 21 21 21 21 20 20 20 20 22 23 23 23 23 22 22 22 22 24 25 25 25 25 24 24 22 20 18 16 14 12 10 8 6 4 4 4 3 3 2 1 0 @	5114100043	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100043--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:int ( =100 ) B:int ( =100 ) B:int ( =100 ) C ( B:int D ( ) E ( ) ) ) L:public ( C ( B:void D ( ) E ( ( -=V -=20 ) ( +=V +=30 ) ( -=V -=30 ) ) ) C ( B:void D ( ) E ( ( -=V -=15 ) ( +=V +=10 ) ( -=V -=30 ) ) ) C ( B:void D ( ) E ( ( -=V -=5 ) ( +=V +=5 ) ) ) C ( B:void D ( ) E ( ( +=V +=25 ) ( -=V -=10 ) ) ) C ( B:void D ( ) E ( ( +=V +=50 ) ( +=V +=30 ) ( -=V -=30 ) ) ) C ( B:void D ( ) E ( ( +=V +=40 ) ( +=V +=20 ) ( +=V +=5 ) ) ) C ( B:void D ( ) E ( ( +=V +=50 ) ( +=V +=30 ) ( -=V -=30 ) ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( +=V +=30 ) ( +=V +=50 ) ) ) C ( B:void D ( ) E ( ) ) ) ) A ( C ( B:int D ( ) E ( B:char B:Peliharaan VO PV PV. V.O I:while ( ( J1 ) VO PString H:if ( ( J== JV J0 J'F' ) V.O H:if ( ( J== J&& J== JV J1 J'e' JV J0 J'T' ) V.O H:if ( ( J== JV J0 J'C' ) V.O H:if ( ( J== JV J0 J'N' ) V.O H:if ( ( J== JV J2 J'k' ) V.O H:if ( ( J== JV J1 J'i' ) V.O H:if ( ( J== JV J0 J'T' ) V.O H:if ( ( J== JV J2 J'n' ) V.O H:if ( ( J== JV J0 J'S' ) V.O H:if ( ( J== JV J0 J'K' ) break ) ) ) ) ) ) ) ) ) ) VO PString ) return0 ) ) ) @	2528
ff808181559765b101559765c0e3000c	cpp	TUGAS2_C_5114100057.cpp	-2090169820	24	26	2015 10 01 22:13:20	0 0 0 0 0 1 1 2 2 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 5 6 7 6 6 6 6 8 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 8 8 8 8 10 11 11 11 10 10 11 11 10 10 11 11 10 10 11 11 10 10 11 11 10 10 10 12 13 13 13 12 12 13 13 12 12 13 13 12 12 13 13 12 12 13 13 12 12 12 14 15 15 15 14 14 15 15 14 14 15 15 14 14 15 15 14 14 15 15 14 14 14 16 17 17 17 16 16 17 17 16 16 17 17 16 16 17 17 16 16 17 17 16 16 14 12 10 8 6 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 3 3 3 3 2 1 0 @	5114100057	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100057--TUGAS2_C_5114100057.cpp	A ( ) A ( K:class ( L:public ( B:string B:int ( =20 ) B:int ( =20 ) B:int ( =20 ) B:int ( =20 ) C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( B:int I:while ( ( J1 ) VO H:if ( ( J< J&& J< J&& J< J&& J< JV J20 JV J20 JV J20 JV J20 ) break H:if ( ( J== JV J1 ) ( -=V -=30 ) ( +=V +=5 ) ( +=V +=25 ) ( -=V -=25 ) H:if ( ( J== JV J2 ) ( +=V +=30 ) ( +=V +=15 ) ( +=V +=5 ) ( -=V -=25 ) H:if ( ( J== JV J3 ) ( -=V -=15 ) ( -=V -=35 ) ( -=V -=40 ) ( +=V +=25 ) H:if ( ( J== JV J4 ) ( +=V +=20 ) ( +=V +=5 ) ( -=V -=25 ) ( -=V -=35 ) break ) ) ) ) ) ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet ( =V. =String ) V.O V.O return0 ) ) ) @	2222
ff808181559765b101559765c1e1000d	cpp	TUGAS2_C_5114100019.cpp	-1690477852	24	26	2015 10 01 22:12:24	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 4 4 3 3 3 4 3 3 3 3 4 5 5 5 4 4 4 6 7 7 7 6 4 4 4 6 7 7 7 6 4 4 4 6 7 7 7 6 4 4 4 6 7 7 7 6 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 10 8 6 4 4 3 3 3 3 2 1 0 @	5114100019	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100019--TUGAS2_C_5114100019.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int C ( B:int D ( ) E ( ( =V =50 ) ( =V =50 ) ( =V =50 ) ( =V =50 ) ) ) C ( B:void D ( ) E ( H:if ( ( J<= JV J85 ) ( +=V +=15 ) ( =V =100 ) ) H:if ( ( J<= JV J95 ) ( +=V +=5 ) ( =V =100 ) ) H:if ( ( J<= JV J95 ) ( +=V +=5 ) ( =V =100 ) ) H:if ( ( J<= JV J90 ) ( +=V +=5 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J<= JV J85 ) ( +=V +=15 ) ( =V =100 ) ) H:if ( ( J>= JV J45 ) ( -=V -=45 ) ( =V =0 ) ) H:if ( ( J<= JV J85 ) ( +=V +=15 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J>= JV J35 ) ( -=V -=35 ) ( =V =0 ) ) H:if ( ( J>= JV J5 ) ( -=V -=5 ) ( =V =0 ) ) H:if ( ( J>= JV J5 ) ( -=V -=5 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J>= JV J25 ) ( -=V -=25 ) ( =V =0 ) ) H:if ( ( J<= JV J90 ) ( +=V +=10 ) ( =V =100 ) ) H:if ( ( J<= JV J90 ) ( +=V +=10 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:char B:char B:Pet ( =V. =V ) B:int ( =1 ) V.O I:while ( ( J!= JV J0 ) H:if ( ( J== JV. J0 ) ) H:if ( ( J== JV. J100 ) ) H:if ( ( J== JV. J100 ) ) H:if ( ( J== JV. J0 ) ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O ) ) ) ) V.O ) VO VO return0 ) ) ) @	3501
ff808181559765b101559765c34b000e	cpp	Source.cpp	1278958402	24	26	2016 05 20 12:04:14	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 4 4 4 6 4 4 4 5 6 6 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 6 6 5 5 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 6 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 10 10 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 7 7 7 9 10 10 10 9 9 9 11 12 12 12 12 12 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 11 12 12 11 9 7 5 5 5 7 8 8 8 7 7 7 9 10 10 10 10 10 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 7 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 3 3 3 3 4 5 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 9 9 9 9 8 8 8 6 4 4 4 6 7 7 7 6 6 6 6 6 8 9 9 9 8 8 8 8 8 10 11 11 11 10 10 10 10 10 12 13 13 13 12 12 12 12 12 14 15 15 15 14 14 14 14 14 16 17 17 17 16 16 16 16 18 19 19 19 18 18 18 16 14 12 10 8 6 4 3 3 2 1 0 @	5114100015	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100015--Source.cpp	A ( ) A ( K:class ( L:public ( B:char B:int B:int B:int B:int B:int C ( B:void D ( B:int ) E ( ( -=V -=/ -=V -=2 ) ( -=V -=2 ) ( -=V -=1 ) ( +=V +=V ) H:if ( ( J> JV J10 ) ( =V =10 ) ) ) ) C ( B:void D ( B:int ) E ( ( +=V +=V ) ( -=V -=1 ) ( -=V -=2 ) ( -=V -=/ -=V -=2 ) H:if ( ( J> JV J10 ) ( =V =10 ) ) ) ) C ( B:void D ( B:int ) E ( ( +=V +=V ) ( -=V -=/ -=V -=2 ) ( -=V -=2 ) ( -=V -=- -=V -=3 ) H:if ( ( J> JV J10 ) ( =V =10 ) ) ) ) C ( B:void D ( B:int ) E ( ( +=V +=V ) ( -=V -=1 ) ( -=V -=3 ) ( -=V -=/ -=V -=2 ) H:if ( ( J> JV J10 ) ( =V =10 ) ) ) ) C ( B:void D ( B:int ) E ( H:if ( ( J== JV J1 ) H:if ( ( J>= J&& J>= JV J5 JV J5 ) ( -=V -=2 ) ( -=V -=2 ) ( -=V -=3 ) ( +=V +=1 ) ( -=V -=3 ) ( -=V -=3 ) ( -=V -=3 ) ( -=V -=1 ) ) H:if ( ( J== JV J2 ) H:if ( ( J>= J&& J>= JV J7 JV J7 ) ( -=V -=2 ) ( -=V -=2 ) ( -=V -=3 ) ( +=V +=2 ) ( -=V -=3 ) ( -=V -=3 ) ( -=V -=3 ) ( -=V -=1 ) ) ) ) H:if ( ( J== JV J3 ) H:if ( ( J>= J&& J>= JV J9 JV J9 ) ( -=V -=2 ) ( -=V -=2 ) ( -=V -=3 ) ( +=V +=5 ) ( -=V -=3 ) ( -=V -=3 ) ( -=V -=3 ) ( +=V +=3 ) ) ) ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet ( =V. =7 ) ( =V. =7 ) ( =V. =7 ) ( =V. =7 ) ( =V. =0 ) B:int B:int V.O V.O I:while ( ( J1 ) H:if ( ( J== JV. J10 ) break H:if ( ( J== J|| J== JV. J0 JV. J0 ) V.O break ) ) H:if ( ( J== JV J1 ) V.O PV H:if ( ( J== JV J2 ) V.O PV H:if ( ( J== JV J3 ) V.O PV H:if ( ( J== JV J4 ) V.O PV H:if ( ( J== JV J5 ) V.O PV H:if ( ( J== JV J7 ) V.O H:if ( ( J== JV J6 ) V.O V.O ) ) ) ) ) ) ) ) return1 ) ) ) @	4105
ff808181559765b101559765c378000f	cpp	Hello.cpp	-1536351462	24	26	2015 09 30 14:12:02	0 0 0 0 0 1 1 2 2 3 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 5 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 5 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 5 4 3 3 3 4 4 4 6 4 4 4 5 5 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 3 3 3 4 4 3 3 3 4 4 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 2 1 0 @	5114100052	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100052--Hello.cpp	A ( ) A ( K:class ( L:public ( B:string B:string B:int ( =100 ) B:int ( =100 ) B:int ( =100 ) B:int ( =0 ) C ( B:int D ( ) E ( ) ) C ( B:void D ( B:int ) E ( ( +=V +=V ) ( -=V -=V ) V++ V-- ) ) C ( B:void D ( B:int ) E ( ( -=V -=V ) ( +=V +=V ) V++ V-- ) ) C ( B:void D ( B:int ) E ( ( -=V -=V ) ( -=V -=V ) V++ V-- ) ) C ( B:void D ( B:int ) E ( V-- V++ V++ ( +=V +=V ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet ( =V. =String ) B:Pet ( =V. =String ) B:Pet ( =V. =String ) P10 V.O P0 V.O P10 V.O P40 V.O V.O P20 V.O P50 V.O P0 V.O P50 V.O V.O P10 V.O P100 V.O P30 V.O P20 V.O V.O return0 ) ) ) @	1411
ff808181559765b101559765c5180010	cpp	TUGAS2_C_5114100053'.cpp	-15478451	24	26	2015 10 01 22:03:36	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 7 7 9 10 10 10 9 9 10 10 9 7 7 7 9 10 10 10 9 9 10 10 9 7 7 7 9 10 10 10 9 9 10 10 9 7 7 7 9 10 10 10 9 9 10 10 9 9 9 11 12 12 12 11 11 12 12 11 9 9 9 11 12 12 12 11 11 12 12 11 11 11 13 14 14 14 13 13 14 14 13 11 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 7 7 9 10 10 10 9 9 10 10 9 7 7 7 9 10 10 10 9 9 10 10 9 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 3 4 5 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 14 12 10 8 6 4 3 3 2 1 0 @	5114100053	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100053--TUGAS2_C_5114100053'.cpp	A ( ) A ( K:class ( L:public ( B:string B:string B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J100 ) ( +=V +=21 ) H:if ( ( J>= JV J100 ) ( =V =100 ) ) ( +=V +=37 ) H:if ( ( J>= JV J100 ) ( =V =100 ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J100 ) ( +=V +=48 ) H:if ( ( J>= JV J100 ) ( =V =100 ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J> J&& J> JV J20 JV J0 ) ( +=V +=16 ) ( -=V -=70 ) ( -=V -=27 ) ( -=V -=25 ) H:if ( ( J>= JV J100 ) ( =V =100 ) ) H:if ( ( J<= JV J0 ) ( =V =0 ) ) H:if ( ( J<= JV J0 ) ( =V =0 ) ) H:if ( ( J<= JV J0 ) ( =V =0 ) ) H:if ( ( J<= JV J20 ) ( -=V -=15 ) H:if ( ( J<= JV J0 ) ( =V =0 ) ) H:if ( ( J== JV J0 ) ( -=V -=45 ) H:if ( ( J<= JV J0 ) ( =V =0 ) ) ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J100 ) ( +=V +=50 ) ( +=V +=10 ) ( +=V +=20 ) H:if ( ( J>= JV J100 ) ( =V =100 ) ) H:if ( ( J>= JV J100 ) ( =V =100 ) ) H:if ( ( J>= JV J100 ) ( =V =100 ) ) ( -=V -=25 ) H:if ( ( J<= JV J0 ) ( =V =0 ) ) ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet ( =V. =100 ) ( =V. =100 ) ( =V. =100 ) ( =V. =100 ) B:int I:while ( ( J1 ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) V.O break ) ) ) ) ) ) return0 ) ) ) @	3290
ff808181559765b101559765c6b70011	cpp	TUGAS2_C_5114100086.cpp	850420900	24	26	2015 10 01 17:25:32	0 0 0 0 0 1 1 2 2 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 6 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 10 10 10 10 9 7 7 7 9 10 10 10 9 9 10 10 10 10 9 7 7 7 9 10 10 10 9 9 10 10 10 10 9 7 7 7 9 10 10 10 9 9 10 10 10 10 9 7 7 7 9 10 10 10 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 7 5 4 3 3 3 4 4 4 6 4 4 4 5 5 7 8 8 8 7 7 7 7 9 10 10 10 9 9 10 10 10 10 10 10 9 7 7 7 9 10 10 10 9 9 10 10 10 10 9 7 7 7 9 10 10 10 9 9 10 10 10 10 10 10 9 7 7 7 9 10 10 10 9 9 10 10 10 10 9 7 7 7 9 10 10 10 9 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 9 9 11 12 12 12 11 11 12 12 12 12 12 12 11 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 8 8 7 5 4 3 3 3 4 4 4 6 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 10 10 10 10 9 7 7 7 9 10 10 10 9 9 10 10 10 10 9 7 7 7 9 10 10 10 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 9 9 11 12 12 12 11 11 12 12 12 12 11 9 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 4 3 3 3 3 3 4 5 5 5 4 4 4 6 7 7 7 6 6 6 6 6 6 8 9 9 9 8 8 8 8 8 8 10 11 11 11 10 10 10 10 10 10 12 13 13 13 12 12 10 8 6 4 4 4 4 6 7 7 7 7 7 7 7 7 7 7 7 6 4 4 4 6 7 7 7 7 7 7 7 6 6 4 4 4 6 7 7 7 6 6 4 3 3 3 2 1 0 @	5114100086	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100086--TUGAS2_C_5114100086.cpp	A ( ) A ( K:class ( L:public ( B:string B:int ( =100 ) B:int ( =100 ) B:int ( =100 ) B:int ( =100 ) C ( B:void D ( ) E ( ) ) C ( B:void D ( B:char ) E ( H:if ( ( J== JV J'C' ) H:if ( ( J!= JV J100 ) ( =V =+ =V =10 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =10 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =10 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =10 ) ) H:if ( ( J== JV J'B' ) H:if ( ( J!= JV J0 ) ( =V =- =V =10 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =5 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =5 ) ) ) ) ) ) C ( B:void D ( B:char ) E ( H:if ( ( J== JV J'M' ) B:int H:if ( ( J!= JV J100 ) ( =V =+ =VO =PV =P10 =P10 ) ) H:if ( ( J!= JV J100 ) ( =V =+ =V =5 ) ) H:if ( ( J!= JV J0 ) ( =V =- =VO =PV =PV =P0 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =5 ) ) H:if ( ( J== JV J'S' ) B:int H:if ( ( J!= JV J100 ) ( =V =+ =V =10 ) ) H:if ( ( J!= JV J100 ) ( =V =+ =V =5 ) ) H:if ( ( J!= JV J0 ) ( =V =- =VO =PV =PV =P0 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =5 ) ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J!= JV J100 ) ( =V =+ =V =10 ) ) ) ) C ( B:void D ( B:char ) E ( H:if ( ( J== JV J'N' ) H:if ( ( J!= JV J100 ) ( =V =+ =V =5 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =10 ) ) H:if ( ( J== JV J'D' ) H:if ( ( J!= JV J100 ) ( =V =+ =V =10 ) ) H:if ( ( J!= JV J100 ) ( =V =+ =V =10 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =10 ) ) H:if ( ( J!= JV J0 ) ( =V =- =V =10 ) ) ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:char B:int ( =0 ) B:Pet V.O I:while ( ( J!= JV J'X' ) H:if ( ( J== JV J'T' ) B:char V.O PV H:if ( ( J== JV J'F' ) B:char V.O PV H:if ( ( J== JV J'S' ) B:char V.O PV H:if ( ( J== JV J'B' ) V.O ) ) ) ) V.O H:if ( ( J< J|| J< J|| J< JV. J10 JV. J10 JV. J10 ) ) H:if ( ( J== J|| J== JV. J0 JV. J0 ) V++ ) H:if ( ( J== JV J2 ) break ) ) V.O return0 ) ) ) @	2976
ff808181559765b101559765c75e0012	cpp	Class.cpp	-261184430	24	26	2015 10 01 20:34:04	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 3 3 4 5 5 5 5 4 4 4 6 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 14 14 16 17 17 17 16 16 16 14 12 10 8 6 4 3 3 2 1 0 @	5114100704	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100704--Class.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ( +=V +=15 ) ( +=V +=10 ) ( -=V -=5 ) ( +=V +=5 ) ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( -=V -=10 ) ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( -=V -=5 ) ) ) C ( B:void D ( ) E ( ( -=V -=5 ) ( +=V +=10 ) ) ) C ( B:void D ( ) E ( ( =V =30 ) ( =V =30 ) ( =V =30 ) ( =V =30 ) ( =V =30 ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet PString PV. V.O B:int I:while ( ( J> J> JV JV ) H:if ( ( J>= J&& J>= J&& J>= J&& J>= J&& J>= JV. J10 JV. J10 JV. J10 JV. J10 JV. J10 ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) V.O break ) ) ) ) ) ) ) return0 ) ) ) @	1862
ff808181559765b101559765c9bc0013	cpp	Source.cpp	1400439719	24	26	2015 10 01 22:02:42	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 5 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 6 6 5 5 5 5 5 5 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 6 6 5 4 3 3 3 4 4 4 4 4 4 5 5 6 5 5 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 7 8 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 8 8 7 5 5 5 7 8 8 8 7 7 5 5 5 5 5 7 8 8 8 7 5 5 4 3 3 3 4 4 4 4 4 4 5 5 6 5 5 5 5 5 7 8 8 8 8 8 8 8 7 7 8 8 8 8 7 7 8 8 8 8 7 7 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 5 5 5 5 5 7 8 8 8 7 5 5 4 3 3 3 4 4 4 4 4 4 5 5 6 5 5 5 5 5 7 8 8 8 7 7 8 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 7 8 8 8 8 7 7 8 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 7 8 8 7 5 5 5 7 8 8 8 7 7 5 5 5 5 5 7 8 8 8 7 5 5 4 3 3 3 4 4 4 4 4 4 5 5 5 7 8 8 8 7 7 7 7 9 10 10 10 9 9 9 9 11 12 12 12 11 11 11 11 13 14 14 14 13 13 13 13 15 16 16 16 15 15 16 16 15 15 15 15 15 15 15 15 15 15 15 15 13 11 9 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 2 1 0 @	5114100128	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100128--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( ) E ( VO PV PV ( =V =1 ) ( =V =50 ) ( =V =50 ) ( =V =0 ) ( =V =* =V =100 ) VO PString VO PString VO VO ) ) C ( B:void D ( ) E ( ( =V =+ =V =1 ) ( =V =50 ) ( =V =50 ) ( =V =0 ) ( =V =* =V =100 ) ) ) C ( B:void D ( ) E ( B:int ( =0 ) VO PString ( =V =+ =V =10 ) H:if ( ( J<= JV J100 ) ( =V =+ =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =+ =V =10 ) ( =V =1 ) ( =V =50 ) ( =V =- =V =50 ) ) H:if ( ( J>= JV JV ) VO ) VO VO H:if ( ( J== JV J1 ) ) VO ) ) C ( B:void D ( ) E ( B:int ( =0 ) VO PString H:if ( ( J>= J&& J> JV J10 JV J0 ) ( =V =- =V =25 ) ( =V =+ =V =15 ) ( =V =- =V =10 ) ( =V =1 ) ) H:if ( ( J>= JV JV ) VO ) VO VO H:if ( ( J== JV J1 ) ) VO ) ) C ( B:void D ( ) E ( B:int ( =0 ) VO PString H:if ( ( J<= JV J75 ) ( =V =+ =V =50 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =+ =V =5 ) ( =V =- =V =50 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =1 ) ) H:if ( ( J>= JV JV ) VO ) VO VO H:if ( ( J== JV J1 ) ) VO ) ) C ( B:void D ( ) E ( B:int H:if ( ( J== JV J1 ) VO H:if ( ( J== JV J2 ) VO H:if ( ( J== JV J3 ) VO H:if ( ( J== JV J4 ) return H:if ( ( J== JV J99 ) ( =V =99 ) VO PString VO VO VO VO VO PString VO VO VO ) ) ) ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet V.O V.O V.O VO PString V.O VO PString ) ) ) @	3490
ff808181559765b101559765ca3c0014	cpp	main.cpp	1108534527	24	26	2015 09 30 20:29:56	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 3 3 4 4 4 4 4 4 3 3 4 4 4 4 4 4 3 3 4 4 4 4 4 4 3 3 3 4 5 4 4 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 12 10 8 6 4 3 3 3 2 1 0 @	5114100100	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100100--main.cpp	A ( ) A ( K:class ( L:public ( B:string B:string B:string B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ( =V =+ =V =5 ) ( =V =- =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( ( =V =+ =V =5 ) ( =V =- =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( ( =V =+ =V =5 ) ( =V =- =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( ( =V =+ =V =5 ) ( =V =- =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:Pet VO PV PV. VO PV PV. ( =V. =% =+ =VO =70 =30 ) ( =V. =% =+ =VO =70 =30 ) ( =V. =% =+ =VO =70 =30 ) ( =V. =% =+ =VO =70 =30 ) I:while ( ( Jtrue ) VO PString H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) break ) ) ) ) ) ) VO return0 ) ) ) @	2690
ff808181559765b101559765ca570015	cpp	Source.cpp	-1756455652	24	26	2015 10 01 09:18:24	0 0 0 0 0 1 1 2 2 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 4 4 7 8 7 7 7 7 7 7 7 7 7 7 7 7 4 4 5 5 5 4 3 3 2 1 0 @	5114100075	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100075--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:int ( =65 ) B:int ( =70 ) B:int ( =60 ) B:int ( =65 ) C ( B:void D ( ) E ( ( +=V +=7 ) ( +=V +=1 ) ( +=V +=1 ) ( -=V -=3 ) ) ) C ( B:void D ( ) E ( ( -=V -=4 ) ( -=V -=1 ) ( +=V +=8 ) ( -=V -=2 ) ) ) C ( B:void D ( ) E ( ( -=V -=1 ) ( +=V +=1 ) ( +=V +=10 ) ) ) C ( B:void D ( ) E ( ( -=V -=3 ) ( +=V +=7 ) ( -=V -=4 ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:Digimon V.O I:do ( H:switch ( ( JV ) G1break G2V.O G2break G3V.O G3break G4V.O G4break G5V.O G5break G6V.O G6break ) ( J!= JV J0 ) ) return0 ) ) ) @	2279
ff808181559765b101559765cc330016	cpp	TUGAS2_C_5114100027.cpp	-764119548	24	26	2015 10 01 22:30:38	0 0 0 0 0 1 1 2 2 3 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 5 6 7 6 6 6 6 8 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 8 8 6 6 6 8 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 8 8 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 10 10 8 8 8 10 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 10 10 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 12 12 10 10 10 12 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 12 12 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 14 14 12 12 12 14 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 14 14 12 12 12 14 15 15 15 14 14 14 14 16 17 17 17 17 17 17 17 17 17 17 17 17 17 17 17 16 16 14 14 14 16 17 17 17 17 17 17 17 17 17 17 17 17 17 17 17 16 16 14 14 14 16 17 17 17 16 16 16 14 12 10 8 6 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 5 6 6 6 5 5 6 6 5 5 5 5 7 8 8 8 7 7 8 8 7 7 7 7 9 10 10 10 9 9 10 10 9 9 9 7 5 3 3 3 3 2 1 0 @	5114100027	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100027--TUGAS2_C_5114100027.cpp	A ( ) A ( K:class ( L:public ( B:string B:string B:int ( =50 ) B:int ( =50 ) B:int ( =50 ) B:int ( =0 ) B:int ( =50 ) C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( -=V -=10 ) ( +=V +=10 ) ) ) C ( B:void D ( ) E ( ( -=V -=10 ) ( +=V +=10 ) ( +=V +=10 ) ) ) C ( B:void D ( ) E ( ( -=V -=10 ) ( +=V +=10 ) ( -=V -=10 ) ) ) C ( B:void D ( ) E ( ( +=V +=10 ) ( +=V +=10 ) ( +=V +=10 ) ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( ) E ( B:int I:while ( ( J1 ) VO H:if ( ( J== J&& J== J&& J== J&& J== JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J< J&& J< J&& J< J&& J< JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J== JV J1 ) VO H:if ( ( J== J&& J== J&& J== J&& J== JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J< J&& J< J&& J< J&& J< JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J== JV J2 ) VO H:if ( ( J== J&& J== J&& J== J&& J== JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J< J&& J< J&& J< J&& J< JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J== JV J3 ) VO H:if ( ( J== J&& J== J&& J== J&& J== JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J< J&& J< J&& J< J&& J< JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J== JV J4 ) VO H:if ( ( J== J&& J== J&& J== J&& J== JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J< J&& J< J&& J< J&& J< JV J0 JV J0 JV J0 JV J0 ) break ) H:if ( ( J== JV J5 ) break break ) ) ) ) ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:int B:Pet H:if ( ( J== JV J1 ) ( =V. =String ) V.O H:if ( ( J== JV J2 ) ( =V. =String ) V.O H:if ( ( J== JV J3 ) ( =V. =String ) V.O V.O ) ) ) V.O V.O return0 ) ) ) @	3945
ff808181559765b101559765ce0a0017	cpp	Source.cpp	256588990	24	26	2015 10 01 07:23:10	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 5 7 8 8 8 7 7 7 7 9 10 10 10 9 9 9 9 11 12 12 12 11 11 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 7 8 8 8 7 7 8 8 8 8 7 7 8 8 8 8 7 5 5 5 5 5 4 3 3 3 4 4 4 4 4 4 5 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 8 8 7 7 8 8 7 7 8 8 8 8 7 5 5 5 4 3 3 3 4 4 4 4 4 4 5 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 7 8 8 8 8 8 7 7 7 7 7 9 10 10 10 10 10 9 9 10 10 10 10 9 9 10 10 10 10 9 9 9 9 7 5 5 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 7 8 8 8 8 8 7 7 7 7 7 9 10 10 10 10 10 9 9 10 10 10 10 9 9 10 10 10 10 9 9 9 9 7 5 5 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 3 3 2 1 0 @	5114100165	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100165--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:string B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( B:int H:if ( ( J== JV J1 ) VO H:if ( ( J== JV J2 ) VO H:if ( ( J== JV J3 ) VO ) ) ) ) ) C ( B:void D ( ) E ( VO PString H:if ( ( J< JV J100 ) ( =V =+ =V =10 ) ( =V =- =V =5 ) ) VO PString VO VO ) ) C ( B:void D ( ) E ( VO PString ) ) C ( B:void D ( ) E ( ( =V =+ =V =1 ) ( =V =* =V =100 ) H:if ( ( J- J< JV J20 J0 ) ( =V =0 ) ( =V =- =V =20 ) ) VO PString ) ) C ( B:void D ( ) E ( PV PV ) ) C ( B:void D ( ) E ( VO PString H:if ( ( J- J< JV J10 J0 ) VO PString H:if ( ( J+ J< JV J10 JV ) ( =V =+ =V =10 ) ( =V =- =V =10 ) VO PString VO ) ) VO VO ) ) C ( B:void D ( ) E ( VO PString H:if ( ( J- J< JV J5 J0 ) VO PString H:if ( ( J+ J< JV J5 JV ) ( =V =+ =V =5 ) ( =V =- =V =5 ) VO PString VO ) ) VO VO ) ) C ( B:void D ( ) E ( ( =V =100 ) ( =V =0 ) ( =V =1 ) ( =V =50 ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet B:Pet V.O V.O V.O V.O return0 ) ) ) @	2219
ff808181559765b101559765d02b0018	cpp	Tamagotchi_OOP.cpp	114528655	24	26	2015 10 01 07:31:00	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 5 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 5 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 5 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 8 8 8 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 5 5 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 5 6 6 6 6 6 5 5 6 6 6 6 6 5 5 6 6 6 6 6 5 5 6 6 6 6 6 5 5 5 6 7 6 5 5 5 6 7 6 5 5 5 6 7 6 5 5 5 6 7 6 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 5 6 6 6 6 6 6 6 5 5 5 5 6 6 5 5 5 5 5 5 5 5 6 6 5 3 3 3 5 6 6 6 5 5 5 5 5 5 5 5 6 7 6 6 6 6 6 9 10 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 6 5 3 3 2 1 0 @	5114100143	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100143--Tamagotchi_OOP.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int B:int B:int C ( B:int D ( B:string ) E ( ( =V =V ) ( =V =1 ) ( =V =0 ) ( =V =10 ) ( =V =25 ) ( =V =20 ) ( =V =40 ) ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J100 ) ( =V =100 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) H:if ( ( J> JV J100 ) ( =V =100 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) H:if ( ( J> JV J100 ) ( =V =100 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) H:if ( ( J> JV J100 ) ( =V =100 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J== J* JV JV J5 ) V++ ( =V =0 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J> J&& J> J&& J> JV J5 JV J8 JV J6 ) ( -=V -=6 ) ( -=V -=5 ) ( +=V +=10 ) ( -=V -=8 ) VO V++ VO ) ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J9 ) ( -=V -=9 ) ( +=V +=12 ) ( -=V -=2 ) ( +=V +=2 ) VO V++ VO ) ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J95 ) ( +=V +=11 ) ( +=V +=5 ) ( -=V -=2 ) ( -=V -=4 ) VO V++ VO ) ) ) C ( B:void D ( ) E ( ( -=V -=1 ) ( -=V -=3 ) ( -=V -=8 ) ( +=V +=15 ) VO V++ VO ) ) C ( B:void D ( ) E ( B:int B:int B:int B:int ( =V =/ =VO =PV =P2.5 ) ( =V =/ =VO =PV =P2.5 ) ( =V =/ =VO =PV =P2.5 ) ( =V =/ =VO =PV =P2.5 ) I:while ( ( JV-- ) ) I:while ( ( JV-- ) ) I:while ( ( JV-- ) ) I:while ( ( JV-- ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:char B:string B:int H:if ( ( J!= J&& J!= JV J'Y' JV J'y' ) VO PString ( =V =0 ) VO VO PV PV VO PString ( =V =1 ) ) H:if ( ( J== JV J1 ) B:int B:Pet D ( ) I:while ( ( J1 ) VO PString H:switch ( ( JV ) G1V.O G1VO G1PString G1V.O break G1V.O G1VO G1PString G1V.O break G1V.O G1VO G1PString G1V.O break G1V.O G1VO G1PString G1V.O break G1VO G1PString return0 G1V.O ) ) ) return0 ) ) ) @	4035
ff808181559765b101559765d3840019	cpp	PET.cpp	1665237348	24	26	2015 10 01 18:54:48	0 0 0 0 0 1 1 2 2 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 9 11 12 12 12 11 11 11 13 14 14 14 13 13 13 15 16 16 16 15 15 15 17 18 18 18 17 15 13 11 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 9 12 13 12 12 12 14 15 15 15 14 14 15 15 14 14 15 15 14 12 12 12 14 15 15 15 14 14 15 15 14 14 15 15 14 12 12 13 13 12 12 12 12 14 15 15 15 14 14 15 15 14 14 15 15 14 12 12 12 14 15 15 15 14 14 15 15 14 14 15 15 14 12 12 13 13 12 12 12 12 14 15 15 15 14 14 15 15 14 14 15 15 14 12 12 12 14 15 15 15 14 14 15 15 14 14 15 15 14 12 12 13 13 12 12 12 9 7 5 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 7 5 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 9 11 12 12 12 11 11 12 12 11 11 12 12 11 9 9 10 10 9 7 5 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 5 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 7 5 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 5 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 3 3 3 6 7 6 6 6 6 6 3 3 3 3 3 3 4 4 7 8 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 4 4 5 4 3 3 2 1 0 @	5114100154	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100154--PET.cpp	A ( ) A ( K:class ( L:public ( B:string B:int ( =100 ) B:int ( =100 ) B:int ( =100 ) B:int ( =100 ) B:int ( =100 ) B:int ( =100000 ) B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( H:if ( ( J<= JV J25 ) H:if ( ( J<= JV J25 ) H:if ( ( J<= JV J25 ) H:if ( ( J<= JV J25 ) H:if ( ( J<= JV J25 ) H:if ( ( J<= JV J25000 ) ) ) ) ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J== JV J100 ) H:if ( ( J< JV J15000 ) H:switch ( ( JV ) H:if ( ( J<= JV J80 ) ( G1+=V G1+=20 ) ( G1=V G1=100 ) ) H:if ( ( J<= JV J95 ) ( G1+=V G1+=5 ) ( G1=V G1=100 ) ) ( G1-=V G1-=15000 ) G1break H:if ( ( J<= JV J60 ) ( G2+=V G2+=40 ) ( G2=V G2=100 ) ) H:if ( ( J<= JV J90 ) ( G2+=V G2+=10 ) ( G2=V G2=100 ) ) ( G2-=V G2-=30000 ) G2break H:if ( ( J<= JV J20 ) ( G3+=V G3+=80 ) ( G3=V G3=100 ) ) H:if ( ( J<= JV J80 ) ( G3+=V G3+=20 ) ( G3=V G3=100 ) ) ( G3-=V G3-=60000 ) G3break G4return ) ) ) return ) ) C ( B:void D ( ) E ( H:if ( ( J== JV J100 ) H:if ( ( J<= JV J75 ) ( +=V +=25 ) ( =V =100 ) ) H:if ( ( J<= JV J90 ) ( +=V +=10 ) ( =V =100 ) ) ) return ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J60 ) H:if ( ( J< JV J40000 ) H:if ( ( J<= JV J90 ) ( +=V +=10 ) ( =V =100 ) ) ( -=V -=40000 ) ) ) return ) ) C ( B:void D ( ) E ( H:if ( ( J<= J|| J<= J|| J<= J|| J<= JV J20 JV J20 JV J20 JV J30 ) H:if ( ( J<= JV J70 ) ( +=V +=30 ) ( =V =100 ) ) ( -=V -=20 ) ( -=V -=20 ) ( -=V -=5 ) ( -=V -=30 ) ) return ) ) C ( B:void D ( ) E ( H:if ( ( J== JV J100 ) H:if ( ( J<= JV J50 ) ( +=V +=50 ) ( =V =100 ) ) ) return ) ) C ( B:void D ( ) E ( H:if ( ( J<= J|| J<= J|| J<= J|| J<= JV J25 JV J20 JV J20 JV J30 ) ( +=V +=25000 ) ( -=V -=25 ) ( -=V -=20 ) ( -=V -=20 ) ( -=V -=30 ) ) return ) ) ) ) ) A ( C ( B:int D ( ) E ( B:string B:int B:Pet VO PV PV. H:switch ( ( JV ) G1break G2break G3break G4return0 ) VO PV PV. I:do ( H:switch ( ( JV ) G1return0 G2V.O G2break G3V.O G3break G4V.O G4break G5V.O G5break G6V.O G6break G7V.O G7break G8V.O G8break G9break ) ( Jtrue ) ) return0 ) ) ) @	4978
ff808181559765b101559765d4f7001a	cpp	tamago.cpp	-1441494324	24	26	2015 09 30 22:33:14	0 0 0 0 0 1 1 2 2 3 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 4 5 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 14 14 16 17 17 17 16 16 16 16 18 19 19 19 18 18 16 14 12 10 8 6 4 3 3 3 2 1 0 @	5114100044	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100044--tamago.cpp	A ( ) A ( K:class ( L:public ( B:string B:string B:int ( =80 ) B:int ( =85 ) B:int ( =85 ) B:int ( =80 ) B:int ( =85 ) C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J100 ) ( -=V -=5 ) H:if ( ( J<= JV J90 ) ( +=V +=10 ) ( -=V -=5 ) ( =V =100 ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J100 ) ( =V =100 ) ( -=V -=5 ) ( -=V -=5 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J100 ) ( -=V -=5 ) ( -=V -=10 ) ( -=V -=5 ) ( -=V -=10 ) H:if ( ( J<= JV J90 ) ( +=V +=10 ) ( =V =100 ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J100 ) ( -=V -=5 ) ( -=V -=5 ) ( -=V -=5 ) H:if ( ( J<= JV J90 ) ( +=V +=10 ) ( =V =100 ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J100 ) ( -=V -=5 ) ( -=V -=10 ) ( -=V -=10 ) ( -=V -=5 ) H:if ( ( J<= JV J90 ) ( +=V +=10 ) ( =V =100 ) ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:Pet I:while ( ( J1 ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) V.O H:if ( ( J== JV J6 ) V.O H:if ( ( J== JV J7 ) break ) ) ) ) ) ) ) ) V.O return0 ) ) ) @	2896
ff808181559765b101559765d605001b	cpp	TUGAS2_C_5114100033.cpp	98318308	24	26	2015 10 01 21:27:36	0 0 0 0 0 1 1 2 2 3 3 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 4 3 3 3 3 4 5 4 4 4 6 7 7 7 6 4 4 4 6 7 7 7 6 6 6 8 9 9 9 8 8 8 8 9 9 8 8 9 9 8 6 6 6 8 9 9 9 8 8 8 10 11 11 11 10 10 10 10 11 11 10 10 11 11 10 8 8 8 10 11 11 11 10 10 10 12 13 13 13 12 12 12 12 13 13 12 12 13 13 12 10 10 10 12 13 13 13 12 12 12 14 15 15 15 14 14 14 14 15 15 14 14 15 15 14 12 12 12 14 15 15 15 14 14 14 16 17 17 17 16 16 16 16 17 17 16 16 17 17 16 14 14 14 16 17 17 17 16 16 17 17 16 16 16 16 18 19 19 19 18 18 19 19 18 16 14 12 10 8 6 4 3 3 3 2 1 0 @	5114100033	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100033--TUGAS2_C_5114100033.cpp	A ( ) A ( K:class ( L:public ( B:string B:string B:string B:int ( =25 ) B:int ( =25 ) B:int ( =25 ) B:int ( =30 ) C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ( +=V +=5 ) ( -=V -=4 ) ( -=V -=4 ) ) ) C ( B:void D ( ) E ( ( +=V +=5 ) ( -=V -=4 ) ( -=V -=4 ) ) ) C ( B:void D ( ) E ( ( +=V +=5 ) ( +=V +=5 ) ( -=V -=4 ) ) ) C ( B:void D ( ) E ( ( +=V +=5 ) ( +=V +=5 ) ( -=V -=4 ) ) ) C ( B:void D ( ) E ( ( +=V +=5 ) ( +=V +=5 ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet V.O B:int ( =0 ) B:int I:while ( ( J1 ) H:if ( ( J== JV J0 ) ) H:if ( ( J== JV J1 ) H:if ( ( J< JV. J80 ) V.O V.O ( =V =0 ) ( =V =0 ) ) H:if ( ( J== JV J2 ) H:if ( ( J< JV. J80 ) V.O V.O ( =V =0 ) ( =V =0 ) ) H:if ( ( J== JV J3 ) H:if ( ( J< JV. J80 ) V.O V.O ( =V =0 ) ( =V =0 ) ) H:if ( ( J== JV J4 ) H:if ( ( J< JV. J80 ) V.O V.O ( =V =0 ) ( =V =0 ) ) H:if ( ( J== JV J5 ) H:if ( ( J< JV. J80 ) V.O V.O ( =V =0 ) ( =V =0 ) ) H:if ( ( J== JV J6 ) ( =V =0 ) break H:if ( ( J> JV J6 ) ( =V =1 ) ) ) ) ) ) ) ) ) V.O return0 ) ) ) @	4772
ff808181559765b101559765d7ec001c	cpp	Source.cpp	683063138	24	26	2015 09 25 16:06:28	0 0 0 0 0 1 1 2 2 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 7 5 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 10 10 10 10 9 9 10 10 10 10 9 9 9 11 12 12 12 11 9 9 9 11 12 12 12 11 11 12 12 11 11 12 12 12 12 11 9 7 5 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 8 8 7 7 8 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 10 10 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 10 10 10 10 9 9 10 10 10 10 9 9 9 11 12 12 12 11 11 12 12 11 9 9 9 11 12 12 12 11 11 12 12 11 11 12 12 12 12 11 9 7 5 5 5 7 8 8 8 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 10 10 9 9 9 11 12 12 12 12 12 12 12 11 11 12 12 12 12 11 9 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 8 8 7 7 7 7 9 10 10 10 9 9 10 10 9 7 7 8 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 7 7 9 10 10 10 9 9 10 10 9 7 7 8 8 8 8 7 7 7 9 10 10 10 9 9 10 10 9 7 7 8 8 8 8 7 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 8 8 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 4 4 7 8 7 7 7 7 7 7 7 7 7 7 7 7 7 4 4 5 5 5 4 3 2 1 0 @	5114100147	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100147--Source.cpp	A ( ) A ( K:class ( L:public ( B:char B:int ( =0 ) B:int ( =5 ) B:int ( =0 ) B:int ( =100 ) C ( B:void D ( ) E ( H:if ( ( J< JV J0 ) H:if ( ( J> JV J100 ) ( =V =100 ) ( -=V -=5 ) ( -=V -=5 ) ) ) H:if ( ( J<= JV J0 ) ( =V =0 ) H:if ( ( J<= J&& J> JV J100 JV J0 ) ( =V =- =V =10 ) H:if ( ( J< JV J0 ) ) H:if ( ( J> JV J100 ) ( =V =100 ) ( =V =- =V =10 ) ) ) ) H:if ( ( J<= JV J0 ) ( =V =0 ) ) H:if ( ( J<= J&& J> JV J100 JV J0 ) ( =V =- =V =5 ) H:if ( ( J> JV J100 ) ( =V =100 ) ( =V =- =V =5 ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J>= JV J100 ) ( =V =100 ) H:if ( ( J<= J&& J>= JV J100 JV J0 ) ( =V =+ =V =40 ) H:if ( ( J>= JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ( =V =+ =V =40 ) ) ) ) H:if ( ( J<= JV J0 ) ( =V =0 ) H:if ( ( J> JV J100 ) ( =V =100 ) ( =V =- =V =50 ) H:if ( ( J>= J&& J<= JV J0 JV J100 ) ( =V =- =V =50 ) ) ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J>= J&& J>= JV J100 JV J100 ) return H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =+ =V =20 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ( =V =+ =V =20 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =+ =V =5 ) ) ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( ) E ( H:if ( ( J+ J> JV J10 J100 ) ( +=V +=10 ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet B:int I:do ( H:switch ( ( JV ) G1V.O G1break G2V.O G2break G3V.O G3break G4V.O G4break G5V.O G5break G6VO G6P0 ) ( J== J1 J1 ) ) ) ) ) @	2817
ff808181559765b101559765d890001d	cpp	tamagotchi.cpp	-217791265	24	26	2015 10 01 22:58:28	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 6 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 5 5 7 8 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 8 8 7 7 8 8 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 4 3 3 3 3 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 4 4 3 3 4 4 3 3 3 3 3 4 5 5 5 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 14 14 16 17 17 17 16 16 17 17 16 14 12 10 8 6 4 3 3 2 1 0 @	5114100188	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100188--tamagotchi.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( B:Petstat ) E ( ) ) C ( B:void D ( ) E ( H:if ( ( J<= JV. J3 ) ) H:if ( ( J<= JV. J2 ) ) H:if ( ( J<= JV. J4 ) ) H:if ( ( J<= JV. J3 ) ) H:if ( ( J<= JV. J2 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J+ J<= JV. J2 J10 ) ( +=V. +=2 ) ) H:if ( ( J- J>= JV. J2 J0 ) ( -=V. -=2 ) ) H:if ( ( J+ J<= JV. J4 J10 ) ( +=V. +=2 ) ) H:if ( ( J- J>= JV. J1 J0 ) V-- ) H:if ( ( J+ J<= JV. J2 J10 ) ( +=V. +=2 ) ) H:if ( ( J+ J<= JV. J1 J10 ) V++ ) ) ) C ( B:void D ( ) E ( H:if ( ( J+ J<= JV. J3 J10 ) ( +=V. +=3 ) ) H:if ( ( J+ J<= JV. J4 J10 ) ( +=V. +=4 ) ) H:if ( ( J+ J<= JV. J1 J10 ) V++ ) H:if ( ( J- J>= JV. J2 J0 ) ( -=V. -=2 ) ) H:if ( ( J- J>= JV. J2 J0 ) ( -=V. -=2 ) ) H:if ( ( J- J>= JV. J2 J0 ) ( -=V. -=2 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J- J>= JV. J2 J0 ) ( -=V. -=2 ) ) H:if ( ( J- J>= JV. J4 J0 ) ( -=V. -=4 ) ) H:if ( ( J- J>= JV. J1 J0 ) V-- ) H:if ( ( J+ J<= JV. J3 J10 ) ( +=V. +=3 ) ) H:if ( ( J- J>= JV. J3 J0 ) ( -=V. -=3 ) ) H:if ( ( J+ J<= JV. J5 J10 ) ( +=V. +=5 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J- J>= JV. J3 J0 ) ( -=V. -=3 ) ) H:if ( ( J+ J<= JV. J1 J10 ) V++ ) H:if ( ( J+ J<= JV. J4 J10 ) ( +=V. +=4 ) ) H:if ( ( J- J>= JV. J2 J0 ) ( -=V. -=2 ) ) H:if ( ( J- J>= JV. J3 J0 ) ( -=V. -=3 ) ) H:if ( ( J- J>= JV. J3 J0 ) ( -=V. -=3 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J- J>= JV. J3 J0 ) ( -=V. -=3 ) ) H:if ( ( J- J>= JV. J3 J0 ) ( -=V. -=3 ) ) H:if ( ( J+ J<= JV. J1 J10 ) V++ ) H:if ( ( J- J>= JV. J2 J0 ) ( -=V. -=2 ) ) H:if ( ( J+ J<= JV. J5 J10 ) ( +=V. +=5 ) ) H:if ( ( J+ J<= JV. J2 J10 ) ( +=V. +=2 ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Petstat B:int ( =1 ) B:int VO PVO PV ( =V. =% =VO =11 ) ( =V. =% =VO =11 ) ( =V. =% =VO =11 ) ( =V. =% =VO =11 ) ( =V. =% =VO =11 ) ( =V. =0 ) V.O PV I:while ( ( J== JV J1 ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) V.O H:if ( ( J== JV J6 ) ( =V =0 ) ) ) ) ) ) ) ) V.O ) ) ) @	4553
ff808181559765b101559765d8ca001e	cpp	TamagotchiClass.cpp	977453726	24	26	2015 10 01 17:46:28	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 4 5 5 5 6 6 5 5 5 5 6 7 7 7 6 6 7 7 7 7 6 6 6 8 9 9 9 8 6 5 5 5 6 7 7 7 6 6 7 7 7 7 6 6 6 8 9 9 9 8 6 5 5 5 6 7 7 7 6 6 7 7 7 7 6 6 6 8 9 9 9 8 6 5 5 5 6 7 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 14 14 16 17 17 17 16 16 14 12 10 8 6 6 6 8 9 9 9 8 8 8 10 11 11 11 10 8 6 6 6 8 9 9 9 8 8 8 10 11 11 11 10 8 6 6 6 8 9 9 9 8 8 8 10 11 11 11 10 8 6 5 5 5 4 3 2 @	5114100105	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100105--TamagotchiClass.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( ( +=V +=1 ) ( +=V +=2 ) ( -=V -=1 ) ) ) C ( B:void D ( ) E ( ( -=V -=1 ) ( +=V +=2 ) ( +=V +=1 ) ) ) C ( B:void D ( ) E ( ( +=V +=2 ) ( +=V +=1 ) ( -=V -=1 ) ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet ( =V. =V. ( =Vnull =V. ( =Vnull =0 ) B:int I:while ( ( J<= JV. J5 ) ( =V. =% =VO =11 ) H:if ( ( J> JV. J5 ) ) ) I:while ( ( J<= JV. J5 ) ( =V. =% =VO =11 ) H:if ( ( J> JV. J5 ) ) ) I:while ( ( J<= JV. J5 ) ( =V. =% =VO =11 ) H:if ( ( J> JV. J5 ) ) ) I:while ( ( J1 ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) break ) ) ) ) ) H:if ( ( J> JV. J10 ) H:if ( ( J< JV. J5 ) ) ) H:if ( ( J> JV. J10 ) H:if ( ( J< JV. J5 ) ) ) H:if ( ( J> JV. J10 ) H:if ( ( J< JV. J5 ) ) ) ) V.O return0 ) ) ) @	2852
ff808181559765b101559765dc1a0024	cpp	PBO-Tugas2.cpp	291667186	24	26	2015 10 01 22:01:08	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 2 1 0 0 0 1 1 2 2 2 4 2 2 2 3 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 4 4 4 5 5 4 4 5 5 4 4 4 5 6 6 6 5 5 5 8 9 9 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 5 4 4 4 4 3 2 1 @	5114100016	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100016--PBO-Tugas2.cpp	A ( ) A ( K:class ( L:public ( B:int B:int B:int B:char C ( B:void D ( ) E ( ( -=V -=2 ) ( +=V +=1 ) ( -=V -=1 ) ) ) C ( B:void D ( ) E ( ( -=V -=1 ) ( -=V -=2 ) ) ) C ( B:void D ( ) E ( ( +=V +=3 ) ( -=V -=1 ) ) ) C ( B:void D ( ) E ( ( +=V +=3 ) ( -=V -=1 ) ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( ) E ( H:if ( ( J< JV J0 ) ( =V =0 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) ) ) ) A ( C ( B:int D ( B:char ) E ( B:int returnchoice ) ) ) A ( C ( B:int D ( ) E ( B:TEP ( =V. =V. ( =Vnull =10 ) ( =V. =0 ) I:while ( ( J> JV. J0 ) H:switch ( ( JV JPV. ) G1V.O G1V.O G1break G2V.O G2V.O G2break G3V.O G3V.O G3break G4V.O G4V.O G4break G5V.O G5break ) ) VO PString return0 ) ) ) @	1650
ff808181559765b101559765d9a0001f	cpp	Source.cpp	267908992	24	26	2015 10 01 22:17:04	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 6 6 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 5 6 6 6 6 5 5 6 6 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 7 9 10 10 10 9 9 9 11 12 12 12 11 11 11 13 14 14 14 13 11 9 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 4 5 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 6 6 6 8 9 9 9 8 8 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 12 12 12 14 15 15 15 14 14 14 14 16 17 17 17 16 16 14 12 10 8 6 4 4 4 6 7 7 7 6 6 6 8 9 9 9 8 8 8 10 11 11 11 10 10 10 12 13 13 13 12 10 8 6 4 3 2 1 0 @	5114100035	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100035--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int C ( B:void D ( ) E ( ( =V =+ =V =20 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =- =V =15 ) ( =V =- =V =5 ) ) ) C ( B:void D ( ) E ( ( =V =+ =V =25 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =- =V =10 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( ( =V =+ =V =10 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =- =V =20 ) ( =V =+ =V =10 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( ( =V =+ =V =10 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =- =V =20 ) ( =V =+ =V =10 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( ( =V =+ =V =40 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ( =V =- =V =10 ) ( =V =- =V =10 ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J== JV J1 ) H:if ( ( J== JV J2 ) H:if ( ( J== JV J3 ) H:if ( ( J== JV J4 ) ) ) ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:pet ( =V. =100 ) ( =V. =100 ) ( =V. =100 ) I:while ( ( J1 ) H:if ( ( J== JV J1 ) V.O H:if ( ( J<= JV. J0 ) break ) H:if ( ( J<= JV. J0 ) break ) H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J<= JV. J0 ) break ) H:if ( ( J== JV J4 ) V.O H:if ( ( J<= JV. J0 ) break ) H:if ( ( J== JV J5 ) V.O H:if ( ( J<= JV. J0 ) break ) ) ) ) ) ) H:if ( ( J== JV. J1 ) H:if ( ( J== JV. J2 ) H:if ( ( J== JV. J3 ) H:if ( ( J== JV. J4 ) ) ) ) ) ) ) ) ) @	3535
ff808181559765b101559765da340020	cpp	Tamagotchi.cpp	-1562954565	24	26	2015 10 01 23:54:06	0 0 0 0 0 1 1 2 2 3 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 5 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 5 4 3 3 3 4 4 4 6 4 4 4 5 5 5 5 6 6 5 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 6 6 5 5 5 4 3 3 3 4 4 4 4 4 4 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 3 3 4 3 3 3 3 3 5 6 6 6 5 5 5 5 5 5 5 5 6 7 7 7 6 6 6 8 9 9 9 8 8 8 6 6 6 8 9 9 9 8 8 8 6 6 6 8 9 9 9 8 8 8 6 6 6 8 9 9 9 8 8 8 6 6 6 8 9 9 9 8 8 8 9 10 10 9 9 10 10 10 9 9 9 9 9 9 9 9 9 9 8 8 8 8 8 8 8 6 6 6 7 8 8 7 7 8 8 8 7 7 7 6 5 3 3 3 3 2 1 0 @	5114100041	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100041--Tamagotchi.cpp	A ( ) A ( K:class ( L:public ( B:string B:string B:int ( =100 ) B:int ( =100 ) B:int ( =100 ) B:int ( =0 ) C ( B:void D ( B:int ) E ( ( +=V +=V ) ( -=V -=V ) V++ V-- ) ) C ( B:void D ( B:int ) E ( ( -=V -=V ) ( -=V -=V ) V++ V-- ) ) C ( B:void D ( B:int ) E ( V-- V++ V++ ( +=V +=V ) ) ) C ( B:void D ( B:int ) E ( ( -=V -=V ) ( +=V +=V ) V++ V-- ) ) C ( B:void D ( ) E ( ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:int B:int B:int B:int B:int ( =0 ) B:Pet V.O H:if ( ( J== JV J1 ) PV PV PV PV V.O I:while ( ( J!= JV J0 ) H:if ( ( J== JV J1 ) V.O PV ) H:if ( ( J== JV J2 ) V.O PV ) H:if ( ( J== JV J3 ) V.O PV ) H:if ( ( J== JV J4 ) V.O PV ) H:if ( ( J== JV J5 ) I:for ( ( =V =0 ) ( J<= JV JV ) V++ V.O P10 V.O P10 V.O P10 V.O P10 ) V++ V.O PV PV PV PV ) I:for ( ( =V =0 ) ( J<= JV JV ) V++ V.O ) ) ) VO PString return0 ) ) ) @	3207
ff808181559765b101559765dae10021	cpp	Source.cpp	-1127083072	24	26	2015 10 01 22:04:26	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 7 7 8 8 7 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 5 5 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 4 5 4 4 4 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 14 14 16 17 17 17 16 16 16 16 18 19 19 19 18 18 16 14 12 10 8 6 4 3 2 1 0 @	5114100178	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100178--Source.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int B:int C ( B:int D ( ) E ( ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J> JV J100 ) ( =V =100 ) ) H:if ( ( J< JV J0 ) ( =V =0 ) ) ) ) C ( B:void D ( ) E ( ( +=V +=15 ) ( -=V -=10 ) ( -=V -=15 ) ( -=V -=5 ) ) ) C ( B:void D ( ) E ( ( +=V +=50 ) ( -=V -=5 ) ( -=V -=10 ) ) ) C ( B:void D ( ) E ( ( +=V +=30 ) ( -=V -=30 ) ( -=V -=10 ) ( -=V -=5 ) ) ) C ( B:void D ( ) E ( ( +=V +=40 ) ( +=V +=5 ) ) ) C ( B:void D ( ) E ( ( +=V +=60 ) ( -=V -=10 ) ( -=V -=5 ) ( +=V +=5 ) ) ) C ( B:void D ( ) E ( VO PString VO PString ) ) ) ) ) A ( C ( B:int D ( ) E ( B:Pet PV PV PV VO PString ( =V. =100 ) ( =V. =100 ) ( =V. =100 ) ( =V. =100 ) ( =V. =100 ) I:while ( ( J1 ) B:int VO PString H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) V.O H:if ( ( J== JV J6 ) V.O H:if ( ( J== JV J7 ) break ) ) ) ) ) ) ) ) ) ) ) @	2851
ff808181559765b101559765dbde0022	cpp	Tamagocha2.cpp	1573047297	24	26	2015 10 01 23:34:04	0 0 0 0 0 1 1 2 2 3 3 4 3 3 3 4 3 3 3 4 3 3 3 4 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 6 4 4 4 5 5 7 8 8 8 8 8 8 8 7 7 7 7 8 8 7 7 7 9 10 10 10 9 9 10 10 9 9 10 10 9 9 10 10 9 7 7 7 9 10 10 10 10 10 10 10 9 9 9 10 10 9 9 9 11 12 12 12 11 11 9 9 9 11 12 12 12 12 12 12 12 11 11 11 13 14 14 14 14 14 14 14 13 13 13 15 16 16 16 15 15 13 11 9 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 4 5 4 4 4 6 7 7 7 7 7 7 7 6 6 6 6 8 9 9 9 9 9 9 9 8 8 8 8 10 11 11 11 11 11 11 11 10 10 10 10 10 12 13 13 13 13 13 13 13 12 12 12 12 12 14 15 15 15 15 15 15 15 14 14 14 14 14 16 17 17 17 17 17 17 17 16 16 16 16 16 18 19 19 19 19 19 19 19 18 18 18 16 14 12 10 8 6 4 3 3 2 1 0 @	5114100162	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100162--Tamagocha2.cpp	A ( ) A ( K:class ( L:public ( B:double ( =1 ) B:int ( =0 ) B:int ( =0 ) B:int ( =0 ) B:string C ( B:string D ( ) E ( ) ) C ( B:void D ( B:char ) E ( H:if ( ( J== J|| J== JV J'f' JV J'F' ) V++ V++ ( +=V +=0.5 ) H:if ( ( J> JV J10 ) ( -=V -=2 ) ( -=V -=0.5 ) ( +=V +=1 ) ) H:if ( ( J== J|| J== JV J'b' JV J'B' ) V++ ( +=V +=0.5 ) H:if ( ( J> JV J0 ) V-- ) H:if ( ( J== J|| J== JV J'L' JV J'l' ) H:if ( ( J== J|| J== JV J'D' JV J'd' ) H:if ( ( J> JV J0 ) V-- ) ) ) ) ) ) ) ) ) ) A ( C ( B:void D ( ) E ( ) ) ) A ( C ( B:int D ( ) E ( B:Digimon B:char I:while ( ( Jtrue ) H:if ( ( J== J|| J== JV J'H' JV J'h' ) VO H:if ( ( J== J|| J== JV J'Q' JV J'q' ) break H:if ( ( J== J|| J== JV J'F' JV J'f' ) V.O PV H:if ( ( J== J|| J== JV J'B' JV J'b' ) V.O PV H:if ( ( J== J|| J== JV J'F' JV J'f' ) V.O PV H:if ( ( J== J|| J== JV J'L' JV J'l' ) V.O PV H:if ( ( J== J|| J== JV J'D' JV J'd' ) V.O PV ) ) ) ) ) ) ) ) return0 ) ) ) @	2826
ff808181559765b101559765dbff0023	cpp	Source.cpp	-1135904095	24	26	2015 10 01 11:10:36	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 4 4 4 4 3 3 3 4 4 4 6 4 4 4 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 6 6 5 5 5 7 8 8 8 7 7 8 8 7 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 8 8 7 7 8 8 7 7 8 8 7 7 8 8 7 5 4 3 2 1 0 0 0 1 1 2 2 2 2 2 2 3 3 3 3 4 4 3 3 4 4 3 3 4 4 3 3 3 4 5 4 4 4 7 8 7 7 7 7 7 10 11 10 10 10 10 10 10 10 10 10 10 7 7 7 7 7 7 7 7 4 3 2 1 0 @	5114100122	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100122--Source.cpp	A ( ) A ( K:class ( L:public ( B:char B:int B:int B:int C ( B:N D ( ) E ( ) ) C ( B:void D ( ) E ( ) ) C ( B:void D ( B:int ) E ( ( +=V +=V ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( ( +=V +=25 ) H:if ( ( J> JV J100 ) ( =V =100 ) ) ) ) C ( B:void D ( ) E ( H:if ( ( J<= J|| J<= JV J10 JV J10 ) ( +=V +=5 ) ( -=V -=10 ) ( -=V -=5 ) ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:int B:Monster ( =V. =10 ) ( =V. =10 ) ( =V. =0 ) I:while ( ( J1 ) H:switch ( ( JV ) G1V.O G1break H:switch ( ( JV ) G1V.O G1P10 G1break G2V.O G2P15 G2break G3V.O G3P20 G3break ) break V.O break V.O break return0 break ) ) ) ) ) @	1901
ff808181559765b101559765dc830025	cpp	tamagotci02.cpp	-1323089927	24	26	2015 10 01 23:06:02	0 0 0 0 0 1 1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 5 6 6 5 5 6 6 5 5 6 6 5 5 6 6 5 4 3 3 3 4 4 4 4 4 4 5 5 7 8 8 8 8 8 7 7 8 8 8 8 7 7 8 8 7 5 5 6 6 6 7 7 6 6 5 4 4 4 5 5 5 5 5 5 6 7 7 6 6 6 7 7 7 7 6 6 7 7 7 7 6 5 4 4 4 5 5 5 5 5 5 6 6 8 9 9 9 8 8 6 6 6 5 4 4 4 5 5 5 5 5 5 6 7 7 6 6 6 5 4 4 4 5 5 5 5 5 5 6 6 7 7 8 7 7 8 8 8 7 7 6 6 6 7 7 8 7 7 8 8 8 7 7 6 6 6 7 7 8 7 7 8 8 8 7 7 6 6 6 7 7 8 7 7 8 8 8 7 7 6 5 4 3 2 1 0 0 1 1 2 2 2 2 2 2 3 3 3 3 3 4 5 4 4 4 6 7 7 7 6 6 6 6 8 9 9 9 8 8 8 8 10 11 11 11 10 10 10 10 12 13 13 13 12 12 12 12 14 15 15 15 14 14 14 14 16 17 17 17 16 16 14 12 10 8 6 4 3 2 1 0 @	5114100177	/var/www/html/elearning/public/plagiarism_plugin/input/24/26/24 26 5114100177--tamagotci02.cpp	A ( ) A ( K:class ( L:public ( B:string B:int B:int B:int B:int C ( B:void D ( ) E ( ( =V =10 ) ( =V =5 ) ( =V =3 ) ( =V =5 ) ) ) C ( B:void D ( ) E ( H:if ( ( J+ J<= JV J5 J10 ) ( =V =+ =V =5 ) ( =V =10 ) ) ( =V =V ( =V =3 ) V-- ) ) C ( B:void D ( ) E ( ( =V =10 ) V-- ( =V =- =V =3 ) ( =V =- =V =3 ) ) ) C ( B:void D ( ) E ( H:if ( ( J!= JV J10 ) V++ ) V-- V-- ) ) C ( B:void D ( ) E ( ( =V =10 ) V-- V-- ) ) C ( B:void D ( ) E ( I:for ( B:int ( =0 ) ( J< JV JV ) V++ ) I:for ( B:int ( =0 ) ( J< JV JV ) V++ ) I:for ( B:int ( =0 ) ( J< JV JV ) V++ ) I:for ( B:int ( =0 ) ( J< JV JV ) V++ ) ) ) ) ) ) A ( C ( B:int D ( ) E ( B:int B:Pet V.O I:while ( ( Jtrue ) H:if ( ( J== JV J1 ) V.O H:if ( ( J== JV J2 ) V.O H:if ( ( J== JV J3 ) V.O H:if ( ( J== JV J4 ) V.O H:if ( ( J== JV J5 ) V.O H:if ( ( J== JV J0 ) return0 ) ) ) ) ) ) ) ) ) ) @	1763
\.


--
-- TOC entry 2198 (class 0 OID 57413)
-- Dependencies: 191
-- Data for Name: db_similarity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY db_similarity (id_sim, id1, id2, kelas, kode_soal, levenshtein_similarity, similarity_value) FROM stdin;
ff80818155975846015597584ce80015	5113100091	5113100187	24	24	17.4600000000000009	26.5500000000000007
ff80818155975846015597584d110016	5113100091	5113100020	24	24	16.370000000000001	28.0100000000000016
ff80818155975846015597584d320017	5113100091	5113100050	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597584d530018	5113100091	5113100009	24	24	11.6400000000000006	28.370000000000001
ff80818155975846015597584d740019	5113100091	5113100012	24	24	16.370000000000001	28.0100000000000016
ff80818155975846015597584d95001a	5113100091	5113100119	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597584dbd001b	5113100091	5113100004	24	24	16.7300000000000004	29.1000000000000014
ff80818155975846015597584de3001c	5113100091	5113100150	24	24	9.82000000000000028	14.1899999999999995
ff80818155975846015597584e11001d	5113100091	5113100045	24	24	16.0100000000000016	33.1000000000000014
ff80818155975846015597584e33001e	5113100091	5113100005	24	24	12.3699999999999992	26.9100000000000001
ff80818155975846015597584e55001f	5113100091	5113100039	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597584e720020	5113100091	5113100121	24	24	3.64000000000000012	3.64000000000000012
ff80818155975846015597584e9c0021	5113100091	5113100061	24	24	16.370000000000001	28.7300000000000004
ff80818155975846015597584ec90022	5113100091	5113100163	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597584ef10023	5113100091	5113100184	24	24	11.6400000000000006	26.9100000000000001
ff80818155975846015597584f170024	5113100091	5113100152	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597584f4a0025	5113100091	5113100101	24	24	100	100
ff80818155975846015597584f700026	5113100091	5113100134	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597584f920027	5113100091	5113100180	24	24	16.0100000000000016	28.7300000000000004
ff80818155975846015597584fb40028	5113100091	5113100011	24	24	15.6400000000000006	27.6400000000000006
ff80818155975846015597584fbf0029	5113100187	5113100020	24	24	68.5799999999999983	85.7199999999999989
ff80818155975846015597584fd0002a	5113100187	5113100050	24	24	92.730000000000004	92.730000000000004
ff80818155975846015597584fe1002b	5113100187	5113100009	24	24	12.1500000000000004	86.9200000000000017
ff80818155975846015597584ff2002c	5113100187	5113100012	24	24	68.5799999999999983	85.7199999999999989
ff80818155975846015597585003002d	5113100187	5113100119	24	24	92.730000000000004	92.730000000000004
ff80818155975846015597585013002e	5113100187	5113100004	24	24	78.5799999999999983	82.1500000000000057
ff80818155975846015597585026002f	5113100187	5113100150	24	24	11.0199999999999996	26.2800000000000011
ff8081815597584601559758503b0030	5113100187	5113100045	24	24	47.9799999999999969	48.990000000000002
ff8081815597584601559758504c0031	5113100187	5113100005	24	24	10.7899999999999991	88.2399999999999949
ff8081815597584601559758505e0032	5113100187	5113100039	24	24	92.730000000000004	92.730000000000004
ff8081815597584601559758506b0033	5113100187	5113100121	24	24	7.84999999999999964	7.84999999999999964
ff808181559758460155975850770034	5113100187	5113100061	24	24	72.0400000000000063	77.1200000000000045
ff808181559758460155975850870035	5113100187	5113100163	24	24	92.730000000000004	92.730000000000004
ff8081815597584601559758509c0036	5113100187	5113100184	24	24	36.7100000000000009	44.3100000000000023
ff808181559758460155975850a90037	5113100187	5113100152	24	24	92.730000000000004	92.730000000000004
ff808181559758460155975850cd0038	5113100187	5113100101	24	24	17.4600000000000009	26.5500000000000007
ff808181559758460155975850db0039	5113100187	5113100134	24	24	92.730000000000004	92.730000000000004
ff808181559758460155975850ec003a	5113100187	5113100180	24	24	71.4300000000000068	76.480000000000004
ff808181559758460155975850fc003b	5113100187	5113100011	24	24	68.5799999999999983	85.7199999999999989
ff8081815597584601559758510d003c	5113100020	5113100050	24	24	64.5499999999999972	85.4599999999999937
ff8081815597584601559758511e003d	5113100020	5113100009	24	24	11.2200000000000006	83.1800000000000068
ff8081815597584601559758512e003e	5113100020	5113100012	24	24	98.0999999999999943	98.0999999999999943
ff8081815597584601559758513f003f	5113100020	5113100119	24	24	64.5499999999999972	85.4599999999999937
ff808181559758460155975851500040	5113100020	5113100004	24	24	54.4699999999999989	80.3599999999999994
ff808181559758460155975851650041	5113100020	5113100150	24	24	10.1699999999999999	27.9699999999999989
ff8081815597584601559758517a0042	5113100020	5113100045	24	24	43.9399999999999977	49.5
ff8081815597584601559758518a0043	5113100020	5113100005	24	24	9.52999999999999936	83.8100000000000023
ff8081815597584601559758519b0044	5113100020	5113100039	24	24	63.6400000000000006	84.5499999999999972
ff808181559758460155975851a80045	5113100020	5113100121	24	24	8.58000000000000007	10.4800000000000004
ff808181559758460155975851b40046	5113100020	5113100061	24	24	54.240000000000002	77.1200000000000045
ff808181559758460155975851c50047	5113100020	5113100163	24	24	64.5499999999999972	85.4599999999999937
ff808181559758460155975851d90048	5113100020	5113100184	24	24	28.4899999999999984	50
ff808181559758460155975851e60049	5113100020	5113100152	24	24	64.5499999999999972	85.4599999999999937
ff80818155975846015597585213004a	5113100020	5113100101	24	24	16.370000000000001	28.0100000000000016
ff80818155975846015597585229004b	5113100020	5113100134	24	24	64.5499999999999972	85.4599999999999937
ff80818155975846015597585239004c	5113100020	5113100180	24	24	53.7899999999999991	76.480000000000004
ff80818155975846015597585249004d	5113100020	5113100011	24	24	97.1500000000000057	98.0999999999999943
ff8081815597584601559758525b004e	5113100050	5113100009	24	24	20.9100000000000001	90.9099999999999966
ff8081815597584601559758526b004f	5113100050	5113100012	24	24	63.6400000000000006	84.5499999999999972
ff8081815597584601559758527c0050	5113100050	5113100119	24	24	100	100
ff8081815597584601559758528d0051	5113100050	5113100004	24	24	84.8299999999999983	88.4000000000000057
ff808181559758460155975852a00052	5113100050	5113100150	24	24	10.1699999999999999	32.2100000000000009
ff808181559758460155975852b60053	5113100050	5113100045	24	24	51.5200000000000031	52.5300000000000011
ff808181559758460155975852c60054	5113100050	5113100005	24	24	16.370000000000001	81.8199999999999932
ff808181559758460155975852d80055	5113100050	5113100039	24	24	99.0999999999999943	99.0999999999999943
ff808181559758460155975852e50056	5113100050	5113100121	24	24	7.28000000000000025	8.1899999999999995
ff808181559758460155975852f30057	5113100050	5113100061	24	24	77.9699999999999989	83.0600000000000023
ff808181559758460155975853020058	5113100050	5113100163	24	24	100	100
ff808181559758460155975853170059	5113100050	5113100184	24	24	36.7100000000000009	46.2100000000000009
ff80818155975846015597585324005a	5113100050	5113100152	24	24	100	100
ff8081815597584601559758534a005b	5113100050	5113100101	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597585355005c	5113100050	5113100134	24	24	100	100
ff80818155975846015597585367005d	5113100050	5113100180	24	24	77.3199999999999932	82.3599999999999994
ff80818155975846015597585376005e	5113100050	5113100011	24	24	64.5499999999999972	85.4599999999999937
ff80818155975846015597585387005f	5113100009	5113100012	24	24	11.2200000000000006	83.1800000000000068
ff808181559758460155975853980060	5113100009	5113100119	24	24	20.9100000000000001	90.9099999999999966
ff808181559758460155975853a80061	5113100009	5113100004	24	24	31.25	94.6500000000000057
ff808181559758460155975853bb0062	5113100009	5113100150	24	24	11.0199999999999996	36.4500000000000028
ff808181559758460155975853d10063	5113100009	5113100045	24	24	33.8400000000000034	53.5399999999999991
ff808181559758460155975853e10064	5113100009	5113100005	24	24	84.1200000000000045	87.8599999999999994
ff808181559758460155975853f30065	5113100009	5113100039	24	24	20.9100000000000001	90.9099999999999966
ff808181559758460155975854000066	5113100009	5113100121	24	24	5.61000000000000032	8.41999999999999993
ff8081815597584601559758540c0067	5113100009	5113100061	24	24	25.4299999999999997	88.1400000000000006
ff8081815597584601559758541d0068	5113100009	5113100163	24	24	20.9100000000000001	90.9099999999999966
ff808181559758460155975854310069	5113100009	5113100184	24	24	15.1899999999999995	46.8400000000000034
ff8081815597584601559758543e006a	5113100009	5113100152	24	24	20.9100000000000001	90.9099999999999966
ff80818155975846015597585464006b	5113100009	5113100101	24	24	11.6400000000000006	28.370000000000001
ff80818155975846015597585470006c	5113100009	5113100134	24	24	20.9100000000000001	90.9099999999999966
ff80818155975846015597585481006d	5113100009	5113100180	24	24	25.2199999999999989	87.4000000000000057
ff80818155975846015597585491006e	5113100009	5113100011	24	24	11.2200000000000006	83.1800000000000068
ff808181559758460155975854a2006f	5113100012	5113100119	24	24	63.6400000000000006	84.5499999999999972
ff808181559758460155975854b30070	5113100012	5113100004	24	24	54.4699999999999989	80.3599999999999994
ff808181559758460155975854c60071	5113100012	5113100150	24	24	10.1699999999999999	27.9699999999999989
ff808181559758460155975854db0072	5113100012	5113100045	24	24	43.9399999999999977	49.5
ff808181559758460155975854ec0073	5113100012	5113100005	24	24	9.52999999999999936	83.8100000000000023
ff808181559758460155975854fd0074	5113100012	5113100039	24	24	63.6400000000000006	84.5499999999999972
ff8081815597584601559758550a0075	5113100012	5113100121	24	24	8.58000000000000007	10.4800000000000004
ff808181559758460155975855170076	5113100012	5113100061	24	24	54.240000000000002	77.1200000000000045
ff808181559758460155975855270077	5113100012	5113100163	24	24	63.6400000000000006	84.5499999999999972
ff8081815597584601559758553c0078	5113100012	5113100184	24	24	28.4899999999999984	50
ff808181559758460155975855480079	5113100012	5113100152	24	24	63.6400000000000006	84.5499999999999972
ff8081815597584601559758556d007a	5113100012	5113100101	24	24	16.370000000000001	28.0100000000000016
ff8081815597584601559758557b007b	5113100012	5113100134	24	24	63.6400000000000006	84.5499999999999972
ff8081815597584601559758558c007c	5113100012	5113100180	24	24	53.7899999999999991	76.480000000000004
ff8081815597584601559758559c007d	5113100012	5113100011	24	24	95.2399999999999949	96.2000000000000028
ff808181559758460155975855ad007e	5113100119	5113100004	24	24	84.8299999999999983	88.4000000000000057
ff808181559758460155975855c0007f	5113100119	5113100150	24	24	10.1699999999999999	32.2100000000000009
ff808181559758460155975855d50080	5113100119	5113100045	24	24	51.5200000000000031	52.5300000000000011
ff808181559758460155975855ef0081	5113100119	5113100005	24	24	16.370000000000001	81.8199999999999932
ff808181559758460155975856110082	5113100119	5113100039	24	24	99.0999999999999943	99.0999999999999943
ff8081815597584601559758561e0083	5113100119	5113100121	24	24	7.28000000000000025	8.1899999999999995
ff8081815597584601559758562a0084	5113100119	5113100061	24	24	77.9699999999999989	83.0600000000000023
ff8081815597584601559758563b0085	5113100119	5113100163	24	24	100	100
ff8081815597584601559758564f0086	5113100119	5113100184	24	24	36.7100000000000009	46.2100000000000009
ff8081815597584601559758565c0087	5113100119	5113100152	24	24	100	100
ff808181559758460155975856810088	5113100119	5113100101	24	24	16.0100000000000016	29.1000000000000014
ff8081815597584601559758568e0089	5113100119	5113100134	24	24	100	100
ff8081815597584601559758569f008a	5113100119	5113100180	24	24	77.3199999999999932	82.3599999999999994
ff808181559758460155975856af008b	5113100119	5113100011	24	24	64.5499999999999972	85.4599999999999937
ff808181559758460155975856c2008c	5113100004	5113100150	24	24	8.48000000000000043	36.4500000000000028
ff808181559758460155975856d8008d	5113100004	5113100045	24	24	53.0399999999999991	56.0700000000000003
ff808181559758460155975856e9008e	5113100004	5113100005	24	24	27.6799999999999997	88.4000000000000057
ff808181559758460155975856fa008f	5113100004	5113100039	24	24	84.8299999999999983	88.4000000000000057
ff808181559758460155975857070090	5113100004	5113100121	24	24	7.15000000000000036	8.03999999999999915
ff808181559758460155975857140091	5113100004	5113100061	24	24	88.9899999999999949	90.6800000000000068
ff808181559758460155975857240092	5113100004	5113100163	24	24	84.8299999999999983	88.4000000000000057
ff808181559758460155975857380093	5113100004	5113100184	24	24	40.509999999999998	49.3699999999999974
ff808181559758460155975857450094	5113100004	5113100152	24	24	84.8299999999999983	88.4000000000000057
ff8081815597584601559758576a0095	5113100004	5113100101	24	24	16.7300000000000004	29.1000000000000014
ff808181559758460155975857790096	5113100004	5113100134	24	24	84.8299999999999983	88.4000000000000057
ff808181559758460155975857880097	5113100004	5113100180	24	24	88.2399999999999949	89.9200000000000017
ff808181559758460155975857980098	5113100004	5113100011	24	24	54.4699999999999989	80.3599999999999994
ff808181559758460155975857b30099	5113100150	5113100045	24	24	16.1700000000000017	28.7899999999999991
ff808181559758460155975857c4009a	5113100150	5113100005	24	24	10.1699999999999999	27.120000000000001
ff808181559758460155975857d5009b	5113100150	5113100039	24	24	10.1699999999999999	32.2100000000000009
ff808181559758460155975857e2009c	5113100150	5113100121	24	24	11.0199999999999996	11.8699999999999992
ff808181559758460155975857f7009d	5113100150	5113100061	24	24	11.8699999999999992	40.6799999999999997
ff80818155975846015597585807009e	5113100150	5113100163	24	24	10.1699999999999999	32.2100000000000009
ff8081815597584601559758581c009f	5113100150	5113100184	24	24	8.86999999999999922	18.3599999999999994
ff8081815597584601559758582900a0	5113100150	5113100152	24	24	10.1699999999999999	32.2100000000000009
ff8081815597584601559758584d00a1	5113100150	5113100101	24	24	9.82000000000000028	14.1899999999999995
ff8081815597584601559758585b00a2	5113100150	5113100134	24	24	10.1699999999999999	32.2100000000000009
ff8081815597584601559758586c00a3	5113100150	5113100180	24	24	13.4499999999999993	40.3400000000000034
ff8081815597584601559758587c00a4	5113100150	5113100011	24	24	10.1699999999999999	27.9699999999999989
ff8081815597584601559758589100a5	5113100045	5113100005	24	24	30.8099999999999987	50.509999999999998
ff808181559758460155975858ab00a6	5113100045	5113100039	24	24	51.5200000000000031	52.5300000000000011
ff808181559758460155975858c200a7	5113100045	5113100121	24	24	5.05999999999999961	5.55999999999999961
ff808181559758460155975858d400a8	5113100045	5113100061	24	24	59.6000000000000014	59.6000000000000014
ff808181559758460155975858ed00a9	5113100045	5113100163	24	24	51.5200000000000031	52.5300000000000011
ff8081815597584601559758590a00aa	5113100045	5113100184	24	24	30.8099999999999987	51.5200000000000031
ff8081815597584601559758591f00ab	5113100045	5113100152	24	24	51.5200000000000031	52.5300000000000011
ff8081815597584601559758594c00ac	5113100045	5113100101	24	24	16.0100000000000016	33.1000000000000014
ff8081815597584601559758596200ad	5113100045	5113100134	24	24	51.5200000000000031	52.5300000000000011
ff8081815597584601559758597b00ae	5113100045	5113100180	24	24	60.1099999999999994	60.1099999999999994
ff8081815597584601559758599300af	5113100045	5113100011	24	24	43.9399999999999977	49.5
ff808181559758460155975859a500b0	5113100005	5113100039	24	24	16.370000000000001	81.8199999999999932
ff808181559758460155975859b200b1	5113100005	5113100121	24	24	5.88999999999999968	7.84999999999999964
ff808181559758460155975859be00b2	5113100005	5113100061	24	24	26.2800000000000011	81.3599999999999994
ff808181559758460155975859ce00b3	5113100005	5113100163	24	24	16.370000000000001	81.8199999999999932
ff808181559758460155975859e300b4	5113100005	5113100184	24	24	15.8300000000000001	48.1099999999999994
ff808181559758460155975859f000b5	5113100005	5113100152	24	24	16.370000000000001	81.8199999999999932
ff80818155975846015597585a1600b6	5113100005	5113100101	24	24	12.3699999999999992	26.9100000000000001
ff80818155975846015597585a2200b7	5113100005	5113100134	24	24	16.370000000000001	81.8199999999999932
ff80818155975846015597585a3300b8	5113100005	5113100180	24	24	26.8999999999999986	80.6800000000000068
ff80818155975846015597585a4300b9	5113100005	5113100011	24	24	9.52999999999999936	83.8100000000000023
ff80818155975846015597585a5100ba	5113100039	5113100121	24	24	7.28000000000000025	8.1899999999999995
ff80818155975846015597585a5d00bb	5113100039	5113100061	24	24	77.9699999999999989	83.0600000000000023
ff80818155975846015597585a6e00bc	5113100039	5113100163	24	24	99.0999999999999943	99.0999999999999943
ff80818155975846015597585a8200bd	5113100039	5113100184	24	24	36.7100000000000009	46.2100000000000009
ff80818155975846015597585a9700be	5113100039	5113100152	24	24	99.0999999999999943	99.0999999999999943
ff80818155975846015597585abb00bf	5113100039	5113100101	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597585ac900c0	5113100039	5113100134	24	24	99.0999999999999943	99.0999999999999943
ff80818155975846015597585ada00c1	5113100039	5113100180	24	24	77.3199999999999932	82.3599999999999994
ff80818155975846015597585aea00c2	5113100039	5113100011	24	24	63.6400000000000006	84.5499999999999972
ff80818155975846015597585af800c3	5113100121	5113100061	24	24	8.48000000000000043	9.33000000000000007
ff80818155975846015597585b0000c4	5113100121	5113100163	24	24	7.28000000000000025	8.1899999999999995
ff80818155975846015597585b0c00c5	5113100121	5113100184	24	24	6.96999999999999975	6.96999999999999975
ff80818155975846015597585b1900c6	5113100121	5113100152	24	24	7.28000000000000025	8.1899999999999995
ff80818155975846015597585b3500c7	5113100121	5113100101	24	24	3.64000000000000012	3.64000000000000012
ff80818155975846015597585b4200c8	5113100121	5113100134	24	24	7.28000000000000025	8.1899999999999995
ff80818155975846015597585b4b00c9	5113100121	5113100180	24	24	8.41000000000000014	9.25
ff80818155975846015597585b5300ca	5113100121	5113100011	24	24	7.62000000000000011	9.52999999999999936
ff80818155975846015597585b5f00cb	5113100061	5113100163	24	24	77.9699999999999989	83.0600000000000023
ff80818155975846015597585b7700cc	5113100061	5113100184	24	24	39.8800000000000026	50
ff80818155975846015597585b8900cd	5113100061	5113100152	24	24	77.9699999999999989	83.0600000000000023
ff80818155975846015597585bae00ce	5113100061	5113100101	24	24	16.370000000000001	28.7300000000000004
ff80818155975846015597585bbb00cf	5113100061	5113100134	24	24	77.9699999999999989	83.0600000000000023
ff80818155975846015597585bcc00d0	5113100061	5113100180	24	24	99.1599999999999966	99.1599999999999966
ff80818155975846015597585bdc00d1	5113100061	5113100011	24	24	54.240000000000002	77.1200000000000045
ff80818155975846015597585bf100d2	5113100163	5113100184	24	24	36.7100000000000009	46.2100000000000009
ff80818155975846015597585bfe00d3	5113100163	5113100152	24	24	100	100
ff80818155975846015597585c2200d4	5113100163	5113100101	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597585c2f00d5	5113100163	5113100134	24	24	100	100
ff80818155975846015597585c4100d6	5113100163	5113100180	24	24	77.3199999999999932	82.3599999999999994
ff80818155975846015597585c5100d7	5113100163	5113100011	24	24	64.5499999999999972	85.4599999999999937
ff80818155975846015597585c6500d8	5113100184	5113100152	24	24	36.7100000000000009	46.2100000000000009
ff80818155975846015597585c8a00d9	5113100184	5113100101	24	24	11.6400000000000006	26.9100000000000001
ff80818155975846015597585ca000da	5113100184	5113100134	24	24	36.7100000000000009	46.2100000000000009
ff80818155975846015597585cb200db	5113100184	5113100180	24	24	39.8800000000000026	50
ff80818155975846015597585cc000dc	5113100184	5113100011	24	24	27.8500000000000014	48.740000000000002
ff80818155975846015597585ce100dd	5113100152	5113100101	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597585cef00de	5113100152	5113100134	24	24	100	100
ff80818155975846015597585d0000df	5113100152	5113100180	24	24	77.3199999999999932	82.3599999999999994
ff80818155975846015597585d1000e0	5113100152	5113100011	24	24	64.5499999999999972	85.4599999999999937
ff80818155975846015597585d3400e1	5113100101	5113100134	24	24	16.0100000000000016	29.1000000000000014
ff80818155975846015597585d5700e2	5113100101	5113100180	24	24	16.0100000000000016	28.7300000000000004
ff80818155975846015597585d7700e3	5113100101	5113100011	24	24	15.6400000000000006	27.6400000000000006
ff80818155975846015597585d8600e4	5113100134	5113100180	24	24	77.3199999999999932	82.3599999999999994
ff80818155975846015597585d9600e5	5113100134	5113100011	24	24	64.5499999999999972	85.4599999999999937
ff80818155975846015597585da700e6	5113100180	5113100011	24	24	53.7899999999999991	76.480000000000004
ff808181559765b101559765dd250026	5114100062	5114100089	24	26	21.1799999999999997	24.7100000000000009
ff808181559765b101559765dd550027	5114100062	5114100064	24	26	17.4299999999999997	18.9400000000000013
ff808181559765b101559765dd640028	5114100062	5114100179	24	26	47.2800000000000011	56.3699999999999974
ff808181559765b101559765dd730029	5114100062	5114100034	24	26	28.0799999999999983	35.0900000000000034
ff808181559765b101559765dd8f002a	5114100062	5114100151	24	26	15.1600000000000001	17.6799999999999997
ff808181559765b101559765ddbd002b	5114100062	5114100051	24	26	11.3000000000000007	13.5500000000000007
ff808181559765b101559765ddf0002c	5114100062	5114100020	24	26	14.9000000000000004	17.879999999999999
ff808181559765b101559765de26002d	5114100062	5114100110	24	26	15.1899999999999995	16.9100000000000001
ff808181559765b101559765de30002e	5114100062	5114100063	24	26	28.129999999999999	36.4600000000000009
ff808181559765b101559765de45002f	5114100062	5114100115	24	26	21.2199999999999989	32.5799999999999983
ff808181559765b101559765de5b0030	5114100062	5114100043	24	26	22.1600000000000001	30.6900000000000013
ff808181559765b101559765de6b0031	5114100062	5114100057	24	26	11.6600000000000001	29.129999999999999
ff808181559765b101559765de8a0032	5114100062	5114100019	24	26	19.6000000000000014	24.129999999999999
ff808181559765b101559765deae0033	5114100062	5114100015	24	26	20.5199999999999996	21.9800000000000004
ff808181559765b101559765debe0034	5114100062	5114100052	24	26	44.240000000000002	50
ff808181559765b101559765dede0035	5114100062	5114100053	24	26	19.8099999999999987	23.1900000000000013
ff808181559765b101559765df210036	5114100062	5114100086	24	26	12.2599999999999998	14.5199999999999996
ff808181559765b101559765df350037	5114100062	5114100704	24	26	28.3500000000000014	35.4399999999999977
ff808181559765b101559765df580038	5114100062	5114100128	24	26	8.08000000000000007	10
ff808181559765b101559765df6c0039	5114100062	5114100100	24	26	22.7300000000000004	26.1400000000000006
ff808181559765b101559765df7d003a	5114100062	5114100075	24	26	25	47.6199999999999974
ff808181559765b101559765dfa5003b	5114100062	5114100027	24	26	10.7400000000000002	14.4299999999999997
ff808181559765b101559765dfb7003c	5114100062	5114100165	24	26	11.6099999999999994	14.9199999999999999
ff808181559765b101559765dfe1003d	5114100062	5114100143	24	26	10.9499999999999993	12.0500000000000007
ff808181559765b101559765e012003e	5114100062	5114100154	24	26	8.84999999999999964	10.2100000000000009
ff808181559765b101559765e025003f	5114100062	5114100044	24	26	19.8900000000000006	25.1499999999999986
ff808181559765b101559765e03e0040	5114100062	5114100033	24	26	24.2699999999999996	31.370000000000001
ff808181559765b101559765e0720041	5114100062	5114100147	24	26	5.74000000000000021	11.0700000000000003
ff808181559765b101559765e0ae0042	5114100062	5114100188	24	26	11.4499999999999993	12.5399999999999991
ff808181559765b101559765e0c00043	5114100062	5114100105	24	26	24.8299999999999983	30.3500000000000014
ff808181559765b101559765e0cc0044	5114100062	5114100016	24	26	23.5300000000000011	36.2800000000000011
ff808181559765b101559765e0ee0045	5114100062	5114100035	24	26	17.7300000000000004	20.2600000000000016
ff808181559765b101559765e1000046	5114100062	5114100041	24	26	29.6600000000000001	37.25
ff808181559765b101559765e11f0047	5114100062	5114100178	24	26	24.3000000000000007	27.5799999999999983
ff808181559765b101559765e1340048	5114100062	5114100162	24	26	13.75	18.75
ff808181559765b101559765e13f0049	5114100062	5114100122	24	26	29.7899999999999991	37.240000000000002
ff808181559765b101559765e155004a	5114100062	5114100177	24	26	17.25	23.4499999999999993
ff808181559765b101559765e181004b	5114100089	5114100064	24	26	28.4100000000000001	40.9099999999999966
ff808181559765b101559765e1ad004c	5114100089	5114100179	24	26	22.9499999999999993	30.5899999999999999
ff808181559765b101559765e1c6004d	5114100089	5114100034	24	26	25.3000000000000007	26.4800000000000004
ff808181559765b101559765e1eb004e	5114100089	5114100151	24	26	13.6400000000000006	27.2800000000000011
ff808181559765b101559765e221004f	5114100089	5114100051	24	26	11.9399999999999995	22.9100000000000001
ff808181559765b101559765e24b0050	5114100089	5114100020	24	26	20.4299999999999997	37.0300000000000011
ff808181559765b101559765e28c0051	5114100089	5114100110	24	26	24.9299999999999997	30.6600000000000001
ff808181559765b101559765e2a60052	5114100089	5114100063	24	26	18.8299999999999983	25.3000000000000007
ff808181559765b101559765e2d30053	5114100089	5114100115	24	26	25.8900000000000006	35.8900000000000006
ff808181559765b101559765e2f20054	5114100089	5114100043	24	26	13.0700000000000003	25
ff808181559765b101559765e30a0055	5114100089	5114100057	24	26	14.7100000000000009	15.3000000000000007
ff808181559765b101559765e3310056	5114100089	5114100019	24	26	23.120000000000001	39.2000000000000028
ff808181559765b101559765e35c0057	5114100089	5114100015	24	26	15.3900000000000006	26.379999999999999
ff808181559765b101559765e3760058	5114100089	5114100052	24	26	21.7699999999999996	25.8900000000000006
ff808181559765b101559765e39e0059	5114100089	5114100053	24	26	17.879999999999999	30.9200000000000017
ff808181559765b101559765e3d1005a	5114100089	5114100086	24	26	11.3000000000000007	20.6499999999999986
ff808181559765b101559765e405005b	5114100089	5114100704	24	26	20	27.6499999999999986
ff808181559765b101559765e432005c	5114100089	5114100128	24	26	20.7699999999999996	33.8500000000000014
ff808181559765b101559765e45f005d	5114100089	5114100100	24	26	29.5500000000000007	53.9799999999999969
ff808181559765b101559765e488005e	5114100089	5114100075	24	26	22.3599999999999994	23.5300000000000011
ff808181559765b101559765e4ba005f	5114100089	5114100027	24	26	7.04999999999999982	15.4399999999999995
ff808181559765b101559765e4d30060	5114100089	5114100165	24	26	21.5500000000000007	46.4099999999999966
ff808181559765b101559765e5060061	5114100089	5114100143	24	26	18.9800000000000004	33.5799999999999983
ff808181559765b101559765e5530062	5114100089	5114100154	24	26	13.6099999999999994	20.0700000000000003
ff808181559765b101559765e5730063	5114100089	5114100044	24	26	14.6199999999999992	33.9200000000000017
ff808181559765b101559765e5940064	5114100089	5114100033	24	26	10	28.2399999999999984
ff808181559765b101559765e5c00065	5114100089	5114100147	24	26	12.3000000000000007	26.2300000000000004
ff808181559765b101559765e6040066	5114100089	5114100188	24	26	15.5399999999999991	16.629999999999999
ff808181559765b101559765e61e0067	5114100089	5114100105	24	26	11.1799999999999997	21.1799999999999997
ff808181559765b101559765e6330068	5114100089	5114100016	24	26	20	29.4200000000000017
ff808181559765b101559765e66b0069	5114100089	5114100035	24	26	25.3200000000000003	43.8900000000000006
ff808181559765b101559765e681006a	5114100089	5114100041	24	26	9.41999999999999993	28.2399999999999984
ff808181559765b101559765e6a7006b	5114100089	5114100178	24	26	27.1099999999999994	38.3200000000000003
ff808181559765b101559765e6c5006c	5114100089	5114100162	24	26	8.83000000000000007	18.8299999999999983
ff808181559765b101559765e6d8006d	5114100089	5114100122	24	26	24.120000000000001	30
ff808181559765b101559765e6f7006e	5114100089	5114100177	24	26	17.0599999999999987	28.2399999999999984
ff808181559765b101559765e71d006f	5114100064	5114100179	24	26	20.8399999999999999	25.379999999999999
ff808181559765b101559765e7470070	5114100064	5114100034	24	26	15.1600000000000001	17.8099999999999987
ff808181559765b101559765e7830071	5114100064	5114100151	24	26	13.6400000000000006	20.4600000000000009
ff808181559765b101559765e7d00072	5114100064	5114100051	24	26	16.4600000000000009	33.5499999999999972
ff808181559765b101559765e8050073	5114100064	5114100020	24	26	18.1900000000000013	45.4600000000000009
ff808181559765b101559765e8580074	5114100064	5114100110	24	26	34.9600000000000009	53.5900000000000034
ff808181559765b101559765e8810075	5114100064	5114100063	24	26	13.6400000000000006	15.5399999999999991
ff808181559765b101559765e8b30076	5114100064	5114100115	24	26	20.4600000000000009	31.0700000000000003
ff808181559765b101559765e8e70077	5114100064	5114100043	24	26	8.72000000000000064	22.3500000000000014
ff808181559765b101559765e9100078	5114100064	5114100057	24	26	8.33999999999999986	12.8800000000000008
ff808181559765b101559765e9480079	5114100064	5114100019	24	26	27.6600000000000001	45.0799999999999983
ff808181559765b101559765e984007a	5114100064	5114100015	24	26	17.2199999999999989	31.5100000000000016
ff808181559765b101559765e9b1007b	5114100064	5114100052	24	26	10.9900000000000002	15.9100000000000001
ff808181559765b101559765e9e7007c	5114100064	5114100053	24	26	25	31.4400000000000013
ff808181559765b101559765ea34007d	5114100064	5114100086	24	26	12.9100000000000001	22.5899999999999999
ff808181559765b101559765ea60007e	5114100064	5114100704	24	26	14.4000000000000004	23.1099999999999994
ff808181559765b101559765ea9b007f	5114100064	5114100128	24	26	17.0500000000000007	40.5399999999999991
ff808181559765b101559765eacc0080	5114100064	5114100100	24	26	40.1599999999999966	51.1400000000000006
ff808181559765b101559765eaf20081	5114100064	5114100075	24	26	11.75	13.6400000000000006
ff808181559765b101559765eb330082	5114100064	5114100027	24	26	6.37999999999999989	18.4600000000000009
ff808181559765b101559765eb5e0083	5114100064	5114100165	24	26	20.8399999999999999	29.5500000000000007
ff808181559765b101559765eba20084	5114100064	5114100143	24	26	14.9700000000000006	36.1400000000000006
ff808181559765b101559765ebef0085	5114100064	5114100154	24	26	13.2699999999999996	26.1999999999999993
ff808181559765b101559765ec200086	5114100064	5114100044	24	26	18.9400000000000013	31.8200000000000003
ff808181559765b101559765ec520087	5114100064	5114100033	24	26	7.95999999999999996	24.25
ff808181559765b101559765ec8f0088	5114100064	5114100147	24	26	11.75	30.6900000000000013
ff808181559765b101559765ece80089	5114100064	5114100188	24	26	20.7100000000000009	27.8000000000000007
ff808181559765b101559765ed15008a	5114100064	5114100105	24	26	10.6099999999999994	17.4299999999999997
ff808181559765b101559765ed3b008b	5114100064	5114100016	24	26	15.1600000000000001	18.5700000000000003
ff808181559765b101559765ed76008c	5114100064	5114100035	24	26	37.5	61.3699999999999974
ff808181559765b101559765eda2008d	5114100064	5114100041	24	26	6.82000000000000028	18.1900000000000013
ff808181559765b101559765edde008e	5114100064	5114100178	24	26	36.3699999999999974	50.759999999999998
ff808181559765b101559765ee08008f	5114100064	5114100162	24	26	5.30999999999999961	14.4000000000000004
ff808181559765b101559765ee2c0090	5114100064	5114100122	24	26	17.4299999999999997	19.3200000000000003
ff808181559765b101559765ee5a0091	5114100064	5114100177	24	26	20.0799999999999983	27.2800000000000011
ff808181559765b101559765ee6a0092	5114100179	5114100034	24	26	28.9499999999999993	42.990000000000002
ff808181559765b101559765ee870093	5114100179	5114100151	24	26	23.2399999999999984	24.25
ff808181559765b101559765eebe0094	5114100179	5114100051	24	26	15.1699999999999999	18.7100000000000009
ff808181559765b101559765eedd0095	5114100179	5114100020	24	26	23.4100000000000001	25.9600000000000009
ff808181559765b101559765ef1a0096	5114100179	5114100110	24	26	23.5	24.6499999999999986
ff808181559765b101559765ef280097	5114100179	5114100063	24	26	33.6400000000000006	40.9099999999999966
ff808181559765b101559765ef3d0098	5114100179	5114100115	24	26	27.2800000000000011	44.7000000000000028
ff808181559765b101559765ef520099	5114100179	5114100043	24	26	32.9600000000000009	40.3500000000000014
ff808181559765b101559765ef63009a	5114100179	5114100057	24	26	10.9100000000000001	34.5499999999999972
ff808181559765b101559765ef82009b	5114100179	5114100019	24	26	25.629999999999999	31.1600000000000001
ff808181559765b101559765efaf009c	5114100179	5114100015	24	26	23.4499999999999993	28.2100000000000009
ff808181559765b101559765efbe009d	5114100179	5114100052	24	26	30.9100000000000001	54.5499999999999972
ff808181559765b101559765efdf009e	5114100179	5114100053	24	26	26.5799999999999983	34.2999999999999972
ff808181559765b101559765f015009f	5114100179	5114100086	24	26	14.8399999999999999	18.7100000000000009
ff808181559765b101559765f02500a0	5114100179	5114100704	24	26	41.740000000000002	54.3400000000000034
ff808181559765b101559765f04800a1	5114100179	5114100128	24	26	12.3100000000000005	14.6199999999999992
ff808181559765b101559765f05c00a2	5114100179	5114100100	24	26	39.2100000000000009	39.7800000000000011
ff808181559765b101559765f06d00a3	5114100179	5114100075	24	26	25.4600000000000009	41.8200000000000003
ff808181559765b101559765f09500a4	5114100179	5114100027	24	26	15.4399999999999995	21.4800000000000004
ff808181559765b101559765f0af00a5	5114100179	5114100165	24	26	15.4700000000000006	20.4499999999999993
ff808181559765b101559765f0d800a6	5114100179	5114100143	24	26	14.5999999999999996	15.3300000000000001
ff808181559765b101559765f10900a7	5114100179	5114100154	24	26	10.8900000000000006	15.3100000000000005
ff808181559765b101559765f12600a8	5114100179	5114100044	24	26	33.3400000000000034	37.4299999999999997
ff808181559765b101559765f14200a9	5114100179	5114100033	24	26	32.5499999999999972	43.7899999999999991
ff808181559765b101559765f16200aa	5114100179	5114100147	24	26	6.96999999999999975	13.9399999999999995
ff808181559765b101559765f19e00ab	5114100179	5114100188	24	26	20.7100000000000009	20.9899999999999984
ff808181559765b101559765f1b800ac	5114100179	5114100105	24	26	28.9699999999999989	39.3200000000000003
ff808181559765b101559765f1cc00ad	5114100179	5114100016	24	26	25.4600000000000009	40.9099999999999966
ff808181559765b101559765f1ef00ae	5114100179	5114100035	24	26	23.629999999999999	28.2800000000000011
ff808181559765b101559765f20100af	5114100179	5114100041	24	26	24.1400000000000006	41.3800000000000026
ff808181559765b101559765f21f00b0	5114100179	5114100178	24	26	34.5799999999999983	37.8599999999999994
ff808181559765b101559765f23500b1	5114100179	5114100162	24	26	18.75	23.129999999999999
ff808181559765b101559765f24800b2	5114100179	5114100122	24	26	27.2800000000000011	35.4600000000000009
ff808181559765b101559765f26200b3	5114100179	5114100177	24	26	26.8999999999999986	33.1099999999999994
ff808181559765b101559765f27f00b4	5114100034	5114100151	24	26	23.7399999999999984	27.2800000000000011
ff808181559765b101559765f2b700b5	5114100034	5114100051	24	26	11.6199999999999992	13.5500000000000007
ff808181559765b101559765f2d700b6	5114100034	5114100020	24	26	17.879999999999999	19.1499999999999986
ff808181559765b101559765f31000b7	5114100034	5114100110	24	26	16.620000000000001	19.4899999999999984
ff808181559765b101559765f32100b8	5114100034	5114100063	24	26	28.0799999999999983	39.4799999999999969
ff808181559765b101559765f33600b9	5114100034	5114100115	24	26	25.7600000000000016	28.0399999999999991
ff808181559765b101559765f34c00ba	5114100034	5114100043	24	26	27.2800000000000011	31.8200000000000003
ff808181559765b101559765f35c00bb	5114100034	5114100057	24	26	12.2899999999999991	22.8099999999999987
ff808181559765b101559765f37b00bc	5114100034	5114100019	24	26	21.6099999999999994	25.129999999999999
ff808181559765b101559765f3ab00bd	5114100034	5114100015	24	26	19.0500000000000007	24.5500000000000007
ff808181559765b101559765f3b700be	5114100034	5114100052	24	26	30.7100000000000009	45.6199999999999974
ff808181559765b101559765f3d800bf	5114100034	5114100053	24	26	17.3999999999999986	19.3299999999999983
ff808181559765b101559765f40a00c0	5114100034	5114100086	24	26	11.3000000000000007	11.9399999999999995
ff808181559765b101559765f41e00c1	5114100034	5114100704	24	26	29.1400000000000006	48.8200000000000003
ff808181559765b101559765f44000c2	5114100034	5114100128	24	26	16.9299999999999997	20.3900000000000006
ff808181559765b101559765f45500c3	5114100034	5114100100	24	26	22.1600000000000001	23.3000000000000007
ff808181559765b101559765f46500c4	5114100034	5114100075	24	26	43.8599999999999994	52.6400000000000006
ff808181559765b101559765f48d00c5	5114100034	5114100027	24	26	11.0800000000000001	18.4600000000000009
ff808181559765b101559765f4a800c6	5114100034	5114100165	24	26	17.6799999999999997	26.5199999999999996
ff808181559765b101559765f4d500c7	5114100034	5114100143	24	26	16.4299999999999997	18.9800000000000004
ff808181559765b101559765f50300c8	5114100034	5114100154	24	26	16.3299999999999983	18.370000000000001
ff808181559765b101559765f51f00c9	5114100034	5114100044	24	26	22.8099999999999987	26.9100000000000001
ff808181559765b101559765f53700ca	5114100034	5114100033	24	26	22.4899999999999984	33.7299999999999969
ff808181559765b101559765f55b00cb	5114100034	5114100147	24	26	11.8900000000000006	18.0399999999999991
ff808181559765b101559765f59700cc	5114100034	5114100188	24	26	11.7200000000000006	11.9900000000000002
ff808181559765b101559765f5b100cd	5114100034	5114100105	24	26	14.4900000000000002	29.6600000000000001
ff808181559765b101559765f5c500ce	5114100034	5114100016	24	26	28.9499999999999993	42.1099999999999994
ff808181559765b101559765f5eb00cf	5114100034	5114100035	24	26	16.4600000000000009	17.7300000000000004
ff808181559765b101559765f60200d0	5114100034	5114100041	24	26	17.9400000000000013	36.5600000000000023
ff808181559765b101559765f62000d1	5114100034	5114100178	24	26	24.7699999999999996	28.5100000000000016
ff808181559765b101559765f63600d2	5114100034	5114100162	24	26	10.6300000000000008	12.5
ff808181559765b101559765f64900d3	5114100034	5114100122	24	26	25.4400000000000013	33.3400000000000034
ff808181559765b101559765f65f00d4	5114100034	5114100177	24	26	15.1799999999999997	19.3200000000000003
ff808181559765b101559765f6a300d5	5114100151	5114100051	24	26	13.2300000000000004	26.129999999999999
ff808181559765b101559765f6d200d6	5114100151	5114100020	24	26	11.9199999999999999	23.8299999999999983
ff808181559765b101559765f71900d7	5114100151	5114100110	24	26	14.0500000000000007	17.7699999999999996
ff808181559765b101559765f73600d8	5114100151	5114100063	24	26	18.6900000000000013	21.7199999999999989
ff808181559765b101559765f75300d9	5114100151	5114100115	24	26	16.1700000000000017	26.2699999999999996
ff808181559765b101559765f77a00da	5114100151	5114100043	24	26	20.2100000000000009	30.3099999999999987
ff808181559765b101559765f79b00db	5114100151	5114100057	24	26	11.1199999999999992	13.1400000000000006
ff808181559765b101559765f7c200dc	5114100151	5114100019	24	26	10.0600000000000005	26.1400000000000006
ff808181559765b101559765f7ff00dd	5114100151	5114100015	24	26	18.3200000000000003	29.6799999999999997
ff808181559765b101559765f81f00de	5114100151	5114100052	24	26	17.1799999999999997	23.7399999999999984
ff808181559765b101559765f84c00df	5114100151	5114100053	24	26	12.5700000000000003	30.9200000000000017
ff808181559765b101559765f88c00e0	5114100151	5114100086	24	26	11.9399999999999995	19.3599999999999994
ff808181559765b101559765f8a800e1	5114100151	5114100704	24	26	23.7399999999999984	30.3099999999999987
ff808181559765b101559765f8da00e2	5114100151	5114100128	24	26	16.1600000000000001	31.5399999999999991
ff808181559765b101559765f8ff00e3	5114100151	5114100100	24	26	14.6500000000000004	20.7100000000000009
ff808181559765b101559765f91800e4	5114100151	5114100075	24	26	19.6999999999999993	23.7399999999999984
ff808181559765b101559765f94f00e5	5114100151	5114100027	24	26	11.75	27.5199999999999996
ff808181559765b101559765f97500e6	5114100151	5114100165	24	26	18.6900000000000013	36.8699999999999974
ff808181559765b101559765f9a600e7	5114100151	5114100143	24	26	14.2400000000000002	31.7600000000000016
ff808181559765b101559765f9e100e8	5114100151	5114100154	24	26	13.9499999999999993	25.1799999999999997
ff808181559765b101559765fa0400e9	5114100151	5114100044	24	26	17.6799999999999997	32.8299999999999983
ff808181559765b101559765fa2d00ea	5114100151	5114100033	24	26	17.1799999999999997	27.7800000000000011
ff808181559765b101559765fa5a00eb	5114100151	5114100147	24	26	8.19999999999999929	23.370000000000001
ff808181559765b101559765faa800ec	5114100151	5114100188	24	26	10.9000000000000004	13.6300000000000008
ff808181559765b101559765fac800ed	5114100151	5114100105	24	26	17.6799999999999997	21.2199999999999989
ff808181559765b101559765fae500ee	5114100151	5114100016	24	26	19.6999999999999993	23.2399999999999984
ff808181559765b101559765fb1000ef	5114100151	5114100035	24	26	15.1899999999999995	24.0599999999999987
ff808181559765b101559765fb3300f0	5114100151	5114100041	24	26	14.6500000000000004	29.3000000000000007
ff808181559765b101559765fb6200f1	5114100151	5114100178	24	26	16.3599999999999994	29.9100000000000001
ff808181559765b101559765fb8c00f2	5114100151	5114100162	24	26	10.6099999999999994	20.7100000000000009
ff808181559765b101559765fbac00f3	5114100151	5114100122	24	26	18.1900000000000013	23.7399999999999984
ff808181559765b101559765fbca00f4	5114100151	5114100177	24	26	10.6099999999999994	13.6400000000000006
ff808181559765b101559765fc0e00f5	5114100051	5114100020	24	26	16.129999999999999	30.9699999999999989
ff808181559765b101559765fc6800f6	5114100051	5114100110	24	26	14.6199999999999992	31.2399999999999984
ff808181559765b101559765fc9d00f7	5114100051	5114100063	24	26	10.6500000000000004	12.5899999999999999
ff808181559765b101559765fcd100f8	5114100051	5114100115	24	26	16.4600000000000009	23.2300000000000004
ff808181559765b101559765fd1000f9	5114100051	5114100043	24	26	9.03999999999999915	20.6499999999999986
ff808181559765b101559765fd4200fa	5114100051	5114100057	24	26	6.45999999999999996	12.9100000000000001
ff808181559765b101559765fd8100fb	5114100051	5114100019	24	26	17.75	29.3599999999999994
ff808181559765b101559765fdd400fc	5114100051	5114100015	24	26	17.75	35.1700000000000017
ff808181559765b101559765fe0900fd	5114100051	5114100052	24	26	9.03999999999999915	12.9100000000000001
ff808181559765b101559765fe4c00fe	5114100051	5114100053	24	26	24.5199999999999996	33.2299999999999969
ff808181559765b101559765fe9e00ff	5114100051	5114100086	24	26	8.07000000000000028	29.6799999999999997
ff808181559765b101559765fed80100	5114100051	5114100704	24	26	15.8100000000000005	20.3299999999999983
ff808181559765b101559765ff200101	5114100051	5114100128	24	26	9.67999999999999972	30.9699999999999989
ff808181559765b101559765ff570102	5114100051	5114100100	24	26	17.75	27.1000000000000014
ff808181559765b101559765ff870103	5114100051	5114100075	24	26	9.35999999999999943	10.9700000000000006
ff808181559765b101559765ffd80104	5114100051	5114100027	24	26	4.20000000000000018	21.620000000000001
ff808181559765b10155976600170105	5114100051	5114100165	24	26	14.5199999999999996	25.8099999999999987
ff808181559765b10155976600620106	5114100051	5114100143	24	26	10.9700000000000006	30.6499999999999986
ff808181559765b10155976600b30107	5114100051	5114100154	24	26	9.67999999999999972	34.2000000000000028
ff808181559765b10155976600f30108	5114100051	5114100044	24	26	22.5899999999999999	30.3299999999999983
ff808181559765b10155976601330109	5114100051	5114100033	24	26	7.09999999999999964	20.6499999999999986
ff808181559765b1015597660177010a	5114100051	5114100147	24	26	11.3000000000000007	28.7100000000000009
ff808181559765b10155976601d7010b	5114100051	5114100188	24	26	14.9900000000000002	25.620000000000001
ff808181559765b1015597660214010c	5114100051	5114100105	24	26	8.71000000000000085	19.0399999999999991
ff808181559765b1015597660246010d	5114100051	5114100016	24	26	10.9700000000000006	14.5199999999999996
ff808181559765b1015597660289010e	5114100051	5114100035	24	26	14.8399999999999999	33.2299999999999969
ff808181559765b10155976602bd010f	5114100051	5114100041	24	26	6.78000000000000025	15.8100000000000005
ff808181559765b10155976603040110	5114100051	5114100178	24	26	25.8099999999999987	32.259999999999998
ff808181559765b101559766033f0111	5114100051	5114100162	24	26	9.67999999999999972	23.5500000000000007
ff808181559765b10155976603700112	5114100051	5114100122	24	26	12.9100000000000001	17.75
ff808181559765b10155976603a80113	5114100051	5114100177	24	26	13.8800000000000008	19.3599999999999994
ff808181559765b10155976603f30114	5114100020	5114100110	24	26	20.6400000000000006	35.8200000000000003
ff808181559765b10155976604150115	5114100020	5114100063	24	26	14.9000000000000004	16.6000000000000014
ff808181559765b101559766043f0116	5114100020	5114100115	24	26	26.3900000000000006	35.75
ff808181559765b101559766046b0117	5114100020	5114100043	24	26	13.1999999999999993	28.5199999999999996
ff808181559765b101559766048b0118	5114100020	5114100057	24	26	10.6400000000000006	20
ff808181559765b10155976604ba0119	5114100020	5114100019	24	26	20.8599999999999994	45.1099999999999994
ff808181559765b10155976604f9011a	5114100020	5114100015	24	26	16.4899999999999984	33.7000000000000028
ff808181559765b1015597660518011b	5114100020	5114100052	24	26	12.3499999999999996	14.9000000000000004
ff808181559765b101559766054a011c	5114100020	5114100053	24	26	20.8599999999999994	34.8999999999999986
ff808181559765b1015597660590011d	5114100020	5114100086	24	26	13.5500000000000007	20
ff808181559765b10155976605b1011e	5114100020	5114100704	24	26	21.7100000000000009	27.6600000000000001
ff808181559765b10155976605e4011f	5114100020	5114100128	24	26	16.5399999999999991	37.3100000000000023
ff808181559765b101559766060a0120	5114100020	5114100100	24	26	27.2399999999999984	44.6899999999999977
ff808181559765b101559766062b0121	5114100020	5114100075	24	26	13.1999999999999993	14.4700000000000006
ff808181559765b10155976606630122	5114100020	5114100027	24	26	9.74000000000000021	24.8399999999999999
ff808181559765b10155976606930123	5114100020	5114100165	24	26	13.1999999999999993	30.2199999999999989
ff808181559765b10155976606c80124	5114100020	5114100143	24	26	12.4100000000000001	37.2299999999999969
ff808181559765b101559766070c0125	5114100020	5114100154	24	26	11.5700000000000003	22.7899999999999991
ff808181559765b101559766073f0126	5114100020	5114100044	24	26	25.9600000000000009	33.6199999999999974
ff808181559765b10155976607690127	5114100020	5114100033	24	26	10.2200000000000006	31.0700000000000003
ff808181559765b101559766079e0128	5114100020	5114100147	24	26	8.19999999999999929	27.870000000000001
ff808181559765b10155976607ec0129	5114100020	5114100188	24	26	17.4400000000000013	24.2600000000000016
ff808181559765b1015597660814012a	5114100020	5114100105	24	26	11.0700000000000003	23.4100000000000001
ff808181559765b1015597660839012b	5114100020	5114100016	24	26	17.4499999999999993	19.1499999999999986
ff808181559765b101559766086c012c	5114100020	5114100035	24	26	16.0399999999999991	53.5900000000000034
ff808181559765b101559766088f012d	5114100020	5114100041	24	26	9.78999999999999915	20.8599999999999994
ff808181559765b10155976608be012e	5114100020	5114100178	24	26	24.2600000000000016	42.5600000000000023
ff808181559765b10155976608e4012f	5114100020	5114100162	24	26	6.38999999999999968	20.8599999999999994
ff808181559765b101559766090b0130	5114100020	5114100122	24	26	17.0300000000000011	20.4299999999999997
ff808181559765b101559766092f0131	5114100020	5114100177	24	26	31.4899999999999984	34.0499999999999972
ff808181559765b10155976609610132	5114100110	5114100063	24	26	11.75	13.7599999999999998
ff808181559765b10155976609990133	5114100110	5114100115	24	26	19.1999999999999993	22.9299999999999997
ff808181559765b10155976609d70134	5114100110	5114100043	24	26	14.6199999999999992	23.2100000000000009
ff808181559765b1015597660a170135	5114100110	5114100057	24	26	7.74000000000000021	11.1799999999999997
ff808181559765b1015597660a590136	5114100110	5114100019	24	26	24.9299999999999997	38.6899999999999977
ff808181559765b1015597660aa90137	5114100110	5114100015	24	26	18.3399999999999999	32.6700000000000017
ff808181559765b1015597660ae20138	5114100110	5114100052	24	26	14.3300000000000001	16.0500000000000007
ff808181559765b1015597660b300139	5114100110	5114100053	24	26	21.2100000000000009	24.9299999999999997
ff808181559765b1015597660b89013a	5114100110	5114100086	24	26	11.75	20.0599999999999987
ff808181559765b1015597660bce013b	5114100110	5114100704	24	26	18.629999999999999	24.6499999999999986
ff808181559765b1015597660c1b013c	5114100110	5114100128	24	26	16.620000000000001	32.6700000000000017
ff808181559765b1015597660c5c013d	5114100110	5114100100	24	26	37.25	40.9799999999999969
ff808181559765b1015597660c92013e	5114100110	5114100075	24	26	12.6099999999999994	14.3300000000000001
ff808181559765b1015597660ce7013f	5114100110	5114100027	24	26	7.16999999999999993	19.7800000000000011
ff808181559765b1015597660d280140	5114100110	5114100165	24	26	16.9100000000000001	23.2100000000000009
ff808181559765b1015597660d810141	5114100110	5114100143	24	26	16.620000000000001	32.1000000000000014
ff808181559765b1015597660dd60142	5114100110	5114100154	24	26	11.4700000000000006	22.3500000000000014
ff808181559765b1015597660e1c0143	5114100110	5114100044	24	26	22.3500000000000014	25.5100000000000016
ff808181559765b1015597660e5d0144	5114100110	5114100033	24	26	12.6099999999999994	23.7899999999999991
ff808181559765b1015597660eaf0145	5114100110	5114100147	24	26	13.1899999999999995	24.6499999999999986
ff808181559765b1015597660f130146	5114100110	5114100188	24	26	20.7100000000000009	31.6099999999999994
ff808181559765b1015597660f550147	5114100110	5114100105	24	26	12.3300000000000001	17.7699999999999996
ff808181559765b1015597660f8a0148	5114100110	5114100016	24	26	13.7599999999999998	16.3399999999999999
ff808181559765b1015597660fdb0149	5114100110	5114100035	24	26	29.8000000000000007	41.8400000000000034
ff808181559765b1015597661012014a	5114100110	5114100041	24	26	12.3300000000000001	20.6400000000000006
ff808181559765b1015597661059014b	5114100110	5114100178	24	26	35.25	42.7000000000000028
ff808181559765b1015597661099014c	5114100110	5114100162	24	26	6.01999999999999957	11.4700000000000006
ff808181559765b10155976610d2014d	5114100110	5114100122	24	26	15.4800000000000004	16.3399999999999999
ff808181559765b101559766110e014e	5114100110	5114100177	24	26	18.9200000000000017	21.7800000000000011
ff808181559765b101559766111f014f	5114100063	5114100115	24	26	18.9400000000000013	28.0399999999999991
ff808181559765b10155976611340150	5114100063	5114100043	24	26	22.1600000000000001	23.3000000000000007
ff808181559765b10155976611450151	5114100063	5114100057	24	26	12.6300000000000008	24.2800000000000011
ff808181559765b10155976611630152	5114100063	5114100019	24	26	15.0800000000000001	19.1000000000000014
ff808181559765b10155976611870153	5114100063	5114100015	24	26	13.9199999999999999	17.9499999999999993
ff808181559765b10155976611980154	5114100063	5114100052	24	26	23.0799999999999983	41.3500000000000014
ff808181559765b10155976611b80155	5114100063	5114100053	24	26	14.0099999999999998	19.3299999999999983
ff808181559765b10155976611ea0156	5114100063	5114100086	24	26	10	11.3000000000000007
ff808181559765b10155976611fe0157	5114100063	5114100704	24	26	30.7100000000000009	33.8599999999999994
ff808181559765b10155976612240158	5114100063	5114100128	24	26	11.1600000000000001	14.2400000000000002
ff808181559765b101559766123e0159	5114100063	5114100100	24	26	17.620000000000001	21.0300000000000011
ff808181559765b101559766124e015a	5114100063	5114100075	24	26	19.8000000000000007	41.6700000000000017
ff808181559765b1015597661277015b	5114100063	5114100027	24	26	11.4100000000000001	15.1099999999999994
ff808181559765b1015597661291015c	5114100063	5114100165	24	26	16.5799999999999983	20.4499999999999993
ff808181559765b10155976612bb015d	5114100063	5114100143	24	26	13.5099999999999998	16.0599999999999987
ff808181559765b10155976612ec015e	5114100063	5114100154	24	26	9.86999999999999922	11.9100000000000001
ff808181559765b1015597661307015f	5114100063	5114100044	24	26	19.8900000000000006	21.0599999999999987
ff808181559765b10155976613200160	5114100063	5114100033	24	26	22.4899999999999984	25.4499999999999993
ff808181559765b10155976613440161	5114100063	5114100147	24	26	6.96999999999999975	15.5800000000000001
ff808181559765b10155976613840162	5114100063	5114100188	24	26	9.8100000000000005	11.7200000000000006
ff808181559765b10155976613990163	5114100063	5114100105	24	26	18.629999999999999	31.0399999999999991
ff808181559765b10155976613a50164	5114100063	5114100016	24	26	33.3400000000000034	54.9099999999999966
ff808181559765b10155976613c80165	5114100063	5114100035	24	26	14.7699999999999996	16.4600000000000009
ff808181559765b10155976613da0166	5114100063	5114100041	24	26	18.629999999999999	26.8999999999999986
ff808181559765b10155976613f80167	5114100063	5114100178	24	26	20.1000000000000014	22.4299999999999997
ff808181559765b101559766140d0168	5114100063	5114100162	24	26	10.6300000000000008	13.7599999999999998
ff808181559765b10155976614190169	5114100063	5114100122	24	26	30.2100000000000009	45.8400000000000034
ff808181559765b101559766142f016a	5114100063	5114100177	24	26	9.66000000000000014	15.1799999999999997
ff808181559765b1015597661448016b	5114100115	5114100043	24	26	26.1400000000000006	31.8200000000000003
ff808181559765b1015597661458016c	5114100115	5114100057	24	26	15.9100000000000001	30.3099999999999987
ff808181559765b1015597661476016d	5114100115	5114100019	24	26	25.129999999999999	36.6899999999999977
ff808181559765b10155976614a4016e	5114100115	5114100015	24	26	21.9800000000000004	29.6799999999999997
ff808181559765b10155976614b3016f	5114100115	5114100052	24	26	23.4899999999999984	28.7899999999999991
ff808181559765b10155976614dc0170	5114100115	5114100053	24	26	25.6099999999999994	37.6899999999999977
ff808181559765b101559766150f0171	5114100115	5114100086	24	26	20.3299999999999983	22.5899999999999999
ff808181559765b10155976615220172	5114100115	5114100704	24	26	24.25	40.1599999999999966
ff808181559765b101559766154e0173	5114100115	5114100128	24	26	17.6999999999999993	30
ff808181559765b101559766156a0174	5114100115	5114100100	24	26	27.2800000000000011	42.0499999999999972
ff808181559765b101559766157a0175	5114100115	5114100075	24	26	23.4899999999999984	24.25
ff808181559765b10155976615a40176	5114100115	5114100027	24	26	12.4199999999999999	20.8099999999999987
ff808181559765b10155976615be0177	5114100115	5114100165	24	26	19.3399999999999999	33.1499999999999986
ff808181559765b10155976615e70178	5114100115	5114100143	24	26	16.7899999999999991	20.4400000000000013
ff808181559765b101559766161b0179	5114100115	5114100154	24	26	18.0300000000000011	22.1099999999999994
ff808181559765b1015597661634017a	5114100115	5114100044	24	26	35.6799999999999997	43.2800000000000011
ff808181559765b101559766164c017b	5114100115	5114100033	24	26	21.3099999999999987	37.2800000000000011
ff808181559765b101559766166f017c	5114100115	5114100147	24	26	15.9900000000000002	27.870000000000001
ff808181559765b10155976616b5017d	5114100115	5114100188	24	26	15.5399999999999991	17.7199999999999989
ff808181559765b10155976616d9017e	5114100115	5114100105	24	26	11.7300000000000004	32.4200000000000017
ff808181559765b10155976616f4017f	5114100115	5114100016	24	26	19.6999999999999993	31.0700000000000003
ff808181559765b101559766172c0180	5114100115	5114100035	24	26	27.4299999999999997	37.9799999999999969
ff808181559765b101559766174c0181	5114100115	5114100041	24	26	13.1099999999999994	30.3500000000000014
ff808181559765b101559766177c0182	5114100115	5114100178	24	26	29.9100000000000001	39.259999999999998
ff808181559765b10155976617950183	5114100115	5114100162	24	26	19.379999999999999	35.6300000000000026
ff808181559765b10155976617a90184	5114100115	5114100122	24	26	24.25	34.8500000000000014
ff808181559765b10155976617bf0185	5114100115	5114100177	24	26	28.2800000000000011	37.25
ff808181559765b10155976617d90186	5114100043	5114100057	24	26	12.5	22.7300000000000004
ff808181559765b10155976617ff0187	5114100043	5114100019	24	26	12.5700000000000003	28.1499999999999986
ff808181559765b10155976618350188	5114100043	5114100015	24	26	15.7599999999999998	33.3400000000000034
ff808181559765b101559766184d0189	5114100043	5114100052	24	26	22.7300000000000004	30.120000000000001
ff808181559765b1015597661876018a	5114100043	5114100053	24	26	11.5999999999999996	28.9899999999999984
ff808181559765b10155976618b1018b	5114100043	5114100086	24	26	10.9700000000000006	17.4200000000000017
ff808181559765b10155976618d1018c	5114100043	5114100704	24	26	35.7999999999999972	44.8900000000000006
ff808181559765b1015597661900018d	5114100043	5114100128	24	26	11.5399999999999991	18.4699999999999989
ff808181559765b101559766191d018e	5114100043	5114100100	24	26	10.2300000000000004	31.8200000000000003
ff808181559765b1015597661936018f	5114100043	5114100075	24	26	24.4400000000000013	26.7100000000000009
ff808181559765b10155976619660190	5114100043	5114100027	24	26	16.1099999999999994	25.8399999999999999
ff808181559765b10155976619890191	5114100043	5114100165	24	26	13.2599999999999998	26.5199999999999996
ff808181559765b10155976619bc0192	5114100043	5114100143	24	26	14.5999999999999996	17.5199999999999996
ff808181559765b10155976619f50193	5114100043	5114100154	24	26	12.5899999999999999	18.0300000000000011
ff808181559765b1015597661a1c0194	5114100043	5114100044	24	26	18.1900000000000013	39.2100000000000009
ff808181559765b1015597661a390195	5114100043	5114100033	24	26	27.2800000000000011	47.7299999999999969
ff808181559765b1015597661a660196	5114100043	5114100147	24	26	6.96999999999999975	13.1199999999999992
ff808181559765b1015597661aaa0197	5114100043	5114100188	24	26	9.26999999999999957	19.0799999999999983
ff808181559765b1015597661acb0198	5114100043	5114100105	24	26	31.25	33.5300000000000011
ff808181559765b1015597661ae00199	5114100043	5114100016	24	26	25.5700000000000003	26.1400000000000006
ff808181559765b1015597661b0c019a	5114100043	5114100035	24	26	16.0399999999999991	26.5899999999999999
ff808181559765b1015597661b26019b	5114100043	5114100041	24	26	22.1600000000000001	33.5300000000000011
ff808181559765b1015597661b50019c	5114100043	5114100178	24	26	26.6400000000000006	51.4099999999999966
ff808181559765b1015597661b6a019d	5114100043	5114100162	24	26	13.6400000000000006	27.2800000000000011
ff808181559765b1015597661b86019e	5114100043	5114100122	24	26	17.620000000000001	20.4600000000000009
ff808181559765b1015597661ba4019f	5114100043	5114100177	24	26	15.9100000000000001	25
ff808181559765b1015597661bbe01a0	5114100057	5114100019	24	26	12.0700000000000003	18.1000000000000014
ff808181559765b1015597661bea01a1	5114100057	5114100015	24	26	8.80000000000000071	15.0199999999999996
ff808181559765b1015597661bfa01a2	5114100057	5114100052	24	26	16.3500000000000014	27.8900000000000006
ff808181559765b1015597661c1b01a3	5114100057	5114100053	24	26	11.1199999999999992	18.3599999999999994
ff808181559765b1015597661c4c01a4	5114100057	5114100086	24	26	8.07000000000000028	10.9700000000000006
ff808181559765b1015597661c6101a5	5114100057	5114100704	24	26	11.0299999999999994	32.2899999999999991
ff808181559765b1015597661c8801a6	5114100057	5114100128	24	26	9.61999999999999922	10.3900000000000006
ff808181559765b1015597661ca101a7	5114100057	5114100100	24	26	11.9399999999999995	21.6000000000000014
ff808181559765b1015597661cb101a8	5114100057	5114100075	24	26	11.6600000000000001	23.3099999999999987
ff808181559765b1015597661cda01a9	5114100057	5114100027	24	26	17.7899999999999991	19.129999999999999
ff808181559765b1015597661cf401aa	5114100057	5114100165	24	26	13.2599999999999998	15.4700000000000006
ff808181559765b1015597661d1e01ab	5114100057	5114100143	24	26	8.02999999999999936	10.2200000000000006
ff808181559765b1015597661d4e01ac	5114100057	5114100154	24	26	9.52999999999999936	9.52999999999999936
ff808181559765b1015597661d6b01ad	5114100057	5114100044	24	26	15.2100000000000009	23.9800000000000004
ff808181559765b1015597661d8301ae	5114100057	5114100033	24	26	12.4299999999999997	26.0399999999999991
ff808181559765b1015597661da701af	5114100057	5114100147	24	26	9.01999999999999957	9.01999999999999957
ff808181559765b1015597661de601b0	5114100057	5114100188	24	26	6.26999999999999957	11.1799999999999997
ff808181559765b1015597661dfc01b1	5114100057	5114100105	24	26	11.7300000000000004	28.9699999999999989
ff808181559765b1015597661e0801b2	5114100057	5114100016	24	26	5.83000000000000007	22.3399999999999999
ff808181559765b1015597661e2b01b3	5114100057	5114100035	24	26	8.86999999999999922	16.0399999999999991
ff808181559765b1015597661e3d01b4	5114100057	5114100041	24	26	10.3499999999999996	21.379999999999999
ff808181559765b1015597661e5b01b5	5114100057	5114100178	24	26	10.75	18.6999999999999993
ff808181559765b1015597661e7101b6	5114100057	5114100162	24	26	7.5	21.879999999999999
ff808181559765b1015597661e7c01b7	5114100057	5114100122	24	26	11.6600000000000001	22.3399999999999999
ff808181559765b1015597661e9201b8	5114100057	5114100177	24	26	10.3499999999999996	25.5199999999999996
ff808181559765b1015597661ec401b9	5114100019	5114100015	24	26	21.25	28.5799999999999983
ff808181559765b1015597661eee01ba	5114100019	5114100052	24	26	14.5800000000000001	19.6000000000000014
ff808181559765b1015597661f1701bb	5114100019	5114100053	24	26	22.2300000000000004	39.6199999999999974
ff808181559765b1015597661f5401bc	5114100019	5114100086	24	26	13.8800000000000008	25.1700000000000017
ff808181559765b1015597661f7601bd	5114100019	5114100704	24	26	22.120000000000001	31.1600000000000001
ff808181559765b1015597661faa01be	5114100019	5114100128	24	26	19.2399999999999984	34.6199999999999974
ff808181559765b1015597661fce01bf	5114100019	5114100100	24	26	34.1799999999999997	47.240000000000002
ff808181559765b1015597661fe701c0	5114100019	5114100075	24	26	16.0899999999999999	19.1000000000000014
ff808181559765b101559766201901c1	5114100019	5114100027	24	26	6.04999999999999982	17.120000000000001
ff808181559765b101559766203b01c2	5114100019	5114100165	24	26	15.0800000000000001	31.1600000000000001
ff808181559765b101559766207001c3	5114100019	5114100143	24	26	21.1700000000000017	32.1199999999999974
ff808181559765b10155976620af01c4	5114100019	5114100154	24	26	13.9499999999999993	26.879999999999999
ff808181559765b10155976620d301c5	5114100019	5114100044	24	26	24.129999999999999	39.7000000000000028
ff808181559765b10155976620fc01c6	5114100019	5114100033	24	26	9.05000000000000071	31.1600000000000001
ff808181559765b101559766212f01c7	5114100019	5114100147	24	26	13.5299999999999994	31.5599999999999987
ff808181559765b101559766217d01c8	5114100019	5114100188	24	26	21.2600000000000016	25.0700000000000003
ff808181559765b10155976621a201c9	5114100019	5114100105	24	26	12.0700000000000003	24.129999999999999
ff808181559765b10155976621c401ca	5114100019	5114100016	24	26	18.1000000000000014	22.120000000000001
ff808181559765b10155976621f801cb	5114100019	5114100035	24	26	23.2100000000000009	43.0399999999999991
ff808181559765b101559766221a01cc	5114100019	5114100041	24	26	9.55000000000000071	24.129999999999999
ff808181559765b101559766224901cd	5114100019	5114100178	24	26	28.0399999999999991	46.7299999999999969
ff808181559765b101559766226f01ce	5114100019	5114100162	24	26	6.04000000000000004	20.1099999999999994
ff808181559765b101559766228b01cf	5114100019	5114100122	24	26	20.1099999999999994	26.6400000000000006
ff808181559765b10155976622b101d0	5114100019	5114100177	24	26	26.6400000000000006	33.1700000000000017
ff808181559765b10155976622dd01d1	5114100015	5114100052	24	26	17.5899999999999999	21.25
ff808181559765b101559766231b01d2	5114100015	5114100053	24	26	25.6499999999999986	34.4399999999999977
ff808181559765b101559766236701d3	5114100015	5114100086	24	26	12.2599999999999998	27.75
ff808181559765b101559766239301d4	5114100015	5114100704	24	26	23.4499999999999993	27.4800000000000004
ff808181559765b10155976623d001d5	5114100015	5114100128	24	26	8.0600000000000005	29.3099999999999987
ff808181559765b101559766240501d6	5114100015	5114100100	24	26	21.25	29.3099999999999987
ff808181559765b101559766243101d7	5114100015	5114100075	24	26	13.9199999999999999	19.0500000000000007
ff808181559765b101559766247101d8	5114100015	5114100027	24	26	6.37999999999999989	28.1900000000000013
ff808181559765b10155976624a201d9	5114100015	5114100165	24	26	13.1899999999999995	27.8399999999999999
ff808181559765b10155976624e601da	5114100015	5114100143	24	26	8.02999999999999936	29.5700000000000003
ff808181559765b101559766253001db	5114100015	5114100154	24	26	7.83000000000000007	27.2199999999999989
ff808181559765b101559766256801dc	5114100015	5114100044	24	26	24.1799999999999997	35.5399999999999991
ff808181559765b101559766259501dd	5114100015	5114100033	24	26	13.1899999999999995	34.7999999999999972
ff808181559765b10155976625d301de	5114100015	5114100147	24	26	10.6300000000000008	26.7399999999999984
ff808181559765b101559766262701df	5114100015	5114100188	24	26	15.2599999999999998	25.620000000000001
ff808181559765b101559766265201e0	5114100015	5114100105	24	26	12.0899999999999999	24.5500000000000007
ff808181559765b101559766268301e1	5114100015	5114100016	24	26	17.9499999999999993	21.25
ff808181559765b10155976626bc01e2	5114100015	5114100035	24	26	19.0500000000000007	38.1000000000000014
ff808181559765b10155976626e601e3	5114100015	5114100041	24	26	15.0199999999999996	25.6499999999999986
ff808181559765b101559766271c01e4	5114100015	5114100178	24	26	31.1400000000000006	43.9600000000000009
ff808181559765b101559766274c01e5	5114100015	5114100162	24	26	12.8300000000000001	26.379999999999999
ff808181559765b101559766277801e6	5114100015	5114100122	24	26	18.3200000000000003	20.5199999999999996
ff808181559765b10155976627ab01e7	5114100015	5114100177	24	26	20.1499999999999986	23.0799999999999983
ff808181559765b10155976627ca01e8	5114100052	5114100053	24	26	15.4600000000000009	21.2600000000000016
ff808181559765b10155976627fc01e9	5114100052	5114100086	24	26	10.9700000000000006	12.5899999999999999
ff808181559765b101559766281001ea	5114100052	5114100704	24	26	25.9899999999999984	37.7999999999999972
ff808181559765b101559766283301eb	5114100052	5114100128	24	26	11.1600000000000001	15.3900000000000006
ff808181559765b101559766284701ec	5114100052	5114100100	24	26	17.0500000000000007	21.0300000000000011
ff808181559765b101559766285801ed	5114100052	5114100075	24	26	33.6599999999999966	44.240000000000002
ff808181559765b101559766288001ee	5114100052	5114100027	24	26	12.7599999999999998	17.120000000000001
ff808181559765b101559766289201ef	5114100052	5114100165	24	26	16.5799999999999983	23.7600000000000016
ff808181559765b10155976628bc01f0	5114100052	5114100143	24	26	11.6799999999999997	15.3300000000000001
ff808181559765b10155976628f201f1	5114100052	5114100154	24	26	12.5899999999999999	13.9499999999999993
ff808181559765b101559766290901f2	5114100052	5114100044	24	26	21.0599999999999987	22.8099999999999987
ff808181559765b101559766292101f3	5114100052	5114100033	24	26	24.2699999999999996	31.370000000000001
ff808181559765b101559766294501f4	5114100052	5114100147	24	26	6.15000000000000036	13.5299999999999994
ff808181559765b101559766298001f5	5114100052	5114100188	24	26	9.26999999999999957	11.1799999999999997
ff808181559765b101559766299201f6	5114100052	5114100105	24	26	13.8000000000000007	28.9699999999999989
ff808181559765b101559766299e01f7	5114100052	5114100016	24	26	20.1999999999999993	42.3100000000000023
ff808181559765b10155976629c201f8	5114100052	5114100035	24	26	11.4000000000000004	16.879999999999999
ff808181559765b10155976629d301f9	5114100052	5114100041	24	26	33.1099999999999994	45.5200000000000031
ff808181559765b10155976629f101fa	5114100052	5114100178	24	26	19.1600000000000001	26.1700000000000017
ff808181559765b1015597662a0701fb	5114100052	5114100162	24	26	10	11.8800000000000008
ff808181559765b1015597662a1201fc	5114100052	5114100122	24	26	23.0799999999999983	35.5799999999999983
ff808181559765b1015597662a2801fd	5114100052	5114100177	24	26	7.58999999999999986	14.4900000000000002
ff808181559765b1015597662a6d01fe	5114100053	5114100086	24	26	26.4600000000000009	36.7800000000000011
ff808181559765b1015597662a9201ff	5114100053	5114100704	24	26	18.8500000000000014	27.0599999999999987
ff808181559765b1015597662ac60200	5114100053	5114100128	24	26	16.9299999999999997	27.6999999999999993
ff808181559765b1015597662ae90201	5114100053	5114100100	24	26	24.6400000000000006	40.1000000000000014
ff808181559765b1015597662b0b0202	5114100053	5114100075	24	26	14.9800000000000004	16.4299999999999997
ff808181559765b1015597662b450203	5114100053	5114100027	24	26	8.73000000000000043	19.129999999999999
ff808181559765b1015597662b6e0204	5114100053	5114100165	24	26	16.9100000000000001	34.7899999999999991
ff808181559765b1015597662bad0205	5114100053	5114100143	24	26	17.8900000000000006	31.3900000000000006
ff808181559765b1015597662beb0206	5114100053	5114100154	24	26	18.370000000000001	35.3800000000000026
ff808181559765b1015597662c180207	5114100053	5114100044	24	26	33.8200000000000003	51.2100000000000009
ff808181559765b1015597662c410208	5114100053	5114100033	24	26	9.66999999999999993	31.4100000000000001
ff808181559765b1015597662c740209	5114100053	5114100147	24	26	20.5	47.1400000000000006
ff808181559765b1015597662cc6020a	5114100053	5114100188	24	26	19.3500000000000014	19.620000000000001
ff808181559765b1015597662cec020b	5114100053	5114100105	24	26	11.5999999999999996	24.1600000000000001
ff808181559765b1015597662d09020c	5114100053	5114100016	24	26	14.9800000000000004	20.7800000000000011
ff808181559765b1015597662d3d020d	5114100053	5114100035	24	26	21.1000000000000014	39.25
ff808181559765b1015597662d5e020e	5114100053	5114100041	24	26	9.66999999999999993	24.6400000000000006
ff808181559765b1015597662d8e020f	5114100053	5114100178	24	26	30.379999999999999	42.0600000000000023
ff808181559765b1015597662db40210	5114100053	5114100162	24	26	11.1199999999999992	26.5799999999999983
ff808181559765b1015597662dcf0211	5114100053	5114100122	24	26	18.3599999999999994	24.6400000000000006
ff808181559765b1015597662dfa0212	5114100053	5114100177	24	26	22.2300000000000004	27.0599999999999987
ff808181559765b1015597662e2f0213	5114100086	5114100704	24	26	12.5899999999999999	18.7100000000000009
ff808181559765b1015597662e720214	5114100086	5114100128	24	26	9.67999999999999972	21.9400000000000013
ff808181559765b1015597662ea80215	5114100086	5114100100	24	26	13.5500000000000007	19.6799999999999997
ff808181559765b1015597662ed90216	5114100086	5114100075	24	26	9.67999999999999972	11.9399999999999995
ff808181559765b1015597662f2a0217	5114100086	5114100027	24	26	4.20000000000000018	16.7800000000000011
ff808181559765b1015597662f5f0218	5114100086	5114100165	24	26	13.2300000000000004	24.5199999999999996
ff808181559765b1015597662fab0219	5114100086	5114100143	24	26	10.3300000000000001	20.3299999999999983
ff808181559765b1015597662ffc021a	5114100086	5114100154	24	26	10.3300000000000001	24.1999999999999993
ff808181559765b1015597663032021b	5114100086	5114100044	24	26	19.3599999999999994	23.879999999999999
ff808181559765b101559766306f021c	5114100086	5114100033	24	26	8.39000000000000057	18.3900000000000006
ff808181559765b10155976630b0021d	5114100086	5114100147	24	26	20.6499999999999986	40.6499999999999986
ff808181559765b101559766310f021e	5114100086	5114100188	24	26	7.91000000000000014	15.5399999999999991
ff808181559765b1015597663148021f	5114100086	5114100105	24	26	9.67999999999999972	14.5199999999999996
ff808181559765b101559766317a0220	5114100086	5114100016	24	26	9.03999999999999915	12.2599999999999998
ff808181559765b10155976631bb0221	5114100086	5114100035	24	26	12.9100000000000001	23.2300000000000004
ff808181559765b10155976631ee0222	5114100086	5114100041	24	26	9.67999999999999972	16.7800000000000011
ff808181559765b101559766322e0223	5114100086	5114100178	24	26	14.8399999999999999	20.9699999999999989
ff808181559765b10155976632640224	5114100086	5114100162	24	26	11.6199999999999992	19.3599999999999994
ff808181559765b101559766329d0225	5114100086	5114100122	24	26	10.6500000000000004	14.1999999999999993
ff808181559765b10155976632cf0226	5114100086	5114100177	24	26	13.5500000000000007	15.8100000000000005
ff808181559765b10155976632f40227	5114100704	5114100128	24	26	12.3100000000000005	18.4699999999999989
ff808181559765b10155976633100228	5114100704	5114100100	24	26	27.2800000000000011	32.3900000000000006
ff808181559765b10155976633210229	5114100704	5114100075	24	26	29.9299999999999997	36.2299999999999969
ff808181559765b101559766334a022a	5114100704	5114100027	24	26	19.8000000000000007	26.8500000000000014
ff808181559765b1015597663364022b	5114100704	5114100165	24	26	18.7899999999999991	25.9699999999999989
ff808181559765b101559766338e022c	5114100704	5114100143	24	26	15.6999999999999993	18.9800000000000004
ff808181559765b10155976633be022d	5114100704	5114100154	24	26	12.5899999999999999	15.9900000000000002
ff808181559765b10155976633de022e	5114100704	5114100044	24	26	30.4100000000000001	38.6000000000000014
ff808181559765b10155976633fb022f	5114100704	5114100033	24	26	33.1400000000000006	46.1599999999999966
ff808181559765b101559766341f0230	5114100704	5114100147	24	26	6.96999999999999975	13.1199999999999992
ff808181559765b10155976634630231	5114100704	5114100188	24	26	16.0799999999999983	17.4400000000000013
ff808181559765b101559766347d0232	5114100704	5114100105	24	26	32.4200000000000017	46.8999999999999986
ff808181559765b10155976634910233	5114100704	5114100016	24	26	27.5599999999999987	33.0799999999999983
ff808181559765b10155976634b40234	5114100704	5114100035	24	26	21.5199999999999996	26.1700000000000017
ff808181559765b10155976634c60235	5114100704	5114100041	24	26	22.7600000000000016	35.8699999999999974
ff808181559765b10155976634ed0236	5114100704	5114100178	24	26	30.379999999999999	37.3900000000000006
ff808181559765b10155976635020237	5114100704	5114100162	24	26	18.75	24.379999999999999
ff808181559765b10155976635160238	5114100704	5114100122	24	26	22.0500000000000007	27.5599999999999987
ff808181559765b101559766352b0239	5114100704	5114100177	24	26	20.6900000000000013	33.1099999999999994
ff808181559765b101559766355d023a	5114100128	5114100100	24	26	18.0799999999999983	30.3900000000000006
ff808181559765b1015597663583023b	5114100128	5114100075	24	26	10.3900000000000006	13.0800000000000001
ff808181559765b10155976635bc023c	5114100128	5114100027	24	26	11.0800000000000001	16.7800000000000011
ff808181559765b10155976635e7023d	5114100128	5114100165	24	26	24.620000000000001	52.7000000000000028
ff808181559765b1015597663621023e	5114100128	5114100143	24	26	9.13000000000000078	44.8999999999999986
ff808181559765b1015597663668023f	5114100128	5114100154	24	26	12.5899999999999999	32.3200000000000003
ff808181559765b10155976636a80240	5114100128	5114100044	24	26	15.7699999999999996	25.7699999999999996
ff808181559765b10155976636db0241	5114100128	5114100033	24	26	11.1600000000000001	16.5399999999999991
ff808181559765b101559766370f0242	5114100128	5114100147	24	26	14.2400000000000002	38.8500000000000014
ff808181559765b10155976637640243	5114100128	5114100188	24	26	14.7200000000000006	18.8099999999999987
ff808181559765b101559766378e0244	5114100128	5114100105	24	26	10.3900000000000006	12.6999999999999993
ff808181559765b10155976637b70245	5114100128	5114100016	24	26	12.6999999999999993	15.7699999999999996
ff808181559765b10155976637f00246	5114100128	5114100035	24	26	16.1600000000000001	38.4699999999999989
ff808181559765b10155976638190247	5114100128	5114100041	24	26	9.61999999999999922	17.6999999999999993
ff808181559765b10155976638520248	5114100128	5114100178	24	26	16.9299999999999997	33.8500000000000014
ff808181559765b10155976638760249	5114100128	5114100162	24	26	5.76999999999999957	14.2400000000000002
ff808181559765b101559766389a024a	5114100128	5114100122	24	26	13.8499999999999996	17.3099999999999987
ff808181559765b10155976638c2024b	5114100128	5114100177	24	26	13.0800000000000001	18.0799999999999983
ff808181559765b10155976638d8024c	5114100100	5114100075	24	26	15.3499999999999996	19.3200000000000003
ff808181559765b101559766390e024d	5114100100	5114100027	24	26	9.40000000000000036	17.120000000000001
ff808181559765b101559766392c024e	5114100100	5114100165	24	26	19.3399999999999999	38.1300000000000026
ff808181559765b101559766395e024f	5114100100	5114100143	24	26	19.7100000000000009	30.6600000000000001
ff808181559765b10155976639970250	5114100100	5114100154	24	26	11.9100000000000001	22.1099999999999994
ff808181559765b10155976639bb0251	5114100100	5114100044	24	26	26.7100000000000009	45.4600000000000009
ff808181559765b10155976639dc0252	5114100100	5114100033	24	26	12.5	34.6599999999999966
ff808181559765b1015597663a080253	5114100100	5114100147	24	26	13.1199999999999992	28.6900000000000013
ff808181559765b1015597663a510254	5114100100	5114100188	24	26	20.7100000000000009	22.8900000000000006
ff808181559765b1015597663a6e0255	5114100100	5114100105	24	26	13.6400000000000006	27.8500000000000014
ff808181559765b1015597663a820256	5114100100	5114100016	24	26	21.0300000000000011	26.1400000000000006
ff808181559765b1015597663aaf0257	5114100100	5114100035	24	26	35.8699999999999974	53.5900000000000034
ff808181559765b1015597663ac80258	5114100100	5114100041	24	26	11.3699999999999992	25.5700000000000003
ff808181559765b1015597663aef0259	5114100100	5114100178	24	26	38.3200000000000003	53.740000000000002
ff808181559765b1015597663b0d025a	5114100100	5114100162	24	26	6.25	22.7300000000000004
ff808181559765b1015597663b20025b	5114100100	5114100122	24	26	25.5700000000000003	28.9800000000000004
ff808181559765b1015597663b3e025c	5114100100	5114100177	24	26	27.2800000000000011	42.6199999999999974
ff808181559765b1015597663b62025d	5114100075	5114100027	24	26	12.7599999999999998	15.7799999999999994
ff808181559765b1015597663b7b025e	5114100075	5114100165	24	26	14.3699999999999992	18.7899999999999991
ff808181559765b1015597663ba9025f	5114100075	5114100143	24	26	12.7799999999999994	14.5999999999999996
ff808181559765b1015597663bd70260	5114100075	5114100154	24	26	15.6500000000000004	15.6500000000000004
ff808181559765b1015597663bf20261	5114100075	5114100044	24	26	19.3000000000000007	20.4699999999999989
ff808181559765b1015597663c0a0262	5114100075	5114100033	24	26	23.0799999999999983	29
ff808181559765b1015597663c2e0263	5114100075	5114100147	24	26	14.7599999999999998	17.629999999999999
ff808181559765b1015597663c6a0264	5114100075	5114100188	24	26	8.72000000000000064	9.26999999999999957
ff808181559765b1015597663c7c0265	5114100075	5114100105	24	26	17.25	29.6600000000000001
ff808181559765b1015597663c870266	5114100075	5114100016	24	26	27.4600000000000009	43.1400000000000006
ff808181559765b1015597663cab0267	5114100075	5114100035	24	26	12.6600000000000001	13.9299999999999997
ff808181559765b1015597663cbc0268	5114100075	5114100041	24	26	24.8299999999999983	33.1099999999999994
ff808181559765b1015597663cdf0269	5114100075	5114100178	24	26	17.7600000000000016	21.9699999999999989
ff808181559765b1015597663cef026a	5114100075	5114100162	24	26	8.75999999999999979	12.5
ff808181559765b1015597663cfb026b	5114100075	5114100122	24	26	21.2800000000000011	38.2999999999999972
ff808181559765b1015597663d11026c	5114100075	5114100177	24	26	11.7300000000000004	15.1799999999999997
ff808181559765b1015597663d3d026d	5114100027	5114100165	24	26	10.7400000000000002	17.120000000000001
ff808181559765b1015597663d80026e	5114100027	5114100143	24	26	5.70999999999999996	20.4699999999999989
ff808181559765b1015597663dcb026f	5114100027	5114100154	24	26	6.37999999999999989	20.1400000000000006
ff808181559765b1015597663dfe0270	5114100027	5114100044	24	26	13.4299999999999997	21.8200000000000003
ff808181559765b1015597663e340271	5114100027	5114100033	24	26	21.8200000000000003	28.8599999999999994
ff808181559765b1015597663e6d0272	5114100027	5114100147	24	26	5.70999999999999996	12.4199999999999999
ff808181559765b1015597663ec30273	5114100027	5114100188	24	26	7.36000000000000032	17.1700000000000017
ff808181559765b1015597663eec0274	5114100027	5114100105	24	26	18.4600000000000009	24.1700000000000017
ff808181559765b1015597663f110275	5114100027	5114100016	24	26	11.75	14.7699999999999996
ff808181559765b1015597663f520276	5114100027	5114100035	24	26	8.73000000000000043	25.1700000000000017
ff808181559765b1015597663f800277	5114100027	5114100041	24	26	12.4199999999999999	24.8399999999999999
ff808181559765b1015597663fb80278	5114100027	5114100178	24	26	10.0700000000000003	24.8399999999999999
ff808181559765b1015597663fe60279	5114100027	5114100162	24	26	11.4100000000000001	17.4499999999999993
ff808181559765b101559766400a027a	5114100027	5114100122	24	26	9.40000000000000036	12.7599999999999998
ff808181559765b1015597664039027b	5114100027	5114100177	24	26	9.74000000000000021	14.4299999999999997
ff808181559765b101559766406e027c	5114100165	5114100143	24	26	18.25	37.9600000000000009
ff808181559765b10155976640ac027d	5114100165	5114100154	24	26	15.9900000000000002	25.5199999999999996
ff808181559765b10155976640cc027e	5114100165	5114100044	24	26	17.129999999999999	38.6799999999999997
ff808181559765b10155976640ec027f	5114100165	5114100033	24	26	12.7100000000000009	24.3099999999999987
ff808181559765b10155976641190280	5114100165	5114100147	24	26	19.6799999999999997	34.4299999999999997
ff808181559765b101559766415d0281	5114100165	5114100188	24	26	13.6300000000000008	16.0799999999999983
ff808181559765b10155976641760282	5114100165	5114100105	24	26	12.1600000000000001	18.2399999999999984
ff808181559765b101559766418b0283	5114100165	5114100016	24	26	19.3399999999999999	24.870000000000001
ff808181559765b10155976641b70284	5114100165	5114100035	24	26	16.4600000000000009	32.490000000000002
ff808181559765b10155976641d10285	5114100165	5114100041	24	26	12.1600000000000001	24.3099999999999987
ff808181559765b10155976641f90286	5114100165	5114100178	24	26	21.0300000000000011	36.4500000000000028
ff808181559765b10155976642140287	5114100165	5114100162	24	26	6.62999999999999989	17.6799999999999997
ff808181559765b10155976642280288	5114100165	5114100122	24	26	18.2399999999999984	22.6600000000000001
ff808181559765b10155976642470289	5114100165	5114100177	24	26	12.7100000000000009	25.4200000000000017
ff808181559765b101559766428c028a	5114100143	5114100154	24	26	9.52999999999999936	32.3200000000000003
ff808181559765b10155976642c0028b	5114100143	5114100044	24	26	18.620000000000001	29.5700000000000003
ff808181559765b10155976642f2028c	5114100143	5114100033	24	26	11.6799999999999997	17.5199999999999996
ff808181559765b1015597664332028d	5114100143	5114100147	24	26	10.9499999999999993	32.8500000000000014
ff808181559765b101559766438a028e	5114100143	5114100188	24	26	11.9900000000000002	17.9899999999999984
ff808181559765b10155976643b6028f	5114100143	5114100105	24	26	10.2200000000000006	15.3300000000000001
ff808181559765b10155976643da0290	5114100143	5114100016	24	26	12.7799999999999994	17.5199999999999996
ff808181559765b10155976644170291	5114100143	5114100035	24	26	17.8900000000000006	35.7700000000000031
ff808181559765b10155976644460292	5114100143	5114100041	24	26	10.9499999999999993	20.8099999999999987
ff808181559765b10155976644820293	5114100143	5114100178	24	26	24.4600000000000009	33.5799999999999983
ff808181559765b10155976644b00294	5114100143	5114100162	24	26	6.57000000000000028	11.6799999999999997
ff808181559765b10155976644d30295	5114100143	5114100122	24	26	14.5999999999999996	19.3500000000000014
ff808181559765b10155976645030296	5114100143	5114100177	24	26	12.7799999999999994	17.8900000000000006
ff808181559765b10155976645390297	5114100154	5114100044	24	26	21.0899999999999999	33
ff808181559765b10155976645770298	5114100154	5114100033	24	26	10.8900000000000006	17.0100000000000016
ff808181559765b10155976645b80299	5114100154	5114100147	24	26	16.3299999999999983	35.3800000000000026
ff808181559765b1015597664616029a	5114100154	5114100188	24	26	11.4499999999999993	19.0799999999999983
ff808181559765b1015597664647029b	5114100154	5114100105	24	26	8.84999999999999964	11.5700000000000003
ff808181559765b1015597664675029c	5114100154	5114100016	24	26	12.5899999999999999	12.9299999999999997
ff808181559765b10155976646bd029d	5114100154	5114100035	24	26	9.86999999999999922	24.8299999999999983
ff808181559765b10155976646ed029e	5114100154	5114100041	24	26	9.86999999999999922	17.0100000000000016
ff808181559765b101559766472c029f	5114100154	5114100178	24	26	16.3299999999999983	26.5399999999999991
ff808181559765b101559766476302a0	5114100154	5114100162	24	26	7.15000000000000036	15.9900000000000002
ff808181559765b101559766478f02a1	5114100154	5114100122	24	26	14.9700000000000006	16.6700000000000017
ff808181559765b10155976647ca02a2	5114100154	5114100177	24	26	9.86999999999999922	12.5899999999999999
ff808181559765b10155976647ee02a3	5114100044	5114100033	24	26	15.7899999999999991	45.6199999999999974
ff808181559765b101559766481902a4	5114100044	5114100147	24	26	14.7599999999999998	29.1000000000000014
ff808181559765b101559766485d02a5	5114100044	5114100188	24	26	18.8099999999999987	21.2600000000000016
ff808181559765b101559766487802a6	5114100044	5114100105	24	26	15.7899999999999991	29.8299999999999983
ff808181559765b101559766489402a7	5114100044	5114100016	24	26	19.3000000000000007	24.5700000000000003
ff808181559765b10155976648bf02a8	5114100044	5114100035	24	26	29.5399999999999991	35.8699999999999974
ff808181559765b10155976648da02a9	5114100044	5114100041	24	26	13.4600000000000009	29.2399999999999984
ff808181559765b101559766490502aa	5114100044	5114100178	24	26	37.3900000000000006	46.7299999999999969
ff808181559765b101559766492702ab	5114100044	5114100162	24	26	9.35999999999999943	32.1700000000000017
ff808181559765b101559766494302ac	5114100044	5114100122	24	26	23.9800000000000004	28.6600000000000001
ff808181559765b101559766496102ad	5114100044	5114100177	24	26	29.2399999999999984	36.259999999999998
ff808181559765b101559766499102ae	5114100033	5114100147	24	26	4.50999999999999979	13.9399999999999995
ff808181559765b10155976649d302af	5114100033	5114100188	24	26	8.72000000000000064	20.7100000000000009
ff808181559765b10155976649ef02b0	5114100033	5114100105	24	26	25.4499999999999993	39.0600000000000023
ff808181559765b1015597664a0b02b1	5114100033	5114100016	24	26	21.3099999999999987	26.0399999999999991
ff808181559765b1015597664a3f02b2	5114100033	5114100035	24	26	13.5099999999999998	31.6499999999999986
ff808181559765b1015597664a5d02b3	5114100033	5114100041	24	26	23.0799999999999983	34.9200000000000017
ff808181559765b1015597664a8802b4	5114100033	5114100178	24	26	16.8299999999999983	41.5900000000000034
ff808181559765b1015597664aa502b5	5114100033	5114100162	24	26	10.6600000000000001	27.2199999999999989
ff808181559765b1015597664ab902b6	5114100033	5114100122	24	26	16.5700000000000003	21.8999999999999986
ff808181559765b1015597664ad702b7	5114100033	5114100177	24	26	10.6600000000000001	30.1799999999999997
ff808181559765b1015597664b2502b8	5114100147	5114100188	24	26	10.9000000000000004	15.2599999999999998
ff808181559765b1015597664b4f02b9	5114100147	5114100105	24	26	4.91999999999999993	11.8900000000000006
ff808181559765b1015597664b7402ba	5114100147	5114100016	24	26	8.60999999999999943	17.2199999999999989
ff808181559765b1015597664bac02bb	5114100147	5114100035	24	26	8.19999999999999929	31.5599999999999987
ff808181559765b1015597664bd302bc	5114100147	5114100041	24	26	7.37999999999999989	18.4499999999999993
ff808181559765b1015597664c0a02bd	5114100147	5114100178	24	26	14.3499999999999996	32.3800000000000026
ff808181559765b1015597664c2f02be	5114100147	5114100162	24	26	9.42999999999999972	15.5800000000000001
ff808181559765b1015597664c5402bf	5114100147	5114100122	24	26	11.8900000000000006	22.5500000000000007
ff808181559765b1015597664c7a02c0	5114100147	5114100177	24	26	7.79000000000000004	17.2199999999999989
ff808181559765b1015597664cbe02c1	5114100188	5114100105	24	26	7.62999999999999989	14.1699999999999999
ff808181559765b1015597664d0002c2	5114100188	5114100016	24	26	10.9000000000000004	11.1799999999999997
ff808181559765b1015597664d5302c3	5114100188	5114100035	24	26	14.9900000000000002	21.8000000000000007
ff808181559765b1015597664d9602c4	5114100188	5114100041	24	26	6.82000000000000028	12.5399999999999991
ff808181559765b1015597664de702c5	5114100188	5114100178	24	26	23.4400000000000013	26.7100000000000009
ff808181559765b1015597664e3102c6	5114100188	5114100162	24	26	4.08999999999999986	11.9900000000000002
ff808181559765b1015597664e6b02c7	5114100188	5114100122	24	26	12.2699999999999996	12.2699999999999996
ff808181559765b1015597664ea902c8	5114100188	5114100177	24	26	15.5399999999999991	16.0799999999999983
ff808181559765b1015597664ec002c9	5114100105	5114100016	24	26	20.6900000000000013	29.6600000000000001
ff808181559765b1015597664eec02ca	5114100105	5114100035	24	26	16.4600000000000009	24.8999999999999986
ff808181559765b1015597664f0502cb	5114100105	5114100041	24	26	15.8699999999999992	35.1799999999999997
ff808181559765b1015597664f3002cc	5114100105	5114100178	24	26	14.0199999999999996	28.9800000000000004
ff808181559765b1015597664f4a02cd	5114100105	5114100162	24	26	13.1300000000000008	21.879999999999999
ff808181559765b1015597664f5d02ce	5114100105	5114100122	24	26	15.1799999999999997	23.4499999999999993
ff808181559765b1015597664f7302cf	5114100105	5114100177	24	26	7.58999999999999986	28.2800000000000011
ff808181559765b1015597664f9602d0	5114100016	5114100035	24	26	17.3000000000000007	20.6799999999999997
ff808181559765b1015597664fa702d1	5114100016	5114100041	24	26	20.6900000000000013	30.3500000000000014
ff808181559765b1015597664fc602d2	5114100016	5114100178	24	26	19.1600000000000001	28.0399999999999991
ff808181559765b1015597664fdb02d3	5114100016	5114100162	24	26	8.75999999999999979	15
ff808181559765b1015597664fe602d4	5114100016	5114100122	24	26	25.5	40.2000000000000028
ff808181559765b1015597664ffc02d5	5114100016	5114100177	24	26	15.8699999999999992	19.3200000000000003
ff808181559765b101559766501e02d6	5114100035	5114100041	24	26	10.9800000000000004	21.1000000000000014
ff808181559765b101559766505602d7	5114100035	5114100178	24	26	32.9200000000000017	50.6400000000000006
ff808181559765b101559766508002d8	5114100035	5114100162	24	26	10.9800000000000004	23.2100000000000009
ff808181559765b10155976650a002d9	5114100035	5114100122	24	26	20.2600000000000016	21.9499999999999993
ff808181559765b10155976650c602da	5114100035	5114100177	24	26	26.1700000000000017	31.2300000000000004
ff808181559765b10155976650ed02db	5114100041	5114100178	24	26	12.6199999999999992	28.9800000000000004
ff808181559765b101559766510102dc	5114100041	5114100162	24	26	8.13000000000000078	20
ff808181559765b101559766511502dd	5114100041	5114100122	24	26	16.5599999999999987	27.5899999999999999
ff808181559765b101559766512b02de	5114100041	5114100177	24	26	6.20999999999999996	26.2100000000000009
ff808181559765b101559766515202df	5114100178	5114100162	24	26	6.54999999999999982	21.5
ff808181559765b101559766516d02e0	5114100178	5114100122	24	26	21.0300000000000011	25.7100000000000009
ff808181559765b101559766519402e1	5114100178	5114100177	24	26	24.7699999999999996	33.1799999999999997
ff808181559765b10155976651a402e2	5114100162	5114100122	24	26	10.6300000000000008	15.6300000000000008
ff808181559765b10155976651be02e3	5114100162	5114100177	24	26	6.87999999999999989	28.75
ff808181559765b10155976651cd02e4	5114100122	5114100177	24	26	13.8000000000000007	21.379999999999999
\.


--
-- TOC entry 2199 (class 0 OID 57419)
-- Dependencies: 192
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
-- TOC entry 2200 (class 0 OID 57422)
-- Dependencies: 193
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY password_resets (email, token, created_at) FROM stdin;
admin@its.ac.id	03473469649752bc91d5b5c11580d4bd2bd1bc4410551aae84f36e5b2314fcd0	2016-04-03 15:56:15
\.


--
-- TOC entry 2201 (class 0 OID 57428)
-- Dependencies: 194
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
-- TOC entry 2264 (class 0 OID 0)
-- Dependencies: 195
-- Name: permission_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permission_role_id_seq', 71, true);


--
-- TOC entry 2203 (class 0 OID 57433)
-- Dependencies: 196
-- Data for Name: permission_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permission_user (id, permission_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2265 (class 0 OID 0)
-- Dependencies: 197
-- Name: permission_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permission_user_id_seq', 7, true);


--
-- TOC entry 2205 (class 0 OID 57438)
-- Dependencies: 198
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
-- TOC entry 2266 (class 0 OID 0)
-- Dependencies: 199
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permissions_id_seq', 123, true);


--
-- TOC entry 2207 (class 0 OID 57446)
-- Dependencies: 200
-- Data for Name: role_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY role_user (id, role_id, user_id, created_at, updated_at) FROM stdin;
15	35	7	2016-05-12 14:43:22	2016-05-12 14:43:22
17	37	3	2016-05-12 17:47:08	2016-05-12 17:47:08
20	36	1	2016-05-21 10:30:39	2016-05-21 10:30:39
33	41	2	2016-06-12 06:44:18	2016-06-12 06:44:18
34	37	10	2016-06-18 06:33:49	2016-06-18 06:33:49
35	37	11	2016-06-18 07:10:07	2016-06-18 07:10:07
36	37	12	2016-06-18 13:43:09	2016-06-18 13:43:09
37	37	13	2016-06-18 14:34:18	2016-06-18 14:34:18
38	37	14	2016-06-18 20:46:46	2016-06-18 20:46:46
\.


--
-- TOC entry 2267 (class 0 OID 0)
-- Dependencies: 201
-- Name: role_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('role_user_id_seq', 38, true);


--
-- TOC entry 2209 (class 0 OID 57451)
-- Dependencies: 202
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roles (id, name, slug, description, created_at, updated_at) FROM stdin;
36	Administrator	admin	Administrator	2016-05-12 17:08:34	2016-05-12 17:08:34
37	Mahasiswa	mhs	Mahasiswa	2016-05-12 17:42:46	2016-05-12 17:42:46
41	Dosen	dosen	Dosen	2016-06-11 19:33:07	2016-06-11 19:33:07
\.


--
-- TOC entry 2268 (class 0 OID 0)
-- Dependencies: 203
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_id_seq', 41, true);


--
-- TOC entry 2211 (class 0 OID 57459)
-- Dependencies: 204
-- Data for Name: sc_dosen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_dosen (id_seq_dosen, extension, file_name, hashcode, kelas, kodesoal, last_modified, level_seq, line, path, sequence, size) FROM stdin;
\.


--
-- TOC entry 2212 (class 0 OID 57465)
-- Dependencies: 205
-- Data for Name: sc_sequence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_sequence (id_seq_mhs, extension_mhs, file_name_mhs, hashcode_mhs, kelas_mhs, kodesoal, last_modified_mhs, level_mhs, line_mhs, nrp_mhs, path_mhs, sequence_mhs, size_mhs) FROM stdin;
\.


--
-- TOC entry 2213 (class 0 OID 57471)
-- Dependencies: 206
-- Data for Name: sc_similarity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_similarity (id_similarity, file_dosen, nrp, similarity_value_modif, similarity_value_smith, kelas, kodesoal) FROM stdin;
\.


--
-- TOC entry 2214 (class 0 OID 57477)
-- Dependencies: 207
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, name, email, password, remember_token, created_at, updated_at, nomorinduk) FROM stdin;
12	Mohammad Ardhiansyah Metana Putra	metana.p12@mhs.if.its.ac.id	$2y$10$KT32RLSklmPkck769jPa9OIL2FHVJmg6i3TQ7xQm2/F5zbOsoQAUq	xET7ZKEobAD0QlqIbEuMmlU4j1U4i7R2ABUWnzNzER2yEz3B0De5ocDqwJs9	2016-06-18 13:42:43	2016-06-18 13:56:00	5112100204
13	Argyanto Dimas N	argyantodimasn@gmail.com	$2y$10$B3/myzDU6k9.lZ60lQ2FmOPST671stmNvkLbBDUzbT88.tttCJ4VS	s0nE7Yf2PnYujU4iYjUOb51OmBkaK9HuU38VeGlmmSO1nVKBon82WKZ7ak9K	2016-06-18 14:33:14	2016-06-18 14:53:06	5112100109
14	Fananda Herda Perdana	fananda.herda@gmail.com	$2y$10$ThaY4Gp55W2kS5K1ZdOgm.t/WFc9m.wcMZjH5vSVZXdt.NibxCx5S	kni1lj0ScJrijwcf9MzHyF7SPcOAOF3y6QAqOMICcxEwXn5OwSO2I2yASSvn	2016-06-18 20:46:16	2016-06-18 20:57:13	5112100104
10	Ardhya	ardhya@gmail.com	$2y$10$nTpuFF9sNxzh.KWrL34xmuY/JYsuSeNB7TvDO7ItNQjqkyQs5IvVu	ck9sTq7dlY5H1xxsGOyg7DaxZm4X73uiTifE7VvSVNbc192wK3e6KP8iHXMG	2016-06-18 06:30:52	2016-06-18 07:06:25	5112100187
11	Fandy	fandazky@gmail.com	$2y$10$yz.x7T0qIM4lWFQaQN6iH.kC6YvP/exPKuMfBo31MGsqPZyzV9kF2	\N	2016-06-18 07:09:13	2016-06-18 07:09:13	5112100047
3	Mahasiswa	mahasiswa@its.ac.id	$2y$10$lDYeqSzHgAmFI4eadqj1Ee/2M2oWvt0X8xyDGL1JiglATsRWPBjha	Vnw14kvRJIHmRX2Z9zX8lytfc5oKA5wqBVrjFc4ng1uPJUeUeeVbw7UJdDA7	2016-04-10 12:02:16	2016-06-21 05:47:22	5112100096
2	Dosen	dosen@its.ac.id	$2y$10$bLIStAciirU9rJtSZzC2qOwdzvWikio9rhtCAcU6jIX6NPzjOLWPy	8EobgFwGRY6MEKT0HfujhBQTgi8bsaPnPfLXMvWWhaifgW3v6alDzOB62ASK	2016-04-10 12:01:33	2016-06-28 19:01:13	dosen001
1	Administrator	admin@its.ac.id	$2y$10$PCsaxDeYuUnatlTAAjsQtudiTwJVFUjYCTdbrL4eKbk.DiZnPQk2C	B8v1RSqWliwCH8lS7pYTJjaDE1117Xr25CfSYIFpsAutMQ7KgeG3QmlpAEcD	2016-04-03 14:41:24	2016-06-28 19:01:59	admin001
\.


--
-- TOC entry 2269 (class 0 OID 0)
-- Dependencies: 208
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 14, true);


SET search_path = elearning, pg_catalog;

--
-- TOC entry 2005 (class 2606 OID 57501)
-- Name: detail_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY detail
    ADD CONSTRAINT detail_pkey PRIMARY KEY (id);


--
-- TOC entry 2007 (class 2606 OID 57503)
-- Name: enrollment_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (id);


--
-- TOC entry 2009 (class 2606 OID 57505)
-- Name: kursus_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY kursus
    ADD CONSTRAINT kursus_pkey PRIMARY KEY (id);


--
-- TOC entry 2011 (class 2606 OID 57507)
-- Name: matakuliah_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY matakuliah
    ADD CONSTRAINT matakuliah_pkey PRIMARY KEY (id);


--
-- TOC entry 2013 (class 2606 OID 57509)
-- Name: pengumpulan_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY pengumpulan
    ADD CONSTRAINT pengumpulan_pkey PRIMARY KEY (id);


--
-- TOC entry 2015 (class 2606 OID 57511)
-- Name: periode_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT periode_pkey PRIMARY KEY (id);


--
-- TOC entry 2003 (class 2606 OID 57513)
-- Name: pk_convention; Type: CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY convention
    ADD CONSTRAINT pk_convention PRIMARY KEY (id);


--
-- TOC entry 2017 (class 2606 OID 57515)
-- Name: posting_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY posting
    ADD CONSTRAINT posting_pkey PRIMARY KEY (id);


--
-- TOC entry 2019 (class 2606 OID 57517)
-- Name: tugas_pkey; Type: CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY tugas
    ADD CONSTRAINT tugas_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2021 (class 2606 OID 57519)
-- Name: db_sequence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_sequence
    ADD CONSTRAINT db_sequence_pkey PRIMARY KEY (id_seq);


--
-- TOC entry 2023 (class 2606 OID 57521)
-- Name: db_similarity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_similarity
    ADD CONSTRAINT db_similarity_pkey PRIMARY KEY (id_sim);


--
-- TOC entry 2028 (class 2606 OID 57523)
-- Name: permission_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_role
    ADD CONSTRAINT permission_role_pkey PRIMARY KEY (id);


--
-- TOC entry 2032 (class 2606 OID 57525)
-- Name: permission_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_user
    ADD CONSTRAINT permission_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2037 (class 2606 OID 57527)
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2040 (class 2606 OID 57529)
-- Name: role_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_user
    ADD CONSTRAINT role_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2044 (class 2606 OID 57531)
-- Name: roles_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_name_unique UNIQUE (name);


--
-- TOC entry 2046 (class 2606 OID 57533)
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2048 (class 2606 OID 57535)
-- Name: roles_slug_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_slug_unique UNIQUE (slug);


--
-- TOC entry 2052 (class 2606 OID 57537)
-- Name: sb_sequence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_sequence
    ADD CONSTRAINT sb_sequence_pkey PRIMARY KEY (id_seq_mhs);


--
-- TOC entry 2050 (class 2606 OID 57539)
-- Name: sc_dosen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_dosen
    ADD CONSTRAINT sc_dosen_pkey PRIMARY KEY (id_seq_dosen);


--
-- TOC entry 2054 (class 2606 OID 57541)
-- Name: sc_similarity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_similarity
    ADD CONSTRAINT sc_similarity_pkey PRIMARY KEY (id_similarity);


--
-- TOC entry 2056 (class 2606 OID 57543)
-- Name: users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 2058 (class 2606 OID 57545)
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2024 (class 1259 OID 57546)
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX password_resets_email_index ON password_resets USING btree (email);


--
-- TOC entry 2025 (class 1259 OID 57547)
-- Name: password_resets_token_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX password_resets_token_index ON password_resets USING btree (token);


--
-- TOC entry 2026 (class 1259 OID 57548)
-- Name: permission_role_permission_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX permission_role_permission_id_index ON permission_role USING btree (permission_id);


--
-- TOC entry 2029 (class 1259 OID 57549)
-- Name: permission_role_role_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX permission_role_role_id_index ON permission_role USING btree (role_id);


--
-- TOC entry 2030 (class 1259 OID 57550)
-- Name: permission_user_permission_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX permission_user_permission_id_index ON permission_user USING btree (permission_id);


--
-- TOC entry 2033 (class 1259 OID 57551)
-- Name: permission_user_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX permission_user_user_id_index ON permission_user USING btree (user_id);


--
-- TOC entry 2034 (class 1259 OID 57552)
-- Name: permissions_inherit_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX permissions_inherit_id_index ON permissions USING btree (inherit_id);


--
-- TOC entry 2035 (class 1259 OID 57553)
-- Name: permissions_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX permissions_name_index ON permissions USING btree (name);


--
-- TOC entry 2038 (class 1259 OID 57554)
-- Name: permissions_slug_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX permissions_slug_index ON permissions USING btree (slug);


--
-- TOC entry 2041 (class 1259 OID 57555)
-- Name: role_user_role_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX role_user_role_id_index ON role_user USING btree (role_id);


--
-- TOC entry 2042 (class 1259 OID 57556)
-- Name: role_user_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX role_user_user_id_index ON role_user USING btree (user_id);


SET search_path = elearning, pg_catalog;

--
-- TOC entry 2071 (class 2620 OID 57557)
-- Name: t_total; Type: TRIGGER; Schema: elearning; Owner: postgres
--

CREATE TRIGGER t_total AFTER INSERT OR UPDATE ON detail FOR EACH ROW EXECUTE PROCEDURE tf_gettotal();


--
-- TOC entry 2064 (class 2606 OID 57558)
-- Name: enroll_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY pengumpulan
    ADD CONSTRAINT enroll_id_foreign FOREIGN KEY (enroll_id) REFERENCES enrollment(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2067 (class 2606 OID 57563)
-- Name: enrollment_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY tugas
    ADD CONSTRAINT enrollment_id_foreign FOREIGN KEY (enroll_id) REFERENCES enrollment(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2060 (class 2606 OID 57568)
-- Name: kursus_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY enrollment
    ADD CONSTRAINT kursus_id_foreign FOREIGN KEY (kursus_id) REFERENCES kursus(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2062 (class 2606 OID 57573)
-- Name: mk_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY kursus
    ADD CONSTRAINT mk_id_foreign FOREIGN KEY (mk_id) REFERENCES matakuliah(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2059 (class 2606 OID 57578)
-- Name: pengumpulan_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY detail
    ADD CONSTRAINT pengumpulan_id_foreign FOREIGN KEY (kumpul_id) REFERENCES pengumpulan(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2063 (class 2606 OID 57583)
-- Name: periode_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY kursus
    ADD CONSTRAINT periode_id_foreign FOREIGN KEY (periode_id) REFERENCES periode(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2065 (class 2606 OID 57588)
-- Name: tugas_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY pengumpulan
    ADD CONSTRAINT tugas_id_foreign FOREIGN KEY (tugas_id) REFERENCES tugas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2061 (class 2606 OID 57593)
-- Name: user_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY enrollment
    ADD CONSTRAINT user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2066 (class 2606 OID 57598)
-- Name: user_id_foreign; Type: FK CONSTRAINT; Schema: elearning; Owner: postgres
--

ALTER TABLE ONLY posting
    ADD CONSTRAINT user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


SET search_path = public, pg_catalog;

--
-- TOC entry 2068 (class 2606 OID 57603)
-- Name: permission_role_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_role
    ADD CONSTRAINT permission_role_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE;


--
-- TOC entry 2069 (class 2606 OID 57608)
-- Name: permission_role_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_role
    ADD CONSTRAINT permission_role_role_id_foreign FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE;


--
-- TOC entry 2070 (class 2606 OID 57613)
-- Name: permissions_inherit_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_inherit_id_foreign FOREIGN KEY (inherit_id) REFERENCES permissions(id);


--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 8
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = elearning, pg_catalog;

--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 174
-- Name: detail; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE detail FROM PUBLIC;
REVOKE ALL ON TABLE detail FROM postgres;
GRANT ALL ON TABLE detail TO postgres;
GRANT ALL ON TABLE detail TO PUBLIC;


--
-- TOC entry 2227 (class 0 OID 0)
-- Dependencies: 176
-- Name: enrollment; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE enrollment FROM PUBLIC;
REVOKE ALL ON TABLE enrollment FROM postgres;
GRANT ALL ON TABLE enrollment TO postgres;
GRANT ALL ON TABLE enrollment TO PUBLIC;


--
-- TOC entry 2229 (class 0 OID 0)
-- Dependencies: 178
-- Name: kursus; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE kursus FROM PUBLIC;
REVOKE ALL ON TABLE kursus FROM postgres;
GRANT ALL ON TABLE kursus TO postgres;
GRANT ALL ON TABLE kursus TO PUBLIC;


--
-- TOC entry 2231 (class 0 OID 0)
-- Dependencies: 180
-- Name: matakuliah; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE matakuliah FROM PUBLIC;
REVOKE ALL ON TABLE matakuliah FROM postgres;
GRANT ALL ON TABLE matakuliah TO postgres;
GRANT ALL ON TABLE matakuliah TO PUBLIC;


--
-- TOC entry 2233 (class 0 OID 0)
-- Dependencies: 182
-- Name: pengumpulan; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE pengumpulan FROM PUBLIC;
REVOKE ALL ON TABLE pengumpulan FROM postgres;
GRANT ALL ON TABLE pengumpulan TO postgres;
GRANT ALL ON TABLE pengumpulan TO PUBLIC;


--
-- TOC entry 2235 (class 0 OID 0)
-- Dependencies: 184
-- Name: periode; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE periode FROM PUBLIC;
REVOKE ALL ON TABLE periode FROM postgres;
GRANT ALL ON TABLE periode TO postgres;
GRANT ALL ON TABLE periode TO PUBLIC;


--
-- TOC entry 2237 (class 0 OID 0)
-- Dependencies: 186
-- Name: posting; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE posting FROM PUBLIC;
REVOKE ALL ON TABLE posting FROM postgres;
GRANT ALL ON TABLE posting TO postgres;
GRANT ALL ON TABLE posting TO PUBLIC;


--
-- TOC entry 2239 (class 0 OID 0)
-- Dependencies: 188
-- Name: tugas; Type: ACL; Schema: elearning; Owner: postgres
--

REVOKE ALL ON TABLE tugas FROM PUBLIC;
REVOKE ALL ON TABLE tugas FROM postgres;
GRANT ALL ON TABLE tugas TO postgres;
GRANT ALL ON TABLE tugas TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- TOC entry 2241 (class 0 OID 0)
-- Dependencies: 192
-- Name: migrations; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE migrations FROM PUBLIC;
REVOKE ALL ON TABLE migrations FROM postgres;
GRANT ALL ON TABLE migrations TO postgres;
GRANT ALL ON TABLE migrations TO PUBLIC;


--
-- TOC entry 2242 (class 0 OID 0)
-- Dependencies: 193
-- Name: password_resets; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE password_resets FROM PUBLIC;
REVOKE ALL ON TABLE password_resets FROM postgres;
GRANT ALL ON TABLE password_resets TO postgres;
GRANT ALL ON TABLE password_resets TO PUBLIC;


--
-- TOC entry 2243 (class 0 OID 0)
-- Dependencies: 194
-- Name: permission_role; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE permission_role FROM PUBLIC;
REVOKE ALL ON TABLE permission_role FROM postgres;
GRANT ALL ON TABLE permission_role TO postgres;
GRANT ALL ON TABLE permission_role TO PUBLIC;


--
-- TOC entry 2245 (class 0 OID 0)
-- Dependencies: 196
-- Name: permission_user; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE permission_user FROM PUBLIC;
REVOKE ALL ON TABLE permission_user FROM postgres;
GRANT ALL ON TABLE permission_user TO postgres;
GRANT ALL ON TABLE permission_user TO PUBLIC;


--
-- TOC entry 2247 (class 0 OID 0)
-- Dependencies: 198
-- Name: permissions; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE permissions FROM PUBLIC;
REVOKE ALL ON TABLE permissions FROM postgres;
GRANT ALL ON TABLE permissions TO postgres;
GRANT ALL ON TABLE permissions TO PUBLIC;


--
-- TOC entry 2249 (class 0 OID 0)
-- Dependencies: 200
-- Name: role_user; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE role_user FROM PUBLIC;
REVOKE ALL ON TABLE role_user FROM postgres;
GRANT ALL ON TABLE role_user TO postgres;
GRANT ALL ON TABLE role_user TO PUBLIC;


--
-- TOC entry 2251 (class 0 OID 0)
-- Dependencies: 202
-- Name: roles; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE roles FROM PUBLIC;
REVOKE ALL ON TABLE roles FROM postgres;
GRANT ALL ON TABLE roles TO postgres;
GRANT ALL ON TABLE roles TO PUBLIC;


--
-- TOC entry 2253 (class 0 OID 0)
-- Dependencies: 207
-- Name: users; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM postgres;
GRANT ALL ON TABLE users TO postgres;
GRANT ALL ON TABLE users TO PUBLIC;


-- Completed on 2017-02-10 09:46:03

--
-- PostgreSQL database dump complete
--

