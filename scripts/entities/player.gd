class_name Player
extends Node2D

@onready var rotor: Node2D = $Rotor

var state : PlayerState

func _ready() -> void:
    state.destroyed.connect(_on_destroy)

func _process(delta: float) -> void:
    # Gather input
    var input_thrust := _get_input_thrust()
    var input_turn := _get_input_turn()
    
    # Update state
    state.rotation += input_turn * GameConfig.PLAYER_TURN_RATE
    var current_direction := Vector2.UP.rotated(state.rotation)
    state.velocity += current_direction * input_thrust * GameConfig.PLAYER_THRUST_ACCEL * delta
    state.velocity *= (1.0 - GameConfig.SPACE_FRICTION * delta)
    if state.velocity.length_squared() > GameConfig.PLAYER_MAX_V2:
        state.velocity = state.velocity.normalized() * GameConfig.PLAYER_MAX_V
    state.position = WrappedPositionManager.get_wrapped_position(state.position + state.velocity * delta)
    
    # Display state
    rotor.rotation = state.rotation
    var asteroid_collision := CollisionHelpers.intersects_asteroid(position, state.position)
    position = state.position
    if asteroid_collision != -1:
        EventHelpers.asteroid_player_collide(asteroid_collision)

func _on_destroy() -> void:
    var game := get_parent() as Game
    game.start_game_over()
    queue_free()

func _get_input_thrust() -> float:
    var input_thrust : float = 0.0
    if Input.is_action_pressed("up"):
        input_thrust += 1.0
    if Input.is_action_pressed("down"):
        input_thrust += 0.5
    return input_thrust

func _get_input_turn() -> float:
    var input_turn : float = 0.0
    if Input.is_action_pressed("left"):
        input_turn += -1.0
    if Input.is_action_pressed("right"):
        input_turn += 1.0
    return input_turn
    
