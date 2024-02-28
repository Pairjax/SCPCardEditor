extends OptionButton

@onready var card: Card = $"../../../../Card Hologram/SubViewport/Card"

@export var class_type: CardDataComponent.CardClass

func _ready():
	self.item_selected.connect(self._item_selected)
	card.class_changed.connect(self._class_changed)

func _item_selected(new_index):
	if (new_index == -1): return
	
	card.on_class_change(CardDataComponent.CardClass.values()[new_index])
	
func _class_changed(new_class):
	var new_index = CardDataComponent.CardClass.values().find(new_class)
	if new_index == -1:
		return
	
	self.selected = new_index 
