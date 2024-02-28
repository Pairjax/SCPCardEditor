extends CheckButton

@onready var action: BaseAction = $"../../../../../Card Hologram/SubViewport/Card/Base/Action"

func _ready():
	action.toggle_icon_bar_changed.connect(self._toggle_icon_bar_changed)

func _on_pressed():
	action.on_toggle_icon_bar(button_pressed)
	
func _toggle_icon_bar_changed(toggle: bool):
	self.button_pressed = toggle
