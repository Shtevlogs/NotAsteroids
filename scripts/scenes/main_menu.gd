class_name MainMenu
extends Node2D

func _on_start_game_pressed() -> void:
    SceneManager.change_scene(SceneManager.GAME)
