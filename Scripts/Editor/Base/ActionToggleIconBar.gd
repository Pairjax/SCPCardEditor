extends CheckButton

@onready var action: BaseAction = $"../../../../../Card Hologram/SubViewport/Card/Base/Action"

func _on_pressed():
	action.on_toggle_icon_bar(button_pressed)
