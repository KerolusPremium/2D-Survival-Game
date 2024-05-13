extends CharacterBody2D

@export var speed = 100

@export var inv: Inv

var playerState

func  _ready():
	hideText()

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		playerState = "idle"
	elif direction.x != 0 or direction.y != 0:
		playerState = "walking"
	
	velocity = direction * speed
	#move_and_collide(velocity)
	move_and_slide()
	
	playAnimation(direction)
	

func playAnimation(dir):
	if playerState == "idle":
		$AnimatedSprite2D.play("idle")
	if playerState == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("n_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("e_walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("s_walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("w_walk")
		
		if dir.x > 0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("ne_walk")
		if dir.x > 0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("se_walk")
		if dir.x < -0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("sw_walk")
		if dir.x < -0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("nw_walk")
		
		

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
