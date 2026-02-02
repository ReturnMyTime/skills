# Tool Templates Reference

Guide for creating single-file tools using UV Python or Go.

---

## When to Use Each

| Use Case | Recommended | Reason |
|----------|-------------|--------|
| Quick prototyping | UV Python | Fast iteration, rich libraries |
| Data processing | UV Python | pandas, json, csv built-in |
| API interactions | UV Python | requests, httpx easy to use |
| Distributable CLI | Go | Single binary, no runtime needed |
| Performance-critical | Go | Compiled, fast execution |
| Cross-platform binary | Go | Easy cross-compilation |

---

## UV Python Scripts

### What is UV?

[UV](https://github.com/astral-sh/uv) is an extremely fast Python package installer and resolver. It supports single-file scripts with inline dependencies.

### Template

```python
#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "requests>=2.31",
#     "rich>=13.0",
# ]
# ///
"""
Skill Name Tool

Description of what this tool does.

Usage:
    ./tool-name.py --input file.txt --output result.json
    uv run tool-name.py --help
"""

import argparse
import json
import sys
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Tool description",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--input", "-i",
        type=Path,
        required=True,
        help="Input file path",
    )
    parser.add_argument(
        "--output", "-o",
        type=Path,
        help="Output file path (default: stdout)",
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose output",
    )
    
    args = parser.parse_args()
    
    # Implementation here
    try:
        result = process(args.input, verbose=args.verbose)
        
        if args.output:
            args.output.write_text(json.dumps(result, indent=2))
        else:
            print(json.dumps(result, indent=2))
        
        return 0
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1


def process(input_path: Path, verbose: bool = False) -> dict:
    """Process the input file and return results."""
    # Implementation
    return {"status": "success"}


if __name__ == "__main__":
    sys.exit(main())
```

### Key Features

1. **Shebang**: `#!/usr/bin/env -S uv run` - Runs with UV directly
2. **Inline dependencies**: Declared in `# /// script` block
3. **Type hints**: Modern Python with type annotations
4. **Argparse**: Standard library CLI parsing
5. **Exit codes**: Return 0 for success, non-zero for errors

### Running UV Scripts

```bash
# Make executable and run directly
chmod +x tool-name.py
./tool-name.py --help

# Or run with uv explicitly
uv run tool-name.py --help

# UV automatically installs dependencies on first run
```

---

## Go Binaries

### Template

```go
//go:build ignore

// Tool Name
//
// Description of what this tool does.
//
// Install:
//   go install github.com/ReturnMyTime/skills/skill-packs/category/skill-name/scripts/tool-name.go@latest
//
// Usage:
//   tool-name --input file.txt --output result.json

package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"
)

var (
	inputPath  = flag.String("input", "", "Input file path (required)")
	outputPath = flag.String("output", "", "Output file path (default: stdout)")
	verbose    = flag.Bool("verbose", false, "Enable verbose output")
)

func main() {
	flag.Usage = func() {
		fmt.Fprintf(os.Stderr, "Usage: %s [options]\n\n", os.Args[0])
		fmt.Fprintf(os.Stderr, "Options:\n")
		flag.PrintDefaults()
	}
	flag.Parse()

	if *inputPath == "" {
		fmt.Fprintln(os.Stderr, "Error: --input is required")
		flag.Usage()
		os.Exit(1)
	}

	result, err := process(*inputPath, *verbose)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}

	output, err := json.MarshalIndent(result, "", "  ")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error encoding output: %v\n", err)
		os.Exit(1)
	}

	if *outputPath != "" {
		if err := os.WriteFile(*outputPath, output, 0644); err != nil {
			fmt.Fprintf(os.Stderr, "Error writing output: %v\n", err)
			os.Exit(1)
		}
	} else {
		fmt.Println(string(output))
	}
}

func process(inputPath string, verbose bool) (map[string]interface{}, error) {
	// Implementation here
	return map[string]interface{}{
		"status": "success",
	}, nil
}
```

### Key Features

1. **Build tag**: `//go:build ignore` - Prevents accidental package inclusion
2. **Install comment**: Documents how to install globally
3. **Flag package**: Standard library CLI parsing
4. **Error handling**: Explicit error returns and stderr output
5. **Exit codes**: `os.Exit(0)` for success, `os.Exit(1)` for errors

### Building Go Binaries

```bash
# Run directly (for development)
go run tool-name.go --help

# Build for current platform
go build -o tool-name tool-name.go

# Install globally
go install ./tool-name.go

# Cross-compile for different platforms
GOOS=linux GOARCH=amd64 go build -o tool-name-linux tool-name.go
GOOS=darwin GOARCH=arm64 go build -o tool-name-mac tool-name.go
GOOS=windows GOARCH=amd64 go build -o tool-name.exe tool-name.go
```

---

## Best Practices

### Both Languages

1. **Single file**: Keep tools self-contained when possible
2. **Clear help**: Include usage examples in --help
3. **Exit codes**: 0 = success, 1 = error
4. **Stderr for errors**: Keep stdout clean for piping
5. **JSON output**: Easy to parse programmatically

### UV Python Specific

1. **Pin major versions**: `requests>=2.31` not `requests`
2. **Use pathlib**: `Path` over string manipulation
3. **Type hints**: Help with IDE support and documentation
4. **Rich for output**: Better terminal formatting

### Go Specific

1. **Standard library**: Prefer stdlib over external deps
2. **Context support**: Add context.Context for cancellation
3. **Struct for config**: Group related flags
4. **Table-driven tests**: Easy to test multiple cases

---

## Directory Structure

```
scripts/
├── tool-name.py         # UV Python tool
├── tool-name.go         # Go tool
├── helper.sh            # Shell helper (if needed)
└── README.md            # Tool documentation (optional)
```

---

## Testing Tools

### UV Python

```bash
# Run tests (if using pytest)
uv run pytest scripts/test_tool.py

# Type check (if using mypy)
uv run mypy scripts/tool-name.py
```

### Go

```bash
# Run from scripts directory
go test ./...

# Run with verbose output
go test -v ./...
```
