extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



	# Called when the node enters the scene tree for the first time.
func _ready():
	print("rebyreby")
	pass # Replace with function body.
func _physics_process(delta):
	#print("enemy move "+str(delta))
	var enemymove = Vector2(20,0)
	if $sprite.flip_h == true:
		enemymove.x =-20
	var col = move_and_collide(enemymove * delta)
	if col:
		$sprite.flip_h = not $sprite.flip_h



func _on_Area2D_area_entered(area):
	print("area " + area.get_name())
