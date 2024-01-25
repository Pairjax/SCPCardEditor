extends Button

@onready var card = $"../../../TextureRect/SubViewport/Card"

@export var primary_color: Color
@export var secondary_color: Color
@export var neutral_color: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self._button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed():
	card.primary_color = primary_color
	card.secondary_color = secondary_color
	card.neutral_color = neutral_color
	
	card.update_palette()
