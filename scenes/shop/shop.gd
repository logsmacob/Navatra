extends Control
## Shop script: coordinates this part of the game's behavior.

@export var currency_label: Label
@export var inventory_label: Label
@export var offers_container: VBoxContainer
@export var reroll_button: Button
@export var continue_button: Button

@export var item_pool: Array[ItemData] = []
@export_range(1, 12, 1) var offer_count: int = 6

const REROLL_COST: int = 3

var _offers: Array[ItemData] = []
var _offer_service: ShopOfferService = ShopOfferService.new()
var _purchase_service: ShopPurchaseService = ShopPurchaseService.new()

func _ready() -> void:
	_roll_offers()
	_refresh_view()

	if reroll_button:
		reroll_button.pressed.connect(_on_reroll_pressed)
	if continue_button:
		continue_button.pressed.connect(_on_continue_pressed)
	GameState.currency_changed.connect(_on_currency_changed)

func _roll_offers() -> void:
	_offers = _offer_service.roll_weighted_offers(item_pool, max(GameState.round_index, 1), offer_count, true)
	_rebuild_offer_buttons()

func _rebuild_offer_buttons() -> void:
	if offers_container == null:
		return
	for child in offers_container.get_children():
		child.queue_free()

	for i in range(_offers.size()):
		var offer: ItemData = _offers[i]
		var button := Button.new()
		button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		button.text = _format_offer_text(offer)
		button.pressed.connect(_on_offer_button_pressed.bind(i))
		offers_container.add_child(button)

func _on_offer_button_pressed(index: int) -> void:
	_try_buy_offer(index)

func _format_offer_text(offer: ItemData) -> String:
	return "%s [%s] | Cost %d | +%d base +%d mult" % [
		offer.get_display_name(),
		ItemData.ItemRarity.keys()[offer.rarity].capitalize(),
		offer.cost,
		offer.base,
		offer.mult,
	]

func _try_buy_offer(index: int) -> void:
	if index < 0 or index >= _offers.size():
		return

	var offer: ItemData = _offers[index]
	if not _purchase_service.apply_purchase(GameState, offer):
		return

	_offers.remove_at(index)
	_rebuild_offer_buttons()
	_refresh_view()

func _on_reroll_pressed() -> void:
	if not GameState.spend_currency(REROLL_COST):
		return
	_roll_offers()
	_refresh_view()

func _on_continue_pressed() -> void:
	GameState.start_next_round()
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func _on_currency_changed(_amount: int) -> void:
	_refresh_view()

func _refresh_view() -> void:
	if currency_label:
		currency_label.text = "Currency: %d" % GameState.currency
	if reroll_button:
		reroll_button.text = "Reroll offers (%d)" % REROLL_COST
	var item_counts: Dictionary = GameState.get_shop_item_counts()
	var lines: Array[String] = ["Owned items:"]
	for key in item_counts.keys():
		lines.append("- %s x%d" % [str(key), int(item_counts[key])])
	if item_counts.is_empty():
		lines.append("- none")
	if inventory_label:
		inventory_label.text = "\n".join(lines)
