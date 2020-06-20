extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 30
var position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	print('stars')
	# show()
	# $ParallaxLayer.motion_mirroring = $ParallaxLayer/sprite.texture.get_size()  # .rotated(sprite.global_rotation)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta
	set_scroll_offset(position)
	
func _exit_tree():
	print('background exiting')
