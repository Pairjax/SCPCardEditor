extends OptionButton


@onready var card: Card = $"../../../Card Hologram/SubViewport/Card"

@export var base_type: CardDataComponent.CardBase

func _ready():
	self.item_selected.connect(self._item_selected)

func _item_selected(new_index):
	if (new_index == -1): return
	
	card.on_base_change(CardDataComponent.CardBase.values()[new_index])
