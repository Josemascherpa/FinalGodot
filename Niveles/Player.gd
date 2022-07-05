extends KinematicBody2D

export(float) var SPEED=100

func _ready():
	set_process_input(true)

func _physics_process(_delta):	
	move_and_slide(move())


func move() -> Vector2:#retorno el vector2 para no hacerlo en el evento y procesar todo por fuera, y solo devolver el resultado
	var movement = Vector2()
	if (Input.is_action_pressed("move_up")):
		movement += Vector2(0, -1)
		##ANIMACION Y FLIPEO
	if (Input.is_action_pressed("move_down")):
		movement += Vector2(0, 1)		
	if (Input.is_action_pressed("move_left")):
		movement += Vector2(-1, 0)
	if (Input.is_action_pressed("move_right")):
		movement += Vector2(1, 0)		
	movement = movement.normalized()*SPEED	
	return movement
