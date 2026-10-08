# Feature: Support Dose Range Calculation History Model

**Created:** 2026-10-08
**Status:** done
**Completed:** 2026-10-08
**Branch:** master

## Objective

Update the calculation history schema so LunaVet can store single-dose and catalog range calculations without losing medication context.

## Tasks

- [x] #1: Extend `historial_calculos` schema for dose range fields
- [x] #2: Add constraints/indexes that preserve valid history rows
- [x] #3: Update Supabase documentation with the new model
- [x] #4: Verify `supabase db reset`, repeatability, and build

## Acceptance Criteria

- `historial_calculos` can store legacy single dose calculations.
- `historial_calculos` can store min/max calculated doses for catalog range calculations.
- Schema remains resettable with local Supabase.
- Production build still succeeds.

## Non-Goals

- Persisting calculations from the UI.
- Authentication changes.
- History page UI.
- Production deploy.

## Evidence

- `historial_calculos` now supports `dosis_calculada` plus range fields `dosis_minima_calculada`, `dosis_maxima_calculada`, `dosis_minima_mg_kg`, and `dosis_maxima_mg_kg`.
- Check constraints require either a single calculated dose or a valid min/max range, and catalog source doses must be ordered when both are present.
- Added `idx_historial_metodo` for filtering by calculation method.
- `supabase db reset` succeeds and leaves `historial_calculos` empty after verification inserts are cleared by reset.
- `npm run build` succeeds.
