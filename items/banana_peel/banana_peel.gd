extends Item

@export var slipMagnitude : float

func slip(body):
	if body is Player:
		body.velocity.y = - slipMagnitude
		discard()

# _on_body_entered() <=> OnTriggerEntered()
func _on_body_entered(body : Node2D):
	slip(body)
