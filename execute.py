import math
import tkinter as tk
from tkinter import messagebox
import clingo
import multiprocessing
import random

# ----------------------------------------------------------
# Run clingo using the Python API
# ----------------------------------------------------------
def run_clingo(size, doors, enemies, boss, min):
    available_threads = multiprocessing.cpu_count()
    if min:
        control = clingo.Control(["-t", str(available_threads), "-c", f"island_num={size-1}", "-c", f"number_of_doors={doors}"])
    else:
        seed = random.randint(1,1000)
        print(seed)
        control = clingo.Control(["-n", "1", "--rand-freq=1", f"--seed={seed}", "-t", str(available_threads), "-c", f"island_num={size-1}", "-c", f"number_of_doors={doors}"])
        
    # Load files
    control.load("islands_and_bridges_with_distance.lp")

    if doors > 0:
        control.load("keys_and_doors.lp")
    if enemies:
        control.load("enemies.lp")
    if boss:
        control.load("boss.lp")
    if min:
        control.load("minimize.lp")

    print(f"min: {min}")

    # Ground the program
    control.ground()

    model_atoms = []

    # capture only the shown atoms
    def on_model(model):
        shown_symbols = model.symbols(shown=True)
        print("New model (potentially better):")
        for sym in shown_symbols:
            print(str(sym))
        # Overwrite with the current (better) model
        model_atoms.clear()
        model_atoms.extend(shown_symbols)
        # model_atoms.extend(str(sym) for sym in shown_symbols)

    # solve 
    control.solve(on_model=on_model)

    return model_atoms


# ----------------------------------------------------------
# Parse model symbols into islands + bridges
# ----------------------------------------------------------
def parse_atoms(symbols):
    islands = {}      # id -> (x, y)
    bridges = []      # (id1, id2)
    enemies = {}      # island_id -> list of enemy types (strings)

    for sym in symbols:
        if sym.name == "island" and len(sym.arguments) == 3:
            i = sym.arguments[0].number
            x = sym.arguments[1].number
            y = sym.arguments[2].number
            islands[i] = (x, y)

        elif sym.name == "bridge" and len(sym.arguments) == 2:
            a = sym.arguments[0].number
            b = sym.arguments[1].number
            bridges.append((a, b))

        elif sym.name == "spawn" and len(sym.arguments) == 3:
            # spawn(Value, EnemyType, IslandID)
            enemy_type = str(sym.arguments[1])
            island_id = sym.arguments[2].number

            enemies.setdefault(island_id, []).append(enemy_type)

    return islands, bridges, enemies


# ----------------------------------------------------------
# Draw map in Tkinter
# ----------------------------------------------------------
def draw_map(islands, bridges, enemies):
    map_window = tk.Toplevel()
    map_window.title("Generated Island Map")

    canvas = tk.Canvas(map_window, width=600, height=600, bg="white")
    canvas.pack(fill="both", expand=True)

    CELL_SIZE = 120
    RADIUS = 20

    coords = {}

    # Draw islands
    for island_id, (x, y) in islands.items():
        px = x * CELL_SIZE + CELL_SIZE // 2
        py = y * CELL_SIZE + CELL_SIZE // 2

        coords[island_id] = (px, py)

        canvas.create_oval(
            px - RADIUS, py - RADIUS,
            px + RADIUS, py + RADIUS,
            fill="lightblue"
        )
        canvas.create_text(px, py, text=str(island_id))

    # Draw bridges
    for a, b in bridges:
        if a in coords and b in coords:
            x1, y1 = coords[a]
            x2, y2 = coords[b]
            canvas.create_line(x1, y1, x2, y2, width=4)

    # Draw enemies (small red dots around the island)
    ENEMY_OFFSET = 30
    SMALL_R = 6

    for island_id, enemy_list in enemies.items():
        cx, cy = coords[island_id]

        # distribute enemies around the island
        angle_step = 360 / max(1, len(enemy_list))
        angle = 0

        for enemy in enemy_list:
            rad = angle * 3.14159 / 180
            ex = cx + ENEMY_OFFSET * (math.cos(rad))
            ey = cy + ENEMY_OFFSET * (math.sin(rad))

            canvas.create_oval(
                ex - SMALL_R, ey - SMALL_R,
                ex + SMALL_R, ey + SMALL_R,
                fill="red"
            )
            canvas.create_text(ex, ey - 10, text=enemy, fill="black", font=("Arial", 8))

            angle += angle_step


# ----------------------------------------------------------
# GUI interaction
# ----------------------------------------------------------
def generate_map():
    try:
        size = int(size_var.get())
        doors = int(doors_var.get())
    except ValueError:
        messagebox.showerror("Error", "Size and doors must be integers.")
        return

    enemies = enemies_var.get()
    boss = boss_var.get()
    min = min_var.get()

    atoms = run_clingo(size, doors, enemies, boss, min)
    print(atoms)
    islands, bridges, enemies = parse_atoms(atoms)

    if not islands:
        messagebox.showerror("Error", "No islands generated by ASP program.")
        return

    draw_map(islands, bridges, enemies)


# ----------------------------------------------------------
# Main Tkinter UI
# ----------------------------------------------------------
root = tk.Tk()
root.title("ASP Procedural Island Generator")

tk.Label(root, text="Island grid size (e.g., 2 = 2x2)").grid(row=0, column=0, sticky="w")
size_var = tk.StringVar(value="2")
tk.Entry(root, textvariable=size_var).grid(row=0, column=1)

tk.Label(root, text="Number of doors").grid(row=1, column=0, sticky="w")
doors_var = tk.StringVar(value="1")
tk.Entry(root, textvariable=doors_var).grid(row=1, column=1)

enemies_var = tk.IntVar()
boss_var = tk.IntVar()
min_var = tk.IntVar()

tk.Checkbutton(root, text="Spawn enemies?", variable=enemies_var).grid(row=2, column=0, sticky="w")
tk.Checkbutton(root, text="Spawn boss?", variable=boss_var).grid(row=3, column=0, sticky="w")
tk.Checkbutton(root, text="Minimize bridges?", variable=min_var).grid(row=4, column=0, sticky="w")

tk.Button(root, text="Generate Map", command=generate_map).grid(row=5, column=0, columnspan=2, pady=10)

root.mainloop()
