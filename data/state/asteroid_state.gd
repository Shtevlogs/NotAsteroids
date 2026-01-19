class_name AsteroidState
extends _State

var position : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var rotation : float = 0.0
var is_approaching : bool = true
var power : int = 1

func serialize() -> Dictionary:
    return {
        "position": StateHelpers.serialize_v2(position),
        "velocity": StateHelpers.serialize_v2(velocity),
        "rotation": rotation,
        "is_approaching": is_approaching,
        "power": power
    }

func deserialize(data: Dictionary) -> _State:
    position = StateHelpers.deserialize_v2(data["position"])
    velocity = StateHelpers.deserialize_v2(data["velocity"])
    rotation = data["rotation"]
    is_approaching = data["is_approaching"]
    power = data["power"]
    return self
