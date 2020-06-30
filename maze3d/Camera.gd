extends KinematicBody

var health = 40
var up_dir = Vector3(0, 1, 0)
var bullet = preload("res://bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func damage(amount):
	health -= amount
	print('player damaged ' + str(health))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mv = Vector3()
	var up = Input.get_action_strength('ui_up')
	mv.z += -1.0 * up
	var down = Input.get_action_strength('ui_down')
	mv.z += +1.0 * down
	var left = Input.get_action_strength('ui_left')
	mv.x += -1.0 * left
	var right = Input.get_action_strength('ui_right')
	mv.x += 1.0 * right
	
	var mv_transformed = mv.rotated(up_dir, rotation.y)
	
	move_and_slide(mv_transformed * 10, up_dir)

	var rotation_val = 0.0
	var rotate_right = Input.get_action_strength('ui_rotate_right')
	rotation_val -= 1.0 * rotate_right
	var rotate_left = Input.get_action_strength('ui_rotate_left')
	rotation_val += 1.0 * rotate_left
	rotate_y(rotation_val * 0.08)

	var rotate_up = Input.get_action_strength('ui_rotate_up')
	var rotate_down = Input.get_action_strength('ui_rotate_down')
	# print(str(rotate_up) + " " + str(rotate_down))
	var camera_rot = $Camera.get_transform()
	# print(str(camera_rot))
	
	var camera_look = camera_rot.basis * Vector3(0, 0, 1)
	var rotate_scale = 0.05
	# print(camera_look)
	
	if camera_look.z > 0.0:  # and camera_look.y <= 1.0:
		$Camera.rotate_x((-rotate_down + rotate_up) * rotate_scale)
	
	# get it a second time to make sure it doesn't go too far
	var camera_look2 = camera_rot.basis * Vector3(0, 0, 1)
	if camera_look.z < 0.0:
		if camera_look.y > 0.0:
			$Camera.rotate_x(0.05)
		else:
			$Camera.rotate_x(-0.05)
			
	######
	if Input.is_action_just_pressed('fire'):
		# print('fire')
		# spawn a bullet
		var new_bullet = bullet.instance()
		var aim = $Camera.get_camera_transform().basis * Vector3(0, 0, -1)
		new_bullet.velocity = aim * 0.5
		# bullets.push_back(fireball)
		# var bullet_pos = get_transform().basis
		# bullet_pos.y -= 10
		new_bullet.set_translation(get_translation() + aim)
		# bulletl.start(bullet_pos, -transform.y)
		owner.add_child(new_bullet)
		
func _process(delta):
	if health <= 0:
		get_tree().reload_current_scene()
		
	$Camera/Spatial.scale.x = 0.2 * health / 100.0
