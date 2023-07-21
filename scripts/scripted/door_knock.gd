extends Door

@onready var audio_stream: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var timer = $Timer

func interact():
	super.interact()
	audio_stream.stop()
	
	if !self.open:
		timer.start(5)
	else:
		timer.stop()

func _on_timer_timeout():
	audio_stream.play()
