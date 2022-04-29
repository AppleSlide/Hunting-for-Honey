extends Area2D



onready var collision = $CollisionShape2D
onready var tween = $Tween
var space = 0
var dir = Vector2.RIGHT
var speed = 2
var tilesize = 64
var score = 0
var move_space = 0
var id = 1
var around = 0
var totalspaces = 0


signal movedone
signal gameover2


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 30
	position.y = 30
	
func resetScore():
	score = 0

func move(spaces):
	move_space = spaces
	totalspaces += spaces
	for n in spaces:
		movespace()
		yield(tween, "tween_completed")
		GameState.update_spaceLabel(space)
	print("MADE IT " + str(score))
	collision.visible = true
	collision.set_disabled(false)
	emit_signal("movedone")

func movespace():
	match space:
		0: dir = Vector2.RIGHT
		15: dir = Vector2.DOWN
		23: dir = Vector2.LEFT
		38: dir = Vector2.UP
	space = (space + 1) % 46
	if(space > 35):
		around = 1
	tween.interpolate_property(self, "position", position,
	position + dir * tilesize, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
func checkCollision():
	print("ENTERED")
	if(collision.disabled == false):
		print("COLLISION SHOULD WORK")



func _on_Score10_area_entered(area):
	if(area.id == id):
		score = score + 10
		if(score > 20 and around == 1 and totalspaces >= 46):
			emit_signal("gameover2")
		elif(score < 20 and around == 1 and totalspaces >= 46):
			score = score + 50
			around = 0
			totalspaces = totalspaces - 46
		print("pLAYER 2 ENTERED + 10, SCORE = " + str(score))


func _on_Score50_area_entered(area):
	if(area.id == id):
		score = score + 50
		if(score > 20 and around == 1 and totalspaces >= 46):
			emit_signal("gameover2")
		elif(score < 20 and around == 1 and totalspaces >= 46):
			score = score + 50
			around = 0
			totalspaces = totalspaces - 46
		print("PLAYER 2 ENTERED + 50, SCORE = " + str(score))


func _on_DoubleMove_area_entered(area):
	if(area.id == id):
		move(move_space)


func _on_Minus10_area_entered(area):
	if(area.id == id):
		score = score - 10
		if(score > 20 and around == 1 and totalspaces >= 46):
			emit_signal("gameover2")
		elif(score < 20 and around == 1 and totalspaces >= 46):
			score = score + 50
			around = 0
			totalspaces = totalspaces - 46
		print("Player 2 ENTERED - 10, SCORE = " + str(score))


func _on_Minus50_area_entered(area):
	if(area.id == id):
		score = score - 50
		if(score > 20 and around == 1 and totalspaces >= 46):
			emit_signal("gameover2")
		elif(score < 20 and around == 1 and totalspaces >= 46):
			score = score + 50
			around = 0
			totalspaces = totalspaces - 46
		print("Player 2 ENTERED - 50, SCORE = " + str(score))


func _on_MoveBack2_area_entered(area):
	pass


func _on_WinPlane_area_entered(area):
	if(area.id == id):
		if(score > 100):
			emit_signal("gameover2")
	else:
		score = score + 50
