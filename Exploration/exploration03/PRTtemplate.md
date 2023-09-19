# AIFFEL Campus Online 5th Code Peer Review
- 코더 : 조대희
- 리뷰어 : 심지안


# PRT(PeerReviewTemplate) 

- [X]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
  > 네. 원본과 블러된 배경이 합성된 코드가 제출되었습니다.
    
- [X]  **2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 
주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?**
  > 코드마다 설명이 상세히 적혀있어 이해하기 수월했습니다
        
- []  **3. 에러가 난 부분을 디버깅하여 문제를 “해결한 기록을 남겼거나” 
”새로운 시도 또는 추가 실험을 수행”해봤나요?**
  > 따로 하시진 않은 것 같습니다
        
- []  **4. 회고를 잘 작성했나요?**
  > 회고는 따로 작성하시지 않은 것 같습니다
    

- [X]  **5. 코드가 간결하고 효율적인가요?**
   > 군더더기 없이 코드가 잘 작성되어있는 것 같습니다.
  

# 예시
1. 코드의 작동 방식을 주석으로 기록합니다.
2. 코드의 작동 방식에 대한 개선 방법을 주석으로 기록합니다.
3. 참고한 링크 및 ChatGPT 프롬프트 명령어가 있다면 주석으로 남겨주세요.
```python
# Q. 이번에는 사람 부분을 블러로, 배경 부분을 원본으로 출력해볼까요?
# 힌트 : img_mask_color 옵션을 적절히 조정해주고, img_orig, img_orig_blur 를 활용하세요.
img_concat = np.where(img_mask_color==20, img_orig, img_bg_blur)
plt.imshow(cv2.cvtColor(img_concat, cv2.COLOR_BGR2RGB))
plt.show()

# 위 부분 아직 작성하시지 않은 것 같아 남겨드려요

img_concat_2 = np.where(img_mask_color == 0, img_orig, img_orig_blur)
plt.imshow(cv2.cvtColor(img_concat_2, cv2.COLOR_BGR2RGB))
plt.show()

# np.where에서 img_mask_color == 0로 조건을 바꾸어 주면 인물만 블러되게 됩니다
```

# 참고 링크 및 코드 개선
```python
# 코드 리뷰 시 참고한 링크가 있다면 링크와 간략한 설명을 첨부합니다.
# 코드 리뷰를 통해 개선한 코드가 있다면 코드와 간략한 설명을 첨부합니다.
```
