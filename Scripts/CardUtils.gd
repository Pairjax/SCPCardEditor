extends Node
class_name CardUtils

enum IconType {
	D4,
	D6,
	D8,
	D10,
	D12,
	D20,
	DAny,
	
	Slash,
	Plus,
	Minus,
	Mult,
	
	EffHalf,
	EffThird,
	
	Invert,
	Nudge,
	RollResult,
	AdjustAdd,
	AdjustSub,
	Advantage,
	Disadvantage,
	Allocate,
	Escalating,
	Sequence,
	
	Refresh,
	Discard,
	
	Science,
	Supplies,
	Pill,
	Ordinance,
}

const icons = [
	preload("res://CardAssets/Icons/D4.png"),
	preload("res://CardAssets/Icons/D6.png"),
	preload("res://CardAssets/Icons/D8.png"),
	preload("res://CardAssets/Icons/D10.png"),
	preload("res://CardAssets/Icons/D12.png"),
	preload("res://CardAssets/Icons/D20.png"),
	preload("res://CardAssets/Icons/DAny.png"),
	
	preload("res://CardAssets/Icons/Slash.png"),
	preload("res://CardAssets/Icons/Plus.png"),
	preload("res://CardAssets/Icons/Minus.png"),
	preload("res://CardAssets/Icons/Times.png"),
	
	preload("res://CardAssets/Icons/HalfEfficiency.png"),
	preload("res://CardAssets/Icons/ThirdEfficiency.png"),
	
	preload("res://CardAssets/Icons/Invert.png"),
	preload("res://CardAssets/Icons/Nudge.png"),
	preload("res://CardAssets/Icons/RollResult.png"),
	preload("res://CardAssets/Icons/AdjustAdd.png"),
	preload("res://CardAssets/Icons/AdjustSubtract.png"),
	preload("res://CardAssets/Icons/Advantage.png"),
	preload("res://CardAssets/Icons/Disadvantage.png"),
	preload("res://CardAssets/Icons/Allocate.png"),
	preload("res://CardAssets/Icons/Escalating.png"),
	preload("res://CardAssets/Icons/Sequence.png"),
	
	preload("res://CardAssets/Icons/Refresh.png"),
	preload("res://CardAssets/Icons/Discard.png"),
	
	preload("res://CardAssets/Icons/Science.png"),
	preload("res://CardAssets/Icons/Supplies.png"),
	preload("res://CardAssets/Icons/Pill.png"),
	preload("res://CardAssets/Icons/Ordinance.png"),
]

const icon_scale = [
	100, # D4
	80, # D6
	120, # D8
	110, # D10
	110, # D12
	100, # D20
	100, # DAny
	
	80,  # Slash
	90,  # Plus
	100, # Minus
	100, # Times
	
	100, # HalfEff
	100, # ThirdEff
	
	100, # Invert
	100, # Nudge
	100, # RR
	100, # AdjustAdd
	100, # AdjustSub
	100, # Advantage
	100, # Disadvantage
	150, # Allocate
	100, # Escalating
	100, # Sequence
	
	100, # Refresh
	100, # Discard
	
	100, # Science
	100, # Supplies
	100, # Pill
	100, # Ordinance
]

static func get_icon(icon: IconType):
	return icons[icon]

static func get_icon_scale(icon: IconType):
	return icon_scale[icon]

static func get_icon_type_from_name(name: String):
	for icon_name in IconType.keys():
		if name.to_lower() == icon_name.to_lower():
			return IconType[icon_name]
	return null

static func parse_icons(raw_text: String):
	var parsed_text = ""
	
	var in_tag = false
	var tag = ""
	
	for ch in raw_text:
		if ch == '[':
			in_tag = true
		elif ch == ']':
			in_tag = false
			
			var icon_type = CardUtils.get_icon_type_from_name(tag)
			if icon_type == null:
				parsed_text += "[" + tag + "]"
			else:
				var icon: Resource = CardUtils.get_icon(icon_type)
				var icon_scale = CardUtils.get_icon_scale(icon_type) / 2
				
				parsed_text += "[img height=" + str(icon_scale) + "]" + icon.resource_path + "[/img]"
			tag = ""
		else:
			if in_tag:
				tag += ch
			else :
				parsed_text += ch
	if in_tag:
		parsed_text += "[" + tag
		
	return parsed_text
