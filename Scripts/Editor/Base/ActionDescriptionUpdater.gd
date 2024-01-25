extends TextEdit

@onready var action: BaseAction = $"../../../../../SubViewport/Card/Base/Action"

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_text_edited():
	pass


func _on_text_changed():
	action.on_description_change(text)
