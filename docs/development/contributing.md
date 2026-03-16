# Contributing & Development Notes

This project is organized to keep UI code separate from gameplay logic.

## Principles

1. Keep gameplay logic in `core/services` and runtime manager classes.
2. Keep scene scripts focused on presentation, input, and wiring signals.
3. Prefer data transfer through models/resources (`DiceHand`, `HandDetailsData`, etc.).
4. Use `EventBus` signals for cross-feature communication.

## Where to place changes

- **Scoring & hand rules:** `core/services/`
- **Round progression / run-level state:** `autoload/managers/`
- **Die and hand interaction UI:** `features/dice/`
- **Main game flow orchestration:** `scenes/main/controllers/`

## Working with `GameState`

`GameState` is the central runtime coordinator:

- Starts/reset runs.
- Starts rounds and emits round state updates.
- Applies played hand results.
- Tracks player currency and hand-type upgrades.

When adding a mechanic that affects round state, add behavior in managers first and keep `GameState` as orchestration.

## Signals and event flow

- Prefer explicit scene signals for local communication.
- Use `EventBus` for global or cross-screen events.
- Keep signal payloads model/data oriented where possible.

## Suggested workflow for new features

1. Define data shape (model/resource) if needed.
2. Add deterministic logic to a core service.
3. Integrate with manager(s) for runtime state.
4. Wire to scene/feature scripts.
5. Update docs when behavior or architecture changes.
