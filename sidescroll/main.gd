extends Node2D


var Enemy = preload("res://Enemy.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		var enemy = Enemy.instance()
		var pos = Vector2()
		pos.x = 50 + i * 100
		pos.y = 60
		enemy.start(pos)
		add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
