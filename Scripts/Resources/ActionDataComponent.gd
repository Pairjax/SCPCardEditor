extends Resource
class_name ActionDataComponent

@export var type: ActionType

@export var description: String
@export var description_size: int

@export var hasIconBar := true

@export var iconBarText: String

enum ActionType {
	Logistics,
	Tactical
}
