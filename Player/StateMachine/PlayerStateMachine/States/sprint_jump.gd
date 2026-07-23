extends Motion

signal sprint_ended

func _enter() -> void:
	jump()
	return super._enter()
	

func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("sprint"):
		sprint_ended.emit()
		finished.emit("Jump")
		
	
func _update(delta: float) -> void:
	set_direction()
	calculate_gravity(delta)
	calculate_velocity(sprint_speed, direction, PLAYER_MOVEMENT_STATS.in_air_acceleration, delta)
	
	
	
	if velocity.y <= 0:
		finished.emit("SprintFall")
	
func jump() -> void:
	velocity.y = jump_velocity
