extends KinematicBody

var bullet = preload("res://bullet.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 20

var reload_time = 3.0
var countdown = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func damage(amount):
	health -= amount
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		queue_free()

func _physics_process(delta):
	var dir = (get_node("/root/Spatial/Player").get_translation() - get_translation())
	dir.y = 0.0
	dir = dir.normalized()
	move_and_slide(dir * 0.5)
	
	countdown -= delta
	if countdown <= 0.0:
		var new_bullet = bullet.instance()
		var aim = dir
		new_bullet.velocity = aim * 0.2
		# bullets.push_back(fireball)
		# var bullet_pos = get_transform().basis
		# bullet_pos.y -= 10
		new_bullet.set_translation(get_translation() + Vector3(0, 0.5, 0) + aim)
		# bulletl.start(bullet_pos, -transform.y)
		owner.add_child(new_bullet)
		countdown = reload_time	
	
