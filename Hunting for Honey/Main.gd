extends Node2D

onready var nav2d = $Navigation2D
onready var bee = $Bee

func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	bee.path = nav2d.get_simple_path(bee.global_position, event.global_position)
	print(event.global_position, $Navigation2D/TileMap.world_to_map(event.global_position))
