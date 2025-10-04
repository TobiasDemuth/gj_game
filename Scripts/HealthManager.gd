extends Node2D

@export var target: CharacterBody2D
@export var health: float = 100

func takeDamage(damage: float) -> void:
	health -= damage
	
func _physics_process(_delta: float) -> void:
	if (health <= 0):
		target.free()
