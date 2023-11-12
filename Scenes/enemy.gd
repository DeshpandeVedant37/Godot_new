extends CharacterBody2D

var speed = 40
var entered = false
var player = null
var Health = 2
var dead = false
var overlap = false
@onready var anim = $AnimatedSprite2D

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	#damage()
	

		
	if entered == true:
		anim.flip_h = false
		
		position = position.move_toward(player.position , speed*delta)
		anim.play("Walk")
		move_and_collide(Vector2(0,0))
		if player.position.x - position.x > 0 :
			anim.flip_h = true
	else:
		anim.play("Idle")
func _on_detection_area_body_entered(body):
	entered = true
	player = body
func _on_detection_area_body_exited(body):
	entered = false
	
func enemy():
	pass
	
func _on_hitbox_e_body_entered(body):
	if body.has_method("player"):
		overlap = true
func _on_hitbox_e_body_exited(body):
	if body.has_method("player"):
		overlap = false
		
func damage():
	if overlap: 
		Health -= 2
		if Health <=0:
			anim.play("Death")
		print (Health)
func _on_timer_timeout():
	damage()
	

