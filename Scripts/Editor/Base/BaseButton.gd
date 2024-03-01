extends OptionButton

@onready var base_selector = $"../../Base Selector"
@onready var base_holos = $"../../../Card Hologram/BaseHolos"

@onready var card: Card = $"../../../Card Hologram/SubViewport/Card"

const SCENE_ACTION = preload("res://Scenes/SceneAction.tscn")
const ACTION_MENU = preload("res://Scenes/ActionMenu.tscn")

const SCENE_PASSIVE = preload("res://Scenes/ScenePassive.tscn")
const PASSIVE_MENU = preload("res://Scenes/PassiveMenu.tscn")

func _ready():
	self.item_selected.connect(self._item_selected)
	card.base_changed.connect(self._base_changed)
	

func update_menu(new_index):
	for menu in base_selector.get_children():
		menu.free()
	
	for holo in base_holos.get_children():
		holo.free()
	
	match new_index:
		CardDataComponent.CardBase.Action:
			var action_holo = SCENE_ACTION.instantiate()
			base_holos.add_child(action_holo)
			
			var action_menu = ACTION_MENU.instantiate()
			base_selector.add_child(action_menu)
		CardDataComponent.CardBase.Passive:
			var passive_holo = SCENE_PASSIVE.instantiate()
			base_holos.add_child(passive_holo)
			
			var passive_menu = PASSIVE_MENU.instantiate()
			base_selector.add_child(passive_menu)
		_:
			pass

func _item_selected(new_index):
	if (new_index == -1): return
	
	card.on_base_change(CardDataComponent.CardBase.values()[new_index])
	update_menu(new_index)

func _base_changed(new_base):
	var new_index = CardDataComponent.CardBase.values().find(new_base)
	if new_index == -1 or new_index == self.selected:
		return
		
	self.selected = new_index
	update_menu(new_index)
