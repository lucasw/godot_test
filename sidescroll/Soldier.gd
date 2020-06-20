extends KinematicBody2D

var fireballs = preload("res://fireballs.tscn")
# Declare member variables here. Examples:
var move = Vector2()
var vel = Vector2()
var up = Vector2(0, -1)  # , 0)
var jumping = false
var spin_jumping = false
var health = 100
# var invincibility_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready player 1")

func _on_Area2D_area_entered(area):
	print("player area entered " + area.get_name())
	# if invincibility_count == 0:
	health -= 5
	print("health " + str(health))
	# 	 invincibility_count += 60
	# else:
	# 	invincibility_count -= 1
	

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
	#var collision = move_and_collide(mv_scaled)
	
	if is_on_floor():
		jumping = false;
		spin_jumping = false;
		if Input.is_action_pressed("ui_accept"):
			move.y = -4
			if pressing_left_or_right:
				spin_jumping = true
			jumping = true
		else:
			move.y = 0
		move.x *= 0.5
	elif is_on_ceiling():
		move.y = 0.1
	else:
		move.y += 0.1
		
	if spin_jumping:
		$spin.show()
		$soldier.hide()
		if $soldier.flip_h:
			$spin.flip_h = true
			# rotation_degrees -= 15
		else:
			$spin.flip_h = false
			# rotation_degrees += 15
		# $spin.flip_v = !$spin.flip_v
	else:
		$spin.hide()
		$soldier.show()
		#rotation_degrees = 0
