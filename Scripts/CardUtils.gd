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
]

const icon_scale = [
	120, # D4
	100, # D6
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
]

static func get_icon(icon: IconType):
	return icons[icon]

static func get_icon_scale(icon: IconType):
	return icon_scale[icon]
