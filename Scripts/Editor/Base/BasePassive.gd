extends Node2D
class_name BasePassive

signal description_changed(new_description: String)
signal description_size_changed(offest: int)

@onready var card: Card = $"../.."
@onready var card_name = $"../../Card Name"
@onready var card_type: Label = $"../../Card Type"

@onready var description = $Description
@onready var description_text: RichTextLabel = $"Description/MarginContainer/Description Label"

@export var description_size: int = 1

const MAX_DESCRIPTION_SIZE = 6

const PASSIVE_DESCRIPTION = "Passive"

var data: PassiveDataComponent = PassiveDataComponent.new()

var copy_changes_base: BasePassive = null

func reset():
	description_size = 1
	data.description_size = 1
	
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

func copy(_data: PassiveDataComponent):
	var old_desc_size = data.description_size
	
	data = _data
	
	on_description_change(data.description)
	
	description_size = data.description_size
	var desc_size_change = data.description_size - old_desc_size
	
	description.size.y += 60 * desc_size_change
	description.position.y -= 60 * desc_size_change
	
	description_size_changed.emit(desc_size_change)

func copy_changes_to(other_base: BasePassive):
	copy_changes_base = other_base
