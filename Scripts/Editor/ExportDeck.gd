extends Button

@onready var grid_container = $"../../../../ScrollContainer/GridContainer"
@onready var line_edit: LineEdit = $"../../../Export Line Edit"

var path: String

func _ready():
	self.pressed.connect(self._button_pressed)

func _button_pressed():
	path = line_edit.text
	for card_hologram in grid_container.get_children():
		export_card(card_hologram)

func export_card(card_hologram):
	var viewport = card_hologram.get_node("SubViewport")
	var card: Card = card_hologram.get_node("SubViewport/Card")
	
	var img = viewport.get_viewport().get_texture().get_image()
	img.convert(Image.FORMAT_RGBA8)
	
	var save_full_path = path + "/" + card.cardData.card_title + ".png"
	img.save_png(save_full_path)
