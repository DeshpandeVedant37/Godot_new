extends CharacterBody2D

var speed = 40
var entered = false
var player = null

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	var anim = $AnimatedSprite2D
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
