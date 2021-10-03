extends Node2D

var num_beats = 0
var beats_ = []
var Beat = load("res://Beat.tscn")

# Called when the node enters the scene tree for the first time.
func init(num_beats_):
	num_beats = num_beats_
	for i in range(num_beats):
		var beat = Beat.instance();
		add_child(beat)
		beat.position.x = position.x + i * 10
		beat.position.y = position.y + 5
		print(beat.position)
		beats_.append(beat)
	pass # Replace with function body.

func set_playing(n):
	for i in range(num_beats):
		beats_[i].playing(i == n)

func set_selected(program):
	for i in range(num_beats):
		beats_[i].selected(program.has(i))
