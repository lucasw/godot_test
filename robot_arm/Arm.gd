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
    return
    var joint0 = self.get_node('Base/Joint')
    var joint1 = self.get_node('RigidBody2/Joint')
    
    if int(t / 3.0) % 2 == 0:
        joint0.set('motor/target_velocity', 1.0)
        joint1.set('motor/target_velocity', -0.4)
    else:
        joint0.set('motor/target_velocity', -1.0)
        joint1.set('motor/target_velocity', 0.4)
    print(joint0.get('motor/target_velocity'))

func _on_rotate_gui_value_changed(value):
    var joint = self.get_node('Base/Joint')
    var value_scaled = value / 100.0
    print(value_scaled)
    joint.set('motor/target_velocity', value_scaled)

func _on_rotate_shoulder_gui_value_changed(value):
    print(value)
    var joint = self.get_node('Rotation/Joint')
    var value_scaled = value / 100.0
    joint.set('motor/target_velocity', value_scaled)

func _on_rotate_elbow_gui_value_changed(value):
    var joint = self.get_node('UpperArm/Elbow')
    var value_scaled = value / 100.0
    print(value_scaled)
    joint.set('motor/target_velocity', value_scaled)
