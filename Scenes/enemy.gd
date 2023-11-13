extends CharacterBody2D
#variables, of course
var speed = 40
var entered = false
var player = null
var Health = 2
var dead = false
var overlap = false
@onready var anim = $AnimatedSprite2D
#Decides what animation should be playing at load
func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	if entered == true:#movement with animation controller
		anim.flip_h = false
		#Main enemy movement script
		position = position.move_toward(player.position , speed*delta)
		anim.play("Walk")
		#Decides which side the player is on and flips the sprite accordingly
		move_and_collide(Vector2(0,0))
		if player.position.x - position.x > 0 :
			anim.flip_h = true
	else:
		anim.play("Idle")
#detects when a body enters the detection area and sets that body as the player
func _on_detection_area_body_entered(body):
	entered = true
	player = body
#Detects when the body (player) exits
func _on_detection_area_body_exited(body):
	entered = false
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
	if overlap: 
		Health -= 2
		if Health <=0:
			anim.play("Death")
		print (Health)
#fires every 0.2 seconds
func _on_timer_timeout():
	damage()
	

