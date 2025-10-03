extends CharacterBody2D

@export var movementSpeed: float = 400;
@export var movementDeceleration: float = 1000;

@export var rotationSpeed: float = 8;
var rotationDirection: Vector2 = Vector2.ZERO

@export var dashSpeed: float = 600;
@export var dashDeceleration: float = 1500;
@export var dashDuration: float = 0.8;
@export var dashCooldown: float = 2;
var dashDirection: Vector2 = Vector2.ZERO
var isDashing: bool = false
var canDash: bool = true
var dashTimer: float = 0
var dashCooldownTimer: float = 1.5

func _physics_process(delta: float) -> void:
	if dashCooldownTimer > dashCooldown:
		canDash = true
	else:
		dashCooldownTimer += delta
		
	if Input.is_action_pressed("move_dash") and canDash:
		dashCooldownTimer = 0
		canDash = false
		isDashing = true
	
	if !isDashing:
		var movementDirection: Vector2 = Vector2(
			Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left"),
			Input.get_action_raw_strength("move_down") - Input.get_action_raw_strength("move_up")
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
