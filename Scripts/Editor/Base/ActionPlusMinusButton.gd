extends Button

@onready var action: BaseAction = $"../../../../../Card Hologram/SubViewport/Card/Base/Action"
@onready var description = $"../../../../../Card Hologram/BaseHolos/Action/Description"

@export var add: bool

func _ready():
	
	if (add):
		self.pressed.connect(action.grow_description_box)
	else:
		self.pressed.connect(action.shrink_description_box)
	
	action.description_size_changed.connect(self._description_size_changed)
	
func _description_size_changed(offset):
	if add and offset < 0:
		return
	
	if not add and offset > 0:
		return
	
	description.size.y += offset * 60
	description.position.y -= offset * 60
