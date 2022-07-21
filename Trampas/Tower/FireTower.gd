extends StaticBody2D

export (PackedScene) var bullet
export var SPEEDROTATION = 50
onready var arrayPosition = [$Sprite/Position2DHigh,$Sprite/Position2DRight,$Sprite/Position2DLeft,$Sprite/Position2DDown]
export var cooldown:float = 5

func _ready():
	$Timer.start(5)

func _physics_process(_delta):
	$Sprite.rotation_degrees+=deg2rad(SPEEDROTATION)

func shot():
	for i in range(4):
		var bullets = bullet.instance()
		arrayPosition[i].add_child(bullets)
		bullets.global_position = arrayPosition[i].global_position##LANZARLOS HCIA EL Y DE CADA POSITION
		
func restartTime():
	$Timer.start(cooldown)
	$AnimationPlayer.play("idle")


func _on_Timer_timeout():
	$AnimationPlayer.play("Shot")
