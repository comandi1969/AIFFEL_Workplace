# ChatGpt 코드 이해해보기

import pprint

# 미로를 5x5 2차원 리스트로 생성합니다
maze = [
    [0, 0, 0, 0, 1],
    [0, 1, 1, 0, 1],
    [0, 0, 0, 0, 0],
    [0, 1, 1, 1, 0],
    [0, 0, 0, 0, 0]
]

# 터틀이 이동할 수 있는 방향을 정의합니다
directions = [(0, 1), (0, -1), (-1, 0), (1, 0)]  # 오른쪽, 왼쪽, 위, 아래

# 미로를 찾는 함수를 작성합니다
def find_maze_path(maze, x, y):
    if x == 5 and y == 5:  # 목적지에 도달한 경우
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

# 시작 위치는 (0,0), 목적지 위치는 (4,4)입니다.
start_x, start_y = 0, 0
goal_x, goal_y = 5, 5

# 미로를 찾는 함수를 호출하고 결과를 출력합니다
if find_maze_path(maze, start_x, start_y):
    print("미로를 찾았습니다.")
else:
    print("미로를 찾을 수 없습니다.")

# 미로를 보기 좋게 출력합니다
pprint.pprint(maze)
