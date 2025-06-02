class_name Projectile extends Area2D

var projectile_resource: ProjectileResource

var speed: int
var texture: Texture2D
var direction: Vector2 = Vector2(0, -1)

var sound: AudioStreamMP3
var damage : int
var shooter
var shooter_owner: CharacterBody2D
var shooter_owner_type

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:	
	name = projectile_resource.name
	animated_sprite_2d.sprite_frames = projectile_resource.sprite_frames
	audio_stream_player.stream = projectile_resource.sound
	damage = projectile_resource.damage
	speed = projectile_resource.speed

	rotation = shooter.rotation
	animated_sprite_2d.play()
	audio_stream_player.play()



func _physics_process(delta: float) -> void:
	position += direction * speed * delta

	
	if not Rect2(-1000, -1000, 3500, 3500).has_point(global_position):
		queue_free()



func _on_body_entered(body: Node2D) -> void:
	# J'ai pas trouvé d'autre moyen pour comparer les type
	var body_type = body.get_script().get_global_name()
	
	if body.has_node("Health") && body_type != shooter_owner_type:
		var health = body.health.get_health()
		body.health.set_health(health-damage)
		queue_free()
