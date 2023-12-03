extends CharacterBody2D

var active: bool = false
var speed: int = 300
var vunerable: bool = true
var player_near: bool = false
var health: int = 20

func hit():
	if vunerable:
		vunerable = false
		$Timers/HitTimer.start()
		health -= 10
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		$particles/HitParticles.emitting = true
	if health <=0 :
		await get_tree().create_timer(0.5).timeout
		queue_free()

func _process(_delta):
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_position)

func _on_attack_area_body_entered(_body):
	player_near = true
	$AnimatedSprite2D.play("Attack")

func _on_attack_area_body_exited(_body):
	player_near = false
	$AnimatedSprite2D.stop()

func _on_notice_area_body_entered(_body):
	active = true
	$AnimatedSprite2D.play("Walk")

func _on_notice_area_body_exited(_body):
	active = false
	$AnimatedSprite2D.stop()


func _on_animated_sprite_2d_animation_finished():
	if player_near:
		Globals.health -= 15
		$Timers/AttackTimer.start()

func _on_attack_timer_timeout():
	$AnimatedSprite2D.play("Attack")


func _on_hit_timer_timeout():
	vunerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
