extends StaticBody2D

signal playerEnteredGate

func _on_area_2d_body_entered(_body):
	playerEnteredGate.emit()
