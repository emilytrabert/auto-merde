--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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
-- Name: courses; Type: TABLE; Schema: public; Owner: emilytrabert
--

CREATE TABLE public.courses (
    id bigint NOT NULL,
    name character varying(20),
    professor_id integer,
    start_date timestamp without time zone,
    is_full boolean,
    description text
);


ALTER TABLE public.courses OWNER TO emilytrabert;

--
-- Name: course_id_sequence; Type: SEQUENCE; Schema: public; Owner: emilytrabert
--

CREATE SEQUENCE public.course_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_id_sequence OWNER TO emilytrabert;

--
-- Name: course_id_sequence; Type: SEQUENCE OWNED BY; Schema: public; Owner: emilytrabert
--

ALTER SEQUENCE public.course_id_sequence OWNED BY public.courses.id;


--
-- Name: enrollment; Type: TABLE; Schema: public; Owner: emilytrabert
--

CREATE TABLE public.enrollment (
    id bigint NOT NULL,
    course_id integer,
    student_id bigint
);


ALTER TABLE public.enrollment OWNER TO emilytrabert;

--
-- Name: enrollment_id_sequence; Type: SEQUENCE; Schema: public; Owner: emilytrabert
--

CREATE SEQUENCE public.enrollment_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enrollment_id_sequence OWNER TO emilytrabert;

--
-- Name: enrollment_id_sequence; Type: SEQUENCE OWNED BY; Schema: public; Owner: emilytrabert
--

ALTER SEQUENCE public.enrollment_id_sequence OWNED BY public.enrollment.id;


--
-- Name: professors; Type: TABLE; Schema: public; Owner: emilytrabert
--

CREATE TABLE public.professors (
    id integer NOT NULL,
    f_name character varying(20),
    l_name character varying(20)
);


ALTER TABLE public.professors OWNER TO emilytrabert;

--
-- Name: professor_id_sequence; Type: SEQUENCE; Schema: public; Owner: emilytrabert
--

CREATE SEQUENCE public.professor_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.professor_id_sequence OWNER TO emilytrabert;

--
-- Name: professor_id_sequence; Type: SEQUENCE OWNED BY; Schema: public; Owner: emilytrabert
--

ALTER SEQUENCE public.professor_id_sequence OWNED BY public.professors.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: emilytrabert
--

CREATE TABLE public.students (
    id bigint NOT NULL,
    f_name character varying(20),
    l_name character varying(20)
);


ALTER TABLE public.students OWNER TO emilytrabert;

--
-- Name: student_id_sequence; Type: SEQUENCE; Schema: public; Owner: emilytrabert
--

CREATE SEQUENCE public.student_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_id_sequence OWNER TO emilytrabert;

--
-- Name: student_id_sequence; Type: SEQUENCE OWNED BY; Schema: public; Owner: emilytrabert
--

ALTER SEQUENCE public.student_id_sequence OWNED BY public.students.id;


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: emilytrabert
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: emilytrabert
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (id);


--
-- Name: professors professors_pkey; Type: CONSTRAINT; Schema: public; Owner: emilytrabert
--

ALTER TABLE ONLY public.professors
    ADD CONSTRAINT professors_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: emilytrabert
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: courses fk_course_professor; Type: FK CONSTRAINT; Schema: public; Owner: emilytrabert
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_course_professor FOREIGN KEY (professor_id) REFERENCES public.professors(id);


--
-- Name: enrollment fk_enrollment_course; Type: FK CONSTRAINT; Schema: public; Owner: emilytrabert
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT fk_enrollment_course FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: enrollment fk_enrollment_student; Type: FK CONSTRAINT; Schema: public; Owner: emilytrabert
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- PostgreSQL database dump complete
--

