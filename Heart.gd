extends Area2D

var beat_counter = null;
var program = []
var beat = 0
var needs_selection = false
var selected = false

var NBeat = load("res://NBeat.tscn")
var nbeat = null;
var beat_audio = null
var beat_width = 8
var key = null

func init(positionx, positiony, beat_width_, stream, db, tex, key_):
	$Sprite.texture = tex
	beat_width = beat_width_
	position.x = positionx
	position.y = positiony
	key = key_
	
	nbeat = NBeat.instance()
	add_child(nbeat)
	nbeat.init(beat_width)
	nbeat.scale.x = 5
	nbeat.scale.y = 5
	nbeat.position.x -= 250
	nbeat.position.y -= 250
	
	beat_audio = AudioStreamPlayer.new()
	add_child(beat_audio)
	beat_audio.set_stream(stream)
	beat_audio.volume_db = db

func pulse():
	nbeat.set_playing(beat)
	if beat == (beat_width - 1):
		if selected:
			$select.play()
			nbeat.set_selected(program)
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
			small(true)
		else:
			big()
		
	beat = (beat + 1) % beat_width;
	
func small(should_play):
	if should_play:
		beat_audio.play()
	$Sprite.scale.x = 0.25
	$Sprite.scale.y = 0.25
	
func big():
	beat_audio.stop()
	$Sprite.scale.x = 0.5
	$Sprite.scale.y = 0.5
	
func _input(event):
	if event is InputEventKey and not event.echo:
		var eventkey = OS.get_scancode_string(event.get_scancode_with_modifiers())
		print(eventkey, " ", key)
		if eventkey == ("Shift+" + key):
			program = []
			nbeat.set_selected(program)
		if eventkey == key:
			if event.pressed:			
				print(beat, " ", key)
				if program.size() == 0 || program[program.size() - 1] != beat:
					program.append(beat)
					small(false)
			else:
				big()
			nbeat.set_selected(program)
