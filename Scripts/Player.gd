extends CharacterBody2D


var SPEED = 300.0
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("Idle-B")
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up" , "ui_down")
	
	if direction_x ==1:
		current_dir = "right"
		play_animation(1)
	elif direction_x == -1:
		current_dir = "left"
		play_animation(1)
	if direction_y == -1:
		current_dir = "up"
		play_animation(1)
	elif direction_y == 1:
		current_dir = "down"
		play_animation(1)
	
	if direction_x == 0 and direction_y ==0:
		play_animation(0)
		
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y *SPEED
		
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
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
