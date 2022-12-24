extends CharacterBody2D

@export var moveSpeed : float = 100;

#var velocity = Vector2.ZERO

func _physics_process(delta):
	
	var inputVector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = inputVector.normalized() * moveSpeed;
	
#	var inputVector = Vector2.ZERO;
#
#	inputVector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
#	inputVector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
#
#	if inputVector != Vector2.ZERO:
#		velocity = inputVector
#	else:
#		velocity = Vector2.ZERO
		
	move_and_slide()
	
	print(velocity)
