DROP TABLE courses;
DROP TABLE professors;
DROP TABLE students;

CREATE TABLE professors (
  id integer,
  f_name character varying(20),
  l_name character varying(20),
  PRIMARY KEY(id)
);

CREATE TABLE students (
  id integer,
  f_name character varying(20),
  l_name character varying(20),
  PRIMARY KEY(id)
);

CREATE TABLE courses (
  id integer,
  name character varying(20),
  professor_id integer,
  PRIMARY KEY(id),
  CONSTRAINT fk_course_professor
    FOREIGN KEY(professor_id)
      REFERENCES professors(id)
);

CREATE TABLE enrollment (
  id integer,
  course_id integer,
  student_id integer,
  PRIMARY KEY(id),
  CONSTRAINT fk_enrollment_course
    FOREIGN KEY(course_id)
      REFERENCES courses(id),
  CONSTRAINT fk_enrollment_student
    FOREIGN KEY(student_id)
      REFERENCES students(id)
);
