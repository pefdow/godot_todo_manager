extends Node

const todoRowPrefab = preload("res://todoItemView.tscn")

var todos = []
var total = 0
var completed = 0

func _ready():
	run_samples()

func _on_NewTodoForm_new_todo_created(todo):
	var todoItem = TodoItem.new(next_todo_item_id(), todo)
	todos.push_front(todoItem)
	display_todos()

func _on_TodoItem_delete_todo_item(todoItem):
	for index in range(todos.size()):
		var todo = todos[index]
		if todo.id == todoItem.id:
			todos.remove(index)
			break
	display_todos()

func _on_TodoItem_toggle_todo_item(todoItem):
	for todo in todos:
		if todo.id == todoItem.id:
			todo = todoItem
	display_todos()

func display_todos():
	var listView = $AppContainer/ScrollContainer/TodoListView
	remove_children(listView)
	total = 0
	completed = 0
	for todo in todos:
		total += 1
		if todo.done:
			completed += 1
		var rowItem = todoRowPrefab.instance()
		rowItem.set_todo_item(todo)
		rowItem.connect("toggle_todo_item", self, "_on_TodoItem_toggle_todo_item")
		rowItem.connect("delete_todo_item", self, "_on_TodoItem_delete_todo_item")
		listView.add_child(rowItem)
	display_stats()

func display_stats():
	var totalLabel = $AppContainer/StatsContainer/TotalCount
	var todoLabel = $AppContainer/StatsContainer/TodoCount
	var completedLabel = $AppContainer/StatsContainer/CompletedCount
	totalLabel.text = "TOTAL: " + str(total)
	completedLabel.text = "COMPLETED: " + str(completed)
	todoLabel.text = "TODO: " + str(total - completed)

func remove_children(node):
	for c in node.get_children():
		node.remove_child(c)

func next_todo_item_id() -> int:
	var size = todos.size()
	return (todos[size - 1].id if size > 0 else 0) + 1

func run_samples():
	for i in range(5):
		_on_NewTodoForm_new_todo_created("Todo " + str(i+1))