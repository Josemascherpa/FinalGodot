extends KinematicBody2D

onready var boton=get_node("/root/Level1/Boton")
export(float) var SPEED=180
export (PackedScene) var bullet_normal #BALA NORMAL
export (PackedScene) var shield
onready var arrayPosition = [$Sprite/position1,$Sprite/position2,$Sprite/position3]
var flip=1.5
var rainOfBullets:bool=false
var shieldPU:bool=false##BOLEANO PARA QE NO SE INSTANCIE EN CADA FRAME
export var cooldown=5
onready var TimingRainOfBullets = $TimerRainOfBullets
onready var TimingShield = $TimerShield
var protectShield#GUARDO INSTANCIA DEL ESCUDO PARA BORRARLA LUEGO
var life=100
var stayBoton=false

func _ready():
	set_process_input(true)
	
	
func _process(delta):		
	if (Input.is_action_just_pressed("shot")):		
		match rainOfBullets:
			false: shot(bullet_normal,$Sprite.scale.x)
			true: shotThree(bullet_normal,$Sprite.scale.x)
	if(Input.is_action_just_pressed("Press") && stayBoton):
		boton.Press()
		
	if(shieldPU):
		protect()
		shieldPU=false
		
	
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
	protectShield = shield.instance()
	self.add_child(protectShield)
	protectShield.position = $positionProtect.position

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
	TimingRainOfBullets.stop()

func _on_TimerShield_timeout():###SHIELD
	protectShield.queue_free()
	protectShield = null	
	TimingShield.stop()



func _on_Boton_body_entered(body):
	stayBoton=true


func _on_Boton_body_exited(body):
	stayBoton=false
