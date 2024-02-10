extends Button

@onready var grid_container = $"../../../../Card List/GridContainer"

const EXPORT_DECK_DIALOG = preload("res://Scenes/ExportDeckDialog.tscn")

func _on_pressed():
	var new_deck: Deck = Deck.new()
	
	for card_holo in grid_container.get_children():
		var card: Card = card_holo.get_node("SubViewport/Card")
		new_deck.cards.append(card.cardData)
	
	var dialog = EXPORT_DECK_DIALOG.instantiate()
	dialog._load_deck_data(new_deck)
	add_child(dialog)
