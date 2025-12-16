# Repository Guidelines

## Project Structure & Module Organization
- `install.sh` is the bootstrap entry point for new macOS machines; it fetches the repo, installs Homebrew, and runs `bin/dotfiles`.
- `bin/` holds the primary CLIs (e.g., `bin/dotfiles` for syncing/linking dotfiles, `bin/macosdefaults` for macOS tweaks, app launchers).
- `lib/` contains shared shell helpers (brew/composer/node/pip/utils/zsh) sourced by the CLIs; keep shared logic here.
- `functions/` and `oh-my-zsh-custom/` define zsh functions, aliases, paths, and exports loaded by `.zshrc`.
- `dotfiles/` stores the tracked configuration files that get symlinked or mirrored into `$HOME` (`zshrc`, `gitconfig`, `curlrc`, etc.).

## Build, Test, and Development Commands
- `./install.sh [--configure-macos] [--install-casks]` — full bootstrap; only run on macOS with Xcode CLT installed.
- `zsh bin/dotfiles --help` — show available flags for syncing (packages, macOS defaults, casks).
- `zsh bin/dotfiles --no-sync --no-packages` — re-link dotfiles without pulling or touching packages; safe for iterative edits.
- `zsh bin/macosdefaults` — apply macOS defaults independently if you skipped them during install.
- `git pull --rebase origin main` — preferred update path before hacking; keeps local scripts aligned with upstream helpers.

## Coding Style & Naming Conventions
- Shell scripts use a mix of POSIX `sh`, `bash`, and `zsh`; keep the existing shebang and avoid introducing new language dependencies.
- Prefer 2-space indentation, lower_snake_case function names, and explicit `local` declarations inside functions.
- Source shared helpers from `lib/` instead of reimplementing logging, prompts, or platform checks.
- Keep user-facing output terse and colored via `lib/utils` helpers (`e_header`, `e_warning`, `e_success`).
- Place personal overrides in `~/.zshrc.before` or `~/.zshrc.after` instead of modifying tracked files.

## Testing Guidelines
- Smoke-test provisioning steps you touch: run `zsh bin/dotfiles --no-sync --no-packages` to confirm linking and flag handling.
- For scripts invoked by `install.sh`, verify they run under `/bin/sh` where applicable and avoid zsh-only syntax unless the shebang is zsh.
- Optional: run `shellcheck` on `sh`/`bash` scripts when making non-trivial edits to catch portability issues.
- If you add new helpers in `lib/`, ensure they are idempotent and safe to re-run; prefer mockable checks (e.g., `formula_exists`) over direct installs in tests.

## Commit & Pull Request Guidelines
- Use short, imperative commit subjects (e.g., “Add brew check for gh”) with concise bodies explaining context or risk.
- Keep changes scoped: one concern per commit/PR; avoid mixing macOS defaults, package lists, and dotfile tweaks in a single change.
- Reference related issues if present and describe any manual steps required after merging (e.g., rerun `bin/dotfiles` or `bin/macosdefaults`).
- Include examples or command snippets in the PR description when behavior changes (new flags, renamed functions, or added dependencies).

## Security & Configuration Tips
- Do not commit secrets or machine-specific credentials; prefer `~/.zshrc.before`/`after` for private data and `git config --global` for author info.
- When adjusting Homebrew, cask lists, or defaults, confirm they are safe for a broad macOS audience and guard machine-specific logic with checks (e.g., `is_apple_silicon`).
- Be explicit about networked actions; note when a script downloads tarballs or taps new formulae so reviewers can assess risk.
