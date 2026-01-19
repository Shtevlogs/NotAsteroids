class_name BlastManager
extends Node

const BLAST : PackedScene = preload("uid://befd57d58ec50")

var active_blast : Blast = null

func _process(_delta: float) -> void:
    var active := GameState.current.blast_state.active
    if !Input.is_action_just_pressed("shoot") || GameState.current.blast_state.active:
        return
    
    var player_state := GameState.current.player_state
    var current_direction := Vector2.UP.rotated(player_state.rotation)
    
    var blast_state := GameState.current.blast_state
    blast_state.active = true
    blast_state.traveled_distance = 0.0
    blast_state.position = player_state.position
    blast_state.velocity = player_state.velocity + current_direction * GameConfig.BLAST_VELOCITY
    
    var new_blast := BLAST.instantiate() as Blast
    new_blast.state = blast_state
    new_blast.position = blast_state.position
    get_parent().add_child(new_blast)
