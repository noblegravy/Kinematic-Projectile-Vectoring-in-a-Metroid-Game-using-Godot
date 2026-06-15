extends Node2D

var bullet:PackedScene = preload("res://scenes/bullets/bullet.tscn")
var speed = 50

func _ready() -> void:
	var light_tween = create_tween()
	light_tween.set_loops()
	light_tween.tween_property($lights/PointLight2D2, "energy",1.5,1)
	light_tween.tween_property($lights/PointLight2D2, "energy",0.5,1)

func _on_player_shoot(pos: Vector2, dir: Vector2) -> void:
	var fire = bullet.instantiate() as Area2D
	$Bullets.add_child(fire)
	fire.setup(pos,dir)
	

	
