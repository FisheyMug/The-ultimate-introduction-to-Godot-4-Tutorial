extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true
signal laserFired(pos, direction)
signal grenade(pos, direction)

@export var max_speed: int = 500
var speed: int = max_speed

func hit():
	Globals.health -=10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#Input
	var direction= Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_position = global_position
	
	#rotate player
	look_at(get_global_mouse_position())
	
	# Laser Input
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_marker = laser_markers[randi() % laser_markers.size()]
		laserFired.emit(selected_marker.global_position, player_direction)
		can_laser = false
		$Timer.start()
		
		#print(Globals.laser_amount)
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		#print(Globals.grenade_amount)
		var pos = $LaserStartPositions.get_children()[0].global_position
		grenade.emit(pos, player_direction)
		can_grenade = false
		$GrenadeCooldown.start()


func _on_timer_timeout():
	can_laser = true


func _on_grenade_cooldown_timeout():
	can_grenade = true
