extends Door

@onready var audio_stream: AudioStreamPlayer3D = $KnockingStream
@onready var timer = $Timer

var stinger_played = false

func _ready():
	timer.start(2)

func interact():
	super.interact()
	audio_stream.stop()
	
func _on_timer_timeout():
	audio_stream.play()
	
func stop_knocking():
	audio_stream.stop()
