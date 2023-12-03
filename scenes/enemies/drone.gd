extends CharacterBody2D

var active: bool = false
var max_speed: int = 600
var speed: int = 150
var vulnerable: bool = true
var health: int = 20
var explosion_active: bool = false

func _ready():
	$explosion.hide()

func _process(delta):
	if active:
		look_at(Globals.player_position)
		var direction = (Globals.player_position - position).normalized()
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
			explosion_active = true
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range= target.global_position.distance_to(global_position) < 400 
			if in_range and "hit" in target:
				target.hit()

func hit():
	if vulnerable:
		vulnerable = false
		health -= 10
		$droneImage.material.set_shader_parameter("progress", 1)
		$HitTimer.start()
	if health <=0:
		active = false
		$AnimationPlayer.play("explosion")
		explosion_active = true


func _on_notice_area_body_entered(_body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)


func _on_hit_timer_timeout():
	vulnerable =true
	$droneImage.material.set_shader_parameter("progress", 0)
