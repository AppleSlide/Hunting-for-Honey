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
	disableCollision()
	p1.collision.disabled = true
	p2.collision.disabled = true
	p3.collision.disabled = true
	p4.collision.disabled = true
	
	p1.sprite.set_texture(p1.sprites[0])
	p2.sprite.set_texture(p2.sprites[1])
	p3.sprite.set_texture(p3.sprites[2])
	p4.sprite.set_texture(p4.sprites[3])
	move_camera(p1)
	GameState.currentPlayer = p1
	GameState.currentPlayer.collision.disabled = true
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
	print("NOW INDEX: " + str(nowIdx))
	disableCollision()
	GameState.currentPlayer.collision.disabled = true
	GameState.currentPlayer.move(rng.randi_range(1,6))
	yield(GameState.currentPlayer, 'movedone')
	GameState.currentPlayer.collision.disabled = false
	enableCollision()
	GameState.currentPlayer.checkCollision()
	moveBtn.visible = false
	honeyPoints[nowIdx] = honeyPoints[nowIdx] + GameState.currentPlayer.score
	print(honeyPoints[nowIdx])
	$HUD/P1Score.text = "Player 1: " + str(honeyPoints[0]) + " Player 2: " + str(honeyPoints[1]) + " Player 3: " + str(honeyPoints[2]) + " Player 4: " + str(honeyPoints[3])
	#GameState.currentPlayer.score = 0
	GameState.currentPlayer.collision.disabled = true
	endBtn.visible = true
	nowIdx = nowIdx + 1
	if(nowIdx > 3):
		nowIdx = 0
	print("NOW INDEX: " + str(nowIdx))

func _on_EndTurn_pressed():
	$HUD/TurnSwitch/VBoxContainer/Label.text = nextPlayer[currPlayerIdx] + "'s Turn"
	$HUD/TurnSwitch.visible = true


func _on_Button_pressed():
	GameState.currentPlayerLabel = nextPlayer[currPlayerIdx]
	match currPlayerIdx:
		0:
			GameState.currentPlayer = p2
			disableCollision()
			GameState.currentPlayer.collision.disabled = true
			#GameState.currentPlayer.sprite.set_texture(GameState.currentPlayer.sprites[currPlayerIdx])
			currPlayerIdx = 1
		1:
			GameState.currentPlayer = p3
			disableCollision()
			GameState.currentPlayer.collision.disabled = true
			#GameState.currentPlayer.sprite.set_texture(GameState.currentPlayer.sprites[currPlayerIdx])
			currPlayerIdx = 2
		2:
			GameState.currentPlayer = p4
			disableCollision()
			GameState.currentPlayer.collision.disabled = true
			#GameState.currentPlayer.sprite.set_texture(GameState.currentPlayer.sprites[currPlayerIdx])
			currPlayerIdx = 3
		3:
			GameState.currentPlayer = p1
			disableCollision()
			GameState.currentPlayer.collision.disabled = true
			#GameState.currentPlayer.sprite.set_texture(GameState.currentPlayer.sprites[currPlayerIdx])
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
	$Score10/CS2.disabled = true
	$Score10/CS1.disabled = true
	$Score10/CS3.disabled = true
	$Score10/CS4.disabled = true
	$Score10/CS5.disabled = true
	$Score10/CS6.disabled = true
	$Score10/CS7.disabled = true
	$Score10/CS8.disabled = true
	$Score10/CS9.disabled = true
	$Score10/CS10.disabled = true
	$Score10/CS11.disabled = true
	$Score10/CS12.disabled = true
	$Score10/CS13.disabled = true
	$Score10/CS14.disabled = true
	$Score10/CS15.disabled = true
	##$Score10/CS16.disabled = true
	$Score10/CS17.disabled = true
	$Score10/CS18.disabled = true
	$Score10/CS19.disabled = true
	$Score10/CS20.disabled = true
	
	$Score50/CS1.disabled = true
	$Score50/CS2.disabled = true
	$Score50/CS3.disabled = true
	
	$Minus10/CS1.disabled = true
	$Minus10/CS2.disabled = true
	$Minus10/CS3.disabled = true
	$Minus10/CS4.disabled = true
	$Minus10/CS5.disabled = true
	$Minus10/CS6.disabled = true
	$Minus10/CS7.disabled = true
	$Minus10/CS8.disabled = true
	$Minus10/CS9.disabled = true
	$Minus10/CS10.disabled = true
	$Minus10/CS11.disabled = true
	$Minus10/CS12.disabled = true
	$Minus10/CS13.disabled = true
	
	$Minus50/CollisionShape2D.disabled = true
	$Minus50/CollisionShape2D2.disabled = true
	$Minus50/CollisionShape2D3.disabled = true
	$DoubleMove/CS1.disabled = true
	$DoubleMove/CS2.disabled = true
	$DoubleMove/CS3.disabled = true
	$MoveBack2/CollisionShape2D.disabled = true
	$MoveBack2/CollisionShape2D2.disabled = true
	$MoveBack2/CollisionShape2D3.disabled = true

func enableCollision():
	$Score10/CS1.disabled = false
	$Score10/CS2.disabled = false
	$Score10/CS1.disabled = false
	$Score10/CS3.disabled = false
	$Score10/CS4.disabled = false
	$Score10/CS5.disabled = false
	$Score10/CS6.disabled = false
	$Score10/CS7.disabled = false
	$Score10/CS8.disabled = false
	$Score10/CS9.disabled = false
	$Score10/CS10.disabled = false
	$Score10/CS11.disabled = false
	$Score10/CS12.disabled = false
	$Score10/CS13.disabled = false
	$Score10/CS14.disabled = false
	$Score10/CS15.disabled = false
	$Score10/CS17.disabled = false
	$Score10/CS18.disabled = false
	$Score10/CS19.disabled = false
	$Score10/CS20.disabled = false
	
	$Score50/CS1.disabled = false
	$Score50/CS2.disabled = false
	$Score50/CS3.disabled = false
	
	$Minus10/CS1.disabled = false
	$Minus10/CS2.disabled = false
	$Minus10/CS3.disabled = false
	$Minus10/CS4.disabled = false
	$Minus10/CS5.disabled = false
	$Minus10/CS6.disabled = false
	$Minus10/CS7.disabled = false
	$Minus10/CS8.disabled = false
	$Minus10/CS9.disabled = false
	$Minus10/CS10.disabled = false
	$Minus10/CS11.disabled = false
	$Minus10/CS12.disabled = false
	$Minus10/CS13.disabled = false
	
	$Minus50/CollisionShape2D.disabled = false
	$Minus50/CollisionShape2D2.disabled = false
	$Minus50/CollisionShape2D3.disabled = false
	$DoubleMove/CS1.disabled = false
	$DoubleMove/CS2.disabled = false
	$DoubleMove/CS3.disabled = false
	$MoveBack2/CollisionShape2D.disabled = false
	$MoveBack2/CollisionShape2D2.disabled = false
	$MoveBack2/CollisionShape2D3.disabled = false











