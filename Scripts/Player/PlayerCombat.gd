extends Node2D

@export var player: CharacterBody2D
@export var enemyHealth: Node2D
@export var normalAttackHitbox: Area2D

@export var attackCastTime: float = 1
@export var attackCooldown: float = 1
@export var damage: float = 20
@export var knockbackForce: float = 100
var attackTimer: float = 1
var isAttacking: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_pressed("hit") and !isAttacking:
		isAttacking = true;
		var radians = deg_to_rad(player.rotation)
		var knockbackDirection = Vector2(cos(radians), sin(radians))
		attack(knockbackDirection)
		
func _physics_process(delta: float) -> void:
	if isAttacking:
		attackTimer += delta
		if attackTimer >= attackCooldown:
			attackTimer = 0
			isAttacking = false
	
func attack(knockbackDirection: Vector2) -> void:
	var bodies = normalAttackHitbox.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			print(body)
			enemyHealth.takeDamage(damage, knockbackDirection, knockbackForce)
