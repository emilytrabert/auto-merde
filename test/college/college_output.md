erDiagram
	courses {
		int id
		text name
		int professor_id
		timestamp start_date
		boolean is_full
		text description
	}
	enrollment {
		int id
		int course_id
		int student_id
	}
	professors {
		int id
		text f_name
		text l_name
	}
	students {
		int id
		text f_name
		text l_name
	}
	courses }|--|| professors : ""
	enrollment }|--|| courses : ""
	enrollment }|--|| students : ""
