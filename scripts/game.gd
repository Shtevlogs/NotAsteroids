class_name Game
extends Node2D

const PLAYER : PackedScene = preload("uid://cvcvdumefti7m")

func _ready() -> void:
    GameState.current = GameState.new()
    var player := PLAYER.instantiate() as Player
    player.state = GameState.current.player_state
    add_child(player)

func _process(delta: float) -> void:
    GameState.current.game_time += delta

func start_game_over() -> void:
    await get_tree().create_timer(GameConfig.DEATH_TIME).timeout
    SceneManager.change_scene(SceneManager.MAIN_MENU)
