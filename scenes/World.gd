extends Node

export (PackedScene) var Mob
var score

onready var MobSpawnLocation = $MobPath/MobSpawnLocation

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$HUD.show_game_over()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_Player_hit():
	game_over()

func _on_MobTimer_timeout():
	MobSpawnLocation.set_offset(randi())
	
	var mob = Mob.instance()
	add_child(mob)
	
	mob.position = MobSpawnLocation.position
	
	# Set the mob's direction perpendicular to the path direction
	var direction = MobSpawnLocation.rotation + PI / 2
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
	$HUD.connect("start_game", mob, "_on_start_game")

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
