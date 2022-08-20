extends CanvasLayer

func _ready():
	randomize()

func _process(delta):
	lifes()
	Pause()
	Sounds()
	
func lifes():##MUestro u oculto, segun las vidas
	match Singleton.lifesPlayer:
		0:
			for child in get_children():				
				if(child.name != "SelectButton"):
					child.visible = false			
		1:
			for child in get_children():
				if(child.name == "life2" || child.name == "life3"):
					child.visible = false
		2:
			for child in get_children():
				if(child.name=="life2"):
					child.visible=true
				if(child.name == "life3"):
					child.visible = false
		3:
			for child in get_children():				
					child.visible = true

func Pause():#Cuando estoy en pausa muestro u oculto 
	if(get_tree().paused):
		$Control/Play.visible=true
		$Control/MainMenu.visible=true		
		$Control/Pause.disabled=true
		$Control/Pause.visible=false
		$Control/SoundMusic.visible=true
		$Control/SoundSFX.visible=true
	else:
		$Control/Pause.disabled=false
		$Control/Pause.visible=true
		$Control/Play.visible=false
		$Control/MainMenu.visible=false
		$Control/SoundMusic.visible=false
		$Control/SoundSFX.visible=false
		

func _on_TextureButton_pressed():#Boton pausa, para poenr o no el juego 
	get_tree().paused=!get_tree().paused


func _on_Play_pressed():##resumo juego
	get_tree().paused=false


func _on_MainMenu_pressed():#Vuelvo al menu
		get_tree().change_scene("res://Niveles/MainMenu.tscn")
		
func Sounds():#manejo sonidos en base al bus de sonido y el uso del singleton para que funcione en todas las escenas
	if(Singleton.VolumeMusic):		
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		$Control/SoundMusic/Label.text="ON"		
	else:				
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)		
		$Control/SoundMusic/Label.text="OFF"
		
	if(Singleton.VolumeSfx):			
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), false)
		$Control/SoundSFX/Label.text="ON"		
	else:	
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"),true)		
		$Control/SoundSFX/Label.text="OFF"


func _on_SoundMusic_pressed():	
	Singleton.VolumeMusic=!Singleton.VolumeMusic

func _on_SoundSFX_pressed():
	Singleton.VolumeSfx=!Singleton.VolumeSfx

func _on_MainMenu_mouse_entered():#Sonidito para cuando paso el mouse por encima
	$Control/SelectButton.play()

func _on_Play_mouse_entered():
	$Control/SelectButton.play()
