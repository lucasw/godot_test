extends KinematicBody2D

var vel = Vector2()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
func _physics_process(delta):
    var move = Vector2()
    var pressing_left_or_right = false
    if Input.is_action_pressed("ui_left"):
        move.x = -1
        #$soldier.flip_h = true
        pressing_left_or_right = true
    if Input.is_action_pressed("ui_right"):
        move.x = 1
    var mv_scaled = move * 100
    move_and_slide(mv_scaled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
