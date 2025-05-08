extends Area2D

@export var speed = 2000
var start_size = Vector2(0.1,0.1)
var end_size = Vector2(0.6,0.6)
var duration = 10
var fraction = 0
var current_size
func _ready():
	scale = start_size
	current_size = start_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	fraction = clamp(fraction + delta/duration, 0, 1)
	position += transform.x * speed * delta
	current_size = lerp(current_size, end_size, fraction)
	scale = current_size
	


func _on_lifetime_timeout() -> void:
	queue_free()
