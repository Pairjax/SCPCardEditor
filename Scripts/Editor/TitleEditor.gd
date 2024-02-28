extends LineEdit

@onready var card: Card = $"../SubViewport/Card"

func _ready():
	self.text_changed.connect(card.set_card_name)
	card.name_changed.connect(self._name_changed)
	
func _name_changed(new_name):
	if self.text == new_name:
		return
		
	self.text = new_name
