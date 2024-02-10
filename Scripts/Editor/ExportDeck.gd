extends Button

@onready var grid_container = $"../../../../Card List/GridContainer"
@onready var line_edit = $"../../../Export Line Edit"

func _on_pressed():
	var new_deck: Deck = Deck.new()
	
	for card_holo in grid_container.get_children():
		var card: Card = card_holo.get_node("SubViewport/Card")
		new_deck.cards.append(card.cardData)
	
	ResourceSaver.save(new_deck, line_edit.text + "/ExampleDeck.tres")
