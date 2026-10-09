# Feature: Autenticación y persistencia de historial

**Created:** 2026-10-08
**Status:** in_progress
**Branch:** master

## Objective

Add Supabase authentication first so LunaVet can persist calculation history with the existing `historial_calculos` row-level security model.

## Tasks

- [x] #1: Add Supabase auth service and session hook
- [x] #2: Add login/register page and navigation session controls
- [x] #3: Persist calculator results to `historial_calculos` for authenticated users
- [ ] #4: Add history page for the authenticated user
- [ ] #5: Verify build and Supabase auth/history behavior

## Acceptance Criteria

- Users can register/sign in/out through Supabase Auth.
- App exposes the current authenticated session to pages and layout.
- Calculator saves single-dose and catalog range calculations only for signed-in users.
- History page lists the signed-in user's calculation rows.
- Existing public medication catalog behavior remains unchanged.
- Production build succeeds.

## Non-Goals

- Production deploy.
- Admin roles or medication editing UI.
- Password reset flow.
- Social login.
- Medical validation beyond existing catalog fields.

## Evidence

Pending.
