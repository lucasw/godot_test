extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector3()


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    # var move = Vector3()
    var acc = 0.1
    if Input.is_action_pressed('ui_up'):
        vel.z -= acc
    if Input.is_action_pressed('ui_down'):
        vel.z += acc
    if Input.is_action_pressed('ui_left'):
        vel.x -= acc * 0.2
    if Input.is_action_pressed('ui_right'):
        vel.x += acc * 0.2
    if Input.is_action_just_pressed('ui_select'):
        vel.y += 5.0 * (1.0 + abs(vel.x))
    # TODO(lucasw) can't keep accelerating forever, need to detect
    # down collision and zero out vel.y
    vel.y -= 0.1
    move_and_slide(vel)
    vel *= 0.96
