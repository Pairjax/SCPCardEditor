extends Button

@onready var hologram = $"../../../../Card Hologram"
@onready var card_of_hologram: Card = $"../../../../Card Hologram/SubViewport/Card"
@onready var grid_container = $"../../../../Card List/GridContainer"

const CARD_HOLOGRAM = preload("res://Scenes/card_hologram.tscn")

var card_queue: Array[Card]

func _ready():
	self.pressed.connect(self._button_pressed)

func _button_pressed():
	var new_card = CARD_HOLOGRAM.instantiate()
	var card: Card = new_card.get_node("SubViewport/Card")
	
	card.ready.connect(self.on_added_card_ready)
	card_queue.push_front(card)
	
	grid_container.add_child(new_card)

func on_added_card_ready():
	var ready_card = card_queue.pop_back()
	
	if !ready_card: return
	
	card_of_hologram.forward_base_data()
	ready_card.copy(card_of_hologram.cardData)
	ready_card.set_edit_mode(false)
