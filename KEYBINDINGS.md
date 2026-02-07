# TMUX Essential Commands

Window Management
Create new window: prefix + c
Switch between windows: prefix + [window number]
Cycle through windows: prefix + n (next) or prefix + p (previous)
Close window: prefix + &

## Pane Management

Split horizontally: prefix + %
Split vertically: prefix + "
Navigate panes: prefix + [arrow keys]
Swap panes: prefix + { or prefix + }
Show pane numbers: prefix + q
Zoom into pane: prefix + z
Turn pane into window: prefix + !
Close pane: prefix + x

## Session Management

Create new session: tmux new -s [session-name]
List sessions: tmux ls (outside tmux) or prefix + s (inside tmux)
Attach to session: tmux attach -t [session-name]
Preview windows: prefix + w
