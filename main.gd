extends Node

@export var pipe_scene :PackedScene
@onready var sfx_hit: AudioStreamPlayer2D = $sfxHit
@onready var sfx_jump: AudioStreamPlayer2D = $sfxJump
var gameRunning : bool
var gameOver : bool
var scroll
var score
var scrollSpeed : int = 4
var screenSize : Vector2i
var groundHeight : int
var pipes : Array
const  pipeDelay  : int = 100
const pipeRange : int = 200
func _ready():
	screenSize = get_window().size
	groundHeight = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()



func new_game():
	gameRunning = false
	gameOver = false
	score= 0
	scroll = 0
	$Label.text = "Score: " + str(score)
	get_tree().call_group("pipes", "queue_free")
	$GameOver.hide()
	pipes.clear()
	generatePipe()
	$Bird.reset()

func _input(event):
	if  gameOver == false :
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if gameRunning == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()
						$sfxJump.play()
						checkTop()
func start_game():
	
	gameRunning = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()
	$sfxJump.play()

func _process(delta):
	if gameRunning:
		scroll += scrollSpeed
		if scroll >= screenSize.x:
			scroll = 0
		$Ground.position.x = -scroll
		for pipe in pipes:
			pipe.position.x -= scrollSpeed



func _on_pipe_timer_timeout() -> void:
	generatePipe()
func generatePipe():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screenSize.x + pipeDelay
	pipe.position.y = (screenSize.y - groundHeight) / 2 + randi_range(-pipeRange, pipeRange)
	pipe.hit.connect(birdHit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)
	
func scored():
	score += 1
	$Label.text = "Score: " + str(score)
	if score % 10 ==  0:
		$sfxScore.play()
func checkTop():
	if $Bird.position.y < 0 :
		$Bird.falling = true
		stopGame()
func stopGame():
	$PipeTimer.stop()
	$Bird.flying = false
	gameRunning = false
	gameOver = true
	$GameOver.show()
	
func birdHit():
	$Bird.falling = true
	$sfxHit.play()
	stopGame()
func _on_ground_hit():
	$Bird.falling = false
	$sfxHit.play()
	stopGame()
	




func _on_game_over_restart():
	new_game()

func _on_exit_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
	get_tree().change_scene_to_file("res://StartMenu.tscn")
