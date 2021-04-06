###MAC 에서 Oracle Database 설치 및 Sql Developer 설치 및 사용
1. 도커를 다운 받는다.
2. 도커에서 오라클 데이터 베이스 이미지를 다운 받는다.(다운받은것 삭제및 관리는 VScode 에서도 관리가능)
3. Sql Developer 를 다운 받아서 사용하면 된다.

** 간단하게 정리하면 위의 3단계를 거치면 사용이 가능하다. 
- 나의 오류 
1. 맥에서 Developer를 설치하고 실행했을때 경고창이 나왔다.(확인되지 않은 개발자에 의한 프로그램은 실행 될 수 없습니다.)
2. Developer 아이콘을 더블클릭 했더니 아이콘이 통통 튀기고 나서 실행되지않음.

- 해결 방법
1. 첫 번째 문제는 설정에 들어가서 락을 풀어 주면 된다.
 - https://support.apple.com/ko-kr/guide/mac-help/mh11784/11.0/mac/11.0                                                  
 다음에서 다운로드한 앱 허용:
   - App Store 또는 확인된 개발자가 제공한 앱만 허용하여 Mac을 악성코드로부터 보호할 수 있습니다.

  - App Store: App Store에서 다운로드한 앱만 허용하려면 선택하십시오.     
     App Store 및 확인된 개발자: App Store에서 다운로드하고 Apple이 확인한 개발자 제공 앱만 허용하려면 선택하십시오
 
 - 이두가지 중 App Store 을 선택해도 당연히 확인되지 않은 허용자 이기때문에 실행이 안됐다.
 
 * 해결 : 어쩌다가 된지는 모르겠는데 갑자기 확인없이 열기라는 선택지가 생겼고 이렇게 설정을 햇다.--> 이후에는 경고창 내용이 '프로그램 실행 할 수없습니다.' 로 바뀌었다.

2. 두번째 문제는 sqldeveloper.sh 수정하기로 해결했따.
- https://proni.tistory.com/m/entry/%E2%9C%85-Solved-sqldeveloper-%EC%95%84%EC%9D%B4%EC%BD%98%EB%A7%8C-%EB%B0%98%EC%A7%9D%EC%9D%B4%EA%B3%A0-%EC%82%AC%EB%9D%BC%EC%A7%88-%EB%95%8C-at-Mac

- 여기에 들어가서 작성자가 한 방법대로 따라하면 가능 하다.
 #####sqldeveloper.sh 수정하기순서
 1) sqldeveloper.sh 파일을 열어서 
 
 TMP_PATH=`/usr/libexec/java_home -F -v 1.8`이였던 내용을
 TMP_PATH=`/usr/libexec/java_home -F -v 1.8.0_281`로 바꾸어주고, 저장후 sqldeveloper를 실행하니까 문제없이 실행되었다.
 
 ps. 진짜 아이콘이 통통거리고 메세지창도 안떳을 때는 너무 막막하고 설치를 포기하고 맥에 윈도우를 설치할까도 생각했다. 하지만 계속 여러가지방법으로 생각날때마다 시도했더니 해결되었고    
 방법 또한 생각보다 단순했다.
