extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true
signal laserFired(pos, direction)
signal grenade(pos, direction)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#Input
	var direction= Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
	#rotate player
	look_at(get_global_mouse_position())
	
	# Laser Input
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser:
		$GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_marker = laser_markers[randi() % laser_markers.size()]
		laserFired.emit(selected_marker.global_position, player_direction)
		can_laser = false
		$Timer.start()
		
	if Input.is_action_pressed("secondary action") and can_grenade:
		var pos = $LaserStartPositions.get_children()[0].global_position
		grenade.emit(pos, player_direction)
		can_grenade = false
		$GrenadeCooldown.start()


func _on_timer_timeout():
	can_laser = true


func _on_grenade_cooldown_timeout():
	can_grenade = true
