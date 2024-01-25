extends Button

@onready var viewport = $"../../../../Card Hologram/SubViewport"

func _ready():
	self.pressed.connect(self._button_pressed)

func _button_pressed():
	var img = viewport.get_viewport().get_texture().get_image()
	img.convert(Image.FORMAT_RGBA8)
	img.save_png("Export/card.png")
