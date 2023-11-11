extends CharacterBody2D

var speed = 50
var entered = false
var player = null

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	var anim = $AnimatedSprite2D
	if entered == true:
		position = position.move_toward(player.position , speed*delta)
		anim.play("Walk")
	else:
		anim.play("Idle")
	if player.position.normalized < -1:
		anim.flip_h = true
		anim.play("walk")
	
func _on_detection_area_body_entered(body):
	entered = true
	player = body

func _on_detection_area_body_exited(body):
	entered = false
