extends CharacterBody2D
@export var rotation_speed = 0.08
@export var player_speed = 500
@export var friction = 0.5
@export var dash_speed = 10

var dash_direction = Vector2()
var can_dash = true

@export var max_health: int = 3
@onready var current_health = max_health

var mousePos = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	mousePos = get_global_mouse_position()
	var targetDir = get_angle_to(mousePos - position.normalized())
	rotation += sin(targetDir * rotation_speed) 
	
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	direction = direction.normalized()
	velocity = velocity.lerp(direction * player_speed, 0.1)
	velocity *= 1.0 - (friction * delta)
	
	if Input.is_action_just_pressed("dash") and can_dash:
		can_dash = false
		dash_direction = direction.normalized()
		velocity = dash_direction * dash_speed
		
		#var dash_direction = get_global_mouse_position() - self.position
		#dash_direction = dash_direction.normalized()
		#velocity = dash_direction * dash_speed
		velocity *= 1.0 - (friction * delta)
		$Dash_Cooldown.start()
	
	
	move_and_collide(velocity)
	
	pass


func _on_dash_cooldown_timeout() -> void:
	can_dash = true
