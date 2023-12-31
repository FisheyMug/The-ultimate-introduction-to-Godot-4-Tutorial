extends CanvasLayer

#colours
var green: Color = Color("6bbfa3")
var red: Color = Color(0.9, 0, 0, 1)

@onready var laser_label: Label = $AmmoCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer2/Label
@onready var laser_icon: TextureRect = $AmmoCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer2/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready():
	Globals.connect("stat_change", update_stat_text)
	update_grenade_text()
	update_laser_text()
	update_health_text()

func update_health_text():
	health_bar.value = Globals.health

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_colour(Globals.laser_amount, laser_label, laser_icon)
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_colour(Globals.grenade_amount, grenade_label, grenade_icon)

func update_stat_text():
	update_grenade_text()
	update_laser_text()
	update_health_text()
	
func update_colour(amount, label, icon):
	if amount<=0 :
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green
