extends CharacterBody2D

@export var speed: int = 200
@export var maxhealth: int = 100

@onready var damage_dealer: DamageDealer = $DamageDealer
@onready var health: Health = $Health

@export var target_position: Vector2 = Vector2(200,200)

func _ready() -> void:
	add_to_group("enemies")
	health.health_changed.connect(_on_health_health_changed)
	health.died.connect(_on_health_died)

func _process(_delta: float) -> void:
	var direction = (target_position - position).normalized()
	velocity = direction * speed  
	move_and_slide()  

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"): 
		if body.has_node("Health"):  
			var player_health = body.get_node("Health") as Health
			var damage = damage_dealer.damage_amount  
			player_health.take_damage(damage)  
		queue_free() 

func _on_health_health_changed(current: int, max: int) -> void:
	print("enemy: Health updated: ", current, "/", max)

func _on_health_died() -> void:
	print("enemy: man im dead")
	queue_free()
