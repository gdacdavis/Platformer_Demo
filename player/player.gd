extends CharacterBody2D

class_name Player

# @export in Godot Engine is essentially [SerializeField] in Unity Engine
@export var SPEED : float = 250.0
@export var JUMP_VELOCITY : float = 400.0
const CAMERA_OFFSET : Vector2 = Vector2(320.0, 108.0)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = - JUMP_VELOCITY
	
	var direction = Vector2(Input.get_axis("MOVE_LEFT", "MOVE_RIGHT"), Input.get_axis("JUMP", "DUCK"))
	if direction:
		velocity.x = direction.x * SPEED
		# $AnimatedSprite is the same as GetComponent(<AnimatedSprite2D>)
		$AnimatedSprite2D.play("RUN")
		if direction == Vector2.LEFT:
			$AnimatedSprite2D.flip_h = true
		elif direction == Vector2.RIGHT:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("IDLE")
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)
	
	if Input.is_action_pressed("DUCK"):
		drop()
	
	if not is_on_floor():
		$AnimatedSprite2D.play("JUMP")
	
	update_camera_position(direction)
	
	move_and_slide()

func update_camera_position(direction : Vector2) -> void:
	$Camera2D.position = direction * CAMERA_OFFSET

func drop() -> void:
	position.y += 1
