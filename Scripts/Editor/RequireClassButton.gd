extends CheckButton

@onready var card: Card = $"../../../../Card Hologram/SubViewport/Card"

func _ready():
	self.toggled.connect(card.set_require_class)
