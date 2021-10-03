extends Node

var Heart = load("res://Heart.tscn")
var heartpng = preload("res://assets/heart.png")
var heartstream = load("res://assets/hit.wav")

var lungpng = preload("res://assets/lung.png")
var lungstream = load("res://assets/breath.wav")

var brainpng = preload("res://assets/cyborgbrain.png")
var brainstream = load("res://assets/battery.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	var heart = Heart.instance()
	heart.init(500, 250, 8, heartstream, 1, heartpng, "A")
	add_child(heart)
	
	var lung = Heart.instance()
	lung.init(1000, 250, 4, lungstream, -15, lungpng, "S")
	add_child(lung)
	
	var brain = Heart.instance()
	brain.init(750, 750, 16, brainstream, -5, brainpng, "D")
	add_child(brain)
	
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", heart, "pulse")
	timer.connect("timeout", lung, "pulse")
	timer.connect("timeout", brain, "pulse")
	timer.connect("timeout", self, "pulse")
	timer.set_wait_time(0.25)
	timer.set_one_shot(false)
	timer.start()
	pass # Replace with function body.

var state = 0
func pulse():
	if state % 2 == 0:
		$pulse.stop()
		$pulse.play()
	state = (state + 1) % 4
