class_name Projectile extends Area2D

var projectile_resource: ProjectileResource

var speed: int
var texture: Texture2D
var direction: Vector2 = Vector2(0, -1)

var sound: AudioStreamMP3
var damage : int
var owner_type

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	# Placé ici parceque init() est called avant
	# que le projectile soit add_child (init -> add_child -> ready)
	# au moment du init (called dans un shooter),
	# les childs du projectile sont pas encore instanciés
	animated_sprite_2d.sprite_frames = projectile_resource.sprite_frames
	audio_stream_player.stream = projectile_resource.sound
	
	animated_sprite_2d.play()
	audio_stream_player.play()


func init(_projectile_resource: ProjectileResource,
	_position: Vector2,
	_rotation: float,
	_direction: Vector2,
	_owner_type
	):
	
	projectile_resource = _projectile_resource
	name = _projectile_resource.name
	damage = _projectile_resource.damage
	speed = _projectile_resource.speed

	position = _position
	rotation = _rotation
	direction = _direction
	owner_type = _owner_type




func _physics_process(delta: float) -> void:
	position += direction * speed * delta

	
	if not Rect2(-1000, -1000, 3500, 3500).has_point(global_position):
		queue_free()



func _on_body_entered(body: Node2D) -> void:
	# J'ai pas trouvé d'autre moyen pour comparer les type
	var body_type = body.get_script().get_global_name()
	
	if body.has_node("Health") && body_type != owner_type:
		var health = body.health.get_health()
		body.health.set_health(health-damage)
		queue_free()
