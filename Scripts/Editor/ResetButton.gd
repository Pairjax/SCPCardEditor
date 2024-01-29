extends Button

@onready var icon_bar: BaseAction = get_node("../../../../../Card Hologram/"
										+ "SubViewport/Card/Base/Action")

func _on_pressed():
	icon_bar.reset_icon_bar()
