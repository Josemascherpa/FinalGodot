extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
	else:
		$Control/Play.visible=false
		$Control/MainMenu.visible=false

func _on_TextureButton_pressed():
	get_tree().paused=!get_tree().paused


func _on_Play_pressed():
	get_tree().paused=false


func _on_MainMenu_pressed():
	print("CARGO MENU PRINCIPAL")
