extends Node2D

@export var enemy: CharacterBody2D

@export var enemySpeed: float = 150
@export var player: CharacterBody2D
@onready var navAgent: NavigationAgent2D = $NavigationAgent2D

func _physics_process(_delta: float) -> void:
	var movementDirection = to_local(navAgent.get_next_path_position()).normalized()
	enemy.velocity = movementDirection * enemySpeed
	enemy.move_and_slide()

func makePath() -> void:
	navAgent.target_position = player.global_position

func _on_timer_timeout() -> void:
	makePath()
