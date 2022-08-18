extends Area2D

export (PackedScene) var Heart
export (PackedScene) var Shield
export (PackedScene) var RainOfBullets
export var positionGuard = Vector2()
export var positionGuard2 = Vector2()
export (float) var speed
var velocity:Vector2=Vector2.ZERO
var pos_objetive=Vector2()
var nav=Navigation2D
var path:Array=[]
var player = KinematicBody2D
var attack:bool=false
var kill:bool=false
export (float) var seeEnemy


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_physics_process(true)
	player = get_tree().get_nodes_in_group("player")[0]
	nav = get_tree().get_nodes_in_group("nav")[0]
	pos_objetive= Vector2(rand_range(positionGuard.x,positionGuard2.x),rand_range(positionGuard.y,positionGuard2.y))

func _physics_process(delta):	
	if(!kill):
		distanceWithPlayer()
		distanceAttack()
		var distancia = speed*delta
		if(!attack):	
			navigation(distancia)
		
	
func set_path(objetive):##Seteo objetivo
	path = nav.get_simple_path(self.global_position,objetive,false)
	path.remove(0)##REMUEVO PRIMER POSICION O SEA LA DEL JUGADOR

func navigation(distancia):
	var ultima_pos=self.position
	for i in range(path.size()):##En cada elemento hago esto
		var distance_final= ultima_pos.distance_to(path[0])#Guardo la posicion final en cada iteraccion
		if(distancia <= distance_final):##Muevo el pj en base al proximo path que seria el 0, ya que el anterior lo remuevo
			$AnimationPlayer.play("Walk")
			flip(path[0])
			self.position = ultima_pos.linear_interpolate(path[0],distancia/distance_final)#Hago la interpolacion
			break
		elif distancia <=0.0:##Si no tengo nada por recorrer			
			self.position=path[0]			
			break
		distancia-=distance_final
		ultima_pos = path[0]#IGualo a ultima pos
		$AnimationPlayer.play("Idle")			
		path.remove(0)#remuevo el path en el que me encuentro
		
func distanceWithPlayer():##Cuando la distancia del player con el enemigo es menor ala vista, lo sigue
	if(self.position.distance_to(player.position)<seeEnemy):		
		set_path(player.position)
	else:
		set_path(pos_objetive)	
		
func distanceAttack():##Cuando la posicion del enemigo se aleja, deja de atacar
	if(self.position.distance_to(player.position)>50):		
		attack=false	
		
func flip(objetive):##Roto el nodo en base al proximo path en el navigation
	if(objetive.x<self.position.x):	
		self.scale.x=-1
	else:
		self.scale.x=1
		
func _on_Timer_timeout():	
	pos_objetive= Vector2(rand_range(positionGuard.x,positionGuard2.x),rand_range(positionGuard.y,positionGuard2.y))

func _on_Enemy_body_entered(body):
	if(body.name == player.name):
		attack=true
		$AnimationPlayer.play("Attack")

func hurt():
	Singleton.lifesPlayer-=1

func _on_Enemy_area_entered(area):
	if(area.is_in_group("bullet") || area.is_in_group("shield")):
		speed=0
		kill=true		
		$AnimationPlayer.play("Death")

func kill():
	var numeroRandom = randi()%10+1
	match numeroRandom:		
		1:	
			var powerups = Heart.instance()
			get_parent().add_child(powerups)
			powerups.global_position=self.global_position
		2:
			var powerups = Shield.instance()
			get_parent().add_child(powerups)
			powerups.global_position=self.global_position
		3:
			var powerups = RainOfBullets.instance()
			get_parent().add_child(powerups)
			powerups.global_position=self.global_position			
		4:
			print("Nada")
			pass
		5:
			print("Nada")
			pass
		6:
			print("Nada")
			pass
		7:
			print("Nada")
			pass
		8:
			print("Nada")
			pass
		9:
			print("Nada")
			pass
		10:
			print("Nada")
			pass
	
	queue_free()
