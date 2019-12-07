extends Node

signal toggle_todo_item(todo)
signal delete_todo_item(todo)

var todoItem: TodoItem

func set_todo_item(todo: TodoItem):
	todoItem = todo
	$Todo.text = todoItem.todo
	$Done.pressed = todoItem.done

func _on_DeleteButton_button_up():
	emit_signal("delete_todo_item", todoItem)

func _on_Done_toggled(button_pressed):
	todoItem.done = button_pressed
	emit_signal("toggle_todo_item", todoItem)