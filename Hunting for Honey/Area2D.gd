extends Area2D


onready var sprite = $Sprite
export var player = 0;
onready var tween = $Tween
var sprites = [preload("res://Assets/Grass1.png"), preload("res://Assets/Grass1.png"), preload("res://Assets/Stup.png"), preload("res://Assets/Queen_bee_model.jpg")]
var space = 0
var dir = Vector2.RIGHT
var speed = 2
var tilesize = 64
var score = 0
var move_space = 0

signal movedone


# Called when the node enters the scene tree for the first time.
func _ready():
	##sprite.texture = sprites[player]
	sprite.set_texture(sprites[player])
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
		11: dir = Vector2.DOWN
		18: dir = Vector2.LEFT
		29: dir = Vector2.UP
	space = (space + 1) % 36
	tween.interpolate_property(self, "position", position,
	position + dir * tilesize, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Score10_body_entered(body):
	score = score + 10
	


func _on_Score50_body_entered(body):
	score = score + 50
	


func _on_DoubleMove_body_entered(body):
	move(move_space)


func _on_Minus10_body_entered(body):
	score = score - 10


func _on_Minus50_body_entered(body):
	score = score - 50



func _on_MoveBack2_body_entered(body):
	pass # Replace with function body.
	#NEED TO MAKE THE MOVE BACK FUNCTION


func _on_Score10_area_entered(area):
	score = score + 10


func _on_Score50_area_entered(area):
	score = score + 50


func _on_DoubleMove_area_entered(area):
	move(move_space)


func _on_Minus10_area_entered(area):
	score = score - 10


func _on_Minus50_area_entered(area):
	score = score - 50


func _on_MoveBack2_area_entered(area):
	score = 1000
