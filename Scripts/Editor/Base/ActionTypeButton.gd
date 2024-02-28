extends OptionButton

@onready var action: BaseAction = $"../../../../../Card Hologram/SubViewport/Card/Base/Action"

func _ready():
	self.item_selected.connect(self._item_selected)
	action.type_changed.connect(self._type_changed)

func _item_selected(new_index):
	if (new_index == -1): return
	
	action.on_type_change(ActionDataComponent.ActionType.values()[new_index])

func _type_changed(type):
	var new_index = ActionDataComponent.ActionType.values().find(type)
	if new_index == -1:
		return
		
	self.selected = new_index
