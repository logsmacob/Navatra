extends Node

# NOTE: Global signal hub for decoupled feature communication.

# Emitted when any system requests a full dice roll.
@warning_ignore("unused_signal")
signal roll_all_dice_requested

# Emitted after hand evaluation is complete.
@warning_ignore("unused_signal")
signal dice_evaluated(result: HandResult)

# Emitted when a run is initialized.
@warning_ignore("unused_signal")
signal run_started(round_state: RoundStateModel)

# Emitted when a new round starts.
@warning_ignore("unused_signal")
signal round_started(round_state: RoundStateModel)

# Emitted whenever hands/rerolls/quota values change.
@warning_ignore("unused_signal")
signal round_state_changed(round_state: RoundStateModel)

# Emitted after a scored hand is submitted.
@warning_ignore("unused_signal")
signal hand_scored(score: int, quota_remaining: int)

# Emitted when player clears the current quota.
@warning_ignore("unused_signal")
signal round_cleared(round_state: RoundStateModel)

# Emitted when no playable hands remain and quota is still positive.
@warning_ignore("unused_signal")
signal run_failed(round_state: RoundStateModel)

# Emitted when a trinket is added to the run.
@warning_ignore("unused_signal")
signal trinket_added(trinket: TrinketModel)
