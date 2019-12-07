extends Reference

class_name TodoItem

var id
var todo
var done

func _init(id, todo):
	self.id = id
	self.todo = todo
	self.done = false

func toggle_done():
	self.done = !self.done