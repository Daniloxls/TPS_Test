extends Motion

signal sprint_ended

	
func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("sprint"):
		finished.emit("Fall")
		sprint_ended.emit()
		
func _update(delta: float) -> void:
	set_direction()
	calculate_gravity(delta)
	calculate_velocity(sprint_speed, direction, PLAYER_MOVEMENT_STATS.in_air_acceleration, delta)
	
	
	
	if is_on_floor() && (direction != Vector3.ZERO):
		finished.emit("Sprint")
	elif is_on_floor():
		finished.emit("Idle")
		sprint_ended.emit()
