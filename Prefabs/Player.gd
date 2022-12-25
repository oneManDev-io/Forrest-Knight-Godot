extends CharacterBody2D

@export var moveSpeed : float = 100;

@export var facingDirection : Vector2 = Vector2(0, 1)

@onready var animationTree = $AnimationTree
@onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	update_animation_parameters(facingDirection)

func _physics_process(delta):

	var inputVector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	update_animation_parameters(inputVector)

	velocity = inputVector.normalized() * moveSpeed;


	move_and_slide()
	
	pick_new_state()

func update_animation_parameters(moveInput : Vector2):
	if(moveInput != Vector2.ZERO):
		animationTree.set("parameters/Idle/blend_position", moveInput)
		animationTree.set("parameters/Run/blend_position", moveInput)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		stateMachine.travel("Run")
	else:
		stateMachine.travel("Idle")
