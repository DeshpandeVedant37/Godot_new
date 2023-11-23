extends CharacterBody2D
#note to self : increase animation speed
var SPEED =00.0
var current_dir = "none"
var Health = 2
var overlap = false
var dead = false
var cooldown = true
var attack_ip = false
var sprint = true 

func _ready():
	current_dir = "up"
	play_animation(0)
func _physics_process(delta):
	damage()
	attack()
	Sprint()
	if dead == true :
		$AnimatedSprite2D.play("Death")
	
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
	if velocity.x == 0 and velocity.y == 0:#stops animation when player is not in motion
		play_animation(0)
#animation controller function
func play_animation(movement):#controlls animation on the basis of 1s and 0s
	var dir = current_dir
	print (SPEED)
	var ainm = $AnimatedSprite2D
	if dir == "right":
		ainm.flip_h = false
		if movement == 1 and attack_ip == false and dead == false:
			ainm.play("Run-S")
		elif movement == 0 and attack_ip == false and dead == false: 
			ainm.play("Idle-S")
	if dir == "left":
		ainm.flip_h = true
		if movement  == 1 and attack_ip == false and dead == false:
			ainm.play("Run-S")
		elif movement == 0 and attack_ip == false and dead == false :
			ainm.play("Idle-S")
	if dir == "down":
		ainm.flip_h = true
		if movement  == 1 and attack_ip == false and dead == false:
			ainm.play("Run-F")
		elif movement == 0 and attack_ip == false and dead == false:
			ainm.play("Idle-F")
	if dir == "up":
		ainm.flip_h = true
		if movement  == 1 and attack_ip == false and dead == false:
			ainm.play("Run-B")
		elif movement == 0 and attack_ip == false and dead == false:
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
	if overlap and cooldown == true:
		Health -= 1
		cooldown = false
		$Timer.start()
		if Health <=0 :
			dead = true
			$Death.start()
		#print(Health)
func _on_timer_timeout():#gets called every 0.2 seconds
	cooldown = true
	
#attack animation controller
func attack():
	var dir = current_dir
	var anim = $AnimatedSprite2D
	if Input.is_action_pressed("click"):
		attack_ip = true
		global.player_current_attack = true
		if dir == "right":
			anim.flip_h = false
			anim.play("Attack-S")
			$Attack_timer.start()
		if dir == "left":
			anim.flip_h = true
			anim.play("Attack-S")
			$Attack_timer.start()
		if dir == "down":
			anim.play("Attack-F")
			$Attack_timer.start()
		if dir == "up":
			anim.play("Attack-B")
			$Attack_timer.start()
	

#Attack animationo timer
func _on_attack_timer_timeout():
	$Attack_timer.stop()
	attack_ip = false
	global.player_current_attack = false


func _on_death_timeout():
	$Death.stop()
	get_tree().change_scene_to_file("res://Scenes/Death.tscn")

func Sprint():
	if Input.is_action_pressed("Shift") and sprint == true:
		SPEED = 150
		$Sprint.start()
	else:
		SPEED = 100

func _on_sprint_timeout():
	SPEED = 100
	sprint = false
	$Sprint.stop()
	
