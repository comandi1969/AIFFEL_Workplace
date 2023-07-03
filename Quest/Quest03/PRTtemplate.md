# AIFFEL Campus Online 5th Code Peer Review
- 코더 : 조대희
- 리뷰어 : 박근수


# PRT(PeerReviewTemplate) 
각 항목을 스스로 확인하고 토의하여 작성한 코드에 적용합니다.

- [X] 코드가 정상적으로 동작하고 주어진 문제를 해결했나요?
  
- [X] 주석을 보고 작성자의 코드가 이해되었나요?
  > 각 코드마다 주석을 모두 붙여서 이해하기 쉽고 지금까지 배운내용들을 위주로 작성되어 이해가 쉬웠습니다.
- [X] 코드가 에러를 유발할 가능성이 없나요?
  > 코드확인하여 다른 예시로 돌려보았고 에러를 유발할 가능성이 적어보입니다.
- [X] 코드 작성자가 코드를 제대로 이해하고 작성했나요?
  > 리스트 컴프리 헨션을 이용한 함수 작성법이나 파일을 소문자로 변경후 추출하여 2gram을 구현한 것을 보았을때 제대로 이해하고 작성한 것으로 판단됩니다.
- [X] 코드가 간결한가요?
  > 우리 팀이 작성한 코드보다 훨씬 간결하고 짧고 이해가 쉬웠습니다. 특히 리스트 컴프리헨션을 이용한 2gram은 우리팀에서 구현한 코드보다 짧고 이해가 쉬웠습니다.




# 참고 링크 및 코드 개선
** chat-GPT4 코드 리뷰 첨부
전반적으로 코드는 구조가 잘 짜여져 있으며, 주석이 잘 달려 있어 이해하기 쉽습니다. 다만, 아래와 같이 몇 가지 개선점을 제시하겠습니다.
find_2grams() 및 with open()의 주석에 간단한 설명을 추가하였습니다. 주석을 추가함으로써 코드를 이해하는 데 도움이 되는지 확인해 보세요.
파일 경로를 절대 경로에서 상대 경로로 변경할 수 있습니다. 예를 들어 파일이 코드와 같은 디렉토리에 있다면 '06TheAvengers.txt'와 같이 작성할 수 있습니다.
다른 사람들과 협업할 때는 모든 코드에 주석을 달지 않아도 됩니다. 이미 명확한 코드는 이해하기 쉬우므로 별도의 주석이 필요하지 않습니다.
입력 파일에 인코딩 문제가 있으면, encoding 파라미터를 open() 함수에 추가하여 파일을 읽을 때 발생하는 오류를 방지할 수 있습니다. 예를 들면 with open('06TheAvengers.txt', 'r', encoding='utf-8') as file:과 같이 작성할 수 있습니다.
이 외 추가적인 변경 사항이나 개선점이 필요한 곳이 없습니다. 코드 작성이 잘 되어 있습니다.


```리뷰 바탕으로 코드 작성
import re
from collections import Counter

# 2-gram을 찾는 함수 정의
def find_2grams(words):
    return [(words[i], words[i+1]) for i in range(len(words)-1)]

# 파일 읽기 및 문자열 소문자 변환
with open('06TheAvengers.txt', 'r', encoding='utf-8') as file:
    script = file.read().lower()
    # 정규 표현식을 사용하여 스크립트에서 단어만을 추출
    words = re.findall(r'\b\w+\b', script)
    # 추출된 단어를 2-gram 함수에 전달
    two_grams = find_2grams(words)

# 2-gram에서 가장 흔하게 나타나는 값을 찾아 카운트
counter = Counter(two_grams)
max_2gram, max_count = counter.most_common(1)[0]

# 결과 출력
print(max_2gram, max_count)

```
변경 사항은 다음과 같습니다:
파일 경로를 절대 경로에서 상대 경로로 변경하였습니다. 파일이 코드와 같은 디렉토리에 있을 때, '06TheAvengers.txt'와 같이 작성해 주세요.
파일을 읽는 open() 함수에 encoding 파라미터를 추가하였습니다. 인코딩 문제를 방지하기 위해 encoding='utf-8'을 지정해 주세요.
