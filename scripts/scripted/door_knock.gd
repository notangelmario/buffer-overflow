extends Door

@onready var audio_stream: AudioStreamPlayer3D = $KnockingStream
@onready var stinger_stream: AudioStreamPlayer = $StingerStream
@onready var timer = $Timer

var stinger_played = false

func _ready():
	timer.start(2)

func interact():
	super.interact()
	audio_stream.stop()
	
	if !stinger_played:
		stinger_stream.play()
		stinger_played = true
	
	if !self.open:
		timer.start(5)
	else:
		timer.stop()

func _on_timer_timeout():
	audio_stream.play()
