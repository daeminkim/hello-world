### 2/1일
sql 집계함수 관련 todo 문제 복습, join에 대한 개념 복습 

### 2/8일 
1_basic_select 복습 

------ like ----
select  emp_id,
        emp_name
from  emp
where emp_name like 'S%';  ---> like 쓰는게 가끔 까먹고

---escape-----

select emp_name
from  emp
where emp_name like '%@%%' escape '@';

-->  escape 문자를 정해서 사용한다고 생각하면된다.

---------------------------------------

   <sql remind>
* 조회  : select 과 from 
        
* 연산자

* Where 절을 이용한 행 행 제한

* WHERE 조건이 여러개인 경우
   AND OR
   
* order by를 이용한 정렬
  
  -----까지 remind------------
