# 🌱 BMI 계산기 만들기 🌱
#
# 📌 앱 설명
### 키와 몸무게를 입력하면, 신체질량지수(BMI) 계산식을 통해 결과를 알려주는 앱입니다.
#
## 📌 구성
- StoryBoard, TableView
- 메인화면: Label, TextField, ImageView, Button
- 결과 리스트 화면: TableView, Label
- 닉네임 변경 화면: Label, TextField, Button
#
## 📌 화면 설명
- 데이터는 DataStorage 파일에 따로 만들어 공용 저장소로 사용
## <메인화면>
- 키와 몸무게를 입력한 후, '결과 확인' 버튼을 누르면 Alert를 통해 결과를 보여줄 수 있도록 구현
- 랜덤 버튼을 통해 키와 몸무게를 랜덤으로 뽑아 Alert를 통해 결과를 보여줄 수 있도록 구현
- 이전 결과리스트를 볼 수 있는 화면으로 이동할 수 있는 버튼 생성
- 결과 리스트를 전체 삭제할 수 있는 버튼 구현
- 메인화면 상단에 안내문구 속 닉네임을 변경할 수 있는 화면으로 이동할 수 있는 버튼 생성
#
## <결과 리스트 화면>
- 이전에 검색했거나 랜덤으로 보여줬던 결과들을 보여줄 수 있도록 테이블 뷰로 구현
- 결과 확인 날짜, 키, 몸무게, BMI 지수로 구성
- 리스트는 UserDefaults를 활용하여 앱이 종료되어도 정보가 저장되도록 구현
#
## <닉네임 변경 화면>
- TextField에 원하는 닉네임을 입력한 후, '저장하기'버튼을 클릭하면 저장될 수 있도록 구현
- '저장하기'버튼과 '리셋하기'버튼 클릭 시, Alert 안내 문구가 나올 수 있도록 구현
- viewWillDisappear를 통해 show detail 화면이 내려가면, 메인 화면에서 닉네임이 바로 적용될 수 있도록 구현
- 리셋 버튼을 클릭하면, 디폴트 닉네임인 '당신'으로 리셋될 수 있도록 구현
- 닉네임 또한 UserDefaults를 활용하여 저장될 수 있도록 구현
#
## 📷 ScreenShot
|메인|결과리스트|닉네임 변경|영상|
|:-:|:-:|:-:|:-:|
|<img src="https://github.com/yeggrrr/BMICalculatorApp/assets/161591832/437ae7fb-1282-4608-822b-e46a698a71b7" width="150"/>|<img src="https://github.com/yeggrrr/BMICalculatorApp/assets/161591832/a42729cf-673e-4efb-9057-ebdf2fbc0eb7" width="150"/>|<img src="https://github.com/yeggrrr/BMICalculatorApp/assets/161591832/85a9bcbe-3f25-416e-8558-f6a6218768e4" width="150"/>|<img src="https://github.com/yeggrrr/BMICalculatorApp/assets/161591832/e88efddb-9681-484c-a0c4-81a63abe3c78" width="150"/>|
