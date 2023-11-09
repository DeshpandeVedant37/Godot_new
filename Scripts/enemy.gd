extends CharacterBody2D

var entered = false
var target = position 

func _on_area_2d_body_entered(body: CharacterBody2D ):
	entered = true
func _on_area_2d_body_exited(body: CharacterBody2D):
	entered = false
func _physics_process(delta):
	target = get_position_delta()
	print (target)
