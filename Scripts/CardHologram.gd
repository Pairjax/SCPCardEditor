extends TextureRect
class_name CardHologram 

@onready var card: Card = $"SubViewport/Card"

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var other_card: Card = get_node("../../../Card Hologram/SubViewport/Card")
		if other_card == null:
			return
		
		other_card.copy_changes_to(null)
		
		card.forward_base_data()
		other_card.copy(card.cardData)
		other_card.set_edit_mode(true)
		
		other_card.copy_changes_to(card)
