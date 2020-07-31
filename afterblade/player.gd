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
    move_and_slide(vel)
    vel *= 0.96
