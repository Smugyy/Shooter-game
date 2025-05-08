extends Area2D

@export var speed = 5000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta


func _on_lifetime_timeout() -> void:
	queue_free()
