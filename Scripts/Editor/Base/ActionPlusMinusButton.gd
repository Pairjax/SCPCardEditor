extends Button

@onready var action: BaseAction = $"../../../../../Card Hologram/SubViewport/Card/Base/Action"
@onready var description = $"../../../../../Card Hologram/BaseHolos/Action/Description"

@export var add: bool

static var description_size: int = 1;

const MAX_DESCRIPTION_SIZE = 6

func _ready():
	if (add):
		self.pressed.connect(action.grow_description_box)
		self.pressed.connect(_on_grow)
	else:
		self.pressed.connect(action.shrink_description_box)
		self.pressed.connect(_on_shrink)

func _on_grow():
	description_size += 1;

	if description_size > MAX_DESCRIPTION_SIZE:
		description_size -= 1;
		return

	description.size.y += 60
	description.position.y -= 60

func _on_shrink():
	description_size -= 1;
	
	if description_size < 1:
		description_size = 1;
		return
	
	description.size.y -= 60
	description.position.y += 60
