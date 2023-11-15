extends CharacterBody2D
#note to self : increase animation speed
var SPEED = 150.0
var current_dir = "none"
var Health = 100
var overlap = false
var dead = false
var cooldown = true

func _ready():
	$AnimatedSprite2D.play("Idle-B")
func _physics_process(delta):
	
	if Input.is_action_pressed("Shift"):
		SPEED = 250
	else:
		SPEED = 150
	#gets a vector quantity with respect to keys pressed
	var dir = Input.get_vector("ui_left" , "ui_right" , "ui_up" , "ui_down")
	velocity = dir.normalized() * SPEED
	move_and_slide()

	if dir.y == -1:#Plays Run-B
		current_dir = "up"
		play_animation(1)
	elif dir.y == 1:#plays Run-F
		current_dir = "down"
		play_animation(1)
	elif dir.x == -1:#plays Run -S with flip_h true
		current_dir = "left"
		play_animation(1)
	elif dir.x == 1:# plays Run-S without flip_h
		current_dir = "right"
		play_animation(1)
	if dir.x == 0 and dir.y == 0:#stops animation when player is not in motion
		play_animation(0)
#animation controller function
func play_animation(movement):#controlls animation on the basis of 1s and 0s
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
		if Input.is_action_pressed("click"):
			ainm.play("Attack-F")
			print("attacked")
			
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

func player():#statse that this node is a player
	pass
func _on_hitbox_p_body_entered(body):#if an node enters the hitbox and that node is enemy, overlapped is set is true
	if body.has_method("enemy"):
		overlap = true

func _on_hitbox_p_body_exited(body):#if a node exits and its an enemy, overlap is false
	if body.has_method("enemy"):
		overlap= false
func damage():#basic code for handeling damage
	if overlap:
		Health -= 1
		if Health <= 0:
			print("death")
			get_parent().queue_free()
			get_tree().change_scene_to_file("res://Scenes/Death.tscn")
		#print (Health)
		print(Health)
func _on_timer_timeout():#gets called every 0.2 seconds
	damage()
