class_name AsteroidSpawnManager
extends Node

const ASTEROID : PackedScene = preload("uid://dbxtdwcguixrg")

static var _I : AsteroidSpawnManager

@onready var asteroid_container: Node2D = $".."

func _ready() -> void:
    _I = self

func _process(_delta: float) -> void:
    var asteroid_count := _get_num_asteroids()
    while asteroid_count > GameState.current.asteroid_state.size():
        #could do pooling here
        var cam_rect := WrappedPositionManager.get_camera_rect()
        cam_rect.size /= 2.0
        var rand_x := randf()
        var rand_y := randf()
        var target_position := cam_rect.position + Vector2(cam_rect.size.x * rand_x, cam_rect.size.y * rand_y)
        var starting_postion := Vector2(GameConfig.ASTEROID_DISTANCE, 0.0).rotated(randf_range(0, PI * 2.0))
        var asteroid_speed := randf_range(GameConfig.ASTEROID_MIN_VELOCITY, GameConfig.ASTEROID_MAX_VELOCITY)
        var asteroid_velocity := (target_position - starting_postion).normalized() * asteroid_speed
        create_random_asteroid(starting_postion, asteroid_velocity)
    
func _get_num_asteroids() -> int:
    var gt := GameState.current.game_time * GameConfig.TIME_SLOW_FACTOR
    if gt == 0:
        gt = max(1.0, gt)
    return int(clampf((1.0 - (1.0 / gt)) * 10.0, 1, 10))

func create_random_asteroid(pos: Vector2, v: Vector2, power_limit: int = 2) -> void:
    var new_asteroid_state := AsteroidState.new()
    new_asteroid_state.rotation = randf_range(0,PI*2.0)
    new_asteroid_state.velocity = v
    new_asteroid_state.position = pos
    new_asteroid_state.power = randi_range(0,power_limit)
    
    GameState.current.asteroid_state.append(new_asteroid_state)
    var new_asteroid := ASTEROID.instantiate() as Asteroid
    new_asteroid.state = new_asteroid_state
    new_asteroid.position = pos
    asteroid_container.add_child(new_asteroid)

static func destroy_asteroid(idx: int) -> void:
    var asteroid_state := GameState.current.asteroid_state[idx]
    GameState.current.asteroid_state.remove_at(idx)
    asteroid_state.destroyed.emit()
    
    if asteroid_state.power == 0:
        return
    
    var s1 := randf_range(GameConfig.ASTEROID_MIN_VELOCITY, GameConfig.ASTEROID_MAX_VELOCITY)
    var v1 := Vector2(s1, 0).rotated(randf_range(0, PI * 2.0))
    var s2 := randf_range(GameConfig.ASTEROID_MIN_VELOCITY, GameConfig.ASTEROID_MAX_VELOCITY)
    var v2 := Vector2(s2, 0).rotated(randf_range(0, PI * 2.0))
    
    if asteroid_state.power == 1:
        # create 2 power 0 guys
        _I.create_random_asteroid(asteroid_state.position, v1, 0)
        _I.create_random_asteroid(asteroid_state.position, v2, 0)
    else:
        # create 2 power 1 or 0 guys
        _I.create_random_asteroid(asteroid_state.position, v1, 1)
        _I.create_random_asteroid(asteroid_state.position, v2, 1)
