extends CheckButton

@onready var card: Card = $"../../../../Card Hologram/SubViewport/Card"

func _ready():
	self.toggled.connect(card.set_require_class)
	card.require_class_changed.connect(self._require_class_changed)
	
func _require_class_changed(require_class: bool):
	self.button_pressed = require_class
