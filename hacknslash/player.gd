extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2(0.0, 0.0)
var bounce = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var vel_x = 0.0
    var vel_y = 0.0
    var base_vel = 160.0
    if Input.is_action_pressed("ui_up"):
        vel_y = -base_vel
    if Input.is_action_pressed("ui_down"):
        vel_y = base_vel
    if Input.is_action_pressed("ui_left"):
        vel_x = -base_vel
    if Input.is_action_pressed("ui_right"):
        vel_x = base_vel
    vel.x = vel_x
    vel.y = vel_y
    var move = vel + bounce
    bounce *= 0.8

    self.move_and_slide(move)    
    var slide_count = get_slide_count()
    if slide_count:
        var collision = get_slide_collision(slide_count - 1)
        var collider = collision.collider
        if collider.name == "enemy":
            bounce = (self.position - collider.position) * 10.0
