# Feature: Integrate Dose Calculator with Medication Catalog

**Created:** 2026-10-08
**Status:** done
**Completed:** 2026-10-08
**Branch:** master

## Objective

Allow veterinarians to pick a medication from the Supabase catalog in the dose calculator and automatically calculate a dose range from catalog dose fields.

## Tasks

- [x] #1: Extend calculator hook to support dose ranges
- [x] #2: Load and select catalog medications in calculator page
- [x] #3: Render selected medication context and dose range result
- [x] #4: Verify build, Supabase API, and calculation behavior

## Acceptance Criteria

- Calculator page loads medications from Supabase.
- Selecting a medication auto-fills dose/frequency inputs from `dosis_minima_mg_kg`, `dosis_maxima_mg_kg`, and `frecuencia_horas`.
- User can calculate minimum and maximum dose range for a weight.
- Manual calculation still works when no medication is selected.
- Production build succeeds.

## Non-Goals

- Authentication.
- Persisting calculation history.
- Medical validation beyond existing catalog data.
- Production deploy.

## Evidence

- `useDosisCalculator` now exposes `calcularRangoPorPeso` for min/max mg/kg catalog ranges.
- `CalculadoraPage` loads medications from Supabase, lets the user select one, fills dose range/frequency, and keeps manual methods available.
- `pages.css` includes selected-medication and dose-range styles.
- `npm run build` succeeds.
- Supabase REST query returns medication dose fields, e.g. Ketamina 10% min/max/frequency.
