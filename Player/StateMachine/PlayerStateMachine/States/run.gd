extends Motion

func _enter() -> void:
	animation_state_changed.emit("Walk")
	
func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		finished.emit("Jump")
	
	if _event.is_action_pressed("sprint"):
		finished.emit("Sprint")

func _update(delta: float) -> void:
	set_direction()
	calculate_velocity(speed, direction, PLAYER_MOVEMENT_STATS.acceleration, delta)
	
	if direction == Vector3.ZERO:
		finished.emit("Idle")
		
	if not is_on_floor():
		finished.emit("Fall")
		
	input_direction_changed.emit(input_dir)
