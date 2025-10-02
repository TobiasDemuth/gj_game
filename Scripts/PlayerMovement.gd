extends CharacterBody2D

@export var speed = 5;

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO;
	direction.x = Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left")
	direction.y = Input.get_action_raw_strength("ui_down") - Input.get_action_raw_strength("ui_up")
	direction = direction.normalized()
	
	velocity = direction * speed
	move_and_slide()
