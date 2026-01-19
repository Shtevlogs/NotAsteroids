class_name EventHelpers

static func asteroid_blast_collide(asteroid_idx: int) -> void:
    AsteroidSpawnManager.destroy_asteroid(asteroid_idx)
    GameState.current.blast_state.destroyed.emit()

static func asteroid_player_collide(asteroid_idx: int) -> void:
    AsteroidSpawnManager.destroy_asteroid(asteroid_idx)
    GameState.current.player_state.destroyed.emit()

    
    
