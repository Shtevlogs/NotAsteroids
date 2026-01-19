class_name GameState
extends _State

static var current: GameState

var game_time : float = 0.0
var player_state : PlayerState = PlayerState.new()
var blast_state : BlastState = BlastState.new()
var asteroid_state : Array[AsteroidState] = []

func serialize() -> Dictionary:
    return {
        "game_time": game_time,
        "player_state": player_state.serialize(),
        "blast_state": blast_state.serialize(),
        "asteroid_state": StateHelpers.serialize_array_of_state(asteroid_state)
    }

func deserialize(data: Dictionary) -> _State:
    game_time = data["game_time"]
    player_state = PlayerState.new().deserialize(data["player_state"])
    blast_state = BlastState.new().deserialize(data["blast_state"])
    asteroid_state = StateHelpers.deserialize_array_of_state(data["asteroid_state"], asteroid_state, AsteroidState)
    return self
