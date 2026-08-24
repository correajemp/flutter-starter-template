#!/bin/bash
# Pre-tool execution validation hook for Gemini.
echo "Running pre-tool validation..." >&2
# Insert validation logic here (e.g., check for raw secrets, syntax errors)

# Gemini hooks require returning a JSON decision on stdout
echo '{"decision": "allow"}'
exit 0
