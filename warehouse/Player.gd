extends KinematicBody

var up_dir = Vector3(0, 1, 0)
var down_acc = -8.5
var down_vel = 0.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
    var mv2 = mv_transformed * 10
    down_vel += down_acc * delta
    mv2.y += down_vel
    
    var linear_vel = move_and_slide(mv2, up_dir)
    print("down_vel {} linear_vel {}".format([down_vel, linear_vel.y], "{}"))
    if linear_vel.y < 0.0:
        down_vel = linear_vel.y

    var rotation_val = 0.0
    var rotate_right = Input.get_action_strength('right')
    rotation_val -= 1.0 * rotate_right
    var rotate_left = Input.get_action_strength('left')
    rotation_val += 1.0 * rotate_left
    rotate_y(rotation_val * 0.08)

    var rotate_up = Input.get_action_strength('up')
    var rotate_down = Input.get_action_strength('down')
    # print(str(rotate_up) + " " + str(rotate_down))
    var camera_rot = $Camera.get_transform()
    # print(str(camera_rot))
    
    var camera_look = camera_rot.basis * Vector3(0, 0, 1)
    var rotate_scale = 0.05
    # print(camera_look)
    
    var min_z = -2.0
    if camera_look.z > min_z:  # and camera_look.y <= 1.0:
        $Camera.rotate_x((-rotate_down + rotate_up) * rotate_scale)
    
    # get it a second time to make sure it doesn't go too far
    var camera_look2 = camera_rot.basis * Vector3(0, 0, 1)
    if camera_look.z < min_z:
        if camera_look.y > -2.0:
            $Camera.rotate_x(0.05)
        else:
            $Camera.rotate_x(-0.05)

