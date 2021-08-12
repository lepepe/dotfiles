from config import keys, mod
from rich.console import Console
from rich.table import Table

table = Table(title="Qtile Keybindings")

table.add_column("Keys", style="magenta")
table.add_column("Description", justify="left", style="green")

if mod == 'mod1':
    print("Mod is Alt key")
elif mod == 'mod4':
    print("Mod is Super/Windows key")

for k in keys:
    table.add_row(f"{k.modifiers} + {k.key}", k.desc)

console = Console()
console.print(table)

input('Press Enter to Exit...')
