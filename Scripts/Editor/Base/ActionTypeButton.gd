extends OptionButton

@onready var action: BaseAction = $"../../../../../Card Hologram/SubViewport/Card/Base/Action"

func _ready():
	self.item_selected.connect(self._item_selected)

func _item_selected(new_index):
	if (new_index == -1): return
	
	action.on_type_change(ActionDataComponent.ActionType.values()[new_index])
