extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

onready var timer = $Timer

var invincible = false setget set_invincible

signal invincility_started
signal invincility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincility_started")
	else:
		emit_signal("invincility_ended")

func start_invincility(duration):
	self.invincible = true
	timer.start(duration)

func creat_hit_effect():
	var hitEffect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(hitEffect)
	hitEffect.global_position = global_position
	
func _on_Timer_timeout():
	self.invincible = false

func _on_Hurtbox_invincility_ended():
	monitorable = true
	
func _on_Hurtbox_invincility_started():
	set_deferred("monitorable", false)
