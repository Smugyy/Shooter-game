extends Node2D
var weapons: Array =[preload("res://Projectiles/PlayerProjectile.tscn"), preload("res://Projectiles/3WayShot.tscn"), preload("res://Projectiles/GrowingShot.tscn")]

var current_weapon_index = 0
var current_weapon = weapons[current_weapon_index]

# Called when the node enters the scene tree for the first time.
func _ready():
	current_weapon = weapons[current_weapon_index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("shoot") and $"../Cooldown_Timer".is_stopped():
		shoot()
	
	if Input.is_action_just_pressed("switch weapon up"):
		var direction = 1
		switch_weapon(direction)
	if Input.is_action_just_pressed("switch weapon down"):
		var direction = -1
		switch_weapon(direction)
	
	
	pass

func switch_weapon(direction):
	current_weapon_index +=direction
	if current_weapon_index > weapons.size()-1:
		current_weapon_index = 0
	if current_weapon_index < 0:
		current_weapon_index = weapons.size()-1
	current_weapon = weapons[current_weapon_index]



func shoot():
	var p = current_weapon.instantiate()
	owner.add_child(p)
	p.transform = $"../Gun_Offset".global_transform
	$"../Cooldown_Timer".start()
