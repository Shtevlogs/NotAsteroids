class_name PlayerState
extends _State

var position : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var rotation : float = 0.0

func serialize() -> Dictionary:
    return {
        "position": StateHelpers.serialize_v2(position),
        "velocity": StateHelpers.serialize_v2(velocity),
        "rotation": rotation
    }

func deserialize(data: Dictionary) -> _State:
    position = StateHelpers.deserialize_v2(data["position"])
    velocity = StateHelpers.deserialize_v2(data["velocity"])
    rotation = data["rotation"]
    return self
