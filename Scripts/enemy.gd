extends CharacterBody2D
#variables, of course
var speed = 35
var entered = false
var player = null
var Health = 20
var overlap = false
var dead = false
var cooldown = true
var knockbackPower = 500
var knockbackDir = "left"
@onready var anim = $AnimatedSprite2D


#Decides what animation should be playing at load
func _ready():
	get_node("AnimatedSprite2D").play("Idle") 
func _physics_process(delta):
	damage()
	print (velocity)
	if entered == true and dead == false:#movement with animation controller
		knockbackDir = "right"
		anim.flip_h = false
		#Main enemy movement script
		var moveDirection = (position + player.position ) 
		velocity = moveDirection.normalized()
		if velocity == Vector2(0,0) and knockbackDir == "up" :
			velocity = Vector2(0,1)
		elif velocity == Vector2(0,0) and knockbackDir == "down":
			velocity = Vector2(1,0)
		elif velocity == Vector2(0,0) and knockbackDir == "right":
			velocity = Vector2(1,1)
		position = position.move_toward(player.position , speed*delta)
		anim.play("Walk")
		#Decides which side the player is on and flips the sprite accordingly
		move_and_collide(Vector2(0,0))
		if player.position.x - position.x > 0 :
			anim.flip_h = true
			knockbackDir = "left"
		if player.position.y - position.y > 0 :
			knockbackDir = "up"
		else:
			knockbackDir = "down"
	elif dead == true:
		anim.play("Death")
	else:
		anim.play("Idle")
#detects when a body enters the detection area and sets that body as the player
func _on_detection_area_body_entered(body):
	entered = true
	player = body
#Detects when the body (player) exits
func _on_detection_area_body_exited(body):
	entered = false
	Health = 20
#States that this scene is a type of enemy
func enemy():
	pass

#Basic damage/health control script 
func _on_hitbox_e_body_entered(body):
	if body.has_method("player"):
		overlap = true
func _on_hitbox_e_body_exited(body):
	if body.has_method("player"):
		overlap = false
#whenever called, decreases health
func damage():
	if overlap and Input.is_action_pressed("click") and cooldown == true: 
		
		Health -= 2
		cooldown = false
		$Timer.start()
		if Health <=0:
			dead = true
			$Death.start()
		knockback()
#fires every 0.2 seconds
func _on_timer_timeout():
	cooldown = true
#animation timer for death animation 
#deletes the enemy after a specific time
func _on_death_timeout():
	$Death.stop()
	self.queue_free()
func knockback() :
	var knockbackDirection = -velocity.normalized() * knockbackPower
	velocity = knockbackDirection 
	#print (velocity)
	move_and_slide()
