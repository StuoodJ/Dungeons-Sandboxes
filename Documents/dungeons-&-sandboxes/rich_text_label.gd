extends RichTextLabel


func _process(delta):
	var health = $"../..".playerhealth
	self.text = str(health) + '/100'
