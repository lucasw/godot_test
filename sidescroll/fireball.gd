extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 600


# Called when the node enters the scene tree for the first time.
func _ready():
    hide()
    # print('test')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false
    # print(position)
    
func _process(delta):
    var velocity = Vector2()
    velocity.y = -speed
    position += velocity * delta
    # print('bullet ' + str(position))
    if position.y < -50:
        queue_free()

# func _on_VisibilityNotifier2D_screen_exited():
#     queue_free()
    
func _exit_tree():
    pass
    # print('fireball exiting')


func _on_player_fireball_area_shape_entered(area_id, area, area_shape, self_shape):
    queue_free()
