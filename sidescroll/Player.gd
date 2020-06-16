extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
    if Input.is_action_pressed("ui_accept"):
        if last_fire_countdown <= 0:
            print('fire!')
            var fireball = fireballs.instance()  # .get_node("player_fireball")
            owner.add_child(fireball)
            # bullets.push_back(fireball)
            var bullet_pos = position
            bullet_pos.y -= 10
            if last_fire_alternate:
                bullet_pos.x -= 24
            else:
                bullet_pos.x += 24
            last_fire_alternate = !last_fire_alternate
            fireball.start(bullet_pos)
            last_fire_countdown = 20
    if Input.is_action_pressed("ui_select"):
        pass
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
    
    if last_fire_countdown > 0:
        last_fire_countdown -= 1
        
    position += velocity * delta
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)
    
    # for bullet in bullets:
        # pass
        # if has_node(bullet):
        #     bullet._process(delta)

func start(pos):
    print('player starting')
    position = pos
    show()
    $CollisionShape2D.disabled = false
    
    
func _exit_tree():
    print('exiting')
