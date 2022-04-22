extends Area2D


onready var collision = $CollisionShape2D
onready var tween = $Tween
var space = 0
var dir = Vector2.RIGHT
var speed = 2
var tilesize = 64
var score = 0
var move_space = 0

signal movedone


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 30
	position.y = 30

func move(spaces):
	move_space = spaces
	for n in spaces:
		movespace()
		yield(tween, "tween_completed")
		GameState.update_spaceLabel(space)
	emit_signal("movedone")

func movespace():
	match space:
		0: dir = Vector2.RIGHT
		15: dir = Vector2.DOWN
		24: dir = Vector2.LEFT
		40: dir = Vector2.UP
	space = (space + 1) % 48
	tween.interpolate_property(self, "position", position,
	position + dir * tilesize, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
func checkCollision():
	print("ENTERED")
	if(collision.disabled == false):
		print("COLLISION SHOULD WORK")



func _on_Score10_area_entered(area):
	score = score + 10
	print("ENTERED + 10, SCORE = " + str(score))


func _on_Score50_area_entered(area):
	score = score + 50
	print("ENTERED + 50, SCORE = " + str(score))


func _on_DoubleMove_area_entered(area):
	move(move_space)


func _on_Minus10_area_entered(area):
	score = score - 10
	print("ENTERED - 10, SCORE = " + str(score))


func _on_Minus50_area_entered(area):
	score = score - 50
	print("ENTERED - 50, SCORE = " + str(score))


func _on_MoveBack2_area_entered(area):
	score = 1000

