@abstract
class_name _State
extends RefCounted

@warning_ignore("unused_signal")
signal destroyed()

@abstract func serialize() -> Dictionary

@abstract func deserialize(data: Dictionary) -> _State
