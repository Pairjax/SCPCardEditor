extends TextEdit

@onready var action: BaseAction = $"../../../../../SubViewport/Card/Base/Action"

func _ready():
	action.description_changed.connect(self._description_changed)

func _on_text_changed():
	action.on_description_change(text)
	
func _description_changed(new_description):
	if self.text == new_description:
		return
		
	self.text = new_description
