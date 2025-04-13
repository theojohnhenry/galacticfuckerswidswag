extends Node2D

class_name Weapon

@export var fire_rate: float = 0.2
@export var projectile_scene: PackedScene
@onready var timer: Timer = $Timer

var can_shoot: bool = true

func _ready() -> void:
	timer.stop()
	timer.wait_time = fire_rate
	timer.timeout.connect(Callable(self, "_on_fire_timeout"))
	
func shoot(direction: Vector2):
	#if not shootable, do nothing
	if not can_shoot:
		return
		
	can_shoot = false
	
	if projectile_scene:
		var projectile = projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.set_direction(direction)
		projectile.rotation = direction.angle() + PI/2
		get_tree().current_scene.add_child(projectile)
	timer.start()

func _on_fire_timeout():
	can_shoot = true
