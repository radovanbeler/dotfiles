import sys
import os



print("je to super")

class Sinep:
    def __init__(self) -> None:
        print(self)

    # def _draw_some_line(self, start, end):
    #     pass
    #     # tk.draw_line(x=start, y=end, solid 1px)

    def solve(self, field, solver):
        return solver.solve(field)

