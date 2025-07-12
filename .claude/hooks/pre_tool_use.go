package main

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"regexp"
)

func isDangerousRmCommand(command string) bool {
	// Regex pattern to match rm commands with various flags and arguments
	// Matches: rm, rm -rf, rm -f, rm --recursive, etc.
	pattern := `^\s*rm\s+([-\w]*\s+)*.+`

	matched, err := regexp.MatchString(pattern, command)
	if err != nil {
		return false
	}
	return matched
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
