extends KinematicBody2D

var fireballs = preload("res://fireballs.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var move = Vector2()
var vel = Vector2()
var up = Vector2(0, -1)  # , 0)
var jumping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var pressing_left_or_right = false
	if Input.is_action_pressed("ui_left"):
		move.x = -1
		$soldier.flip_h = true
		pressing_left_or_right = true
	if Input.is_action_pressed("ui_right"):
		move.x = 1
		$soldier.flip_h = false
		pressing_left_or_right = true
	if Input.is_action_just_pressed("fire"):
		print("fire")
		var fireball = fireballs.instance()  # .get_node("player_fireball")
		owner.add_child(fireball)
		# bullets.push_back(fireball)
		var bullet_pos = position
		bullet_pos.y -= 4
		
		var dir = Vector2()
		if $soldier.flip_h:
			# bullet_pos.x += 10
			dir.x = -1
		else:
			# bullet_pos.y -= 10
			dir.x = 1
		
			
		if Input.is_action_pressed("ui_up"):
			dir.y -= 1
			if not pressing_left_or_right:
				dir.x = 0
		if Input.is_action_pressed("ui_down"):
			dir.y += 1
			if not pressing_left_or_right:
				dir.x = 0
		
		
			
		fireball.start(bullet_pos, dir)
		
	var mv_scaled = move * 100
	move_and_slide(mv_scaled, up)
	
	if is_on_floor():
		jumping = false;
		if Input.is_action_pressed("ui_accept"):
			move.y = -4
			jumping = true
		else:
			move.y = 0
		move.x *= 0.5
	elif is_on_ceiling():
		move.y = 0.1
	else:
		move.y += 0.1
		
	if jumping:
		if $soldier.flip_h:
			rotation_degrees -= 15
		else:
			rotation_degrees += 15
	else:
		rotation_degrees = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
