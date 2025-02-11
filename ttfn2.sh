#!/bin/bash

# List of common shell configuration files
RC_FILES=("$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.kshrc" "$HOME/.shrc")

# The 'ttfn2' alias sends a ping to the default router's IP address and displays the result in color (green or red) based on success.
# Detailed explanation of the 'ttfn2' alias:
#
# - 'ping -c 1': Sends a single ping to the specified IP address
# - 'ip r': Displays the complete routing table
# - 'grep default': Filters lines containing "default" (there may be multiple default routes)
# - 'awk '{print $3, $5}'': Extracts the IP address ($3) and metric ($5) from each default route
# - 'sort -n -k2': Numerically sorts (-n) routes by metric (2nd column) in ascending order
# - 'head -n1': Selects the first line (route with lowest metric)
# - 'awk '{print $1}'': Extracts only the IP address of the best route
# - 'PING_RESULT=$()': Captures the complete ping output in a variable
# - '\033[0;32m' and '\033[0;31m': ANSI codes for coloring output green or red
# - '\033[0m': ANSI code to reset color
# - 'grep -q "1 received"': Silently checks (-q) if ping was successful
# - Backslash and multiple single quotes ('\'') are necessary for correct escaping in the alias
TTFN_ALIAS_LINE='alias ttfn2="PING_RESULT=\$(ping -c 1 \$(ip r | grep default | awk '\''{print \$3, \$5}'\'' | sort -n -k2 | head -n1 | awk '\''{print \$1}'\'')) && if echo \"\$PING_RESULT\" | grep -q \"1 received\"; then echo -e \"\033[0;32m\${PING_RESULT}\nOK\033[0m\"; else echo -e \"\033[0;31m\${PING_RESULT}\nKO\033[0m\"; fi"'

add_alias_to_rc() {
    local rc_file=$1
    if [ -f "$rc_file" ]; then
        if grep -q "alias ttfn2" "$rc_file"; then
            echo "The 'ttfn2' alias already exists in $rc_file."
        else
            echo "$TTFN_ALIAS_LINE" >> "$rc_file"
            echo "The 'ttfn2' alias has been added to $rc_file."
        fi
    fi
}

remove_alias_from_rc() {
    local rc_file=$1
    if [ -f "$rc_file" ]; then
        if grep -q "alias ttfn2" "$rc_file"; then
            # Removes the line containing the 'ttfn2' alias from the shell configuration file
            sed -i "/alias ttfn2/d" "$rc_file"
            echo "The 'ttfn2' alias has been removed from $rc_file."
        else
            echo "The 'ttfn2' alias does not exist in $rc_file."
        fi
    fi
}

test_default_route() {
    # Path to the routing table simulation file
    ROUTING_FILE="routing_table_test.txt"

    if [ -f "$ROUTING_FILE" ]; then
        # Extract the IP address of the default route with the lowest metric
        SELECTED_ROUTE=$(cat "$ROUTING_FILE" | grep default | awk '{print $3, $NF}' | sort -n -k2 | head -n1 | awk '{print $1}')
        echo "Selected default route with lowest metric: $SELECTED_ROUTE"
    else
        echo "The simulation file $ROUTING_FILE does not exist. Please create it with routing entries."
    fi
}

echo "Choose an option:"
echo "1. Add the 'ttfn2' alias to shell configuration files."
echo "2. Remove the 'ttfn2' alias from shell configuration files."
echo "3. Test default route selection."
read -p "Enter your choice (1, 2, or 3): " choice

case $choice in
    1)
        for rc_file in "${RC_FILES[@]}"; do
            add_alias_to_rc "$rc_file"
        done
        echo "You can now use 'ttfn2' to test connectivity with your default router in all configured shells."
        ;;
    2)
        for rc_file in "${RC_FILES[@]}"; do
            remove_alias_from_rc "$rc_file"
        done
        ;;
    3)
        test_default_route
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        ;;
esac