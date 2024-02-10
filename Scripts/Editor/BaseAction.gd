extends Node2D
class_name BaseAction

@onready var card: Card = $"../.."
@onready var card_name = $"../../Card Name"
@onready var card_type: Label = $"../../Card Type"

@onready var description = $Description
@onready var description_text: RichTextLabel = $"Description/MarginContainer/Description Label"
@onready var icon_bar = $IconBar
@onready var icon_bar_text: RichTextLabel = $IconBar/MarginContainer/RichTextLabel

@export var description_size: int = 1

const MAX_DESCRIPTION_SIZE = 6

const ACTION_TACTICAL_DESCRIPTION = "Tactical Action"
const ACTION_LOGISTICS_DESCRIPTION = "Logistics Action"

const ActionType = ActionDataComponent.ActionType

var data: ActionDataComponent = ActionDataComponent.new()

func reset():
	description_size = 1
	reset_icon_bar()

func grow_description_box():
	description_size += 1;
	
	if description_size > MAX_DESCRIPTION_SIZE:
		description_size -= 1
		return
	
	data.description_size = description_size
	
	description.size.y += 60
	description.position.y -= 60

func shrink_description_box():
	description_size -= 1
	
	if description_size < 1:
		description_size += 1
		return
	
	data.description_size = description_size
	
	description.size.y -= 60
	description.position.y += 60

func on_type_change(type: ActionType):
	data.type = type
	
	match type:
		ActionType.Logistics:
			card_type.set("theme_override_font_sizes/font_size", 60)
			card_type.text = ACTION_LOGISTICS_DESCRIPTION
		ActionType.Tactical:
			card_type.set("theme_override_font_sizes/font_size", 60)
			card_type.text = ACTION_TACTICAL_DESCRIPTION

## Hides certain components that have holograms overlayed
## on top of them while in the editor.
func toggle_hologram(toggle: bool):
	description.visible = !toggle

func on_description_change(new_description):
	data.description = new_description
	description_text.text = data.description

func on_toggle_icon_bar(toggle: bool):
	data.hasIconBar = toggle
	
	icon_bar.visible = data.hasIconBar

func append_icon_bar(icon_type: CardUtils.IconType):
	var image: Resource = CardUtils.get_icon(icon_type)
	var image_scale = CardUtils.get_icon_scale(icon_type)
	
	icon_bar_text.append_text(" ")
	icon_bar_text.add_image(image, image_scale)
	
	var format_string = " [img height=100]%s[/img]"
	data.iconBarText += format_string % image.resource_path

func reset_icon_bar():
	icon_bar_text.clear()
	icon_bar_text.append_text("[center]")
	
	data.iconBarText = "[center]"

func copy(_data: ActionDataComponent):
	data = _data
	
	on_type_change(data.type)
	on_description_change(data.description)
	on_toggle_icon_bar(data.hasIconBar)
	
	description.size.y += 60 * (_data.description_size - 1)
	description.position.y -= 60 * (_data.description_size - 1)
	
	icon_bar_text.text = data.iconBarText
