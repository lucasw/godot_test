extends HingeJoint


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
    self.set('motor/enable', true)
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    t += delta
    var rv = null;
    if int(t / 3.0) % 2 == 0:
        rv = self.set('motor/target_velocity', 1.0)
    else:
        rv = self.set('motor/target_velocity', -1.0)
    print(rv)
