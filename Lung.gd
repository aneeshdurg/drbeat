extends Area2D

export (int) var beat_width;

var beat_counter = null;
var program = []
var beat = 0
var needs_selection = false
var selected = false

func pulse():
	$NBeat.set_playing(beat)
	if beat == (beat_width - 1):
		if selected:
			$select.play()
			$NBeat.set_selected(program)
			selected = false
			modulate.a = 1
		elif needs_selection:
			$select.play()
			needs_selection = false
			selected = true
			modulate.a = 0.5
			program = []
	if not (selected or needs_selection):
		if program.has(beat):
			small()
		else:
			big()
		
	beat = (beat + 1) % beat_width;
	
func small():
	$beat.play()
	$Sprite.scale.x = 0.25
	$Sprite.scale.y = 0.25
	
func big():
	$beat.stop()
	$Sprite.scale.x = 0.5
	$Sprite.scale.y = 0.5

func _on_Heart_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			if not selected:
				needs_selection = true
			else:
				if program.size() == 0 || program[program.size() - 1] != beat:
					program.append(beat)
					small()
		else:
			if selected:
				big()
		print(program)
		$NBeat.set_selected(program)
