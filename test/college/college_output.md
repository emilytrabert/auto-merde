erDiagram
	courses {}
	enrollment {}
	professors {}
	students {}
	courses }|--|| professors : ""
	enrollment }|--|| courses : ""
	enrollment }|--|| students : ""
