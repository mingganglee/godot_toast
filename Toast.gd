extends CanvasLayer


var duration = 2
var font_size = 40
var _toast_obj: Timer
const pos = {
	top = Control.PRESET_CENTER_TOP,
	center = Control.PRESET_CENTER,
	bottom = Control.PRESET_CENTER_BOTTOM
}


func _init():
	add_child(_generate_timer())
	add_child(_generate_msg())


func toast(msg, _duration: int=duration, _position: int=pos.bottom):
	modify_msg(msg, _position)
	
	$timer.start(_duration)
	$msg.show()


func modify_msg(msg: String, _position: int):
	$msg.text = msg
	$msg.size.x = $msg.get_theme_default_font().get_string_size($msg.text).x
	
	$msg.anchors_preset = _position
	match _position:
		pos.top:
			$msg.anchor_top += 0.03
		pos.bottom:
			$msg.anchor_bottom -= 0.03


func timer_callback():
	$timer.stop()
	$msg.hide()


func _generate_timer() -> Timer:
	var timer = Timer.new()
	timer.name = "timer"
	timer.connect("timeout", timer_callback)
	return timer


func _generate_msg() -> Label:
	var msg: Label = Label.new()
	msg.name = "msg"
	msg.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	msg.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	msg.add_theme_stylebox_override("normal", _generate_style_box_flat())
	msg.add_theme_font_size_override("font_size", font_size)
	msg.hide()
	
	return msg


func _generate_style_box_flat() -> StyleBoxFlat:
	var flat = StyleBoxFlat.new()
	flat.bg_color = Color(0.0, 0.0, 0.0, 0.6)
	flat.set_corner_radius_all(10)
	flat.content_margin_left = 50
	flat.content_margin_top = 15
	flat.content_margin_right = 50
	flat.content_margin_bottom = 15
	
	return flat
