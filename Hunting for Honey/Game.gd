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
var diceRoll = 0
var player = p1

var nowIdx = 0

var nextPlayer = ["Player 2", "Player 3", "Player 4", "Player 1"]
var currPlayerIdx = 0 
var honeyPoints = [0, 0, 0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	disableCollision()
	print("READY WAS CALLED")
	disableCollision()
	print("CALLEd")
	p1.collision.set_disabled(true)
	p2.collision.set_disabled(true)
	p3.collision.set_disabled(true)
	p4.collision.set_disabled(true)
	
	p1.sprite.set_texture(p1.sprites[0])
	p2.sprite.set_texture(p2.sprites[1])
	p3.sprite.set_texture(p3.sprites[2])
	p4.sprite.set_texture(p4.sprites[3])
	move_camera(p1)
	GameState.currentPlayer = p1
	#GameState.currentPlayer.collision.set_deferred("disabled", true)
	GameState.currentPlayerLabel = "Player 1"
	update_label()
	rng.randomize()
	$HUD/HBoxContainer/MoveButton.hide()
	


# moves camera to parent
func move_camera(p):
	cam.get_parent().remove_child(cam)
	p.add_child(cam)

func update_label():
	plabel.text = GameState.currentPlayerLabel

func update_spaceLabel(space):
	spaceLabel.text = str(space)	

func _on_MoveButton_pressed():
	if(nowIdx == 0):
		player = p1
	elif(nowIdx == 1):
		player = p2
	elif(nowIdx == 2):
		player = p3
	elif(nowIdx == 3):
		player = p4
	moveBtn.disabled = true
	print("NOW INDEX: " + str(nowIdx))
	disableCollision()
	GameState.currentPlayer.move(diceRoll + 1)
	yield(GameState.currentPlayer, 'movedone')
	enableCollision()
	player.collision.set_disabled(false)
	print("Should be false everytime: " + str(player.collision.is_disabled()))
	player.checkCollision()
	moveBtn.visible = false
	honeyPoints[nowIdx] = honeyPoints[nowIdx] + player.score
	print(honeyPoints[nowIdx])
	$HUD/P1Score.text = "Player 1: " + str(honeyPoints[0]) + " Player 2: " + str(honeyPoints[1]) + " Player 3: " + str(honeyPoints[2]) + " Player 4: " + str(honeyPoints[3])
	#GameState.currentPlayer.score = 0
	player.collision.set_disabled(true)
	endBtn.visible = true
	nowIdx = nowIdx + 1
	if(nowIdx > 3):
		nowIdx = 0
	print("NOW INDEX: " + str(nowIdx))
	disableCollision()

func _on_EndTurn_pressed():
	$HUD/TurnSwitch/VBoxContainer/Label.text = nextPlayer[currPlayerIdx] + "'s Turn"
	$HUD/TurnSwitch.visible = true
	$HUD/RollButton.show()
	


func _on_Button_pressed():
	GameState.currentPlayerLabel = nextPlayer[currPlayerIdx]
	match currPlayerIdx:
		0:
			GameState.currentPlayer = p2
			#GameState.currentPlayer.collision.set_disabled(true)
			#GameState.currentPlayer.sprite.set_texture(GameState.currentPlayer.sprites[currPlayerIdx])
			currPlayerIdx = 1
		1:
			GameState.currentPlayer = p3
			#GameState.currentPlayer.collision.set_disabled(true)
			#GameState.currentPlayer.sprite.set_texture(GameState.currentPlayer.sprites[currPlayerIdx])
			currPlayerIdx = 2
		2:
			GameState.currentPlayer = p4
			#GameState.currentPlayer.collision.set_disabled(true)
			#GameState.currentPlayer.sprite.set_texture(GameState.currentPlayer.sprites[currPlayerIdx])
			currPlayerIdx = 3
		3:
			GameState.currentPlayer = p1
			#GameState.currentPlayer.collision.set_disabled(true)
			#GameState.currentPlayer.sprite.set_texture(GameState.currentPlayer.sprites[currPlayerIdx])
			currPlayerIdx = 0
	GameState.update_spaceLabel(GameState.currentPlayer.space)
	update_label()
	move_camera(GameState.currentPlayer)
	$HUD/HBoxContainer/MoveButton.visible = false
	$HUD/HBoxContainer/EndTurn.visible = false
	$HUD/HBoxContainer/MoveButton.disabled = false
	$HUD/TurnSwitch.visible = false
	
	
func diceRoller():
	$HUD/DiceRoll.play()
	$HUD/RollTimer.start()


func disableCollision():
	$Score10/CS1.set_disabled(true)
	#print("DISABLED OR NOT: " + str($Score10/CS1.disabled))
	$Score10/CS2.set_disabled(true)
	$Score10/CS1.set_disabled(true)
	$Score10/CS3.set_disabled(true)
	$Score10/CS4.set_disabled(true)
	$Score10/CS5.set_disabled(true)
	$Score10/CS6.set_disabled(true)
	$Score10/CS7.set_disabled(true)
	$Score10/CS8.set_disabled(true)
	$Score10/CS9.set_disabled(true)
	$Score10/CS10.set_disabled(true)
	$Score10/CS11.set_disabled(true)
	$Score10/CS12.set_disabled(true)
	$Score10/CS13.set_disabled(true)
	$Score10/CS14.set_disabled(true)
	$Score10/CS15.set_disabled(true)
	##$Score10/CS16.disabled = true
	$Score10/CS17.set_disabled(true)
	$Score10/CS18.set_disabled(true)
	$Score10/CS19.set_disabled(true)
	$Score10/CS20.set_disabled(true)
	
	$Score50/CS1.set_disabled(true)
	$Score50/CS2.set_disabled(true)
	$Score50/CS3.set_disabled(true)
	
	$Minus10/CS1.set_disabled(true)
	$Minus10/CS2.set_disabled(true)
	$Minus10/CS3.set_disabled(true)
	$Minus10/CS4.set_disabled(true)
	$Minus10/CS5.set_disabled(true)
	$Minus10/CS6.set_disabled(true)
	$Minus10/CS7.set_disabled(true)
	$Minus10/CS8.set_disabled(true)
	$Minus10/CS9.set_disabled(true)
	$Minus10/CS10.set_disabled(true)
	$Minus10/CS11.set_disabled(true)
	$Minus10/CS12.set_disabled(true)
	$Minus10/CS13.set_disabled(true)
	
	$Minus50/CollisionShape2D.set_disabled(true)
	$Minus50/CollisionShape2D2.set_disabled(true)
	$Minus50/CollisionShape2D3.set_disabled(true)
	$DoubleMove/CS1.set_disabled(true)
	$DoubleMove/CS2.set_disabled(true)
	$DoubleMove/CS3.set_disabled(true)
	$MoveBack2/CollisionShape2D.set_disabled(true)
	$MoveBack2/CollisionShape2D2.set_disabled(true)
	$MoveBack2/CollisionShape2D3.set_disabled(true)

func enableCollision():
	$Score10/CS1.set_disabled(false)
	print("IS IT ENABLED: " + str($Score10/CS1.is_disabled()))
	$Score10/CS2.set_disabled(false)
	$Score10/CS1.set_disabled(false)
	$Score10/CS3.set_disabled(false)
	$Score10/CS4.set_disabled(false)
	$Score10/CS5.set_disabled(false)
	$Score10/CS6.set_disabled(false)
	$Score10/CS7.set_disabled(false)
	$Score10/CS8.set_disabled(false)
	$Score10/CS9.set_disabled(false)
	$Score10/CS10.set_disabled(false)
	$Score10/CS11.set_disabled(false)
	$Score10/CS12.set_disabled(false)
	$Score10/CS13.set_disabled(false)
	$Score10/CS14.set_disabled(false)
	$Score10/CS15.set_disabled(false)
	$Score10/CS17.set_disabled(false)
	$Score10/CS18.set_disabled(false)
	$Score10/CS19.set_disabled(false)
	$Score10/CS20.set_disabled(false)
	
	$Score50/CS1.set_disabled(false)
	$Score50/CS2.set_disabled(false)
	$Score50/CS3.set_disabled(false)
	
	$Minus10/CS1.set_disabled(false)
	$Minus10/CS2.set_disabled(false)
	$Minus10/CS3.set_disabled(false)
	$Minus10/CS4.set_disabled(false)
	$Minus10/CS5.set_disabled(false)
	$Minus10/CS6.set_disabled(false)
	$Minus10/CS7.set_disabled(false)
	$Minus10/CS8.set_disabled(false)
	$Minus10/CS9.set_disabled(false)
	$Minus10/CS10.set_disabled(false)
	$Minus10/CS11.set_disabled(false)
	$Minus10/CS12.set_disabled(false)
	$Minus10/CS13.set_disabled(false)
	
	$Minus50/CollisionShape2D.set_disabled(false)
	$Minus50/CollisionShape2D2.set_disabled(false)
	$Minus50/CollisionShape2D3.set_disabled(false)
	$DoubleMove/CS1.set_disabled(false)
	$DoubleMove/CS2.set_disabled(false)
	$DoubleMove/CS3.set_disabled(false)
	$MoveBack2/CollisionShape2D.set_disabled(false)
	$MoveBack2/CollisionShape2D2.set_disabled(false)
	$MoveBack2/CollisionShape2D3.set_disabled(false)



func _on_RollButton_pressed():
	diceRoller()
	$HUD/RollButton.hide()
	$HUD/HBoxContainer/MoveButton.hide()


func _on_RollTimer_timeout():
	$HUD/RollTimer.stop()
	diceRoll = rng.randi_range(0, 5)
	$HUD/DiceRoll.stop()
	$HUD/DiceRoll.set_frame(diceRoll)
	#$Roll.text = str(diceRoll + 1)
	$HUD/HBoxContainer/MoveButton.show()
	
