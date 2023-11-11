extends CharacterBody2D

var speed = 70
var entered = false
var player = null


func _physics_process(delta):
	if entered == true:
		position = position.move_toward(player.position , speed*delta)

func _on_detection_area_body_entered(body):
	entered = true
	player = body

func _on_detection_area_body_exited(body):
	entered = false
