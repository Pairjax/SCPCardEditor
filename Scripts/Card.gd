extends Node2D
class_name Card

@onready var base: Sprite2D = $Background/Base
@onready var card_type: Label = $"Card Type"
@onready var class_icon = $"Class Icon"
@onready var card_name: Label = $"Card Name"
@onready var cover: Sprite2D = $Background/Cover
@onready var base_slot = $Base

const ICON_D_CLASS = preload("res://CardAssets/Icons/Role_DClass.png")
const ICON_SECURITY = preload("res://CardAssets/Icons/Role_Security.png")
const ICON_MECHANIC = preload("res://CardAssets/Icons/Role_Mechanic.png")
const ICON_MEDIC = preload("res://CardAssets/Icons/Role_Medic.png")
const ICON_SCIENTIST = preload("res://CardAssets/Icons/Role_Scientist.png")
const ICON_O5 = preload("res://CardAssets/Icons/Role_O5.png")

const SUPPORT_BAR = preload("res://CardAssets/Covers/SupportBar.png")
const ITEM_COVER = preload("res://CardAssets/Covers/ItemCover.png")
const MODIFIER_COVER = preload("res://CardAssets/Covers/ModifierCover.png")
const PASSIVE_COVER = preload("res://CardAssets/Covers/PassiveCover.png")
const REQUIREMENT_NUMBER_COVER = preload("res://CardAssets/Covers/RequirementNumberCover.png")
const ACTION_LINING_TOP = preload("res://CardAssets/Covers/ActionLiningTop.png")

const COLOR_D_CLASS = Color("ffa45f")
const COLOR_SECURITY = Color("ff5d5f")
const COLOR_MECHANIC = Color("ffd45d")
const COLOR_MEDICAL = Color("7bef6e")
const COLOR_SCIENTIST = Color("6ebdef")
const COLOR_O5 = Color("ce6eef")

const BASIC_CARD: CardDataComponent = preload("res://Scripts/Resources/BasicCard.tres")
const CARD_ACTION = preload("res://Scenes/CardAction.tscn")

const CardBase = CardDataComponent.CardBase
const CardClass = CardDataComponent.CardClass

@export var cardData: CardDataComponent = BASIC_CARD.duplicate()

func on_base_change(new_base: CardBase):
	cardData.card_base = new_base
	
	card_type.text = ""
	
	for child in base_slot.get_children():
		child.queue_free()
	
	match new_base:
		CardBase.Action:
			cover.offset = Vector2(0, -326)
			cover.texture = ACTION_LINING_TOP
			
			var action_base = CARD_ACTION.instantiate()
			base_slot.add_child(action_base)
			action_base.reset()
		CardBase.Support:
			cover.offset = Vector2.ZERO
			cover.texture = null
			
			card_type.set("theme_override_font_sizes/font_size", 75)
			card_type.text = "Support"
		CardBase.Modifier:
			cover.offset = Vector2.ZERO
			cover.texture = MODIFIER_COVER
		CardBase.Item:
			cover.offset = Vector2.ZERO
			cover.texture = ITEM_COVER
			
			card_type.set("theme_override_font_sizes/font_size", 75)
			card_type.text = "Item"
		CardBase.Passive:
			cover.offset = Vector2.ZERO
			cover.texture = PASSIVE_COVER
			
			card_type.set("theme_override_font_sizes/font_size", 75)
			card_type.text = "Passive"
		CardBase.ReqNumber:
			cover.offset = Vector2(0, 37)
			cover.texture = REQUIREMENT_NUMBER_COVER
			card_type.text = ""
		CardBase.ReqContext:
			cover.offset = Vector2.ZERO
			cover.texture = MODIFIER_COVER
			
			card_type.set("theme_override_font_sizes/font_size", 75)
			card_type.text = "Requirement"

func on_class_change(new_class: CardClass):
	cardData.card_class = new_class
	
	match new_class:
		CardClass.DClass:
			base.modulate = COLOR_D_CLASS
			class_icon.texture = ICON_D_CLASS
		CardClass.MTF:
			base.modulate = COLOR_SECURITY
			class_icon.texture = ICON_SECURITY
		CardClass.Maintenance:
			base.modulate = COLOR_MECHANIC
			class_icon.texture = ICON_MECHANIC
		CardClass.Medical:
			base.modulate = COLOR_MEDICAL
			class_icon.texture = ICON_MEDIC
		CardClass.Research:
			base.modulate = COLOR_SCIENTIST
			class_icon.texture = ICON_SCIENTIST
		CardClass.O5:
			base.modulate = COLOR_O5
			class_icon.texture = ICON_O5

func set_card_name(new_name: String):
	cardData.card_title = new_name
	card_name.text = new_name

func set_require_class(require_class: bool):
	cardData.require_class = require_class
	class_icon.visible = require_class

func copy(card: Card):
	var card_data = card.cardData
	on_class_change(card_data.card_class)
	on_base_change(card_data.card_base)
	set_card_name(card_data.card_title)
	set_require_class(card_data.require_class)

func set_edit_mode(editing: bool):
	card_name.visible = !editing
