extends CharacterBody2D

var direction:Vector2
var speed:=50
var player: CharacterBody2D
var health:=3
var is_exploding:=false


func _on_area_2d_body_entered(player_body: CharacterBody2D) -> void:
	player=player_body

	
func _physics_process(_delta: float) -> void:
	if player:
		var dir = (player.position - position).normalized()
		velocity = dir * speed
		move_and_slide()
		
	
func _on_area_2d_body_exited(_player_body : CharacterBody2D) -> void:
	player = null


func _on_explosion_area_body_entered(_body: Node2D) -> void:
	explosion()
	
	
func hit():
	health-=1
	if health <=0:
		is_exploding = true
		explosion()
	var tween_flash=create_tween()
	tween_flash.tween_property($AnimatedSprite2D.material,"shader_parameter/Float",0.0,0.38)
	tween_flash.tween_property($AnimatedSprite2D.material,"shader_parameter/Float",1.0,0.55)
	
	
func explosion():
	$AudioStreamPlayer2D.play()
	speed=0
	$AnimatedSprite2D.hide()
	$explosion.show()
	$AnimationPlayer.play("explosion")
	await $AnimationPlayer.animation_finished
	queue_free()
	
func chain_reaction():
	for drone in get_tree().get_nodes_in_group("Drones"):
		if position.distance_to(drone.position)<20:
			if not is_exploding:
				drone.explosion()
	
	


	
