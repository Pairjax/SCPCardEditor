extends GridContainer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var width = get_global_rect().size.x
	width /= int(round(columns))
	width = max(min(width, 100), 80)
	var height = int(round(width * 2.5))
	
	var minimum_size = Vector2(width, height)
	
	for card in get_children():
		card.custom_minimum_size = minimum_size
