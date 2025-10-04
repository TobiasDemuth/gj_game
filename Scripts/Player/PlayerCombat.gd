extends Node2D

@export var enemyHealth = Node2D;

@export var attackCastTime: float = 1
@export var attackCooldown: float = 1
@export var damage: float = 20
var attackTimer: float = 1
var isAttacking: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_pressed("hit") and isAttacking:
		hit()
		
func _physics_process(delta: float) -> void:
	if !isAttacking:
		attackTimer += delta
		if attackTimer >= attackCooldown:
			attackTimer = 0
			isAttacking = true
	
func hit() -> void:
	print_debug("hit")
	enemyHealth.takeDamage(damage)
	isAttacking = false;
