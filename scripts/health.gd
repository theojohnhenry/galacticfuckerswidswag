extends Node

class_name Health

@export var health_bar: Node2D
@export var max_health: int = 100

var current_health: int

signal health_changed(current: int, max: int)
signal died

func _ready(): #on init, get max hp
	current_health = max_health
	await get_tree().process_frame # waits until all scripts in parent tree is running _process
	update_health_bar()
func take_damage(amount: int):
	if amount <= 0:
		return
		
	current_health = max(current_health - amount, 0) # selects 0 if current-amount < 0
	update_health_bar()
	emit_signal("health_changed", current_health, max_health)

	if current_health == 0:
		update_health_bar()
		emit_signal("died")
		
func heal(amount: int):
	if amount <= 0 or current_health == max_health:
		return
	
	current_health = min(current_health+amount, max_health)
	update_health_bar()
	emit_signal("health_changed",current_health,max_health)

func update_health_bar():
	if health_bar and health_bar.has_method("update_bar"):
		health_bar.update_bar(current_health, max_health)
