extends Button

@onready var passive: BasePassive = $"../../../../../Card Hologram/SubViewport/Card/Base/Passive"
@onready var description = $"../../../../../Card Hologram/BaseHolos/Passive/Description"

@export var add: bool

func _ready():
	
	if (add):
		self.pressed.connect(passive.grow_description_box)
	else:
		self.pressed.connect(passive.shrink_description_box)
	
	passive.description_size_changed.connect(self._description_size_changed)
	
func _description_size_changed(offset):
	if add and offset < 0:
		return
	
	if not add and offset > 0:
		return
	
	description.size.y += offset * 60
	description.position.y -= offset * 60
