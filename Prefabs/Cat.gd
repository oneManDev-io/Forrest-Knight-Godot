extends CharacterBody2D

@export var moveSpeed : float = 20;

@export var facingDirection : Vector2 = Vector2(0, 1)

@export var randomVector = Vector2(randi_range(-1,1), randi_range(-1,1))

@onready var animationTree = $AnimationTree
@onready var stateMachine = animationTree.get("parameters/playback");

func _ready():
	updateAnimation(facingDirection)

func _physics_process(delta):

	velocity = randomVector.normalized() * moveSpeed

	updateAnimation(randomVector)
	move_and_slide()
	pickNewState()

func updateAnimation(moveInput : Vector2):
	if(moveInput != Vector2.ZERO):
		animationTree.set("parameters/Idle/blend_position", moveInput)
		animationTree.set("parameters/Walk/blend_position", moveInput)

func pickNewState():
	if(velocity != Vector2.ZERO):
		stateMachine.travel("Walk")
	else:
		stateMachine.travel("Idle");

