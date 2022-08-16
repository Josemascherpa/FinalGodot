extends Node2D


func _on_MainMenu_pressed():
	get_tree().change_scene("res://Niveles/MainMenu.tscn")


func _on_Restart_pressed():
	match Singleton.Level:
		1:get_tree().change_scene("res://Niveles/Level1.tscn")
			
			
		2:get_tree().change_scene("res://Niveles/Level2.tscn")
		3:get_tree().change_scene("res://Niveles/Level3.tscn")
	
