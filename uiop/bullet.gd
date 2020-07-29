extends KinematicBody2D

var count = 0
var max_count = 20
export var speed = 300
export var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    show()
    # print('test')ddddddddddddddddddddddd

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):aaaaa
#    pass

func start(pos, dir):
    position = pos
    direction = dir
    
func _physics_process(delta):
    var velocity = direction.normalized() * speed
    var collision_info = move_and_collide(velocity * delta)
    if collision_info:
        # print('fireball collision')
        queue_free()
