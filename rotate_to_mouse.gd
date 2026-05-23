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

func _direction_to_mouse() -> Vector2: #Bug for some reason the parent node rotates a lot at spawn
	var camera = get_viewport().get_camera_2d()
	if not camera:
		return Vector2.ZERO
	var mouse_screen_pos = get_viewport().get_mouse_position()
	var viewport_size = get_viewport().get_visible_rect().size
	var mouse_world_pos = camera.global_position + \
						  (mouse_screen_pos - viewport_size / 2) * camera.zoom
	
	return (get_parent().global_position - mouse_world_pos).normalized()
