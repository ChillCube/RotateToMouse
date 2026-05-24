extends Node2D
class_name RotateToMouse

var rotator : Rotator2D
@export var on : bool = true;
@export_enum("IMMIDIATE", "LERP") var mode : int = 0;
@export var lerp_speed : float = 7;

func _create_rotator() -> Rotator2D:
	var _rotator = Rotator2D.new();
	_rotator.rotation_mode = mode;
	_rotator.lerp_speed = lerp_speed;
	return _rotator;

func _ready() -> void:
	rotator = _create_rotator();
	get_parent().add_child.call_deferred(rotator);
	rotator._set_target_rotation_by_direction(_direction_to_mouse())
	get_parent().rotation = rotator.target_rotation

func _process(delta: float) -> void:
	if on:
		rotator._set_target_rotation_by_direction(_direction_to_mouse())

func _direction_to_mouse() -> Vector2:
	return (get_global_mouse_position() - get_parent().global_position).normalized()
