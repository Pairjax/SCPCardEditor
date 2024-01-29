extends OptionButton

@onready var base_selector = $"../../Base Selector"
@onready var base_holos = $"../../../Card Hologram/BaseHolos"

@onready var card: Card = $"../../../Card Hologram/SubViewport/Card"

const SCENE_ACTION = preload("res://Scenes/SceneAction.tscn")
const ACTION_MENU = preload("res://Scenes/ActionMenu.tscn")

func _ready():
	self.item_selected.connect(self._item_selected)

func _item_selected(new_index):
	if (new_index == -1): return
	
	card.on_base_change(CardDataComponent.CardBase.values()[new_index])
	
	for menu in base_selector.get_children():
		menu.queue_free()
	
	for holo in base_holos.get_children():
		holo.queue_free()
	
	match new_index:
		CardDataComponent.CardBase.Action:
			var action_holo = SCENE_ACTION.instantiate()
			base_holos.add_child(action_holo)
			
			var action_menu = ACTION_MENU.instantiate()
			base_selector.add_child(action_menu)
		_:
			pass
