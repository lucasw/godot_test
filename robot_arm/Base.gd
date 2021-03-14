extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    print(self.get_node('BaseJoint'))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var joint = self.get_node('BaseJoint')
    # joint.Motor.Enable = true
