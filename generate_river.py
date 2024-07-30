import random

random.seed(0)

EL = 3
s32 = 3**.5 / 2
for i in range(-EL, EL+1):
  for j in range(-EL if i<=0 else -EL+i, 1+EL+i if i<=0 else EL+1):
    print(f'''
[node name="SphereThing_{i}_{j}" parent="Cells" instance=ExtResource("1_h1yc5")]
transform = Transform3D(0.9, 0, 0, 0, 0.9, 0, 0, 0, 0.9, {i - j/2}, 0, {j * s32})
metadata/ij = Vector2i({i}, {j})
cell_type = {2 if i == 0 else random.choice([0,0,1,1,4,5]) if i<0 else random.choice([0,1,4,4,5,5])}
''')
