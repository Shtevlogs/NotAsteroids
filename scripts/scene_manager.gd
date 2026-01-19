class_name SceneManager
extends Node

const GAME : int = 0
const MAIN_MENU : int = 1

const GAME_SCENE : PackedScene = preload("uid://bp8dcchi6j6yk")
const MAIN_MENU_SCENE : PackedScene = preload("uid://b2bly7rf4hteo")

const SCENES = [GAME_SCENE, MAIN_MENU_SCENE]

static var _I: SceneManager

@onready var scene_container: Node2D = $"../SceneContainer"

func _ready() -> void:
    _I = self

static func change_scene(scene: int) -> void:
    if _I.scene_container.get_child_count() == 1:
        _I.scene_container.get_child(0).queue_free()
    
    var new_scene := SCENES[scene].instantiate() as Node
    _I.scene_container.add_child(new_scene)
