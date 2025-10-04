extends Node2D

@export var enemy: CharacterBody2D

@export var enemySpeed: float = 150
@export var player: CharacterBody2D
@onready var navAgent: NavigationAgent2D = $NavigationAgent2D

var isKnocked: bool = false
var knockDuration: float = 1
var knockedTimer: float = 0

func _physics_process(delta: float) -> void:
	if (!isKnocked):
		var movementDirection = to_local(navAgent.get_next_path_position()).normalized()
		enemy.velocity = movementDirection * enemySpeed
	else:
		knockedTimer += delta
		if (knockedTimer >= knockDuration):
			knockedTimer = 0
			isKnocked = false
	enemy.move_and_slide()

func makePath() -> void:
	navAgent.target_position = player.global_position
	
func gotHit() -> void:
	isKnocked = true;

func _on_timer_timeout() -> void:
	makePath()
