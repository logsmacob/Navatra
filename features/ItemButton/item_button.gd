extends Button

func set_title(title: String):
	$VBoxContainer/Header/Type.text = title

func set_discription(discription: String):
	$VBoxContainer/Discription.text = discription

func set_price(price: int):
	$VBoxContainer/Price.text = "$%d" % price
