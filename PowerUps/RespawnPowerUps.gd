extends Node2D

export (PackedScene) var shield
export (PackedScene) var heart
export (PackedScene) var rainofbullets

func _ready():
	RespawnPowerUps()


func RespawnPowerUps():
	for i in range(self.get_child_count()-1):##Le saco el timer
		var randomNum= randi()%2
		var PU= InstancePU(randomNum)
		
		#self.add_child(PU)
		#PU.position = self.get_child(i).position

func InstancePU(number,position):
	match number:
		0: var shieldPU=shield.instance() 	
				shieldPU.position=position
		1:var heartPU=heart.instance()
			
		2:var rainPU=rainofbullets.instance()
		
		
	
