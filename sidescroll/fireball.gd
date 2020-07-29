extends KinematicBody2D

var count = 0
var max_count = 20
export var speed = 500
export var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    show()
    # print('test')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func start(pos, dir):
    position = pos
    direction = dir
    
func _physics_process(delta):
    var velocity = direction.normalized() * speed
    var collision_info = move_and_collide(velocity * delta)
    if collision_info:
        # print('fireball collision')
        queue_free()

        
        var tilemap = get_node('/root/Platform').get_node('TileMap')
        var cell = tilemap.world_to_map(collision_info.position - collision_info.normal)
        if cell:
            var tile_id = tilemap.get_cellv(cell)
            if tile_id == 1:
                tilemap.set_cell(cell.x, cell.y, -1)
                print(cell)
                print(tile_id)
        else:
            print (collision_info)
    count += 1
    # print('bullet ' + str(position))
    if count > max_count:
        queue_free()

# func _on_VisibilityNotifier2D_screen_exited():
#     queue_free()
    
func _exit_tree():
    pass
    # print('fireball exiting')

func _on_player_fireball_area_shape_entered(area_id, area, area_shape, self_shape):
    print("player fireball area shape entered")
    queue_free()


func _on_player_fireball_body_entered(body):
    print("player fireball body entered")
    pass # Replace with function body.
