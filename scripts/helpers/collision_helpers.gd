class_name CollisionHelpers

# Returns -1 on no-intersect, otherwise returns the asteroid index in gamestate
static func intersects_asteroid(pos_1: Vector2, pos_2: Vector2) -> int:
    if pos_1.distance_squared_to(pos_2) >= GameConfig.MAX_COLLISION_AWARENESS_2:
        return -1
    
    var line_seg := SegmentShape2D.new()
    line_seg.a = pos_1
    line_seg.b = pos_2
    var line_transform := Transform2D(0, Vector2.ZERO)
    
    var asteroids := GameState.current.asteroid_state
    
    for i : int in asteroids.size():
        var asteroid_state := asteroids[i]
        var asteroid_circle := CircleShape2D.new()
        asteroid_circle.radius = GameConfig.ASTEROID_COLLISION_RADIUS_BY_POWER * (asteroid_state.power + 1)
        var circle_transform := Transform2D(0, asteroid_state.position)
        var collides := asteroid_circle.collide(circle_transform, line_seg, line_transform)
        if collides:
            return i
    return -1
