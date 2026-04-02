---
name: tmux
description: Tmux session management for running long-running jobs like servers, tests, and background commands
license: MIT
compatibility: opencode
metadata:
  scope: devops
  category: terminal
---

## What I do

Manage tmux sessions to run long-running jobs (servers, tests, watchers) in the background while maintaining visibility and control. Send commands to running sessions remotely.

## When to use me

- Running Phoenix dev servers (`mix phx.server`, `mix dev`)
- Running test watchers (`mix test --watch`)
- Long-running build processes
- Background tasks that need to persist across terminal sessions
- Sending commands to running tmux sessions

## Rules

### Session Management

1. **Always name sessions** for easy identification:

   ```bash
   tmux new-session -d -s "myapp-server" "cd /path/to/app && mix phx.server"
   ```

2. **Use descriptive session names** that reflect the task:
   - `{app}-server` - for dev servers
   - `{app}-test` - for test watchers
   - `{app}-assets` - for asset builders

3. **Detach cleanly** with `Ctrl+b d` or `tmux detach`

### Common Operations

#### Start a new session

```bash
tmux new-session -d -s "session-name" "command"
```

#### List active sessions

```bash
tmux list-sessions
```

#### Attach to a session

```bash
tmux attach-session -t "session-name"
# or shorthand
tmux a -t "session-name"
```

#### Send commands to a running session

```bash
tmux send-keys -t "session-name" "command" Enter
```

#### View session output (pipe to file for inspection)

```bash
tmux capture-pane -t "session-name" -p > /tmp/session-output.txt
```

#### Kill a session

```bash
tmux kill-session -t "session-name"
```

### Sending Commands to Running Sessions

1. **Single command**:

   ```bash
   tmux send-keys -t "myapp-server" "mix test" Enter
   ```

2. **Multiple commands** (chained):

   ```bash
   tmux send-keys -t "myapp-server" "mix ecto.reset" Enter
   tmux send-keys -t "myapp-server" "mix phx.server" Enter
   ```

3. **Special keys**:
   - `Enter` - send Return key
   - `C-c` - send Ctrl+c (interrupt)
   - `C-d` - send Ctrl+d

### Interrupt/Restart Workflow

1. **Interrupt current command**:

   ```bash
   tmux send-keys -t "myapp-server" C-c
   ```

2. **Clear the command line**:

   ```bash
   tmux send-keys -t "myapp-server" C-c
   tmux send-keys -t "myapp-server" C-u
   ```

3. **Restart server**:

   ```bash
   tmux send-keys -t "myapp-server" "mix phx.server" Enter
   ```

## Phoenix-Specific Patterns

### Dev Server

```bash
# Start Phoenix dev server in background
tmux new-session -d -s "social-server" "cd /home/marco/w/tremtec/social && mix phx.server"

# View output
tmux capture-pane -t "social-server" -p | tail -50

# Send Ctrl+c to stop
tmux send-keys -t "social-server" C-c
```

### Test Watcher

```bash
# Start tests in watch mode
tmux new-session -d -s "social-test" "cd /home/marco/w/tremtec/social && mix test --watch"

# Run specific file tests
tmux send-keys -t "social-test" "mix test test/my_file_test.exs" Enter
```

### Interactive Mix Commands

```bash
# Open iex with Phoenix
tmux new-session -d -s "social-iex" "cd /home/marco/w/tremtec/social && iex -S mix"

# Send code to run
tmux send-keys -t "social-iex" "Social.MyModule.my_function()" Enter
```

## Session Cleanup

### Kill all sessions for an app

```bash
tmux kill-session -t "social-server"
tmux kill-session -t "social-test"
tmux kill-session -t "social-iex"
```

### Kill orphaned sessions (no windows)

```bash
tmux list-sessions | grep -v attached | awk -F: '{print $1}' | xargs -r tmux kill-session
```

## Best Practices

1. **One session per task** - keeps concerns separated
2. **Name everything** - makes targeting easier
3. **Capture output** when debugging issues
4. **Clean up** sessions when done to free resources
5. **Use `-d`** to detach immediately and run in background
6. **Use absolute paths** in commands for reliability

## Useful One-Liners

```bash
# Check if a session exists
tmux has-session -t "myapp-server" 2>/dev/null && echo "running" || echo "not running"

# Restart a session (kill if exists, create new)
tmux kill-session -t "myapp-server" 2>/dev/null; tmux new-session -d -s "myapp-server" "cd /path && mix phx.server"

# Pipe command output to file
tmux capture-pane -t "myapp-server" -p > /tmp/server.log

# Monitor session for new output
watch -n 1 "tmux capture-pane -t 'myapp-server' -p | tail -20"
```

## Key Commands Reference

| Command | Description |
|---------|-------------|
| `tmux new-session -d -s "name" "cmd"` | Create detached session |
| `tmux list-sessions` | List all sessions |
| `tmux attach-session -t "name"` | Attach to session |
| `tmux send-keys -t "name" "cmd" Enter` | Send command |
| `tmux capture-pane -t "name" -p` | View output |
| `tmux kill-session -t "name"` | Kill session |
| `tmux has-session -t "name"` | Check if session exists |
