extends Area2D

@export var speed: int = 600
@export var direction: Vector2
@onready var damage_dealer: DamageDealer = $DamageDealer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var velocity: Vector2

func _ready() -> void:
	velocity = direction*speed
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _process(delta: float) -> void:
	position += velocity * delta
	
func _on_body_entered(body: CharacterBody2D):
	if body.is_in_group("enemies"):
		if body.has_node("Health"):
			var health = body.get_node("Health") as Health
			health.take_damage(damage_dealer.damage_amount)
		queue_free()

func set_direction(dir: Vector2):
	direction = dir.normalized()
	velocity = direction * speed
