package main

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"regexp"
)

func isDangerousRmCommand(command string) bool {
	// Regex patterns to match only recursive rm commands
	// Matches: rm -rf, rm --recursive, rm -r, etc.
	patterns := []string{
		`^\s*rm\s+.*-r.*`,
		`^\s*rm\s+.*--recursive\b.*`,
	}

	for _, pattern := range patterns {
		matched, err := regexp.MatchString(pattern, command)
		if err != nil {
			continue
		}
		if matched {
			return true
		}
	}
	return false
}

func isDangerousSudoCommand(command string) bool {
	// Regex pattern to match sudo commands
	// Matches: sudo, sudo -u user, sudo -i, etc.
	pattern := `^\s*sudo\s+([-\w]*\s+)*.*`

	matched, err := regexp.MatchString(pattern, command)
	if err != nil {
		return false
	}
	return matched
}

func isDangerousADOCommand(command string) bool {
	// Regex pattern to match dangerous ADO commands:
	// - ado releases definitions update
	// - ado releases definitions delete
	// - ado releases deploy
	patterns := []string{
		`^\s*ado\s+releases\s+definitions\s+update\s+\S+.*`,
		`^\s*ado\s+releases\s+definitions\s+delete\s+\S+.*`,
		`^\s*ado\s+releases\s+deploy\s+\S+.*`,
	}
	for _, pattern := range patterns {
		matched, err := regexp.MatchString(pattern, command)
		if err != nil {
			continue
		}
		if matched {
			return true
		}
	}
	return false
}

func isDangerousGitCommand(command string) bool {
	// Regex patterns to match dangerous git commands
	patterns := []string{
		// git push --force (and variations)
		`^\s*git\s+push\s+.*--force\b.*`,
		`^\s*git\s+push\s+.*-f\b.*`,
		// git branch --delete (and variations)
		`^\s*git\s+branch\s+.*--delete\b.*`,
		`^\s*git\s+branch\s+.*-d\b.*`,
		`^\s*git\s+branch\s+.*-D\b.*`,
		// git reset --hard
		`^\s*git\s+reset\s+.*--hard\b.*`,
		// git clean with force
		`^\s*git\s+clean\s+.*-f.*`,
		`^\s*git\s+clean\s+.*--force\b.*`,
		// git checkout --force
		`^\s*git\s+checkout\s+.*--force\b.*`,
		`^\s*git\s+checkout\s+.*-f\b.*`,
		// git rebase --interactive (potentially destructive)
		`^\s*git\s+rebase\s+.*--interactive\b.*`,
		`^\s*git\s+rebase\s+.*-i\b.*`,
		// git filter-branch (rewrites history)
		`^\s*git\s+filter-branch\b.*`,
		// git reflog expire
		`^\s*git\s+reflog\s+expire\b.*`,
		// git gc with aggressive pruning
		`^\s*git\s+gc\s+.*--prune=now\b.*`,
		`^\s*git\s+gc\s+.*--aggressive\b.*`,
	}

	for _, pattern := range patterns {
		matched, err := regexp.MatchString(pattern, command)
		if err != nil {
			continue
		}
		if matched {
			return true
		}
	}
	return false
}

func main() {
	input, err := io.ReadAll(os.Stdin)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading stdin: %v\n", err)
		os.Exit(1)
	}

	var hookData HookData
	if err := json.Unmarshal(input, &hookData); err != nil {
		fmt.Fprintf(os.Stderr, "Error parsing JSON: %v\n", err)
		os.Exit(1)
	}

	if isDangerousRmCommand(hookData.ToolInput.Command) {
		fmt.Fprintf(os.Stderr, "Illegal use of 'rm' command: %s", hookData.ToolInput.Command)
		os.Exit(2)
	}

	if isDangerousSudoCommand(hookData.ToolInput.Command) {
		fmt.Fprintf(os.Stderr, "Illegal use of 'sudo' command: %s", hookData.ToolInput.Command)
		os.Exit(2)
	}

	if isDangerousADOCommand(hookData.ToolInput.Command) {
		fmt.Fprintf(os.Stderr, "Illegal use of 'ado' command: %s", hookData.ToolInput.Command)
		os.Exit(2)
	}

	if isDangerousGitCommand(hookData.ToolInput.Command) {
		fmt.Fprintf(os.Stderr, "Illegal use of 'git' command: %s", hookData.ToolInput.Command)
		os.Exit(2)
	}

	os.Exit(0)
}

type HookData struct {
	SessionID      string `json:"session_id"`
	TranscriptPath string `json:"transcript_path"`
	HookEventName  string `json:"hook_event_name"`
	ToolName       string `json:"tool_name"`
	ToolInput      struct {
		Command     string `json:"command"`
		Description string `json:"description"`
	} `json:"tool_input"`
}
