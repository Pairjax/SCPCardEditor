extends TextEdit

@onready var action: BaseAction = $"../../../../../SubViewport/Card/Base/Action"

func _on_text_changed():
	action.on_description_change(text)
