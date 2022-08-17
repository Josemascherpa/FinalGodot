extends KinematicBody2D

export (float) var velocidad
var pos_objetivo = Vector2()
var nav = Navigation2D
var path = []


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	nav = get_tree().get_nodes_in_group("nav")[0]
	pos_objetivo = get_tree().get_nodes_in_group("player")[0].position
	set_path()
	
func _physics_process(delta):	
	if(path.size()>1):
		var d= self.position.distance_to(path[0])
		if(d>1):		
			self.set_position(self.position.linear_interpolate(path[0],(velocidad*delta)/d))
		else:
			path.remove(0)

func set_path():
	path=nav.get_simple_path(self.global_position,pos_objetivo,false)
