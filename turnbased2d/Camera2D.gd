extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if true:
        var pos = self.position
        var mv = 2
        var try_move = true
        if Input.is_action_just_pressed('left'):
            pos.x -= mv
        elif Input.is_action_just_pressed('right'):
            pos.x += mv
        elif Input.is_action_just_pressed('up'):
            pos.y -= mv
        elif Input.is_action_just_pressed('down'):
            pos.y += mv
        else:
            try_move = false
            
        if try_move:
            if true:
                self.position = pos

        # TODO(lucasw) zoom                
        # if Input.is_action_just_pressed('left'):
