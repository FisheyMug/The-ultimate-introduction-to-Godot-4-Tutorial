extends Node

signal  stat_change

var player_hit_sound: AudioStreamPlayer2D 

var laser_amount = 20 :
	set(value):
		laser_amount = value
		stat_change.emit()
		
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()


var damage_delay: bool = true
var health = 80 :
	get: 
		return health
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if damage_delay == true:
				health = value
				damage_delay = false
				player_damage_delay()
				player_hit_sound.play()
		stat_change.emit()

func player_damage_delay():
	await get_tree().create_timer(0.5).timeout
	damage_delay = true

var player_position: Vector2

func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)
