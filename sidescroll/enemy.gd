extends KinematicBody2D

var health = 15
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var up = Vector2(0, -1)
var move = Vector2()



	# Called when the node enters the scene tree for the first time.
func _ready():
	print("rebyreby")
	pass # Replace with function body.
func _physics_process(delta):
	#print("enemy move "+str(delta))
	var enemymove = Vector2(20,0)
	if $sprite.flip_h == true:
		enemymove.x =-20
	#var col 
	#if col:
	#	$sprite.flip_h = not $sprite.flip_h
	enemymove += move*100
	move_and_slide(enemymove,up)
	
	if is_on_floor():
		move.y = 0
	else:
		move.y += 0.1 
	if is_on_wall():
		$sprite.flip_h = not $sprite.flip_h

func _on_Area2D_area_entered(area):
	# print("enemy area entered " + area.get_name())
	if area.get_name() == 'player_fireball_area':
		print('hit by player fireball')
