extends Control

func _ready():
	get_tree().paused=false##Saco la pausa para cuando vuelvo de ella
	
func _process(delta):
	if(Singleton.VolumeMusic):#Manejo el muteo y desmuteo del volumen segun el bus
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		$SoundMusic/Label.text="ON"		
	else:		
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)		
		$SoundMusic/Label.text="OFF"
		
	if(Singleton.VolumeSfx):	
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), false)
		$SoundSFX/Label.text="ON"		
	else:		
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), true)		
		$SoundSFX/Label.text="OFF"
		
	
func _on_Play_pressed():#Depende en el nivel que quede, va a volver a esa escena cuando apriete play
	match Singleton.Level:
		1:			
			get_tree().change_scene("res://Niveles/Level1.tscn")
		2:
			get_tree().change_scene("res://Niveles/Level2.tscn")
		3:
			get_tree().change_scene("res://Niveles/Level3.tscn")
		
func _on_Tutorial_pressed():
	get_tree().change_scene("res://Niveles/Tutorial.tscn")


func _on_Instrucc_pressed():
	get_tree().change_scene("res://Niveles/Instructions.tscn")
	

func _on_Exit_pressed():##cierro juego
	get_tree().quit()


func _on_Play_mouse_entered():
	if(Singleton.VolumeSfx):
		$SelectButton.play()
		

func _on_Tutorial_mouse_entered():
	if(Singleton.VolumeSfx):
		$SelectButton.play()


func _on_Instrucc_mouse_entered():
	if(Singleton.VolumeSfx):
		$SelectButton.play()


func _on_Exit_mouse_entered():
	if(Singleton.VolumeSfx):
		$SelectButton.play()


func _on_Sound_Music_pressed():
	Singleton.VolumeMusic=!Singleton.VolumeMusic


func _on_Sound_SFX_pressed():
	Singleton.VolumeSfx=!Singleton.VolumeSfx
