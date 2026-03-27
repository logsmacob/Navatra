class_name HandUpgradeBalanceConfig
extends Resource

## Number of hand-type upgrade choices shown in the reward phase.
@export_range(1, 12, 1) var options_per_roll: int = 4

@export_group("Reroll Pricing")
## Starting marble cost to reroll hand-type upgrades.
@export_range(0, 99, 1) var reroll_base_cost: int = 1
## Extra marbles added after each reroll press during upgrade selection.
@export_range(0, 99, 1) var reroll_cost_increase_per_use: int = 1

@export_group("Rarity Roll Weights")
## Relative chance bucket for COMMON upgrade rarity.
@export_range(0.0, 1.0, 0.01) var common_chance: float = 0.6
## Relative chance bucket for RARE upgrade rarity.
@export_range(0.0, 1.0, 0.01) var rare_chance: float = 0.3
## Relative chance bucket for EPIC upgrade rarity.
@export_range(0.0, 1.0, 0.01) var epic_chance: float = 0.1

@export_group("Rarity Bonuses")
## Base bonus applied when a COMMON upgrade is rolled.
@export var common_base_bonus: int = 4
## Mult bonus applied when a COMMON upgrade is rolled.
@export var common_mult_bonus: int = 1
## Base bonus applied when a RARE upgrade is rolled.
@export var rare_base_bonus: int = 9
## Mult bonus applied when a RARE upgrade is rolled.
@export var rare_mult_bonus: int = 2
## Base bonus applied when an EPIC upgrade is rolled.
@export var epic_base_bonus: int = 16
## Mult bonus applied when an EPIC upgrade is rolled.
@export var epic_mult_bonus: int = 3

## Builds the rarity->(base,mult) bonus dictionary consumed by [HandTypeUpgradeService].
func get_rarity_bonuses() -> Dictionary:
	return {
		HandTypeUpgradeDefinition.UpgradeRarity.COMMON: {
			"base": common_base_bonus,
			"mult": common_mult_bonus,
		},
		HandTypeUpgradeDefinition.UpgradeRarity.RARE: {
			"base": rare_base_bonus,
			"mult": rare_mult_bonus,
		},
		HandTypeUpgradeDefinition.UpgradeRarity.EPIC: {
			"base": epic_base_bonus,
			"mult": epic_mult_bonus,
		},
	}

## Returns normalized rarity roll weights that always sum to 1.0.
func get_normalized_rarity_roll_weights() -> Dictionary:
	var common = max(common_chance, 0.0)
	var rare = max(rare_chance, 0.0)
	var epic = max(epic_chance, 0.0)
	var total = common + rare + epic
	if total <= 0.0:
		return {
			HandTypeUpgradeDefinition.UpgradeRarity.COMMON: 0.6,
			HandTypeUpgradeDefinition.UpgradeRarity.RARE: 0.3,
			HandTypeUpgradeDefinition.UpgradeRarity.EPIC: 0.1,
		}
	return {
		HandTypeUpgradeDefinition.UpgradeRarity.COMMON: common / total,
		HandTypeUpgradeDefinition.UpgradeRarity.RARE: rare / total,
		HandTypeUpgradeDefinition.UpgradeRarity.EPIC: epic / total,
	}
