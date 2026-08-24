# Custom Command: Review

Triggered by `/review` inside the Claude Code interface.
Repeatable workflow:
1. Runs linter on modified files.
2. Runs unit tests to ensure no regressions.
3. Performs a sanity check on changed files.
