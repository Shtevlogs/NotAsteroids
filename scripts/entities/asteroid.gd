class_name Asteroid
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

const SPRITE_OFFSETS : Array[float] = [24, 48, 72]

var state : AsteroidState

func _ready() -> void:
    state.destroyed.connect(_on_destroy)
    sprite.texture = sprite.texture.duplicate()
    var atlas_texture := sprite.texture as AtlasTexture
    atlas_texture.region.position.x = SPRITE_OFFSETS[state.power]

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
