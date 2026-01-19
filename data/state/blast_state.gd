class_name BlastState
extends _State

var active : bool = false
var position : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var traveled_distance : float = 0.0

func serialize() -> Dictionary:
    return {
        "active": active,
        "position": StateHelpers.serialize_v2(position),
        "velocity": StateHelpers.serialize_v2(velocity),
        "traveled_distance": traveled_distance
    }

func deserialize(data: Dictionary) -> _State:
    position = StateHelpers.deserialize_v2(data["position"])
    velocity = StateHelpers.deserialize_v2(data["velocity"])
    traveled_distance = data["traveled_distance"]
    return self
