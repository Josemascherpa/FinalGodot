extends Area2D

var direction
var distance
export var SPEED=5

func _ready():	
	distance = self.global_position.distance_to(get_parent().get_child(0).global_position)	
	direction = (get_parent().get_child(0).global_position-self.global_position )/distance
	
	var parentLevel=get_parent().get_parent().get_parent().get_parent()
	get_parent().remove_child(self)
	parentLevel.add_child(self)
	
	
func _physics_process(delta):
	$Sprite.rotation_degrees+=deg2rad(500)
	self.translate(direction*SPEED)
	


func _on_BulletColumn_area_entered(area):
	queue_free() # Replace with function body.


func _on_BulletColumn_body_entered(body):
	queue_free() # Replace with function body.
