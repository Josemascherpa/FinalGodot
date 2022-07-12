extends KinematicBody2D

export(float) var SPEED=180
export (PackedScene) var bullet_normal #BALA NORMAL
export (PackedScene) var shield
onready var arrayPosition = [$Sprite/position1,$Sprite/position2,$Sprite/position3]
var flip=1.5
var rainOfBullets:bool=false
export var cooldown=5
onready var TimingRainOfBullets = $TimerRainOfBullets

func _ready():
	set_process_input(true)
		
func _process(delta):		
	if (Input.is_action_just_pressed("shot")):		
		match rainOfBullets:
			false: shot(bullet_normal,$Sprite.scale.x)
			true: shotThree(bullet_normal,$Sprite.scale.x)

func _physics_process(_delta):	
	move_and_slide(moveAndAnimations())


func moveAndAnimations() -> Vector2:#retorno el vector2 para no hacerlo en el evento y procesar todo por fuera, y solo devolver el resultado
	var movement = Vector2()
	if (Input.is_action_pressed("move_up")):
		movement += Vector2(0, -1)
		$AnimationPlayer.play("Run")
	if (Input.is_action_pressed("move_down")):
		movement += Vector2(0, 1)		
		$AnimationPlayer.play("Run")
	if (Input.is_action_pressed("move_left")):
		movement += Vector2(-1, 0)
		$AnimationPlayer.play("Run")
		$Sprite.scale.x=-flip
	if (Input.is_action_pressed("move_right")):
		movement += Vector2(1, 0)		
		$AnimationPlayer.play("Run")
		$Sprite.scale.x = flip	
	if(Input.is_action_pressed("shot") && movement == Vector2(0,0)):
		$AnimationPlayer.play("Shot")
	elif(movement == Vector2(0,0)):		
		$AnimationPlayer.play("Idle")	
		
	movement = movement.normalized()*SPEED	
	return movement
	
func protect():
	var protect = shield.instance()
	self.add_child(protect)
	protect.position = $positionProtect.position

func shot(bullet,directionX):
	var bulletInst = bullet.instance()
	get_parent().add_child(bulletInst)
	bulletInst.position = arrayPosition[1].global_position
	bulletInst.direction = directionX
	
func shotThree(bullet,directionX):	
	for i in range(3):
		var bulletInst = bullet.instance()		
		get_parent().add_child(bulletInst)
		bulletInst.position = arrayPosition[i].global_position
		bulletInst.direction = directionX

func _on_TimerRainOfBullets_timeout():
	rainOfBullets=false
