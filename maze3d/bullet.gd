extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var countdown = 3.0
var velocity = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    # print('bullet velocity ' + str(velocity))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    # print('update ' + str(get_translation()))
    var collision = move_and_collide(velocity)
    if collision:
        if collision.collider.has_method("damage"):
            #print('bullet collision ' + str(collision.collider))
            collision.collider.damage(5)
        queue_free()
    
    countdown -= delta
    if countdown < 0.0:
        # print('bullet timeout')
        queue_free()
