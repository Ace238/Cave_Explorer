extends CharacterBody2D

@export var MAX_SPEED : int = 250
@export var ACCELERATION = 99999
@export var FRICTION = 999999

@onready var axis : Vector2 = Vector2.ZERO

@onready var all_interactions = []
@onready var interactLabel = $"Interaction Components/Interact Label"

func _ready():
	update_interactions()


func _physics_process(delta):
	move(delta)
	if Input.is_action_just_pressed("Interact"):
		execute_interaction()


func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()

func move(delta):
	
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
		
	else:
		apply_movement(axis * ACCELERATION * delta)
		
	move_and_slide()


func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
		
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)











############################################################################

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#@onready var all_interactions = []
#@onready var interactLabel = $"Interaction Components/Interact Label"

#func _ready():
#	update_interactions()

#func _physics_process(delta):
#
#	if Input.is_action_just_pressed("Interact"):
#		execute_interaction()
#
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()


# Interaction Methods
###################################################

func _on_interation_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()


func _on_interation_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
		
	else:
		interactLabel.text = ""

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"print_text" : print(cur_interaction.interact_value)
