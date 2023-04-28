
## Future Builder 다루기

비동기적 데이터 작업이 필요할때 사용한다.

### 가능 예
비동기적 데이터를 받아. 특정 위젯을 rebuild 시키며 받은 데이터를 위젯에 전달 할 수 있다.

비동기 처리가 안되는 위젯을 처리할때 유용하다. 본인은 TableCalendar와 Firebase의 데이터를 Future로 받지 못해서 해결책으로 FutureBuilder를 생각했다.

FutureBuild의 future를 다시 사용하기 위해 setState를 써야한다는 특징이 있다.

TableCalendar 이벤트 변경중일때 setState가 안되서 FutureBuilder는 맞지 않는다.

[FutureBuilder와 AsyncSnapshot](http://www.incodom.kr/Flutter/FutureBuilder#h_3c6f298a67ad3c4c005a9fc6e42a3cf1)


[[Flutter]플러터 Futurebuilder / Streambuilder란??](https://devmg.tistory.com/183)


## StreamBuilder
꼭 서버통신만 할 수 있는게 아니다.
변수의 변화도 구독할 수 있다.


## Simple Calendar

### 사용한 패키지

- intl : flutter의 공식 다국어 지원 패키지. 언어 번역이나 단수/복수, 성별, 날짜/숫자를 그 지역이나 국가에 맞게 바꿀 수 있