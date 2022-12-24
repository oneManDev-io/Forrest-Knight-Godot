extends CharacterBody2D

@export var moveSpeed : float = 100;


func _physics_process(delta):
	
	var inputVector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = inputVector.normalized() * moveSpeed;
	
		
	move_and_slide()
	
	print(velocity)
