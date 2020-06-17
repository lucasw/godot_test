extends RigidBody2D

# Declare member variables here
export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var fireballs = preload("res://fireballs.tscn")
# var level = preload("res://main.tscn")
var last_fire_countdown = 0
var last_fire_alternate = false
# var bullets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	print('player rigid body 2d')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if last_fire_countdown <= 0:
			print('fire!')
			var fireball = fireballs.instance()  # .get_node("player_fireball")
			owner.add_child(fireball)
			# bullets.push_back(fireball)
			var bullet_pos = position
			bullet_pos.y -= 10
			var alternate_scale = 24
			if last_fire_alternate:
				bullet_pos += transform.x * alternate_scale
			else:
				bullet_pos -= transform.x * alternate_scale
			last_fire_alternate = !last_fire_alternate
			fireball.start(bullet_pos, -transform.y)
			last_fire_countdown = 20
	if Input.is_action_pressed("ui_select"):
		pass
	
	if last_fire_countdown > 0:
		last_fire_countdown -= 1
	
	# for bullet in bullets:
		# pass
		# if has_node(bullet):
		#     bullet._process(delta)
	
func start(pos):
	print('player starting')
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var force = Vector2()
	if Input.is_action_pressed("ui_right"):
		force.x += 1
	if Input.is_action_pressed("ui_left"):
		force.x -= 1
	if Input.is_action_pressed("ui_down"):
		force.y += 1
	if Input.is_action_pressed("ui_up"):
		force.y -= 1
	var speed = 3400.0
	if force.length() > 0:
		force = force.normalized() * speed

	if (force != Vector2()):
		apply_central_impulse(force * delta)
		# print(force)

func _integrate_forces(state):
	var max_speed = 200
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity=state.linear_velocity.normalized() * max_speed
		
func _exit_tree():
	print('player exiting')
