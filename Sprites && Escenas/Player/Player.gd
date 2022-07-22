extends KinematicBody2D

##USAR DOS NAIMATION PARA HACER EFECTOS DE SHADERS 
onready var boton=get_node("/root/Manager/Level1/Boton")
onready var doorLvl1=get_node("/root/Manager/Level1/doorLvl1")
export (PackedScene) var lvl2
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
var life=3
var stayBoton=false
var withShield:bool=false
var noShot:bool=false

func _ready():
	set_process_input(true)
	
	
func _process(delta):		
	#print(life)	
	if (Input.is_action_just_pressed("shot") && !noShot):		
		match rainOfBullets:
			false: shot(bullet_normal,$Sprite.scale.x)
			true: shotThree(bullet_normal,$Sprite.scale.x)	
	if(Input.is_action_just_pressed("Press") && stayBoton):
		boton.Press()		
	if(shieldPU):
		withShield=true
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

func hurt():
	life-=1
	$AnimationEffects.play("flickerLine")

func idleEffects():
	$AnimationEffects.play("idle")

func _on_TimerRainOfBullets_timeout():
	rainOfBullets=false
	TimingRainOfBullets.stop()

func _on_TimerShield_timeout():###SHIELD
	withShield=false
	protectShield.queue_free()
	protectShield = null	
	TimingShield.stop()

func _on_Boton_body_entered(body):
	stayBoton=true


func _on_Boton_body_exited(body):
	stayBoton=false

func _on_doorLvl1_body_entered(body):	
	if(body.name == "Player" && doorLvl1.open):
		noShot=true
		SPEED=0
		$Tween.interpolate_property(self, "scale", Vector2(1,1), Vector2(0,0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()


func _on_Tween_tween_all_completed():	
	get_node("/root/Manager/Level1").queue_free()
	get_node("/root/Manager").add_child(lvl2.instance())
	
