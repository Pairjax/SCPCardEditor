extends FileDialog

var deck: Deck

func _load_deck_data(_deck: Deck):
	deck = _deck

func _on_file_selected(path):
	var error = ResourceSaver.save(deck, path, ResourceSaver.FLAG_CHANGE_PATH)
	
	if error:
		printerr(error)
