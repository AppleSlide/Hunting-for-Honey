extends Node2D


onready var cam = $Camera2D
onready var p1 = $Player10
onready var p2 = $Player20
onready var p3 = $Player30
onready var p4 = $Player40
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
	p1.collision.set_disabled(true)
	p2.collision.set_visible(false)
	p3.collision.set_visible(false)
	p4.collision.set_visible(false)
	p1.collision.set_visible(false)
	p2.collision.set_disabled(true)
	p3.collision.set_disabled(true)
	p4.collision.set_disabled(true)
	move_camera(p1)
	GameState.currentPlayer = p1
	GameState.currentPlayerLabel = "Player 1"
	update_label()
	rng.randomize()
	$HUD/HBoxContainer/MoveButton.hide()
	$HUD/Music.play()
	$HUD/NewGame.hide()
	


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
	player.move(diceRoll + 1)
	yield(player, 'movedone')
	player.collision.visible = true
	player.collision.set_disabled(false)
	moveBtn.visible = false
	honeyPoints[nowIdx] = honeyPoints[nowIdx] + player.score
	print(player.score)
	print("HONEY POINTS: " + str(honeyPoints[nowIdx]))
	#$HUD/P1Score.text = "Player 1: " + str(honeyPoints[0]) + " Player 2: " + str(honeyPoints[1]) + " Player 3: " + str(honeyPoints[2]) + " Player 4: " + str(honeyPoints[3])
	endBtn.visible = true
	nowIdx = nowIdx + 1
	if(nowIdx > 3):
		nowIdx = 0
	print("NOW INDEX: " + str(nowIdx))
	#player.collision.visible = false
	#player.collision.set_disabled(true)
	#player.collision.visible = false
	#player.collision.set_disabled(true)
	##disableCollision()

func _on_EndTurn_pressed():
	$HUD/TurnSwitch/VBoxContainer/Label.text = nextPlayer[currPlayerIdx] + "'s Turn"
	$HUD/TurnSwitch.visible = true
	$HUD/RollButton.show()
	


func _on_Button_pressed():
	GameState.currentPlayerLabel = nextPlayer[currPlayerIdx]
	match currPlayerIdx:
		0:
			honeyPoints[0] = player.score
			player.collision.set_disabled(true)
			player.collision.set_visible(false)
			player = p2
			currPlayerIdx = 1
			player.collision.set_disabled(true)
			player.collision.set_visible(false)
		1:
			honeyPoints[1] = player.score
			player.collision.set_disabled(true)
			player.collision.set_visible(false)
			player = p3
			currPlayerIdx = 2
			player.collision.set_disabled(true)
			player.collision.set_visible(false)
		2:
			honeyPoints[2] = player.score
			player.collision.set_disabled(true)
			player.collision.set_visible(false)
			player = p4
			currPlayerIdx = 3
			player.collision.set_disabled(true)
			player.collision.set_visible(false)
		3:
			honeyPoints[3] = player.score
			player.collision.set_disabled(true)
			player.collision.set_visible(false)
			player = p1
			currPlayerIdx = 0
			player.collision.set_disabled(true)
			player.collision.set_visible(false)
	GameState.update_spaceLabel(player.space)
	update_label()
	$HUD/ScoreColor/ScoreBox/P1Score.text = "Player 1: " + str(honeyPoints[0])
	$HUD/ScoreColor/ScoreBox/P2Score.text = "Player 2: " + str(honeyPoints[1]) 
	$HUD/ScoreColor/ScoreBox/P3Score.text = "Player 3: " + str(honeyPoints[2])
	$HUD/ScoreColor/ScoreBox/P4Score.text = "Player 4: " + str(honeyPoints[3])
	move_camera(player)
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
	#$Score10/CS1.set_disabled(true)
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
	
	$Score50/CollisionShape2D2.set_disabled(true)
	$Score50/CollisionShape2D3.set_disabled(true)
	
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
	#$Score10/CS1.set_disabled(false)
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
	
	$Score50/CollisionShape2D2.set_disabled(false)
	$Score50/CollisionShape2D3.set_disabled(false)
	
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


func _on_Player10_gameover():
	plabel.text = "GAME OVER PLAYER 1 WINS!!!!"
	$HUD/NewGame.show()

func _on_Player20_gameover2():
	plabel.text = "GAME OVER PLAYER 2 WINS!!!!"
	$HUD/NewGame.show()

func _on_Player30_gameover3():
	plabel.text = "GAME OVER PLAYER 3 WINS!!!!"
	$HUD/NewGame.show()

func _on_Player40_gameover4():
	plabel.text = "GAME OVER PLAYER 4 WINS!!!!"
	$HUD/NewGame.show()

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
	

func _on_ATest_area_entered():
	print("HELLO WORLD")
	

func _on_NewGame_pressed():
	p1.collision.set_disabled(true)
	p2.collision.set_visible(false)
	p3.collision.set_visible(false)
	p4.collision.set_visible(false)
	p1.collision.set_visible(false)
	p2.collision.set_disabled(true)
	p3.collision.set_disabled(true)
	p4.collision.set_disabled(true)
	$Player10.score = 0
	$Player20.score = 0
	$Player30.score = 0
	$Player40.score = 0
	honeyPoints = [0, 0, 0, 0]
	$Player10.space = 0
	$Player20.space = 0
	$Player30.space = 0
	$Player40.space = 0
	$Player10.totalspaces2 = 0
	$Player20.totalspaces1 = 0
	$Player30.totalspaces = 0
	$Player40.total_spaces = 0
	$Player10.around = 0
	$Player20.around = 0
	$Player30.around = 0
	$Player40.around = 0
	GameState.update_spaceLabel(player.space)
	$HUD/ScoreColor/ScoreBox/P1Score.text = "Player 1: " + str(honeyPoints[0])
	$HUD/ScoreColor/ScoreBox/P2Score.text = "Player 2: " + str(honeyPoints[1]) 
	$HUD/ScoreColor/ScoreBox/P3Score.text = "Player 3: " + str(honeyPoints[2])
	$HUD/ScoreColor/ScoreBox/P4Score.text = "Player 4: " + str(honeyPoints[3])
	move_camera(p1)
	GameState.currentPlayer = p1
	nowIdx = 0
	GameState.currentPlayerLabel = "Player 1"
	update_label()
	currPlayerIdx = 0
	GameState.currentPlayerLabel = nextPlayer[currPlayerIdx]
	$Player10.position.x = 30
	$Player10.position.y = 30
	$Player20.position.x = 30
	$Player20.position.y = 30
	$Player30.position.x = 30
	$Player30.position.y = 30
	$Player40.position.x = 30
	$Player40.position.y = 30
