extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selected = true;

# Called when the node enters the scene tree for the first time.
func _ready():
    if selected:
        $selected_indicator.show()
    else:
        $selected_indicator.hide()

func _is_non_blocking(pos):
    var offset = Vector2(-1, -1)
    var tile_map = get_tree().get_current_scene().get_node("tile_map")
    var tile = tile_map.get_cellv(pos + offset)
    print(pos)
    # var tile_map_pos = tile_map.world_to_map(pos)
    # print(tile_map_pos)
    print(tile)
    if tile == -1:            
        return true
    return false
        
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if selected:
        var pos = get_node("..").position
        var try_move = true
        if Input.is_action_just_pressed('ui_left'):
            pos.x -= 1
        elif Input.is_action_just_pressed('ui_right'):
            pos.x += 1
        elif Input.is_action_just_pressed('ui_up'):
            pos.y -= 1
        elif Input.is_action_just_pressed('ui_down'):
            pos.y += 1
        else:
            try_move = false
            
        if try_move:
            if self._is_non_blocking(pos):
                get_node("..").position = pos
            else:
                print("blocked")
                
func _on_unit_pressed():
    if not selected:
        print('selected')
        selected = true
        $selected_indicator.show()
    else:
        print('not selected')
        selected = false
        $selected_indicator.hide()
