# Network Default Route Ping Tool (ttfn2)

### Test That Fucking Network 2

A lightweight bash script that helps monitor connectivity to your default gateway. It automatically detects your default route with the lowest metric and performs a ping test with colored output for quick status assessment.

## Features

- Automatically detects all default routes
- Selects the route with the lowest metric
- Performs ping test to default gateway
- Color-coded output (green for success, red for failure)
- Easy installation to common shell configuration files
- Supports multiple shell environments (bash, zsh, ksh)

## Requirements

- Linux/Unix-based operating system
- `ping` utility
- `ip` command
- Basic shell utilities (`awk`, `grep`, `sed`)

## Installation

1. Clone or download the script
2. Make it executable:

```bash
chmod +x ttfn2.sh
```

3. Run the script and select option 1 to install:

```bash
./ttfn2.sh
```

## Usage

After installation, simply use the `ttfn2` command in your terminal:

```bash
ttfn2
```

The output will show:

- The complete ping result
- Color-coded success/failure indication (green for OK, red for KO)

## Example Output

```
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.954 ms
--- 192.168.1.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.954/0.954/0.954/0.000 ms
OK
```

## Management

The script provides three options:

1. Add the `ttfn2` alias to shell configuration files
2. Remove the `ttfn2` alias from shell configuration files
3. Test default route selection

## Security Note

When sharing output from this tool, consider anonymizing sensitive information such as:

- Internal IP addresses
- Network interface names
- Network architecture details

## Testing

The script includes a test mode that uses a simulation file. To test route selection:

1. Create a file named `routing_table_test.txt` with sample routing entries
2. Run the script and select option 3

## Uninstallation

Run the script and select option 2 to remove the alias from all shell configuration files.

## Technical Details

The tool performs the following operations:

1. Queries the routing table with `ip r`
2. Filters for default routes
3. Extracts IP and metric information
4. Sorts by metric to find the preferred route
5. Performs a ping test
6. Displays colored results

## Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

## License

This tool is released under the MIT License. Feel free to use, modify, and distribute as needed.
