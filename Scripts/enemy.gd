extends CharacterBody2D
var speed = 125
var player_chase = false
var player= null

func _physics_process(delta):
	var enemy = global_position
	
	print(enemy)
	if player_chase == true:
		position = player.position
	move_and_slide()
func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		print (player.position)
		player_chase = true

func _on_detection_area_body_exited(body):
		player_chase = false
		print (player.position)
