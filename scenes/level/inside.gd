extends LevelParent

var outside_level_scene: PackedScene = preload("res://scenes/level/outside.tscn")

func _on_exit_gate_area_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
#	get_tree().change_scene_to_file("res://scenes/level/outside.tscn")
	TransistionLayer.change_scene("res://scenes/level/outside.tscn")
