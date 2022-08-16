extends Control

export (PackedScene) var lvl2
export (PackedScene) var lvl1
export (PackedScene) var lvl3
export (PackedScene) var tutorial
export (PackedScene) var instruc

func _ready():
	get_tree().paused=false##Saco la pausa para cuando vuelvo
	
func _on_Play_pressed():
	match Singleton.Level:
		1:			
			get_tree().change_scene("res://Niveles/Level1.tscn")
		2:
			get_tree().change_scene("res://Niveles/Level2.tscn")
			
		
func _on_Tutorial_pressed():
	get_tree().change_scene("res://Niveles/Tutorial.tscn")


func _on_Instrucc_pressed():
	get_tree().change_scene("res://Niveles/Instructions.tscn")
	

func _on_Exit_pressed():##CORROBORAR QUE FUNCIONE
	get_tree().quit()
