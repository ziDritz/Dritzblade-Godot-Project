class_name RichTextLabelFadeOut extends Node

@onready var rich_text_label: RichTextLabel = get_parent()

func _ready():
	var tween: Tween = create_tween()
	tween.tween_property(rich_text_label, "modulate:a", 0.0, 1.0)
