extends Motion

signal sprint_started
signal sprint_ended

func _enter() -> void:
	sprint_started.emit()
	return super._enter()
	
func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		finished.emit("SprintJump")
		
	if _event.is_action_pressed("sprint"):
		finished.emit("Run")
		sprint_ended.emit()

func _update(delta: float) -> void:
	set_direction()
	calculate_velocity(sprint_speed, direction, PLAYER_MOVEMENT_STATS.acceleration, delta)
	
	
	if direction == Vector3.ZERO:
		finished.emit("Idle")
		sprint_ended.emit()
	
	if not is_on_floor():
		finished.emit("SprintFall")
		
	direction_updated.emit(input_dir)
