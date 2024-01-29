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
	preload("res://CardAssets/Icons/DiceIcon_SCP_D4.png"),
	preload("res://CardAssets/Icons/DiceIcon_SCP_D6.png"),
	preload("res://CardAssets/Icons/DiceIcon_SCP_D8.png"),
	preload("res://CardAssets/Icons/DiceIcon_SCP_D10.png"),
	preload("res://CardAssets/Icons/DiceIcon_SCP_D12.png"),
	preload("res://CardAssets/Icons/DiceIcon_SCP_D20.png"),
	preload("res://CardAssets/Icons/DAny.png"),
	
	preload("res://CardAssets/Icons/Slash.png"),
	preload("res://CardAssets/Icons/Plus.png"),
	preload("res://CardAssets/Icons/Minus.png"),
	preload("res://CardAssets/Icons/Times.png"),
	
	preload("res://CardAssets/Icons/Icon_HalfEfficiency.png"),
	preload("res://CardAssets/Icons/Icon_ThirdEfficiency.png"),
	
	preload("res://CardAssets/Icons/Invert.png"),
	preload("res://CardAssets/Icons/Nudge.png"),
	preload("res://CardAssets/Icons/RollResult.png"),
	preload("res://CardAssets/Icons/Icon_AdjustAdd.png"),
	preload("res://CardAssets/Icons/Icon_AdjustSubtract.png"),
	preload("res://CardAssets/Icons/Action_Advantage.png"),
	preload("res://CardAssets/Icons/Action_DisAdvantage.png"),
	preload("res://CardAssets/Icons/Allocate.png"),
]

const icon_scale = [
	120,
	100,
	120,
	110,
	110,
	100,
	100,
	
	80,
	90,
	100,
	100,
	
	100,
	100,
	
	100,
	100,
	100,
	100,
	100,
	100,
	100,
	150,
]

static func get_icon(icon: IconType):
	return icons[icon]

static func get_icon_scale(icon: IconType):
	return icon_scale[icon]
