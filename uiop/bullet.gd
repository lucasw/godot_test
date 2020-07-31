extends KinematicBody2D

var count = 0
var max_count = 8
export var speed = 300
export var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    show()
    # print('test')ddddddddddddddddddddddd

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):aaaaa
#    pass


func start(pos, dir):
    position = pos
    direction = dir
    
func _physics_process(delta):
    var velocity = direction.normalized() * speed
    
    var collision_info = move_and_collide(velocity * delta)
    if collision_info:
        # print('fireball collision')
        
      
        var tilemap = get_node('/root/Node2D').get_node('tiles')
        var dif = (collision_info.position - collision_info.normal)
        var cell = tilemap.world_to_map(dif * 4) 
        
        print (cell)
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
