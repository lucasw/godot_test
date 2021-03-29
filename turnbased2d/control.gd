extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cur_selected = null
var units = {}

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _is_non_blocking(pos):
    var offset = Vector2(-1, -1)
    var tile_map = get_node("tile_map")
    var tile = tile_map.get_cellv(pos + offset)
    # print(pos)
    # var tile_map_pos = tile_map.world_to_map(pos)
    # print(tile_map_pos)
    # print(tile)
    if tile == -1:            
        return true
    return false
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if cur_selected:            
        var pos = cur_selected.position
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
                cur_selected.position = pos
                get_node("camera").position = pos
            else:
                pass  # print("blocked")

func register_unit(unit):
    print("new unit %s" % [unit])
    self.units[unit] = true
    
func on_unit_pressed(source):
    if cur_selected:
        cur_selected.selected = false
    cur_selected = source
    cur_selected.selected = true
    get_node("camera").position = source.position
    print("pressed %s" % source)
