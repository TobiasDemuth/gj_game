extends Camera2D

@onready var target: CharacterBody2D = get_node("../CharacterBody2D")
@export var chaseSpeed: float = 5
@export var camToPlayerOffset: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if target:
		var targetPos: Vector2 = target.position + camToPlayerOffset
		position = position.lerp(targetPos, chaseSpeed * delta)
