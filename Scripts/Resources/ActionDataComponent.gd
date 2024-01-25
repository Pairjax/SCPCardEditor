extends Resource
class_name ActionDataComponent

var type: ActionType

var description: String

var hasIconBar := false

var iconBarText: String

enum ActionType {
	Logistics,
	Tactical
}
