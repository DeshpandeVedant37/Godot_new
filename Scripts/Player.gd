extends CharacterBody2D
var SPEED = 150.0
var current_dir = "none"
func _ready():
	$AnimatedSprite2D.play("Idle-B")
func _physics_process(delta):
	#gets a vector quantity with respect to keys pressed
	var dir = Input.get_vector("ui_left" , "ui_right" , "ui_up" , "ui_down")
	velocity = dir.normalized() * SPEED
	move_and_slide()
	
	if dir.y == -1:
		current_dir = "up"
		play_animation(1)
	elif dir.y == 1:
		current_dir = "down"
		play_animation(1)
	elif dir.x == -1:
		current_dir = "left"
		play_animation(1)
	elif dir.x == 1:
		current_dir = "right"
		play_animation(1)
	if dir.x == 0 and dir.y == 0:
		play_animation(0)
#animation controller function
func play_animation(movement):
	var dir = current_dir
	var ainm = $AnimatedSprite2D
	if dir == "right":
		ainm.flip_h = false
		if movement == 1:
			ainm.play("Run-S")
		elif movement == 0:
			ainm.play("Idle-S")
	if dir == "left":
		ainm.flip_h = true
		if movement  == 1:
			ainm.play("Run-S")
		elif movement == 0:
			ainm.play("Idle-S")
	if dir == "down":
		ainm.flip_h = true
		if movement  == 1:
			ainm.play("Run-F")
		elif movement == 0:
			ainm.play("Idle-F")
	if dir == "up":
		ainm.flip_h = true
		if movement  == 1:
			ainm.play("Run-B")
		elif movement == 0:
			ainm.play("Idle-B")

