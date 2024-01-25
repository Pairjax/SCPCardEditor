extends LineEdit

@onready var card: Card = $"../SubViewport/Card"

func _ready():
	self.text_changed.connect(card.set_card_name)
