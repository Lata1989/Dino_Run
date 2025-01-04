extends Node

# Variables del juego
const DINO_START_POS := Vector2i(150, 485)
const CAM_START_POS := Vector2i(576,324)
var score : float
const SCORE_MODIFIER : int = 10
var speed : float
const START_SPEED : float = 10.0
const SPEED_MODIFIER : float = 100
const MAX_SPEED : int = 25
var screen_size : Vector2i
var game_running : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	screen_size = get_window().size
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#pass
	if game_running:
		speed = START_SPEED + score / SPEED_MODIFIER
		
		# Mover al dinosaurio y la camara
		$Dino.position.x += speed
		$Camera2D.position.x += speed
		
		# Actualizar puntuacion
		score += speed / SCORE_MODIFIER
		print("Puntuacion: ", score)
		show_score()
		
		# Actualizar posicion de la tierra
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$HUD.get_node("StartLabel").hide()

func new_game():
	# Reset variables
	score = 0
	show_score()
	game_running = false
	# Reset nodos
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2i(0, 0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(0, 0)
	
	# Reset HUD
	$HUD.get_node("StartLabel").show()

func show_score():
	$HUD.get_node("ScoreLabel").text = "Puntuacion: " + str(int(score))
