extends Control

signal upgrade_selected(upgrade: HandTypeUpgradeDefinition)
signal reroll_requested

@onready var upgrades_container: VBoxContainer = $VBoxContainer/UpgradeList
@onready var reroll_button: Button = $VBoxContainer/RerollButton

@export var buttons: Array[Button]

func _ready() -> void:
	reroll_button.pressed.connect(_on_reroll_pressed)

func show_upgrades(upgrades: Array[HandTypeUpgradeDefinition]) -> void:

	var i = 0
	for upgrade in upgrades:
		if upgrade == null:
			continue

		var button := buttons[i]
		i += 1
		button.text = "%s\n%s" % [upgrade.get_title(), upgrade.get_description()]
		button.pressed.connect(_on_upgrade_pressed.bind(upgrade))

	visible = true

func _on_upgrade_pressed(upgrade: HandTypeUpgradeDefinition) -> void:
	upgrade_selected.emit(upgrade)

func _on_reroll_pressed() -> void:
	reroll_requested.emit()
