extends KinematicBody

var up_dir = Vector3(0, 1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
	print(camera_look)
	
	if camera_look.z > 0.0:  # and camera_look.y <= 1.0:
		$Camera.rotate_x((-rotate_down + rotate_up) * rotate_scale)
	
	# get it a second time to make sure it doesn't go too far
	var camera_look2 = camera_rot.basis * Vector3(0, 0, 1)
	if camera_look.z < 0.0:
		if camera_look.y > 0.0:
			$Camera.rotate_x(0.05)
		else:
			$Camera.rotate_x(-0.05)
