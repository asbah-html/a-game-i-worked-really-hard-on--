extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const DEATH := 1450.0
const GRAVITY := 900.0

@onready var Sprite: Node2D = $Sprite2D

var respawn: Vector2
func _ready() -> void:
	respawn = global_position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if global_position.y > DEATH:
		die()
		
	move_and_slide()
		
func die() -> void:
	global_position = respawn
	velocity = Vector2.ZERO


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		%Label.visible = true
