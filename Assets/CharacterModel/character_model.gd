extends Node3D
class_name CharacterModel

@export var animation_tree: AnimationTree
@export var armature : Node3D

var current_mouse_rotation: Vector2
var input_dir: Vector2
var turn_rate: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func on_state_machine_animation_state_changed(state: String) -> void:
	animation_tree["parameters/movimento/transition_request"] = state


func _on_camera_mouse_rotated(_rotation: Vector2) -> void:
	current_mouse_rotation = _rotation
	
	transform.basis = Basis()
	rotate_object_local(Vector3(0,1,0), current_mouse_rotation.x)


func on_input_direction_changed(_input_direction: Vector2) -> void:
	input_dir = input_dir.lerp(_input_direction, turn_rate)
	rotate_armature(input_dir, current_mouse_rotation.x)

func rotate_armature(angle: Vector2, _offset: float = 0) -> void:
	var new_angle: float = atan2(angle.x, angle.y) - _offset
	
	armature.basis = Basis()
	armature.rotate_object_local(Vector3(0,1,0), new_angle)
