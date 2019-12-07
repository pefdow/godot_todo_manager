extends Node

signal new_todo_created(todo)

func _on_AddTodoBtn_button_up():
	var todo = $NewTodoInput.text
	if (todo.length()):
		$NewTodoInput.clear()
		emit_signal("new_todo_created", todo)