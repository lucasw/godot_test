extends KinematicBody

var up_dir = Vector3(0, 1, 0)
var right_dir = Vector3(1, 0, 0)
var down_acc = -15.5
var down_vel = 0.0
var count = 0

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
    
    if is_on_floor():
        var floor_normal = get_floor_normal()
        var local_right_dir = mv2.cross(floor_normal)
        mv2 = floor_normal.cross(local_right_dir)
        
        down_vel = down_acc * delta
        if Input.get_action_strength('ui_select') > 0.0:
            down_vel = 8.0
            
    mv2.y += down_vel
  
    var linear_vel = move_and_slide(mv2, up_dir, false, 4, 0.65, false)
    
    if count % 10 == 0:
        pass
        # print("mv2 {} linear_vel {}, {}".format([mv2, linear_vel, is_on_floor()], "{}"))
    count += 1
        
var mouse_look = false
var mouse_sens = 0.1
var look_vert_angle = -90.0

func _input(event):     
    if event is InputEventKey and event.scancode == KEY_M and not event.echo:
        if Input.is_key_pressed(KEY_M):
            mouse_look = !mouse_look
            if mouse_look:
                Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)    
            else:
                Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
            print("mouse look toggle {}".format([mouse_look], "{}"))
    if event is InputEventMouseMotion:
        if mouse_look:
            var dx = event.relative.x
            # var turn = - sign(dx) * (dx * dx) * 0.003
            var turn = - dx * 0.2
            rotate_y(deg2rad(turn))
            
            var changev = -event.relative.y * mouse_sens
            var max_angle = 80
            var test_angle = look_vert_angle + changev
            if test_angle + changev > -90 - max_angle and test_angle + changev < -90 + max_angle:
                look_vert_angle += changev
                $Camera.set_rotation_degrees(Vector3(look_vert_angle, 0, 0))
    
    if false:
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
