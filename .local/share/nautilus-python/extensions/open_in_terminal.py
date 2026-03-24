# Open in Terminal - Nautilus extension
# Opens the default terminal (via xdg-terminal-exec) in the current directory.
#
# Adapted from wezterm/ghostty nautilus extensions.
# Licensed under GPL-2.0-or-later.

from gi.repository import Nautilus, GObject, Gio


def _open_terminal(path):
    Gio.Subprocess.new(
        ['xdg-terminal-exec', f'--dir={path}'],
        Gio.SubprocessFlags.NONE,
    )


def _paths_to_open(files):
    paths = []
    for file in files:
        location = file.get_location() if file.is_directory() else file.get_parent_location()
        path = location.get_path()
        if path and path not in paths:
            paths.append(path)
    if len(paths) > 10:
        return []
    return paths


def _make_item(name, paths):
    item = Nautilus.MenuItem(name=name, label='Open in Terminal',
                            icon='utilities-terminal')
    item.connect('activate', lambda _menu, p: [_open_terminal(d) for d in p], paths)
    return item


class OpenInTerminalProvider(GObject.GObject, Nautilus.MenuProvider):
    def get_file_items(self, *args):
        files = args[0] if len(args) == 1 else args[1]
        paths = _paths_to_open(files)
        if paths:
            return [_make_item('OpenInTerminal::open', paths)]
        return []

    def get_background_items(self, *args):
        file = args[0] if len(args) == 1 else args[1]
        paths = _paths_to_open([file])
        if paths:
            return [_make_item('OpenInTerminal::open_background', paths)]
        return []
