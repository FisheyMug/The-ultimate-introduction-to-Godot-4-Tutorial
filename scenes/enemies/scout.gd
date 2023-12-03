extends CharacterBody2D

signal laser(pos, direction)

var player_nearby: bool = false
var can_laser: bool = true
var right_gun_used: bool = true
var health: int = 30
var can_damage: bool = true

func hit():
	if can_damage == true:
		health -= 10
		can_damage = false
		$DamageDelay.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$AudioStreamPlayer2D.play()
		if health <=0:
			$Explosion.play()
			await $Explosion.finished
			queue_free()

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var marker_node = $LaserSpawnPositions.get_child(right_gun_used)
			right_gun_used = not right_gun_used
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$LaserCooldown.start()

func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_cooldown_timeout():
	can_laser = true

func _on_damage_delay_timeout():
	can_damage = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
