extends CharacterBody2D
const gravity : int = 1000
const MAX_VEl : int =  600
const FLAP_SPEED: int = -500
var flying: bool = false
var falling: bool = false
const START_POS = Vector2(100, 400)

func _ready():
	reset()
	

func reset():
	falling = false
	flying = false
	position = START_POS
	set_rotation(0)
	

func _physics_process(delta):
	if flying or falling:
		velocity.y += gravity * delta
		
		if  velocity.y > MAX_VEl:
			velocity.y = MAX_VEl
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2.play()
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()

func flap():
	velocity.y = FLAP_SPEED
	
		
	
