extends CanvasLayer


var duration = 2
const pos = {
	top = Control.PRESET_CENTER_TOP,
	center = Control.PRESET_CENTER,
	bottom = Control.PRESET_CENTER_BOTTOM
}


func _init():
	add_child(_generate_timer())


func toast(msg, _duration: int=duration, _position: int=pos.bottom):
	_clear_msg()
	$timer.start(_duration)
	call_deferred("add_child", _generate_msg(msg, _position))


func timer_callback():
	$timer.stop()
	_clear_msg()


func _generate_timer() -> Timer:
	var timer = Timer.new()
	timer.name = "timer"
	timer.connect("timeout", self, "timer_callback")
	return timer


func _generate_msg(msg: String, _position: int) -> Label:
	var label = Label.new()
	label.name = "msg"
	label.align = Label.ALIGN_CENTER
	label.valign = Label.VALIGN_CENTER
	label.text = msg

	label.set_anchors_preset(_position)
	label.add_stylebox_override("normal", _generate_style_box_flat())
	# add font to label
    # label.add_font_override("font", font)
	
	match _position:
		pos.top:
			label.anchor_top += 0.03
			label.grow_horizontal = Control.GROW_DIRECTION_BOTH
			label.grow_vertical = Control.GROW_DIRECTION_END
		pos.center:
			label.grow_horizontal = Control.GROW_DIRECTION_BOTH
			label.grow_vertical = Control.GROW_DIRECTION_BOTH
		pos.bottom:
			label.anchor_bottom -= 0.03
			label.grow_horizontal = Control.GROW_DIRECTION_BOTH
			label.grow_vertical = Control.GROW_DIRECTION_BEGIN
	
	return label


func _generate_style_box_flat() -> StyleBoxFlat:
	var flat = StyleBoxFlat.new()
	flat.bg_color = Color(0.0, 0.0, 0.0, 0.6)
	flat.set_corner_radius_all(10)
	flat.content_margin_left = 50
	flat.content_margin_top = 15
	flat.content_margin_right = 50
	flat.content_margin_bottom = 15
	
	return flat


func _clear_msg():
	if has_node("msg"):
		var old_msg = $msg
		old_msg.name = "remove_msg"
		old_msg.queue_free()
