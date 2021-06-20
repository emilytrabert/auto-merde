DROP TABLE enrollment CASCADE;
DROP TABLE courses CASCADE;
DROP TABLE professors CASCADE;
DROP TABLE students CASCADE;

CREATE TABLE professors (
  id integer,
  f_name character varying(20),
  l_name character varying(20),
  PRIMARY KEY(id)
);

CREATE SEQUENCE professor_id_sequence
START 1
INCREMENT 1
MINVALUE 1
OWNED BY professors.id;

CREATE TABLE students (
  id bigint,
  f_name character varying(20),
  l_name character varying(20),
  PRIMARY KEY(id)
);

CREATE SEQUENCE student_id_sequence
START 1
INCREMENT 1
MINVALUE 1
OWNED BY students.id;

CREATE TABLE courses (
  id bigint,
  name character varying(20),
  professor_id integer,
  start_date timestamp,
  is_full boolean,
  description text,
  PRIMARY KEY(id),
  CONSTRAINT fk_course_professor
    FOREIGN KEY(professor_id)
      REFERENCES professors(id)
);

CREATE SEQUENCE course_id_sequence
START 1
INCREMENT 1
MINVALUE 1
OWNED BY courses.id;

CREATE TABLE enrollment (
  id bigint,
  course_id integer,
  student_id bigint,
  PRIMARY KEY(id),
  CONSTRAINT fk_enrollment_course
    FOREIGN KEY(course_id)
      REFERENCES courses(id),
  CONSTRAINT fk_enrollment_student
    FOREIGN KEY(student_id)
      REFERENCES students(id)
);

CREATE SEQUENCE enrollment_id_sequence
START 1
INCREMENT 1
MINVALUE 1
OWNED BY enrollment.id;
