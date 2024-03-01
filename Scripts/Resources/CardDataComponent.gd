extends Resource
class_name CardDataComponent

@export var card_title: StringName
@export var card_label: StringName
@export var card_description: String

@export var card_base: CardBase
@export var card_class: CardClass

@export var require_class: bool

@export var card_base_data: Resource

enum CardBase {
	Action,
	Support,
	Passive,
	Modifier,
	Item,
	ReqContext,
	ReqNumber,
}

enum CardClass {
	Neutral,
	MTF,
	Research,
	Maintenance,
	DClass,
	Medical,
	O5,
}
