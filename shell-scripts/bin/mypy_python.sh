#!/bin/bash
# Gets the python interpreter mypy should be using in pylsp

if [[ -n "${VIRTUAL_ENV:-}" ]]; then 
    "${VIRTUAL_ENV}/bin/python" "$@"
elif command -v python3 &>/dev/null; then
    python3 "$@"
else
    python "$@"
fi
