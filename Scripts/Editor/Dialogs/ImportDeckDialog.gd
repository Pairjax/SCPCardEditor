extends FileDialog

@onready var grid_container = $"../../../../../Card List/GridContainer"

const CARD_HOLOGRAM = preload("res://Scenes/card_hologram.tscn")

var card_queue: Array[Card]
var card_data_queue: Array[CardDataComponent]

func _on_file_selected(path):
	var deck: Deck = ResourceLoader.load(path)
	
	for holo in grid_container.get_children():
		holo.queue_free()
	
	for card_data in deck.cards:
		var hologram = CARD_HOLOGRAM.instantiate()
		var card: Card = hologram.get_node("SubViewport/Card")
		
		card.ready.connect(self.on_added_card_ready)
		card_queue.push_front(card)
		card_data_queue.push_front(card_data)
		
		grid_container.add_child(hologram)

func on_added_card_ready():
	var ready_card = card_queue.pop_back()
	
	if !ready_card: return
	
	ready_card.copy(card_data_queue.pop_back())
	ready_card.set_edit_mode(false)
