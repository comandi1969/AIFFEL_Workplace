# Quest2 문제 :
# 조건을 확인하여 거북이가 미로를 헤매지 않도록 출구를 찾아주자!
# 조건
# 미로는 5x5의 2차원 리스트로 주어져 있다.
# 시작 위치는 (0,0)이고 목적지 위치는 (4,4)이다.
# 터틀은 상하좌우로 움직일 수 있다.
# 미로 내에서 갈 수 있는 길은 0으로 표시되어 있다. 
# 터틀이 이미 지나간 길은 2로 표시해야한다. 
# 거북이가 미로를 찾아 나가면 "미로를 찾았습니다.", 
# 미로를 찾을 수 없으면 "미로를 찾을 수 없습니다."가 나올 수 있도록 만들어보자!.

import pprint

maze = [
    [0, 0, 0, 0, 1],
    [0, 1, 1, 0, 1],
    [0, 0, 0, 0, 0],
    [0, 1, 1, 1, 0],
    [0, 0, 0, 0, 0]
]

directions = [(0, 1), (0, -1), (-1, 0), (1, 0)]

def find_maze_path(maze, x, y):
    if (x, y) == (4, 4):  # 목적지에 도달한 경우
        maze[x][y] = 2  # 출구를 2로 표시
        return True

    if maze[x][y] == 1 or maze[x][y] == 2:  # 벽이거나 이미 지나간 길인 경우
        return False

    maze[x][y] = 2  # 이미 지나간 길을 표시

    for dx, dy in directions:
        new_x = x + dx
        new_y = y + dy

        if 0 <= new_x < 5 and 0 <= new_y < 5:
            if find_maze_path(maze, new_x, new_y):  # 재귀적으로 다음 위치를 탐색
                return True

    return False  # 미로를 찾을 수 없는 경우

start_x, start_y = 0, 0
goal_x, goal_y = 4, 4

if find_maze_path(maze, start_x, start_y):
    print("미로를 찾았습니다.")
else:
    print("미로를 찾을 수 없습니다.")

# 미로를 보기 좋게 출력합니다
pprint.pprint(maze)
# 미로를 보기 좋게 출력합니다
pprint.pprint(maze)
