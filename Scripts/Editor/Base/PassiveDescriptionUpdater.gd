extends TextEdit

@onready var passive: BasePassive = $"../../../../../SubViewport/Card/Base/Passive"

func _ready():
	passive.description_changed.connect(self._description_changed)

func _on_text_changed():
	passive.on_description_change(text)
	
func _description_changed(new_description):
	if self.text == new_description:
		return
	
	self.text = new_description
