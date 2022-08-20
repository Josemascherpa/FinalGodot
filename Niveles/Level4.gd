extends Node2D


func _on_Button_pressed():
	Singleton.Level=1
	get_tree().change_scene("res://Niveles/MainMenu.tscn")
