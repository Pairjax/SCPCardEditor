extends MenuButton

@onready var action: BaseAction = $"../../../../../Card Hologram/SubViewport/Card/Base/Action"

func _ready():
	get_popup().id_pressed.connect(on_select_icon)
	
	for card_icon in CardUtils.IconType.values():
		var icon_name = CardUtils.IconType.keys()[card_icon]
		get_popup().add_item(icon_name)

func on_select_icon(id):
	if id < 0: return
	
	action.append_icon_bar(id)
