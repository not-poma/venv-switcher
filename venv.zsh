VENV_DIRS=(.venv venv)
PYTHON=python3

# Recursively search for a venv dir in the current directory and its parents
__check_path() {
    local check_dir="$1"

    # Abort the search if we reach the parent directory of the current venv
    if [[ -n "$VIRTUAL_ENV" && "$check_dir" = "$(dirname "$VIRTUAL_ENV")" ]]; then
        return
    fi

    # Check if the current directory contains a venv
    for venv_dir in $VENV_DIRS; do
        if [[ -d "$check_dir/$venv_dir" ]]; then
            echo "$check_dir/$venv_dir"
            return
        fi
    done

    # Abort the search at file system root
    if [[ "$check_dir" = "/" ]]; then
        return
    fi

    __check_path "$(dirname "$check_dir")"
}

# Check if we are in a venv and activate/deactivate it if necessary
__check_venv() {
    # deactivate the current venv if we are outside of its parent directory
    if [[ -n "$VIRTUAL_ENV" ]]; then
        if [[ ! "$(pwd)" = "$(dirname "$VIRTUAL_ENV")"* ]]; then
            deactivate
        fi
    fi

    # activate a venv if we are somewhere inside of its parent directory
    local venv_path=$(__check_path "$(pwd)")
    if [[ -n "$venv_path" ]]; then
        source "$venv_path/bin/activate"
    fi
}

# Creates a new .venv in the current directory and installs requirements.txt
mkvenv() {
    for venv_dir in $VENV_DIRS; do
        if [[ -d "$check_dir/$venv_dir" ]]; then
            echo "Virtual environment already exists"
            return
        fi
    done
    
    $PYTHON -m venv .venv
    source .venv/bin/activate
    if [[ -f "requirements.txt" ]]; then
        echo "Virtual environment created, Installing requirements"
        pip install -r requirements.txt
    else
        echo "Virtual environment created"
    fi
}

add-zsh-hook chpwd __check_venv