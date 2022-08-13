extends Control

export (PackedScene) var lvl2
export (PackedScene) var lvl1
export (PackedScene) var lvl3
export (PackedScene) var tutorial
export (PackedScene) var instruc


func _on_Play_pressed():
	match Singleton.Level:
		1:
			get_node("/root/MainMenu").queue_free()
			get_node("/root").add_child(lvl1.instance())
		2:
			get_node("/root/MainMenu").queue_free()
			get_node("/root").add_child(lvl2.instance())
		


func _on_Tutorial_pressed():
	get_node("/root/MainMenu").queue_free()
	get_node("/root").add_child(tutorial.instance())


func _on_Instrucc_pressed():
	get_node("/root/MainMenu").queue_free()
	get_node("/root").add_child(instruc.instance())


func _on_Exit_pressed():##CORROBORAR QUE FUNCIONE
	get_tree().quit()
