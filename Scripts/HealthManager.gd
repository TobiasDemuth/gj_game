extends Node2D

@export var target: CharacterBody2D
@export var enemyAI: Node2D
@export var health: float = 100
	
func _physics_process(_delta: float) -> void:
	if (health <= 0):
		target.free()
		
func takeDamage(damage: float, knockbackDirection: Vector2, knockbackForce: float) -> void:
	health -= damage
	if enemyAI != null:
		enemyAI.gotHit()
	target.velocity = knockbackDirection * knockbackForce
