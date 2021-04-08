erDiagram
	courses {
		int id
		text name
		int professor_id
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
