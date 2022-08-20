extends Area2D

export (PackedScene) var Heart##Usados para instanciar al matar al enemigo
export (PackedScene) var Shield
export (PackedScene) var RainOfBullets

export var positionGuard = Vector2()##Posicion por donde quiero que se muevan los enemigos
export var positionGuard2 = Vector2()##y sacar un punto random hacia donde vayan

export (float) var speed##Velocidad del enemigo

var pos_objetive=Vector2()##Posicion hacia donde va moverse el enemigo cuando no ve el player
var nav=Navigation2D##Navigation para saber que tiles puede moverse el enemigo
var path:Array=[]##Arreglo donde guardo el camino para llegar al enemigo, distintos puntos.

var player = KinematicBody2D##Player, para poder saber la distancia
var attack:bool=false##Atacar al player

var kill:bool=false##para cancelar otras animaciones, y comenzar la animacion de muerte

export (float) var seePlayer##Distancia a la que ve al player

var random = RandomNumberGenerator.new()##NUMEROS RANDOM

func _ready():	
	set_physics_process(true)
	set_process(true)
	player = get_tree().get_nodes_in_group("player")[0]#OBtengo el nodo player y lo guardo
	nav = get_tree().get_nodes_in_group("nav")[0]#obtengo el nodo del navigation para el path yl o guardo
	pos_objetive= Vector2(random.randi_range(positionGuard.x,positionGuard2.x),random.randi_range(positionGuard.y,positionGuard2.y))#Genero un punto al cual ir
	$Timer.wait_time=rand_range(8,20)#Cambio de punto objetivo, en un tiempo random
		
func _physics_process(delta):		
	if(!kill):#Si no esta muerto
		distanceWithPlayer()##Obtengo distancia al player para setear si es objetivo o no
		distanceAttack()##Si la posicion del player y enemigo se cumple, el enemigo deja de atacar
		var distancia = speed*delta##Distancia que se va mover en cada path
		if(!attack):##Si no esta atacando, que se mueva
			navigation(distancia)		
	
	
func set_path(objetive):##Seteo objetivo	
	path = nav.get_simple_path(self.global_position,objetive,false)
	path.remove(0)##REMUEVO PRIMER POSICION O SEA LA DEL JUGADOR

func navigation(distancia):
	var ultima_pos=self.position#Guardo posicion antes de mover
	for i in range(path.size()):##En cada elemento hago esto, osea  recorro el arreglo
		var distance_final= ultima_pos.distance_to(path[0])#Guardo la posicion final en cada iteraccion
		if(distancia <= distance_final):##Muevo el pj en base al proximo path que seria el 0, ya que el anterior lo remuevo
			$AnimationPlayer.play("Walk")
			flip(path[0])#roto dependiendo hacia que lugar de X se encuentre el proximo path
			self.position = ultima_pos.linear_interpolate(path[0],distancia/distance_final)#Hago la interpolacion, o sea, mover entre cada elemento
			break
		elif distancia <=0.0:##Si no tengo nada por recorrer			
			self.position=path[0]			
			break
		distancia-=distance_final
		ultima_pos = path[0]#IGualo a ultima pos		
		$AnimationPlayer.play("Idle")
		path.remove(0)#remuevo el path en el que me encuentro
		
func distanceWithPlayer():##Cuando la distancia del player con el enemigo es menor ala vista, lo sigue
	if(self.position.distance_to(player.position)<seePlayer):		
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
		
func _on_Timer_timeout():##Si termina el timer random, cambio objetivo y sino, hasta que cambian se quedan en idle
	pos_objetive= Vector2(rand_range(positionGuard.x,positionGuard2.x),rand_range(positionGuard.y,positionGuard2.y))

func _on_Enemy_body_entered(body):	
	if(body.name == "TileMap"):##Cuando choco con una pared, lo hago que cambie de objetivo tmb
		pos_objetive= Vector2(rand_range(positionGuard.x,positionGuard2.x),rand_range(positionGuard.y,positionGuard2.y))
	if(body.name == player.name):#Si colisiono con el player, que lo ataque
		attack=true
		$AnimationPlayer.play("Attack")#Hasta que me aleje y ahi llamo al distanceattack

func hurt():##Efectuar daño al player
	player.hurt()

func _on_Enemy_area_entered(area):#Si entro en un area de bala o escudo, muere el enemigo
	if(area.is_in_group("bullet") || area.is_in_group("shield")):
		speed=0
		kill=true		
		$AnimationPlayer.play("Death")

func kill():#En este metodo llamado en el animator, puede instanciar o no powerups
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
			pass
		5:			
			pass
		6:			
			pass
		7:
			pass
		8:
			pass
		9:			
			pass
		10:			
			pass	
	queue_free()
