extends RigidBody2D

const speed = 750

func explosion():
	$AnimationPlayer.play("Explosion")
