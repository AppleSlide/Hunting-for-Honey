extends Node2D


onready var cam = $Camera2D
onready var p1 = $Player1
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4
onready var plabel = $HUD/HBoxContainer/PlayerLabel
onready var spaceLabel = $HUD/HBoxContainer/SpaceLabel
onready var moveBtn = $HUD/HBoxContainer/MoveButton
onready var endBtn = $HUD/HBoxContainer/EndTurn
var rng = RandomNumberGenerator.new()

var nowIdx = 0

var nextPlayer = ["Player 2", "Player 3", "Player 4", "Player 1"]
var currPlayerIdx = 0 
var honeyPoints = [0, 0, 0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	move_camera(p1)
	GameState.currentPlayer = p1
	GameState.currentPlayerLabel = "Player 1"
	update_label()
	


# moves camera to parent
func move_camera(p):
	cam.get_parent().remove_child(cam)
	p.add_child(cam)

func update_label():
	plabel.text = GameState.currentPlayerLabel

func update_spaceLabel(space):
	spaceLabel.text = str(space)	

func _on_MoveButton_pressed():
	moveBtn.disabled = true
	disableCollision()
	GameState.currentPlayer.move(rng.randi_range(1,6))
	yield(GameState.currentPlayer, 'movedone')
	enableCollision()
	moveBtn.visible = false
	honeyPoints[nowIdx] = honeyPoints[nowIdx] + GameState.currentPlayer.score
	print(honeyPoints[0])
	$HUD/P1Score.text = "Player 1: " + str(honeyPoints[0]) + " Player 2: " + str(honeyPoints[1]) + " Player 3: " + str(honeyPoints[2]) + " Player 4: " + str(honeyPoints[3])
	GameState.currentPlayer.score = 0 
	endBtn.visible = true
	nowIdx = nowIdx + 1
	if(nowIdx > 3):
		nowIdx = 0

func _on_EndTurn_pressed():
	$HUD/TurnSwitch/VBoxContainer/Label.text = nextPlayer[currPlayerIdx] + "'s Turn"
	$HUD/TurnSwitch.visible = true


func _on_Button_pressed():
	GameState.currentPlayerLabel = nextPlayer[currPlayerIdx]
	match currPlayerIdx:
		0:
			GameState.currentPlayer = p2
			currPlayerIdx = 1
		1:
			GameState.currentPlayer = p3
			currPlayerIdx = 2
		2:
			GameState.currentPlayer = p4
			currPlayerIdx = 3
		3:
			GameState.currentPlayer = p1
			currPlayerIdx = 0
	GameState.update_spaceLabel(GameState.currentPlayer.space)
	update_label()
	move_camera(GameState.currentPlayer)
	$HUD/HBoxContainer/MoveButton.visible = true
	$HUD/HBoxContainer/EndTurn.visible = false
	$HUD/HBoxContainer/MoveButton.disabled = false
	$HUD/TurnSwitch.visible = false


func disableCollision():
	$Score10/CS1.disabled = true
	$Score50/CS1.disabled = true
	$Minus10/CS1.disabled = true
	$Minus50/CollisionShape2D.disabled = true
	$DoubleMove/CS1.disabled = true
	$MoveBack2/CollisionShape2D.disabled = true

func enableCollision():
	$Score10/CS1.disabled = false
	$Score50/CS1.disabled = false
	$Minus10/CS1.disabled = false
	$Minus50/CollisionShape2D.disabled = false
	$DoubleMove/CS1.disabled = false
	$MoveBack2/CollisionShape2D.disabled = false











