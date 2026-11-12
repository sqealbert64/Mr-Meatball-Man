extends CharacterBody2D

@export var run_speed: float
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float  = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
var horizontal_dir: float

func jump():
	velocity.y = jump_velocity

func get_current_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func get_vertical_input() -> void:
	if Input.is_action_just_pressed("jump"):
		jump()

func get_horizontal_input() -> float:
	var horizontal_input := Input.get_axis("move_left","move_right")
	return horizontal_input

func _physics_process(delta: float) -> void:
	get_vertical_input()
	horizontal_dir = get_horizontal_input()
	velocity.y += get_current_gravity() * delta 
	velocity.x = horizontal_dir * run_speed
	move_and_slide()
