/* *********************************************************************
DML - 데이터 (값)을 다루는 sql 문
    -insert  :create 삽입
    -select : read , retrieve조회 
    -update : 수정
    -delete: 삭제 
    
    
INSERT 문 - 행 추가
구문
 - 한행추가 :
   - INSERT INTO 테이블명 (컬럼 [, 컬럼]) VALUES (값 [, 값[])
   - 모든 컬럼에 값을 넣을 경우 컬럼 지정구문은 생략 할 수 있다.

 - 조회결과를 INSERT 하기 (subquery 이용)
   - INSERT INTO 테이블명 (컬럼 [, 컬럼])  SELECT 구문
	- INSERT할 컬럼과 조회한(subquery) 컬럼의 개수와 타입이 맞아야 한다.
	- 모든 컬럼에 다 넣을 경우 컬럼 설정은 생략할 수 있다.
	
  
************************************************************************ */
desc dept;    -- 테이블 명을 넣으면  널여부 까지 해서 컬럼 확인 가능하다.
insert into  dept(dept_id, dept_name, loc) values(1000,'기획부','서울');  -- 전체 데이터 넣으면 컬럼  안써두됨
insert into  dept values(1100,'구매부','부산');
commit ;   --잊지 말고 해줘야함~!
            -- 커밋 최종 저장 //원본 테이블에 처리를 해라 라는 뜻이다
insert into  dept values(1100,'구매부','부산');
insert into  dept values(1200,'구매부','부산');
insert into  dept values(1300,'구매부','부산');  -- 커밋 전까지는 메모리에 임시 저장한것이다. 조회하면 나오기는 하지만 롤백을 하면 이전으로 돌릴 수 잇다
rollback;   
-- 인설트 업데이트 딜리트 하기 전 (마지막 커밋상태)로 돌려라
-- 커밋을 하면 다시 못 되돌림
-- commit 전은 임시로 처리된상태. commit 최종 처리한것 ( 커밋을 안하면 연결을 끊거나 하면 데이터가 사라짐

select * from dept order by dept_id desc;

desc emp;

insert into emp values (1000,'홍길동', 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);  
select * from emp order by emp_id desc;

insert into emp (emp_id,emp_name,hire_date,salary) values (1100,'이순신','2000/10/20',5000);  
-- 컬럼을 넣지않으면 값을 넣지않으면 null 입력된다. 컴럼을 지정안하면
insert into emp values (1000,'김순신', 'null',100,'2017/10/20',5000,null,20);  
-- 칼럼값을 안넣었을때는 그자리에 null을 써줘야한다.

insert into emp values (17800,'홍동', 'FI_ACCOUNT',null,to_date('2017/01', 'yyyy/mm'),5000,0.1,20);  
-- 형식을 바꿨기 때문에 to_date로 입력해줘야함

--이미 있는 pk 값을 insert 하려고 하면 인서트 오류가난다. 오류를 구글링하면 원인을 알 수있다.
insert into emp values (1000,'홍길동', 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);  

insert into emp values (1000,null, 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);-- not null 컬럼에 null을 삽입할 수없다.

insert into emp values (1000,'홍길동', '회계',100,'2017/10/20',5000,0.1,20);
--emp 의 job_id FK 컬럼 ->부모테이블의 pk 컬럼에 존재하는 값만 넣을 수 있다.


-- 결과 데이터 타입의 크기 보다 더 큰 값을 넣는 경우 오류.
insert into emp values (1000,'홍길동홍길동홍길동', 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);

insert into emp values (1000000,'홍길동', 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);
-- 유형이 number (6) 이다.
desc emp;

commit;

create table emp_copy(
        emp_id number(6),
        emp_name varchar2(20),
        salary number(7,2)
);

insert into emp_copy (emp_id, emp_name, salary)
select emp_id,
        emp_name,
        salary
from emp
where dept_id =10;  -- 서브 커리 처럼

select *  from emp_copy;


--TODO: 부서별 직원의 급여에 대한 통계 테이블 생성. 
--      조회결과를 insert. 집계: 합계, 평균, 최대, 최소, 분산, 표준편차
create table salary_stat(
    dept_id number(6),
    salary_sum number(15,2),
    salary_avg number(10, 2),
    salary_max number(7,2),
    salary_min number(7,2),
    salary_var number(20,2),
    salary_stddev number(7,2)
);

select * from salary_stat;

insert into salary_stat-- (dept_id, salary_sum, salary_avg, salary_max, salary_min, salary_var, salary_stddev) -- 전체 컬럼이라 생략해도됨
select  dept_id,
        sum(salary),
        round(avg(salary),2),
        max(salary),
        min(salary),
        round(VARIANCE(salary),2) 분산,
        round(stddev(salary),2) 표준편차
from    emp 
group by dept_id
order by dept_id;
         


/* *********************************************************************
UPDATE : 테이블의 컬럼의 값을 수정
UPDATE 테이블명
SET    변경할 컬럼 = 변경할 값  [, 변경할 컬럼 = 변경할 값]
[WHERE 제약조건]

 - UPDATE: 변경할 테이블 지정
 - SET: 변경할 컬럼과 값을 지정
 - WHERE: 변경할 행을 선택. 
************************************************************************ */



-- 직원 ID가 200인 직원의 급여를 5000으로 변경
select * from emp where emp_id = 200;   -- 4400

update emp
set salary = 5000
where emp_id = 200;
commit;

select * from emp;
-- 직원 ID가 200인 직원의 급여를 10% 인상한 값으로 변경.   salary*1.1
select * from emp where emp_id = 200;

update emp
set salary = salary*1.1
where emp_id = 200;


-- 부서 ID가 100인 직원의 커미션 비율을 0.2로 salary는 3000을 더한 값으로, 상사_id는 100 변경.
select * from emp where emp_id = 100;

update emp
set    comm_pct = 0.2,
       salary =  salary+3000,
       mgr_id = 100
where  emp_id = 100;
commit;



--update emp ,dept   -- 이런식으로 한번에 여러 테이블의 값을 바꿀수 는 없다 한테이블의 여러 컬럼은 가능하다.
--set    comm_pct = 0.2,
--       salary =  salary+3000,
--       mgr_id = 100
--where  emp_id = 100;

-- TODO: 부서 ID가 100인 직원들의 급여를 100% 인상
update emp
set salary = salary*2
where dept_id= 100;

--<<<<< 내가 하다 포기>>>>---
select * from emp where dept_id = 100;
--
--update emp
--set salary= salary*2
--where emp_id=100;


rollback;
-- TODO: IT 부서의 직원들의 급여를 3배 인상   --== dept_id 60임 아이티  select * from dept;

update emp
set salary =  salary*3
where dept_id in (select dept_id from dept where dept_name = 'IT');  -- 설계상 아이티라는 부서가 여러개일수도 있으니 in 을 쓴다.
--where dept_id = 60



--<<<<<<<내가 하다 포기>>>>>>>>>
--select salary 
--from emp e join dept d on e.dept_id = d.dept_id 
--where dept_name = 'IT'
--and update e.emp
--    set salary = salary*3
--    where d.dept_name= 'IT';
--
--update emp
--set salary = salary*3
--where dept_name= 'IT';

commit;
-- TODO: EMP2 테이블의 모든 데이터를 MGR_ID는 NULL로 HIRE_DATE 는 현재일시로 COMM_PCT는 0.5로 수정.
update emp 
set     mgr_id = null,
        hire_date = sysdate,
        comm_pct = 0.5;
        
select * from emp;
rollback;

-- TODO: COMM_PCT 가 0.3이상인 직원들의 COMM_PCT를 NULL 로 수정.
update emp
set comm_pct = null
where comm_pct>=0.3;
rollback;
-- TODO: 전체 평균급여보다 적게 받는 직원들의 급여를 50% 인상.
select avg(salary) from emp ;
select * from emp where salary < (select avg(salary) from emp) ;

update emp 
set salary = salary *1.5
where salary < (select avg(salary) from emp);

select * from emp;

rollback;
/* *********************************************************************
DELETE : 테이블의 행을 삭제
구문 
 - DELETE FROM 테이블명 [WHERE 제약조건]
   - WHERE: 삭제할 행을 선택
************************************************************************ */

--delete from emp; 테이블에 있는 데이터를 모두 삭제



-- 부서테이블에서 부서_ID가 200인 부서 삭제

delete from dept
where dept_id = 200;
select * from dept;


-- 부서테이블에서 부서_ID가 10인 부서 삭제
select * from emp where dept_id=10;
select * from emp where emp_id =200;
delete from dept where dept_id=10;  --테이블에 on delete set null 이라고 있어서 
rollback;

-- 한테이블 단위로만 행을 처리 할수 있다ㅏ 한번에 여러개의 테이블은 안됨.
-- delete 는 컬럼이랑 상관이 없다 


-- TODO: 부서 ID가 없는 직원들을 삭제
select * from emp where dept_id is null;

delete from emp where dept_id is null;



-- TODO: 담당 업무(emp.job_id)가 'SA_MAN'이고 급여(emp.salary) 가 12000 미만인 직원들을 삭제.
select * from emp where job_id = 'SA_MAN' and salary<12000;
delete from emp where job_id = 'SA_MAN' and salary<12000;

-- TODO: comm_pct 가 null이고 job_id 가 IT_PROG인 직원들을 삭제

select* from emp where comm_pct is null and job_id = 'IT_PROG';

delete from emp where comm_pct is null and job_id = 'IT_PROG';  -- 또 실행하면 0 행이 삭제 ..업데이트도 마찬가지~~ 




-- TODO: job_id에 CLERK가 들어간 업무를 하는 직원들 삭제
select * from emp where job_id like '%CLERK';  --35개 행
delete from emp where job_id like '%CLERK';

rollback;

select * from emp where emp_id = 100;   
-- job_id 만 지우고 싶을때 null 을 만들고 싶을때  ==> update 특정 컬럼의 값만 바꾼다. /// delete 는 행을 다날림
update emp 
set job_id = null
where emp_id = 100;

