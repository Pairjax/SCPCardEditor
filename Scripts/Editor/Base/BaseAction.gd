extends Node2D
class_name BaseAction

signal type_changed(type: ActionType)
signal description_changed(new_description: String)
signal toggle_icon_bar_changed(toggle: bool)
signal description_size_changed(offest: int)

@onready var card: Card = $"../.."
@onready var card_name = $"../../Card Name"
@onready var card_type: Label = $"../../Card Type"

@onready var description = $Description
@onready var description_text: RichTextLabel = $"Description/MarginContainer/Description Label"
@onready var icon_bar = $IconBar
@onready var icon_bar_text: RichTextLabel = $IconBar/MarginContainer/RichTextLabel

@export var description_size: int = 1

const MAX_DESCRIPTION_SIZE = 6

const action_footers = [
	"Tactical Action",
	"Logistics Action",
	"T/L Action",
	"Fey Item",
	"Foundation Item",
	"SCP Item",
	"Fifthist Item",
	"Daevite Item",
	"Mekhanite Item"
	]

const ActionType = ActionDataComponent.ActionType

var data: ActionDataComponent = ActionDataComponent.new()

var copy_changes_base: BaseAction = null

func reset():
	description_size = 1
	data.description_size = 1
	reset_icon_bar()
	
	if copy_changes_base != null:
		copy_changes_base.reset()

func grow_description_box():
	description_size += 1;
	
	if description_size > MAX_DESCRIPTION_SIZE:
		description_size -= 1
		return
	
	data.description_size = description_size
	
	description.size.y += 60
	description.position.y -= 60

	if copy_changes_base != null:
		copy_changes_base.grow_description_box()
		
	description_size_changed.emit(1)

func shrink_description_box():
	description_size -= 1
	
	if description_size < 1:
		description_size += 1
		return
	
	data.description_size = description_size
	
	description.size.y -= 60
	description.position.y += 60
	
	if copy_changes_base != null:
		copy_changes_base.shrink_description_box()
		
	description_size_changed.emit(-1)

func on_type_change(type: ActionType):
	data.type = type
	
	card_type.set("theme_override_font_sizes/font_size", 60)
	
	card_type.text = action_footers[type]
	
	if copy_changes_base != null:
		copy_changes_base.on_type_change(type)
		
	type_changed.emit(type)

## Hides certain components that have holograms overlayed
## on top of them while in the editor.
func toggle_hologram(toggle: bool):
	description.visible = !toggle

func on_description_change(new_description):
	data.description = new_description
	description_text.text = CardUtils.parse_icons(new_description)
	
	if copy_changes_base != null:
		copy_changes_base.on_description_change(new_description)
		
	description_changed.emit(new_description)

func on_toggle_icon_bar(toggle: bool):
	data.hasIconBar = toggle
	
	icon_bar.visible = data.hasIconBar
	
	if copy_changes_base != null:
		copy_changes_base.on_toggle_icon_bar(toggle)
		
	toggle_icon_bar_changed.emit(toggle)

func append_icon_bar(icon_type: CardUtils.IconType):
	var image: Resource = CardUtils.get_icon(icon_type)
	var image_scale = CardUtils.get_icon_scale(icon_type)

	data.iconBarText += " [img width=" + str(image_scale) + "]"\
						 + image.resource_path + "[/img]"
	
	icon_bar_text.text = data.iconBarText
	
	if copy_changes_base != null:
		copy_changes_base.append_icon_bar(icon_type)

func reset_icon_bar():
	icon_bar_text.clear()
	icon_bar_text.append_text("[center]")
	
	data.iconBarText = "[center]"
	
	if copy_changes_base != null:
		copy_changes_base.reset_icon_bar()

func copy(_data: ActionDataComponent):
	var old_desc_size = data.description_size
	
	data = _data
	
	on_type_change(data.type)
	on_description_change(data.description)
	on_toggle_icon_bar(data.hasIconBar)
	
	description_size = data.description_size
	var desc_size_change = data.description_size - old_desc_size
	
	description.size.y += 60 * desc_size_change
	description.position.y -= 60 * desc_size_change
	
	description_size_changed.emit(desc_size_change)
	
	icon_bar_text.text = data.iconBarText
	
func copy_changes_to(other_base: BaseAction):
	copy_changes_base = other_base
