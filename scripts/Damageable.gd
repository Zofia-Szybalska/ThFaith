extends Node

class_name Damageable

signal damaged

func hit():
	damaged.emit()


