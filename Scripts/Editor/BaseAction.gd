extends Node2D
class_name BaseAction

@onready var card: Card = $"../.."
@onready var card_name = $"../../Card Name"
@onready var card_type: Label = $"../../Card Type"

@onready var description = $Description
@onready var icon_bar = $IconBar

@export var description_size: int = 1

const MAX_DESCRIPTION_SIZE = 6

const ACTION_TACTICAL_DESCRIPTION = "Tactical Action"
const ACTION_LOGISTICS_DESCRIPTION = "Logistics Action"

const ActionType = ActionDataComponent.ActionType

var data: ActionDataComponent = ActionDataComponent.new()

func grow_description_box():
	description_size += 1;
	
	if description_size > MAX_DESCRIPTION_SIZE:
		description_size -= 1
		return
	
	description.size.y += 60
	description.position.y -= 60

func shrink_description_box():
	description_size -= 1
	
	if description_size < 1:
		description_size += 1
		return
	
	description.size.y -= 60
	description.position.y += 60

func on_type_change(type: ActionType):
	data.type = type
	
	match type:
		ActionType.Logistics:
			card_type.set("theme_override_font_sizes/font_size", 60)
			card_type.text = ACTION_TACTICAL_DESCRIPTION
		ActionType.Tactical:
			card_type.set("theme_override_font_sizes/font_size", 60)
			card_type.text = ACTION_LOGISTICS_DESCRIPTION

func on_description_change(new_description):
	data.description = new_description

func on_toggle_icon_bar(toggle: bool):
	data.hasIconBar = toggle
	
	icon_bar.visible = data.hasIconBar
