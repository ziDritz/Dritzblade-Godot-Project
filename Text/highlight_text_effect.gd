@tool
extends RichTextEffect 
class_name HighlightTextEffect 
var bbcode = "highlight"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var animation_speed = char_fx.env.get("animation_speed", 5.0)
	var wave_span = char_fx.env.get("wave_span", 10.0)
	var alpha_value = sin(char_fx.elapsed_time * animation_speed + (char_fx.relative_index / wave_span)) * 0.5 + 0.5
	
	char_fx.color.a = alpha_value
	
	return true
