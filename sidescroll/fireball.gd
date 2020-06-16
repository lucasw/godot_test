extends Area2D

export var speed = 600
export var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    hide()
    # print('test')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func start(pos, dir):
    position = pos
    direction = dir
    show()
    $CollisionShape2D.disabled = false
    # print(position)
    
func _process(delta):
    var velocity = direction * speed
    position += velocity * delta
    # print('bullet ' + str(position))
    var screen_size = get_viewport_rect().size
    var off_upper_left = position.y < -50 or position.x < -50
    var off_lower_right = position.y > screen_size.y or position.x > screen_size.x
    if off_upper_left or off_lower_right:
        queue_free()

# func _on_VisibilityNotifier2D_screen_exited():
#     queue_free()
    
func _exit_tree():
    pass
    # print('fireball exiting')

func _on_player_fireball_area_shape_entered(area_id, area, area_shape, self_shape):
    queue_free()
