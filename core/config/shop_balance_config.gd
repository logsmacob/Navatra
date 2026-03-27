class_name ShopBalanceConfig
extends Resource

## Number of trinkets shown in each shop roll.
@export_range(0, 20, 1) var trinket_option_count: int = 4

@export_group("Reroll Pricing")
## Base marble cost for a shop reroll before round scaling.
@export_range(0, 99, 1) var reroll_base_cost: int = 1
## Extra % price per round (0.1 = +10% per round after round 1).
@export_range(0.0, 5.0, 0.01) var round_cost_multiplier_step: float = 0.1
## Flat marble increase after each shop reroll within the same shop visit.
@export_range(0, 20, 1) var reroll_escalation_step: int = 0
## Global cost multiplier applied after round scaling (0.75 = 25% discount).
@export_range(0.0, 5.0, 0.01) var cost_discount_factor: float = 0.75

@export_group("Rarity Weights")
## Relative roll weight used when selecting COMMON rarity offers.
@export_range(0.0, 999.0, 0.1) var common_weight: float = 70.0
## Relative roll weight used when selecting UNCOMMON rarity offers.
@export_range(0.0, 999.0, 0.1) var uncommon_weight: float = 22.0
## Relative roll weight used when selecting RARE rarity offers.
@export_range(0.0, 999.0, 0.1) var rare_weight: float = 7.0
## Relative roll weight used when selecting EPIC rarity offers.
@export_range(0.0, 999.0, 0.1) var epic_weight: float = 1.0

## Builds the rarity->weight dictionary consumed by [ShopOfferService].
func get_rarity_weights() -> Dictionary:
	return {
		TrinketData.TrinketRarity.COMMON: common_weight,
		TrinketData.TrinketRarity.UNCOMMON: uncommon_weight,
		TrinketData.TrinketRarity.RARE: rare_weight,
		TrinketData.TrinketRarity.EPIC: epic_weight,
	}
