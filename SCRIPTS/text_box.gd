extends MarginContainer


@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer
const MAX_WIDTH = 256
var text = " "
var letter_index = 0
var letter_time = 0.03
var space_time = 0.06
var ponctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String):
	text = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	global_position.x -= size.x / 2
