extends OptionButton

@onready var card: Card = $"../../../../Card Hologram/SubViewport/Card"

@export var class_type: CardDataComponent.CardClass

func _ready():
	self.item_selected.connect(self._item_selected)

func _item_selected(new_index):
	if (new_index == -1): return
	
	card.on_class_change(CardDataComponent.CardClass.values()[new_index])
