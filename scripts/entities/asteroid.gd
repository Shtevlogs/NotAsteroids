class_name Asteroid
extends Node2D

@onready var polygons : Array[Polygon2D] = [
    $Polygon2D,
    $Polygon2D2,
    $Polygon2D3
]

var state : AsteroidState

func _ready() -> void:
    state.destroyed.connect(_on_destroy)
    polygons[state.power].visible = true

func _process(delta: float) -> void:
    # Update state
    state.position += state.velocity * delta
    var wrapped_position := WrappedPositionManager.get_wrapped_position(state.position)
    if state.is_approaching:
        if wrapped_position == state.position:
            state.is_approaching = false
    else:
        state.position = wrapped_position
    
    # Display state
    position = state.position

func _on_destroy() -> void:
    queue_free()
