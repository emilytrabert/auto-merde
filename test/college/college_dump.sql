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
    id integer NOT NULL,
    name character varying(20),
    professor_id integer
);


ALTER TABLE public.courses OWNER TO emilytrabert;

--
-- Name: enrollment; Type: TABLE; Schema: public; Owner: emilytrabert
--

CREATE TABLE public.enrollment (
    id integer NOT NULL,
    course_id integer,
    student_id integer
);


ALTER TABLE public.enrollment OWNER TO emilytrabert;

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
-- Name: students; Type: TABLE; Schema: public; Owner: emilytrabert
--

CREATE TABLE public.students (
    id integer NOT NULL,
    f_name character varying(20),
    l_name character varying(20)
);


ALTER TABLE public.students OWNER TO emilytrabert;

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

