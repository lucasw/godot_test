extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func start(pos):
    print('enemy starting')
    position = pos
    show()
    $CollisionShape2D.disabled = false


func _on_Enemy_area_shape_entered(area_id, area, area_shape, self_shape):
    print('shape entered')
    hide()
    queue_free()
