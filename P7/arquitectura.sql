--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 12.1 (Ubuntu 12.1-1.pgdg18.04+1)

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
-- Name: arquitectura; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA arquitectura;


ALTER SCHEMA arquitectura OWNER TO postgres;

--
-- Name: dir; Type: TYPE; Schema: arquitectura; Owner: postgres
--

CREATE TYPE arquitectura.dir AS (
	calle character varying,
	num integer,
	piso integer
);


ALTER TYPE arquitectura.dir OWNER TO postgres;

--
-- Name: t_coordenadas; Type: TYPE; Schema: arquitectura; Owner: postgres
--

CREATE TYPE arquitectura.t_coordenadas AS (
	x integer,
	y integer
);


ALTER TYPE arquitectura.t_coordenadas OWNER TO postgres;

--
-- Name: dir; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.dir AS (
	calle character varying,
	num integer,
	piso integer
);


ALTER TYPE public.dir OWNER TO postgres;

--
-- Name: t_coordenadas; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.t_coordenadas AS (
	x integer,
	y integer
);


ALTER TYPE public.t_coordenadas OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: figura; Type: TABLE; Schema: arquitectura; Owner: postgres
--

CREATE TABLE arquitectura.figura (
    figura_id integer NOT NULL,
    nombre character varying(30),
    perimetro numeric,
    area numeric,
    color integer,
    tipo character varying(35),
    n_lineas integer,
    plano integer,
    linea integer
);


ALTER TABLE arquitectura.figura OWNER TO postgres;

--
-- Name: jefe; Type: TABLE; Schema: arquitectura; Owner: postgres
--

CREATE TABLE arquitectura.jefe (
    jefe_cod integer NOT NULL,
    nombre character varying NOT NULL,
    telefono integer,
    direccion public.dir
);


ALTER TABLE arquitectura.jefe OWNER TO postgres;

--
-- Name: linea; Type: TABLE; Schema: arquitectura; Owner: postgres
--

CREATE TABLE arquitectura.linea (
    origen public.t_coordenadas NOT NULL,
    destino public.t_coordenadas NOT NULL,
    longitud integer NOT NULL,
    linea_id integer NOT NULL,
    fig_id integer NOT NULL
);


ALTER TABLE arquitectura.linea OWNER TO postgres;

--
-- Name: plano; Type: TABLE; Schema: arquitectura; Owner: postgres
--

CREATE TABLE arquitectura.plano (
    plano_id integer NOT NULL,
    arquitectos character varying(30)[],
    num_figuras integer,
    dibujo character varying(35),
    fecha date,
    proyecto integer,
    refproyecto integer NOT NULL
);


ALTER TABLE arquitectura.plano OWNER TO postgres;

--
-- Name: proyecto; Type: TABLE; Schema: arquitectura; Owner: postgres
--

CREATE TABLE arquitectura.proyecto (
    proyecto_cod integer NOT NULL,
    nombre character varying NOT NULL,
    fecha_fin date NOT NULL,
    refjefe integer NOT NULL
);


ALTER TABLE arquitectura.proyecto OWNER TO postgres;

--
-- Data for Name: figura; Type: TABLE DATA; Schema: arquitectura; Owner: postgres
--

COPY arquitectura.figura (figura_id, nombre, perimetro, area, color, tipo, n_lineas, plano, linea) FROM stdin;
\.


--
-- Data for Name: jefe; Type: TABLE DATA; Schema: arquitectura; Owner: postgres
--

COPY arquitectura.jefe (jefe_cod, nombre, telefono, direccion) FROM stdin;
\.


--
-- Data for Name: linea; Type: TABLE DATA; Schema: arquitectura; Owner: postgres
--

COPY arquitectura.linea (origen, destino, longitud, linea_id, fig_id) FROM stdin;
\.


--
-- Data for Name: plano; Type: TABLE DATA; Schema: arquitectura; Owner: postgres
--

COPY arquitectura.plano (plano_id, arquitectos, num_figuras, dibujo, fecha, proyecto, refproyecto) FROM stdin;
\.


--
-- Data for Name: proyecto; Type: TABLE DATA; Schema: arquitectura; Owner: postgres
--

COPY arquitectura.proyecto (proyecto_cod, nombre, fecha_fin, refjefe) FROM stdin;
\.


--
-- Name: figura figura_pkey; Type: CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.figura
    ADD CONSTRAINT figura_pkey PRIMARY KEY (figura_id);


--
-- Name: jefe jefe_nombre_key; Type: CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.jefe
    ADD CONSTRAINT jefe_nombre_key UNIQUE (nombre);


--
-- Name: jefe jefe_pkey; Type: CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.jefe
    ADD CONSTRAINT jefe_pkey PRIMARY KEY (jefe_cod);


--
-- Name: linea linea_pkey; Type: CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.linea
    ADD CONSTRAINT linea_pkey PRIMARY KEY (linea_id);


--
-- Name: plano plano_pkey; Type: CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.plano
    ADD CONSTRAINT plano_pkey PRIMARY KEY (plano_id);


--
-- Name: proyecto proyecto_nombre_key; Type: CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.proyecto
    ADD CONSTRAINT proyecto_nombre_key UNIQUE (nombre);


--
-- Name: proyecto proyecto_pkey; Type: CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.proyecto
    ADD CONSTRAINT proyecto_pkey PRIMARY KEY (proyecto_cod);


--
-- Name: linea fk_figura; Type: FK CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.linea
    ADD CONSTRAINT fk_figura FOREIGN KEY (fig_id) REFERENCES arquitectura.figura(figura_id);


--
-- Name: figura fk_lineafigura; Type: FK CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.figura
    ADD CONSTRAINT fk_lineafigura FOREIGN KEY (linea) REFERENCES arquitectura.linea(linea_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: figura fk_planofigura; Type: FK CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.figura
    ADD CONSTRAINT fk_planofigura FOREIGN KEY (plano) REFERENCES arquitectura.plano(plano_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: plano fk_proyectoplano; Type: FK CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.plano
    ADD CONSTRAINT fk_proyectoplano FOREIGN KEY (proyecto) REFERENCES arquitectura.proyecto(proyecto_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: proyecto fk_refjefe; Type: FK CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.proyecto
    ADD CONSTRAINT fk_refjefe FOREIGN KEY (refjefe) REFERENCES arquitectura.jefe(jefe_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: plano fk_refproyecto; Type: FK CONSTRAINT; Schema: arquitectura; Owner: postgres
--

ALTER TABLE ONLY arquitectura.plano
    ADD CONSTRAINT fk_refproyecto FOREIGN KEY (refproyecto) REFERENCES arquitectura.proyecto(proyecto_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

