extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var countdown = 3.0
var velocity = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	print('bullet velocity ' + str(velocity))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# print('update ' + str(get_translation()))
	var collision = move_and_collide(velocity)
	if collision:
		print('bullet collision')
		queue_free()
	
	countdown -= delta
	if countdown < 0.0:
		print('bullet timeout')
		queue_free()
