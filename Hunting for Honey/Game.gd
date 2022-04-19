extends Node2D


onready var cam = $GameCam
onready var p1 = $Player1
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4
onready var plabel = $HUD/HBoxContainer/PlayerLabel
onready var spaceLabel = $HUD/HBoxContainer/SpaceLabel
onready var moveBtn = $HUD/HBoxContainer/MoveButton
onready var endBtn = $HUD/HBoxContainer/EndTurn
var rng = RandomNumberGenerator.new()

var nextPlayer = ["Player 2", "Player 3", "Player 4", "Player 1"]
var currPlayerIdx = 0 

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
	GameState.currentPlayer.move(rng.randi_range(1,6))
	yield(GameState.currentPlayer, 'movedone')
	moveBtn.visible = false
	endBtn.visible = true

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
			GameState.currentPlayer = p1
			currPlayerIdx = 0
	GameState.update_spaceLabel(GameState.currentPlayer.space)
	update_label()
	move_camera(GameState.currentPlayer)
	$HUD/HBoxContainer/MoveButton.visible = true
	$HUD/HBoxContainer/EndTurn.visible = false
	$HUD/HBoxContainer/MoveButton.disabled = false
	$HUD/TurnSwitch.visible = false












