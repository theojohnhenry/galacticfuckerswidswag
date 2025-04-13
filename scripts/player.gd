extends CharacterBody2D
#TODO: fixa så att player kan collidea med väggarna så att man inte kan åka utanför
@export var speed := 400
@onready var health: Health = $Health
@onready var weapon_slot: Weapon = $Weapon
@onready var healthbar: Node2D = $Healthbar

var aiming_direction

func _ready() -> void:
	add_to_group("players") 
	health.health_changed.connect(_on_health_health_changed)
	health.died.connect(_on_health_died)
	
func get_input():
	#get movement direction and set velocity
	var movement_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	velocity = movement_direction*speed
	#get aiming direction
	var mouse_position = get_global_mouse_position()
	aiming_direction = (mouse_position - global_position).normalized()  # Normalize the vector to get the direction
	rotation = aiming_direction.angle() + PI/2
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	fixfuckyhpbarswivelbullshit() # HACK: wtf
	
	if Input.is_action_pressed("shoot"):
		weapon_slot.shoot(aiming_direction)

func _on_health_health_changed(current: int, max: int) -> void:
	print("Health updated: ", current, "/", max)

func _on_health_died() -> void:
	print("man im dead")
	queue_free()

func fixfuckyhpbarswivelbullshit():
	var offset = Vector2(0, -50) 
	var world_offset = offset.rotated(-rotation)
	healthbar.position = world_offset
	healthbar.rotation = -rotation
