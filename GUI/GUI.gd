extends CanvasLayer

func _process(delta):
	lifes()
	Pause()
	
func lifes():
	match Singleton.lifesPlayer:
		0:
			for child in get_children():				
				child.visible = false			
		1:
			for child in get_children():
				if(child.name == "life2" || child.name == "life3"):
					child.visible = false
		2:
			for child in get_children():
				if(child.name == "life3"):
					child.visible = false
		3:
			for child in get_children():				
					child.visible = true

func Pause():	
	if(get_tree().paused):
		$Control/Play.visible=true
		$Control/MainMenu.visible=true		
		$Control/TextureButton.disabled=true
		$Control/TextureButton.visible=false
	else:
		$Control/TextureButton.disabled=false
		$Control/TextureButton.visible=true
		$Control/Play.visible=false
		$Control/MainMenu.visible=false
		

func _on_TextureButton_pressed():
	get_tree().paused=!get_tree().paused


func _on_Play_pressed():
	get_tree().paused=false


func _on_MainMenu_pressed():
		get_tree().change_scene("res://Niveles/MainMenu.tscn")
		
	
