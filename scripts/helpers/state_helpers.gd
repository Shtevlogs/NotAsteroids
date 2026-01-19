class_name StateHelpers

# This assumes val is an array of _State, but we can't directly enforce that
static func serialize_array_of_state(val: Variant) -> Array:
    var to_return := []
    
    for item : _State in val:
        to_return.append(item.serialize())
    
    return to_return

# This assumes
# 1) data is an array of Dictionaries
# 2) val is an array of type
# 3) type inherits _State
# ... but we can't directly enforce those either
static func deserialize_array_of_state(data: Array, val: Variant, type: GDScript) -> Variant:
    val.clear()
    for item: Dictionary in data:
        var new_state : _State = type.new()
        val.append(new_state.deserialize(item))
    return val

static func serialize_v2(v2: Vector2) -> String:
    return "%s,%s" % [v2.x, v2.y]
    
static func deserialize_v2(data: String) -> Vector2:
    var parts := data.split(",")
    return Vector2(float(parts[0]),float(parts[1]))
