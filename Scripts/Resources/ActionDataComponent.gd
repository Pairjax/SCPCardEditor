extends Resource
class_name ActionDataComponent

var type: ActionType

var description: String
var description_size: int

var hasIconBar := true

var iconBarText: String

enum ActionType {
	Logistics,
	Tactical
}
