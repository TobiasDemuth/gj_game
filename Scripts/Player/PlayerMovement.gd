extends CharacterBody2D

@export var movementSpeed: float = 250;
@export var movementDeceleration: float = 1000;

@export var rotationSpeed: float = 8;
var rotationDirection: Vector2 = Vector2.ZERO

@export var dashSpeed: float = 350;
@export var dashDeceleration: float = 1500;
@export var dashDuration: float = 0.8;
var dashDirection: Vector2 = Vector2.ZERO
var isDashing: bool = false
var dashTimer: float = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_dash") and !isDashing:
		rotationDirection = (get_global_mouse_position() - position).normalized()
		rotation = rotationDirection.angle()
		isDashing = true
	
	if !isDashing:
		var movementDirection: Vector2 = Vector2(
			Input.get_axis("move_left", "move_right"),
			Input.get_axis("move_up", "move_down")
		).normalized()
		
		rotationDirection = (get_global_mouse_position() - position).normalized()
		
		if movementDirection.length() > 0:
			velocity = movementDirection * movementSpeed
		else:
			velocity = velocity.move_toward(Vector2.ZERO, movementDeceleration * delta)
		
		if rotationDirection.length() > 0:
			rotation = lerp_angle(rotation, rotationDirection.angle(), rotationSpeed * delta)
	else:
		dashTimer += delta
		if dashTimer < dashDuration:
			var diff = dashDuration - dashTimer
			if diff > dashDuration / 2:
				velocity = rotationDirection * dashSpeed
			else:
				velocity = velocity.move_toward(Vector2.ZERO, dashDeceleration * delta)
		else:
			dashTimer = 0
			isDashing = false
	
	move_and_slide()
