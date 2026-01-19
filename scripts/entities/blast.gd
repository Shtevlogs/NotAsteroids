class_name Blast
extends Node2D

var state : BlastState

func _ready() -> void:
    state.destroyed.connect(_on_destroy)

func _process(delta: float) -> void:
    var motion_dist := GameConfig.BLAST_VELOCITY * delta
    state.position = WrappedPositionManager.get_wrapped_position(state.position + state.velocity * delta)
    state.traveled_distance += motion_dist
    if state.traveled_distance >= GameConfig.BLAST_DISTANCE:
        _on_destroy()
    else:
        var collision_asteroid := CollisionHelpers.intersects_asteroid(position, state.position)
        position = state.position
        if collision_asteroid != -1:
            EventHelpers.asteroid_blast_collide(collision_asteroid)

func _on_destroy() -> void:
    state.active = false
    queue_free()
