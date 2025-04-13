extends Area2D

var screen_size
var velocity = Vector2.ZERO #Define velocity as zero before deciding velocity
@onready var damage_dealer: DamageDealer = $DamageDealer


func _ready():
	startPos()
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	velocity.y = 400 #determines velocity of fall
	position += velocity * delta #applies velocity to y-axis
	rotation += 3 * delta 

func startPos():
	screen_size = get_viewport_rect().size #get size of viewport
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(0 + screen_size.x * 0.25, screen_size.x * 0.75) #generates number in middle half of screen
	
	position = Vector2(rndX, 0) #applies position on x-axis relative to viewport size
	var rndXDir = rng.randi_range(-150, 150) #generates a random velocity for x-axis
	velocity.x = rndXDir #applies velocity on x-axis

func _on_timer_timeout() -> void:
	startPos()

func _on_body_entered(body: CharacterBody2D):
	if body.is_in_group("players"):
		if body.has_node("Health"):
			var health = body.get_node("Health") as Health
			health.take_damage(damage_dealer.damage_amount)
