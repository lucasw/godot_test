extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2(80.0, 0.0)
var elapsed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
    print(vel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    # self.position.x += 10.0 * delta
    elapsed += delta
    
    var edge_t = 3.0
    if elapsed < edge_t:
        vel = Vector2(80.0, 0.0)
    elif elapsed >= edge_t and elapsed < edge_t * 2.0:
        vel = Vector2(0.0, 80.0)
    elif elapsed >= edge_t * 2.0 and elapsed < edge_t * 3.0:
        vel = Vector2(-80.0, 0.0)
    elif elapsed >= edge_t * 3.0 and elapsed < edge_t * 4.0:
        vel = Vector2(0.0, -80.0)
    elif elapsed >= edge_t * 4.0:
        elapsed = 0.0
        
    var collision = self.move_and_slide(vel)
    
