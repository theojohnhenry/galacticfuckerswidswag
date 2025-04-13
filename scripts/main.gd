extends Node

@export var player_scene : PackedScene
@export var asteroid_scene : PackedScene
@export var cooldown = 3

func _ready() -> void:
	spawn_player()
	spawn_asteroid()

func spawn_player():
	var player = player_scene.instantiate()
	add_child(player)
	player.position = Vector2(400, 400)

func spawn_asteroid():
	var asteroid = asteroid_scene.instantiate()
	add_child(asteroid)
