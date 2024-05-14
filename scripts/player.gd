extends CharacterBody2D

@export var speed = 100

@export var inv: Inv

var playerState

var lastDirX: float
var lastDirY: float

var mouseLocationFromPlayer = null

func  _ready():
	hideText()

func _physics_process(delta):
	mouseLocationFromPlayer = get_global_mouse_position() - self.position
	showText(str(mouseLocationFromPlayer))
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		playerState = "idle"
	elif direction.x != 0 or direction.y != 0:
		playerState = "walking"
	velocity = direction * speed
	#move_and_collide(velocity)
	move_and_slide()
	
	var mousePos = get_global_mouse_position()
	$Marker2D.look_at(mousePos)
	
	if Input.is_action_just_pressed("attack"):
		playerState = "attack"
	
	playAnimation(direction)

func playAnimation(dir):
	if playerState == "idlle": #idle animation
		if lastDirY == -1.0:
			$AnimatedSprite2D.play("n_idle")
		if lastDirX == 1.0:
			$AnimatedSprite2D.play("e_idle")
		if lastDirY == 1.0:
			$AnimatedSprite2D.play("s_idle")
		if lastDirX == -1.0:
			$AnimatedSprite2D.play("w_idle")
		
		if lastDirX > 0.5 and lastDirY < -0.5:
			$AnimatedSprite2D.play("ne_idle")
		if lastDirX > 0.5 and lastDirY > 0.5:
			$AnimatedSprite2D.play("se_idle")
		if lastDirX < -0.5 and lastDirY > 0.5:
			$AnimatedSprite2D.play("sw_idle")
		if lastDirX < -0.5 and lastDirY < -0.5:
			$AnimatedSprite2D.play("nw_idle")
		
		
	if playerState == "walking": #walking animation
		if dir.y == -1:
			$AnimatedSprite2D.play("n_walk")
			lastDirY = -1.0
			lastDirX = 0
		if dir.x == 1:
			$AnimatedSprite2D.play("e_walk")
			lastDirX = 1.0
			lastDirY = 0
		if dir.y == 1:
			$AnimatedSprite2D.play("s_walk")
			lastDirY = 1.0
			lastDirX = 0.0
		if dir.x == -1:
			$AnimatedSprite2D.play("w_walk")
			lastDirX = -1.0
			lastDirY = 0.0
		
		if dir.x > 0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("ne_walk")
			lastDirX = 0.7
			lastDirY = -0.7
		if dir.x > 0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("se_walk")
			lastDirX = 0.7
			lastDirY = 0.7
		if dir.x < -0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("sw_walk")
			lastDirX = -0.7
			lastDirY = 0.7
		if dir.x < -0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("nw_walk")
			lastDirX = -0.7
			lastDirY = -0.7
		
		showText(str(lastDirX) + " : " + str(lastDirY))
		
		
	if playerState == "attack": #attack animation
		if mouseLocationFromPlayer.x >= -25 and mouseLocationFromPlayer.x <= 25 and mouseLocationFromPlayer.y < 0:
			$AnimatedSprite2D.play("n_attack")
		if mouseLocationFromPlayer.y >= -25 and mouseLocationFromPlayer.y <= 25 and mouseLocationFromPlayer.x > 0:
			$AnimatedSprite2D.play("e_attack")
		if mouseLocationFromPlayer.x >= -25 and mouseLocationFromPlayer.x <= 25 and mouseLocationFromPlayer.y > 0:
			$AnimatedSprite2D.play("s_attack")
		if mouseLocationFromPlayer.y >= -25 and mouseLocationFromPlayer.y <= 25 and mouseLocationFromPlayer.x < 0:
			$AnimatedSprite2D.play("w_attack")
		
		#if mouseLocationFromPlayer.x >= 25 and mouseLocationFromPlayer.y <= -25:
			#$AnimatedSprite2D.play("ne_attack")
		#if mouseLocationFromPlayer.x >= 0.5 and mouseLocationFromPlayer.y >= 25:
			#$AnimatedSprite2D.play("se_attack")
		#if mouseLocationFromPlayer.x >= -0.5 and mouseLocationFromPlayer.y >= 25:
			#$AnimatedSprite2D.play("sw_attack")
		#if mouseLocationFromPlayer.x >= -25 and mouseLocationFromPlayer.y <= -25:
			#$AnimatedSprite2D.play("nw_attack")
	

func player():
	pass

func collect(item):
	inv.insert(item)

func showText(text: String):
	var Text = $camera/Label
	Text.text = text
	Text.visible = true

func hideText():
	var Text = $camera/Label
	Text.text = ""
	Text.visible = false
