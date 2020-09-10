import pywal
import os

default = { 
    'special': {
        'background': '#0A0E17', 
        'foreground': '#c6c4c2', 
        'cursor': '#c6c4c2'
    }, 'colors': {
        'color0': '#0A0E17', 
        'color1': '#B93D57', 
        'color2': '#B49A73', 
        'color3': '#156D8B', 
        'color4': '#576F91', 
        'color5': '#E25C8F', 
        'color6': '#389BAE', 
        'color7': '#c6c4c2', 
        'color8': '#8a8987', 
        'color9': '#B93D57', 
        'color10': '#B49A73',
        'color11': '#156D8B', 
        'color12': '#576F91', 
        'color13': '#E25C8F', 
        'color14': '#389BAE', 
        'color15': '#c6c4c2'
    }
}

PYWAL_CACHE = os.path.expanduser('~/.cache/wal')
palette = pywal.colors.file(os.path.join(PYWAL_CACHE, 'colors.json'))
