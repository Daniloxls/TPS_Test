extends Node3D

signal mouse_rotated(_rotation: Vector2)

@export var character: CharacterBody3D
@export var rear_spring_arm: SpringArm3D
@export var camera: Camera3D


@export var sprint_fov : float = 90
@export var sprint_tween_speed: float = 0.5


var camera_rotation: Vector2 = Vector2.ZERO
var mouse_sensitivity: float = 0.001
var max_y_rotation: float = 1.2

var camera_tween : Tween

@onready var default_rear_spring_arm_length: float = rear_spring_arm.spring_length
@onready var default_fov : float = camera.fov

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion:
		var mouse_event: Vector2 = event.screen_relative * mouse_sensitivity
		camera_look(mouse_event)
	
	#if event.is_action_pressed("sprint"):
		#enter_sprint()
	#
	#if event.is_action_released("sprint"):
		#exit_sprint()
		

func camera_look(mouse_movement: Vector2) -> void:
	camera_rotation += mouse_movement
	
	transform.basis = Basis()
	character.transform.basis = Basis()
	
	character.rotate_object_local(Vector3(0,1,0), -camera_rotation.x)
	rotate_object_local(Vector3(1,0, 0), -camera_rotation.y)
	
	camera_rotation.y = clamp( camera_rotation.y, -max_y_rotation, max_y_rotation)
	
	mouse_rotated.emit(camera_rotation)
	
func enter_sprint() -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = get_tree().create_tween()
	camera_tween.set_parallel()
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	
	camera_tween.tween_property(camera, "fov", sprint_fov, sprint_tween_speed)

func exit_sprint() -> void:
	if camera_tween:
		camera_tween.kill()
	
	
	camera_tween = get_tree().create_tween()
	camera_tween.set_parallel()
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	
	camera_tween.tween_property(camera, "fov", default_fov, sprint_tween_speed)
	


func _on_sprint_sprint_started() -> void:
	enter_sprint()


func _on_sprint_ended() -> void:
	exit_sprint()
