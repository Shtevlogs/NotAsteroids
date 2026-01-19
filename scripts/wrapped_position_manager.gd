class_name WrappedPositionManager
extends Node

static var _I: WrappedPositionManager

@onready var camera: Camera2D = $"../Camera2D"

func _ready() -> void:
    _I = self

static func get_wrapped_position(pos: Vector2) -> Vector2:
    var rect = get_camera_rect()

    var min_x : float = rect.position.x
    var max_x : float = min_x + rect.size.x
    var min_y : float = rect.position.y
    var max_y : float = min_y + rect.size.y
    
    if pos.x < min_x:
        pos.x += rect.size.x
    if pos.x > max_x:
        pos.x -= rect.size.x
    if pos.y < min_y:
        pos.y += rect.size.y
    if pos.y > max_y:
        pos.y -= rect.size.y
        
    return pos

static func get_camera_rect() -> Rect2:
    var camera_size = _I.camera.get_viewport_rect().size * _I.camera.zoom
    return Rect2(_I.camera.get_screen_center_position() - camera_size / 2, camera_size)
