extends CharacterBody2D


var SPEED = 300.0
var current_dir = "none"

func _physics_process(delta):
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up" , "ui_down")
	
	if direction_x ==1:
		current_dir = "right"
	elif direction_x == -1:
		current_dir = "left"
		
	if direction_y == -1:
		current_dir == "up"
	elif direction_y ==1:
		current_dir = "down"
	
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y *SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
	print (direction_x)
	print (direction_y)
	print (current_dir)
