extends Node2D
class_name Card

signal base_changed(new_base: CardBase)
signal class_changed(new_class: CardClass)
signal name_changed(new_name: String)
signal require_class_changed(require_class: bool)

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

const COLOR_NEUTRAL = Color("a0a0a0")
const COLOR_D_CLASS = Color("ffa45f")
const COLOR_SECURITY = Color("ff5d5f")
const COLOR_MECHANIC = Color("ffd45d")
const COLOR_MEDICAL = Color("7bef6e")
const COLOR_SCIENTIST = Color("6ebdef")
const COLOR_O5 = Color("ce6eef")

const BASIC_CARD: CardDataComponent = preload("res://Scripts/Resources/BasicCard.tres")
const CARD_ACTION = preload("res://Scenes/CardAction.tscn")
const CARD_PASSIVE = preload("res://Scenes/CardPassive.tscn")

const CardBase = CardDataComponent.CardBase
const CardClass = CardDataComponent.CardClass

@export var cardData: CardDataComponent = BASIC_CARD.duplicate()

var current_base

var copy_changes_card: Card = null

func on_base_change(new_base: CardBase):
	if cardData.card_base == new_base:
		return
	
	cardData.card_base = new_base
	
	card_type.text = ""
	
	current_base = null
	
	for child in base_slot.get_children():
		child.queue_free()
	
	match new_base:
		CardBase.Action:
			cover.offset = Vector2(0, -326)
			cover.texture = ACTION_LINING_TOP
			
			current_base = CARD_ACTION.instantiate()
			base_slot.add_child(current_base)
			
			current_base.reset()
			current_base.on_type_change(ActionDataComponent.ActionType.Logistics)
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
			
			current_base = CARD_PASSIVE.instantiate()
			base_slot.add_child(current_base)
			
			current_base.reset()
		CardBase.ReqNumber:
			cover.offset = Vector2(0, 37)
			cover.texture = REQUIREMENT_NUMBER_COVER
			card_type.text = ""
		CardBase.ReqContext:
			cover.offset = Vector2.ZERO
			cover.texture = MODIFIER_COVER
			
			card_type.set("theme_override_font_sizes/font_size", 75)
			card_type.text = "Requirement"
	
	if copy_changes_card != null:
		copy_changes_card.on_base_change(new_base)
		
		if current_base != null:
			if current_base.has_method("copy_changes_to"):
				current_base.copy_changes_to(copy_changes_card.current_base)
			
			if current_base.has_method("toggle_hologram"):
				copy_changes_card.current_base.toggle_hologram(false)
			
	base_changed.emit(new_base)

func on_class_change(new_class: CardClass):
	cardData.card_class = new_class
	
	match new_class:
		CardClass.Neutral:
			base.modulate = COLOR_NEUTRAL
			class_icon.texture = null
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
	
	if copy_changes_card != null:
		copy_changes_card.on_class_change(new_class)
		
	class_changed.emit(new_class)

func set_card_name(new_name: String):
	cardData.card_title = new_name
	card_name.text = new_name
	
	if copy_changes_card != null:
		copy_changes_card.set_card_name(new_name)
		
	name_changed.emit(new_name)

func set_require_class(require_class: bool):
	cardData.require_class = require_class
	class_icon.visible = require_class
	
	if copy_changes_card != null:
		copy_changes_card.set_require_class(require_class)
		
	require_class_changed.emit(require_class)

func forward_base_data():
	if current_base == null:
		return
	
	cardData.card_base_data = current_base.data

func copy(_card_data: CardDataComponent):
	var old_base = cardData.card_base	
	cardData = _card_data.duplicate(true)
	
	var new_base = cardData.card_base
	cardData.card_base = old_base
	
	on_class_change(cardData.card_class)
	on_base_change(new_base)
	set_card_name(cardData.card_title)
	set_require_class(cardData.require_class)
	
	if current_base == null:
		return
	
	# Expects a valid card base node & card base resource
	if current_base.has_method("copy"):
		current_base.copy(cardData.card_base_data)
	
	if current_base.has_method("toggle_hologram"):
		current_base.toggle_hologram(false) # Disables all holograms

func set_edit_mode(editing: bool):
	card_name.visible = !editing
	
func copy_changes_to(other_card: Card):
	copy_changes_card = other_card
	
	if current_base == null:
		return
	
	if current_base.has_method("copy_changes_to"):
		if other_card == null:
			current_base.copy_changes_to(null)
		else:
			current_base.copy_changes_to(other_card.current_base)
	
	if current_base.has_method("toggle_hologram"):
		current_base.toggle_hologram(true) # Re-enables all holograms
