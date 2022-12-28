extends CharacterBody2D

enum catState { Idle, Walk }

@export var moveSpeed: float = 20
@export var idleTime: float = 1
@export var walkTime: float = 1

#@export var facingDirection= Vector2.ZERO
#@export var randomVector: Vector2 = Vector2(randi_range(-1,1), randi_range(-1,1))

@onready var animationTree = $AnimationTree
@onready var stateMachine = animationTree.get("parameters/playback");
@onready var timer = $Timer

var randomVector: Vector2 = Vector2.ZERO
var currentState: catState = catState.Idle

func _ready():
	pickNewState()
	updateAnimation(randomVector)

func _physics_process(delta):
	if(currentState == catState.Walk):
		velocity = randomVector.normalized() * moveSpeed
		move_and_slide()

func selectNewDirection():
	randomVector = Vector2(
		randi_range(-1,1),
		randi_range(-1,1)
	)

func updateAnimation(moveInput : Vector2):
	if(currentState == catState.Walk):
		animationTree.set("parameters/Walk/blend_position", moveInput)
		animationTree.set("parameters/Idle/blend_position", moveInput)

func pickNewState():
	if(currentState == catState.Idle):
		stateMachine.travel("Walk")
		currentState = catState.Walk
		selectNewDirection()
		updateAnimation(randomVector)
		timer.start(walkTime)
	elif(currentState == catState.Walk):
		stateMachine.travel("Idle");
		currentState = catState.Idle
		timer.start(idleTime)
#		randomVector = Vector2.ZERO



func _on_timer_timeout():
	pickNewState()
