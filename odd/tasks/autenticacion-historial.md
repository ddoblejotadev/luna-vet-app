# Feature: Autenticación y persistencia de historial

**Created:** 2026-10-08
**Status:** done
**Completed:** 2026-10-08
**Branch:** feature/auth-history

## Objective

Add Supabase authentication first so LunaVet can persist calculation history with the existing `historial_calculos` row-level security model.

## Tasks

- [x] #1: Add Supabase auth service and session hook
- [x] #2: Add login/register page and navigation session controls
- [x] #3: Persist calculator results to `historial_calculos` for authenticated users
- [x] #4: Add history page for the authenticated user
- [x] #5: Verify build and Supabase auth/history behavior

## Acceptance Criteria

- [x] Users can register/sign in/out through Supabase Auth.
- [x] App exposes the current authenticated session to pages and layout.
- [x] Calculator saves single-dose and catalog range calculations only for signed-in users.
- [x] History page lists the signed-in user's calculation rows.
- [x] Existing public medication catalog behavior remains unchanged.
- [x] Production build succeeds.

## Non-Goals

- Production deploy.
- Admin roles or medication editing UI.
- Password reset flow.
- Social login.
- Medical validation beyond existing catalog fields.

## Evidence

- `.codegraph` and `.gitignore` updated.
- `src/services/authService.js` and `src/context/AuthContext.jsx` provide `useAuth()` hook.
- `src/App.jsx` and `Layout.jsx` updated with session state and protected routes logic (visual guidance).
- `src/pages/AuthPage.jsx` implements email/password sign-up and sign-in.
- `CalculadoraPage.jsx` modified to post calculations via `historialService.js`.
- `HistorialPage.jsx` renders saved rows fetched via RLS-compliant queries.
- Build verifies (`npm run build`) with zero errors.
- Commited on `feature/auth-history` branch.
