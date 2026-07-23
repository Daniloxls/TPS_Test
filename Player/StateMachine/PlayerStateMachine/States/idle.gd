extends Motion


func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		finished.emit("Jump")
		

func _update(delta: float) -> void:
	set_direction()
	calculate_velocity(speed, direction, PLAYER_MOVEMENT_STATS.acceleration, delta)
	
	if direction != Vector3.ZERO:
		finished.emit("Run")
		
	if not is_on_floor():
		finished.emit("Fall")
