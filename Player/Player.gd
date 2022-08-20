extends KinematicBody2D

var boton
var door
export(float) var SPEED=180 ##Velocidad
export (PackedScene) var bullet_normal #BALA NORMAL
export (PackedScene) var shield
onready var arrayPosition = [$Sprite/position1,$Sprite/position2,$Sprite/position3]##Array con las posiciones de disparo
var flip=1.5
var rainOfBullets:bool=false
var shieldPU:bool=false##BOLEANO PARA QE NO SE INSTANCIE EN CADA FRAME
export var cooldown=5
onready var TimingRainOfBullets = $TimerRainOfBullets
onready var TimingShield = $TimerShield
var protectShield#GUARDO INSTANCIA DEL ESCUDO PARA BORRARLA LUEGO
var life=3
var stayBoton=false##Ver si estoy colisionando con el boton o no
var withShield:bool=false#Si estoy con escudo
var noShot:bool=false#No disparo
var playerDeath:bool=false#Si estoy muerto
var noRun=false#No correr

func _ready():	
	set_process_input(true)	
	door = get_tree().get_nodes_in_group("door")[0]#Guardo puerta
	boton = get_tree().get_nodes_in_group("boton")[0]#guardo boton
	
func _process(delta):
	Death()#En base a las vidas y el booleano, paro animaciones y llamo a la animaicon de muerte
	inputs()#disparo con el space, dependiendo si tengo el power de disparar, disparo 1 o 3
	#Y ademas, si colisiono con el boton puedo apretar la E para activarlo o desactivarlo	
	if(shieldPU):#Tengo escudo
		withShield=true
		protect()
		shieldPU=false			
		
func inputs():
	if (Input.is_action_just_pressed("shot") && !noShot):		
		match rainOfBullets:
			false: shot(bullet_normal,$Sprite.scale.x)
			true: shotThree(bullet_normal,$Sprite.scale.x)	
	if(Input.is_action_just_pressed("Press") && stayBoton):
		boton.Press()		
	
func _physics_process(_delta):	
	if(!noRun):#Movimiento siempre y cuando pueda correr
		move_and_slide(moveAndAnimations())
	
func SceneDeath():#Una vez que la animacion de muerto termina, llamo a la escena death y las vidas a 3
	get_tree().change_scene("res://Niveles/Death.tscn")
	Singleton.lifesPlayer=3
	playerDeath=false
	
func Death():#Animacion death
	if(Singleton.lifesPlayer<=0 && !playerDeath):
		playerDeath=true
		noShot=true
		noRun=true
		$AnimationPlayer.stop()
		$AnimationPlayer.play("Death")
		
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
	if(Input.is_action_just_pressed("shot") && movement == Vector2(0,0)):
		$AnimationPlayer.play("Shot")		
	elif(movement == Vector2(0,0)):		
		$AnimationPlayer.play("Idle")			
	movement = movement.normalized()*SPEED	
	return movement
	
func protect():#Instancio escudo en mi posicion
	protectShield = shield.instance()
	self.add_child(protectShield)
	protectShield.position = $positionProtect.position

func shot(bullet,directionX):#Instancio bala y direccion hacia donde ser lanzada
	var bulletInst = bullet.instance()
	get_parent().add_child(bulletInst)
	bulletInst.position = arrayPosition[1].global_position
	bulletInst.direction = directionX
	
func shotThree(bullet,directionX):#Instancio 3 balas 1 en cada posicion a la misma vez y misma direcc
	for i in range(3):
		var bulletInst = bullet.instance()		
		get_parent().add_child(bulletInst)
		bulletInst.position = arrayPosition[i].global_position
		bulletInst.direction = directionX
		
func pickupPower():#SOnido de recojer powerups
	$power.play()
	
func hurt():#Algo daña al jugador, uso shader y resto vida y sonido
	Singleton.lifesPlayer-=1
	$AnimationEffects.play("flickerLine")
	$hurt.play()

func idleEffects():#Usado para cuando termina el flicker
	$AnimationEffects.play("idle")

func _on_TimerRainOfBullets_timeout():#Termina el tiempo de uso del powerups
	rainOfBullets=false
	TimingRainOfBullets.stop()

func _on_TimerShield_timeout():#tiempo terminado de pwerup shield
	withShield=false
	protectShield.queue_free()
	protectShield = null	
	TimingShield.stop()

func _on_Boton_body_entered(body):#Estoy en el boton
	if(body.name == self.name):
		stayBoton=true

func _on_Boton_body_exited(body):#No estoy en el boton
	stayBoton=false

func _on_Tween_tween_all_completed():#Animacion al colisionar con la puerta abierta y cargo proximo level, al terminar el tween
	match Singleton.Level:
		#1:
		#	get_tree().change_scene("res://Niveles/Level1.tscn")
		2: 
			get_tree().change_scene("res://Niveles/Level2.tscn")
		3:
			get_tree().change_scene("res://Niveles/Level3.tscn")	
		4:
			get_tree().change_scene("res://Niveles/Level4.tscn")	


func _on_door_body_entered(body):#Colisiono con puerta y empiezo el tween en escala al jugador, cuando termina cambio escena
	if(body.name == "Player" && door.open):
		noShot=true
		SPEED=0
		Singleton.Level+=1
		$Tween.interpolate_property(self, "scale", Vector2(1,1), Vector2(0,0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
	
