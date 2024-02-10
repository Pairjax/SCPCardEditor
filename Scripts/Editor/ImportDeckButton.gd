extends Button

@onready var grid_container = $"../../../../Card List/GridContainer"

const IMPORT_DECK_DIALOG = preload("res://Scenes/ImportDeckDialog.tscn")

func _on_pressed():
	var dialog = IMPORT_DECK_DIALOG.instantiate()
	add_child(dialog)
