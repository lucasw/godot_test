extends KinematicBody2D

var vel = Vector2()
var fireballs = preload("res://red_bullet.tscn")

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
    if Input.is_action_pressed("ui_up"):
        move.y = -1
    if Input.is_action_pressed("ui_down"):
        move.y = 1
    move = move.normalized()
    var mv_scaled = move * 100
    move_and_slide(mv_scaled)

    if Input.is_action_just_released("fire"):
        var target= get_global_mouse_position()
        
        var dir = (target - position).normalized()
        print(dir)
        var fireball = fireballs.instance()  # .get_node("player_fireball")
        owner.add_child(fireball)
        fireball.start(position, dir)
        
        
                
    
    
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
