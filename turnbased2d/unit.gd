extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selected = true
var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
    print(self)
    var base = get_tree().get_current_scene()
    base.register_unit(self)
    get_node("button").connect("pressed", base,
                 "on_unit_pressed", [self])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if selected:
        $selected_indicator.show()
    else:
        $selected_indicator.hide()
    
func _on_unit_pressed():
    return
