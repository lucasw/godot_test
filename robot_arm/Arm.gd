extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    t += delta
    var joint0 = self.get_node('Base/Joint')
    var joint1 = self.get_node('RigidBody2/Joint')
    
    if int(t / 3.0) % 2 == 0:
        joint0.set('motor/target_velocity', 1.0)
        joint1.set('motor/target_velocity', -0.4)
    else:
        joint0.set('motor/target_velocity', -1.0)
        joint1.set('motor/target_velocity', 0.4)
    print(joint0.get('motor/target_velocity'))
