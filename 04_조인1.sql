select *
from emp e, dept d    -- 오라클 문법의 크로스 조인 
--where e.dept_id = d.dept_id;  -- where 절 빼고 하면  계속 데이터가 나온다 2889개 가 나온다. emp 테이블 * dept 테입블 //* 크로스 조인이다.
order by 1;                     -- 소스 테이블 하나당 dept 데이터 하나씩 다붙어서  데이터개수가 늘어난다. 조건을 주지 않았기 때문에 다 join 한다.
-- 카티션 곱 : 조인 연산을 잘못해서 두테이블의 모든 행들이 cross로 join 된것.
-- n개의 테이블-> join  연산 최소 n-1개 가 있어야한다~~~
-- 안시 조인에서는 크로스 조인 현상이 안일어 난다. 왜냐하면 on 절이 없으면 error가 발생하기 때문이다.~

select * from emp cross join dept;  --(안시 조인의 크로스 조인 문법)
/* ****************************************
조인(JOIN) 이란
- 2개 이상의 테이블에 있는 컬럼들을 합쳐서 가상의 테이블을 만들어 조회하는 방식을 말한다.
 	- 소스테이블 : 내가 먼저 읽어야 한다고 생각하는 테이블- 메인 테이터 테이블
	- 타겟테이블 : 소스를 읽은 후 소스에 조인할 대상이 되는 테이블-추가정보,부가정보
 
- <<<id가 100인 직원의 id와 이름,연봉,>>emp테이블에 있다.>>부서이름, 부서위치: 소스:직원, 타겟:부서
- <<<<id가 100인 부서의 이름, 위치,>>dept 테이블에 잇다.>> 소속직원의 이름, 연봉: 소스:부서, 타겟:직원
 
- 각 테이블을 어떻게 합칠지를 표현하는 것을 조인 연산이라고 한다.
    - 조인 연산에 따른 조인종류
        - Equi join  , non-equi join 
- 조인의 종류
    - Inner Join 
        - 양쪽 테이블에서 조인 조건을 만족하는 행들만 합친다. 
    - Outer Join
        - <<<<<한쪽 테이블(소스테이블)의 행들을 모두 사용하고 >>>>>
                다른 쪽 테이블은 조인 조건을 만족하는 행만 합친다. 조인조건을 만족하는 행이 없는 경우 NULL을 합친다.
                
        - 종류 : Left Outer Join,  Right Outer Join, Full Outer Join
    - Cross Join
        - 두 테이블의 곱집합을 반환한다. 
- 조인 문법
    - ANSI 조인 문법
        - 표준 SQL 문법
        - 오라클은 9i 부터 지원.
    - 오라클 조인 문법
        - 오라클 전용 문법이며 다른 DBMS는 지원하지 않는다.
**************************************** */        
-- 부모 - 자식 테이블간 : 부모.pk칼럼 = 자식.fk칼럼

/* ****************************************
-- inner join : ANSI 조인 구문
FROM  테이블a 별칭 INNER JOIN 테이블b 별칭 ON 조인조건(연산) 

- inner는 생략 할 수 있다.
**************************************** */
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서 ID, 소속부서이름(dept.dept_name)을 조회

select  e.emp_id,
        e.emp_name,
        e.hire_date,
        d.dept_id,
        d.dept_name
from emp e join dept d on e.dept_id = d.dept_id;  -- inner join 은 join 연산에 만족한 데이터만 표시한다.
--부서 아이디가 null이면 부서테이블의 id와 매칭 되는게 없어서 데이터가 나오지 않는다. null과 같은게 없다.

select  e.emp_id, 
        e.emp_name, 
        e.hire_date, 
        d.dept_id,
        d.dept_name
from    emp e inner join dept d on e.dept_id = d.dept_id; -- dept_id가 null 인 데이터는 날려버린다. 조회 X

select emp_id,emp_name,dept_id from emp where dept_id is null;




-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회.
select  e.emp_id,
        e.emp_name,
        to_char(e.hire_date, 'yyyy')입사년도,
        d.dept_name
from    emp e join dept d on e.dept_id = d.dept_id
where  e.emp_id = 100;


select  e.emp_id,   
        e.emp_name,
        to_char(e.hire_date, 'yyyy"년"') hire_year,
        d.dept_name
--from    emp e inner join dept d on e.dept_id = d.dept_id
from    emp e join dept d on e.dept_id = d.dept_id --inner는 생략 가능. 
where   e.emp_id = 100;

-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회

select  e.emp_id,
        e.emp_name,
        e.salary,
        j.job_title,
        d.dept_name
from emp e join dept d on e.dept_id = d.dept_id
           join job j  on e.job_id = j.job_id;



select  e.emp_id,
        e.emp_name,
        e.salary,
        j.job_id,
        j.job_title,
        d.dept_id,
        d.dept_name
from    emp e join job j on e.job_id = j.job_id 
              join dept d on e.dept_id = d.dept_id;


-- 부서_ID(dept.dept_id)가 30인 부서의 이름(dept.dept_name), 위치(dept.loc), 그 부서에 소속된 직원의 이름(emp.emp_name)을 조회.
-- 소스테이블: 부서(부모), 타겟테이블: 직원(자식)

select  d.dept_id,
        d.dept_name,
        d.loc,
        e.emp_name
from    dept d join emp e on d.dept_id = e.dept_id
where   d.dept_id = 30;




select  d.dept_name,
        d.loc,
        e.emp_name
from    dept d join emp e on d.dept_id = e.dept_id
where   d.dept_id = 30;

select * from dept where   dept_id = 30;
select * from emp where dept_id=30;


-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회. 급여 등급 오름차순으로 정렬


select  e.emp_id,
        e.emp_name,
        e.salary,
        s.grade
        
from emp e join salary_grade s on e.salary between s.low_sal and s.high_sal;
-- salary grade와 emp 테이블 간의 연결은 안 되어 있지만 non-equi join 으로 조회했다.


select e.emp_id,
       e.emp_name,
       e.salary,
       s.grade||' 등급'
from   emp e join salary_grade s on e.salary between s.low_sal and s.high_sal
order by 4;

select * from salary_grade;

--TODO 200번대(200 ~ 299) 직원 ID(emp.emp_id)를 가진 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.

select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name,
        d.loc
from  emp e join dept d on e.dept_id=d.dept_id
where e.emp_id between 200 and 299;


select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name,
        d.loc
from emp e join dept d on e.dept_id = d.dept_id
where e.emp_id between 200 and 299
order by e.emp_id;




--TODO 업무(emp.job_id)가 'FI_ACCOUNT'인 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무(emp.job_id), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.  직원_ID의 오름차순으로 정렬.

select  e.emp_id,
        e.emp_name,
        e.job_id,
        d.dept_name,
        d.loc
from     job j  join emp e on e.job_id= j.job_id
                join dept d on d.dept_id = e.dept_id
where  e.job_id ='FI_ACCOUNT'
order by e.emp_id ;


select  e.emp_id,
        e.emp_name,
        e.job_id,
        d.dept_name,
        d.loc
from emp e join dept d on e.dept_id = d.dept_id
           join job j  on e.job_id = j.job_id
where e.job_id = 'FI_ACCOUNT'
order by e.emp_id;



--TODO 커미션비율(emp.comm_pct)이 있는 //직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 커미션비율(emp.comm_pct), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.

select  e.emp_id,
        e.emp_name,
        e.salary,
        e.comm_pct,
        d.dept_name,
        d.loc
from    emp e join dept d on e.dept_id = d.dept_id
where   e.comm_pct is not null
order by 1;


select  e.emp_id,
        e.emp_name,
        e.salary,
        e.comm_pct,
        d.dept_name,
        d.loc
from emp e join dept d on e.dept_id = d.dept_id
where e.comm_pct is not null
order by e.emp_id;


--TODO 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
--     그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 부서_ID 의 오름차순으로 정렬.

select  d.dept_id,
        d.dept_name,
        d.loc,
        e.emp_id,
        e.emp_name,
        e.job_id
from    dept d join emp e on d.dept_id = e.dept_id
where   d.loc = 'New York'
order by dept_id;



select  d.dept_id,
        d.dept_name,
        d.loc,
        e.emp_id,
        e.emp_name,
        e.job_id
from dept d join emp e on d.dept_id = e.dept_id  -- 부모가 소스 이다.
where d.loc = 'New York'
order by d.dept_id;
            
select * from emp;

--TODO 직원_ID(emp.emp_id), 이름(emp.emp_name), 업무_ID(emp.job_id), 업무명(job.job_title) 를 조회.
select  e.emp_id,
        e.emp_name,
        e.job_id,
        j.job_title
from    emp e join job j on e.job_id = j.job_id;


select  e.emp_id,
        e.emp_name,
        e.job_id,
        j.job_title
from emp e join job j on e.job_id = j.job_id;  -- pk 와 fk 가 같다

-- 잡 아이디가 null 인애들이 이써서  데이터가 101개 이다. 


              
-- TODO: 직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--       담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회   

select  e.emp_id,
        e.emp_name,
        e.salary,
        j.job_title,
        d.dept_name
from    emp e   join dept d on e.dept_id =d.dept_id
                join job j on e.job_id = j.job_id
where   e.emp_id =  200;  -- dept_id 가 null 이라서 조회 안됨

select * from emp where emp_id = 200;

select  e.emp_id,
        e.emp_name,
        e.salary,
        j.job_title,
        d.dept_name
from emp e join job j on e.job_id = j.job_id
           join dept d on e.dept_id = d.dept_id
where e.emp_id = 200;


-- TODO: 'Shipping' 부서의 부서명(dept.dept_name), 위치(dept.loc), 소속 직원의 이름(emp.emp_name), 업무명(job.job_title)을 조회. 
--       직원이름 내림차순으로 정렬

select  d.dept_name,
        d.loc,
        e.emp_name,
        j.job_title
from    dept d join emp e on d.dept_id=e.dept_id
               join job j on e.job_id = j.job_id
where   d.dept_name = 'Shipping';

select  d.dept_name,
        d.loc,
        e.emp_name,
        j.job_title
--from emp e join dept d on e.dept_id = d.dept_id
from dept d join emp e on d.dept_id =  e.dept_id
            join job j  on e.job_id = j.job_id -- 그대로 이어 붙이면 된다.
where d.dept_name = 'Shipping'
order by 3 desc;   -- 관계가 없는 테이블 두개를 엮을때 가운데에 있는 연결되어 있는 애를 갖고와서 join 한다.
                    -- 줄줄이 이어 붙인다고 생각하면 된다. 접점이 있는 애들끼리


-- TODO:  'San Francisco' 에 근무(dept.loc)하는 직원의 id(emp.emp_id), 이름(emp.emp_name), 입사일(emp.hire_date)를 조회
--         입사일은 'yyyy-mm-dd' 형식으로 출력

select e.emp_id,
        e.emp_name,
        e.hire_date,
        d.loc,
        to_char(e.hire_date, 'yyyy/mm/dd')
from emp e join dept d on e.dept_id = d.dept_id
where d.loc = 'San Francisco';


-- TODO 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬.
-- 급여는 , 단위구분자와 $ 를 붙여 출력.

select  d.dept_id,
        d.dept_name,
        to_char(round(avg(salary), 2), '$999,999') salary_평균
from emp e join dept d on e.dept_id = d.dept_id
group by d.dept_id, d.dept_name  -- 여기서 d.dept_id 는  pk 라서 좀 더 정확하게 그룹을 나누기 위해 추가함
order by 3 desc;


select  dept_id,
        avg(salary)
from   emp 
group by dept_id;


--TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 
--     급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회. 등급 내림차순으로 정렬

select  e.emp_id,
        e.emp_name,
        j.job_title,
        e.salary,
        s.grade||'등급' 등급,
        d.dept_name
from    emp e join job j on e.job_id = j.job_id
              join dept d on e.dept_id = d.dept_id
              join salary_grade s on e.salary between s.low_sal and s.high_sal
order by s.grade desc;

select e.emp_id,
       e.emp_name,
       j.job_title,
       e.salary,
       s.grade||' 등급',
       d.dept_name
    from   emp e join salary_grade s on e.salary between s.low_sal and s.high_sal
             join job j on e.job_id = j.job_id
             join dept d on e.dept_id = d.dept_id 
order by 5 desc;


--TODO 부서별 급여등급이(salary_grade.grade) 1인 직원있는 부서이름(dept.dept_name)과 1등급인 직원수 조회. 직원수가 많은 부서 순서대로 정렬.
-- 관계가 없는 테이블들을 조인 해야한다.

select  d.dept_name,
        --d.dept_id,
        count(*)
from    emp e join dept d on e.dept_id = d.dept_id
              join salary_grade s on e.salary between s.low_sal and s.high_sal
where s.grade = 1 
group by d.dept_id,d.dept_name
order by 2 desc;




select  d.dept_name,
        count(*) 직원수 
from emp e join dept d on e.dept_id = d.dept_id
           join salary_grade s on e.salary between s.low_sal and s.high_sal
where s.grade = 1
group by d.dept_id, d.dept_name   -- 프라이머리 값을 해야 분류가 잘된다 // dept_name 은 같은 값을 가진 값이 많기 때문에 id(pk값)으로 그룹하는게 좋다.
order by 1;



select * from salary_grade;

/* ###################################################################################### 
오라클 조인 
- Join할 테이블들을 from절에 나열한다.
- Join 연산은 where절에 기술한다. 

###################################################################################### */
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
-- 입사년도는 년도만 출력

select  e.emp_id,
        e.emp_name,
        extract(year from e.hire_date),
        d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id;


-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
-- 입사년도는 년도만 출력

select  e.emp_id,
        e.emp_name,
        e.hire_date,
        d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id
and e.emp_id = 100 ;   -- 조인문과 where  절 순서는 상관없다.



-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회

select  e.emp_id,
        e.emp_name,
        e.salary,
        j.job_title,
        d.dept_name
from    emp e,
        job j,
        dept d
where e.job_id = j.job_id
and   e.dept_id= d.dept_id;

--TODO 200번대(200 ~ 299) 직원 ID(emp.emp_id)를 가진 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.


select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name
from    emp e,dept d
where   e.dept_id = d.dept_id
and e.emp_id between 200 and 299;




select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name
from  emp e,
      dept d
where e.dept_id = d.dept_id
and e.emp_id between 200 and 299
order by 1;


--TODO 업무(emp.job_id)가 'FI_ACCOUNT'인 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무(emp.job_id), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.  직원_ID의 오름차순으로 정렬.

select  e.emp_id,
        e.emp_name,
        e.job_id,
        d.dept_name,
        d.loc
from emp e, dept d
where e.dept_id = d.dept_id
and e.job_id = 'FI_ACCOUNT'
order by e.emp_id;




--TODO 커미션비율(emp.comm_pct)이 있는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 커미션비율(emp.comm_pct), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.


select  e.emp_id,
        e.emp_name,
        e.salary,
        e.comm_pct,
        d.dept_name
from emp e, dept d 
where e.comm_pct is not null
and e.dept_id = d.dept_id;


--TODO 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
--     그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 부서_ID 의 오름차순으로 정렬.
select d.dept_id,
        d.dept_name 부서이름,
        d.loc 위치,
        e.emp_id,
        e.emp_name,
        e.job_id
from dept d, emp e
where d.dept_id = e.dept_id
and d.loc = 'New York'
order by d.dept_id;



--TODO 직원_ID(emp.emp_id), 이름(emp.emp_name), 업무_ID(emp.job_id), 업무명(job.job_title) 를 조회.
select  e.emp_id,
        e.emp_name,
        e.job_id,
        j.job_title
from emp e, job j
where e.job_id = j.job_id;



-- TODO: 직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--       담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회   

select  e.emp_id,
        e.emp_name,
        e.salary,
        j.job_title,
        d.dept_name
from    emp e,dept d,job j 
where   e.dept_id = d.dept_id
and     e.job_id = j.job_id
and     e.emp_id = 120;

select  e.emp_id,
        e.emp_name,
        e.salary,
        j.job_title,
        d.dept_name
from emp e, 
     job j, 
     dept d
where e.dept_id = d.dept_id
and e.job_id = j.job_id
and e.emp_id = 200;


-- TODO: 'Shipping' 부서의 부서명(dept.dept_name), 위치(dept.loc), 소속 직원의 이름(emp.emp_name), 업무명(job.job_title)을 조회. 
--       직원이름 내림차순으로 정렬


select  d.dept_name,
        d.loc,
        e.emp_name,
        j.job_title
from    dept d, 
        emp e,
        job j
where   d.dept_id = e.dept_id
and     e.job_id = j.job_id
and     d.dept_name = 'Shipping';


select  d.dept_name,
        d.loc,
        e.emp_name,
        j.job_title
from dept d, 
     emp e,
     job j
where e.dept_id = d.dept_id
and e.job_id = j.job_id
and d.dept_name = 'Shipping';



-- TODO:  'San Francisco' 에 근무(dept.loc)하는 직원의 id(emp.emp_id), 이름(emp.emp_name), 입사일(emp.hire_date)를 조회
--         입사일은 'yyyy-mm-dd' 형식으로 출력

select  d.loc,
        e.emp_id,
        e.emp_name,
        to_char(e.hire_date, 'yyyy-mm-dd')
from    dept d,
        emp e
where   d.dept_id = e.dept_id
and     d.loc = 'San Francisco';


select  e.emp_id,
        e.emp_name,
        to_char(e.hire_date,'yyyy-mm-dd')
from dept d, emp e
where d.dept_id=e.dept_id
and d.loc = 'San Francisco';



--TODO 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬.
-- 급여는 , 단위구분자와 $ 를 붙여 출력.


select  d.dept_name,
        to_char(round(avg(e.salary),2), 'fm$9,999,999')
from    emp e, dept d
where   e.dept_id = d.dept_id
group by d.dept_id,d.dept_name
order by 2 desc;



select  to_char(round(avg(e.salary),2),'fm$999,999.99'),
        d.dept_name
        
from dept d, emp e
where d.dept_id = e.dept_id
group by d.dept_id, d.dept_name
order by 1 desc;  -- 숫자를 문자로 바꾸면서 순서가 안맞다면 셀렉에 있는 컬럼 이름을 넣고 정력한다.//


--TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회. 직원 id 오름차순으로 정렬
select e.emp_id,
       e.emp_name,
       e.salary,
       s.grade||' 등급'
       
from   emp e, salary_grade s 
where e.salary between s.low_sal and s.high_sal
order by 1 ;




--TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 
--     급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회. 등급 내림차순으로 정렬


select  e.emp_id,
        e.emp_name,
        j.job_title,
        e.salary,
        s.grade||'등급' "등급",
        d.dept_name
from    emp e, job j,
        salary_grade s,
        dept d
where   e.salary between s.low_sal and s.high_sal
and     e.job_id = j.job_id
and     e.dept_id = d.dept_id
order by s.grade desc;


select  e.emp_id,
        e.emp_name,
        j.job_title,
        e.salary,
        s.grade
from  emp e, job j, salary_grade s,
      dept d
where e.job_id = j.job_id
and e.salary between s.low_sal and s.high_sal
and e.dept_id =d.dept_id;

        
--TODO 부서별 급여등급이(salary_grade.grade) 1인 직원있는 "부서별로 1등급 부서이름(dept.dept_name)과 1등급인 직원수 조회."" 
--직원수가 많은 부서 순서대로 정렬.

select  count(*),
        d.dept_name
from    emp e,
        dept d,
        salary_grade s
where   s.grade = 1
and     e.dept_id = d.dept_id
and     e.salary between s.low_sal and s.high_sal
group by d.dept_id,d.dept_name
order by 1 desc;



select  
        d.dept_name,  -- d 는 테이블에 유일한 컬럼이면 안써도 되지만 어떤것은 쓰고 어떤건ㅅ은 안쓰고 하면 헷갈려서 써준다.
        count(*)
from salary_grade s,dept d , emp e
where s.grade =1
and e.salary between s.low_sal and s.high_sal
and e.dept_id = d.dept_id
group by d.dept_id,d.dept_name
order by count(*) desc;
--select * from salary_grade;
--
--select  d.dept_name,
--        count(*) 직원수 
--from emp e join dept d on e.dept_id = d.dept_id
--           join salary_grade s on e.salary between s.low_sal and s.high_sal
--where s.grade = 1
--group by d.dept_id, d.dept_name   -- 프라이머리 값을 해야 분류가 잘된다 // dept_name 은 같은 값을 가진 값이 많기 때문에 id(pk값)으로 그룹하는게 좋다.
--order by 1;


/* ****************************************************
Self 조인
- 물리적으로 하나의 테이블을 두개의 테이블처럼 조인하는 것.// 게층 관계의 특정컬럼이 프라이머리키를 참조//두개의 테이블로 나눈다고 생각하고 조회하면  
**************************************************** */
--직원의 ID(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name)을 조회

select  e1.emp_id"직원id",
        e1.emp_name"부하직원",
        e2.emp_name"상사이름"
        
from emp e1 join emp e2 on e1.mgr_id = e2.emp_id;




select  e1.emp_id ,
        e1.emp_name 직원이름,
        e1.mgr_id,
        e2.emp_name 상사이름,
        e2.salary
from emp e1 join emp e2 on e1.mgr_id = e2.emp_id; -- e1: 부하직원table  e2:상사직원 table



select * from emp
where emp_id=100;


select  e1.emp_id ,
        e1.emp_id 직원이름,
        e1.mgr_id,
        e2.emp_name 상사이름,
        e2.salary
from emp e1, emp e2
where e1.mgr_id = e2.emp_id;

-- TODO : EMP 테이블에서 직원 ID(emp.emp_id)가 110인 직원의 급여(salary)보다 많이 받는 직원들의 id(emp.emp_id), 
-- 이름(emp.emp_name), 급여(emp.salary)를 직원 ID(emp.emp_id) 오름차순으로 조회.

select  e1.emp_name,
        e1.salary,
        e1.emp_id
        
from emp e1 join emp e2 on e1.salary >e2.salary
where e2.emp_id = 110;







select * from emp
where emp_id=110;  --8200

select  e2.emp_id,
        e2.emp_name,
        e2.salary
from emp e1 join emp e2 on e1.salary < e2.salary
where e1.emp_id =110
order by e2.salary;--e1 은 id 110  e2: 조회할 직원정보 110보다 급여 많은애



/* ****************************************************
아우터 조인 (Outer Join)

- 조인테이블에 소스테이블의 행은 모두 붙이고 타겟 테이블의 행은 조인 연산을 만족하는 것만 붙인다.

-불충분 조인 (조인 연산시 한쪽의 행이 불충분 해도 붙이도록) 
 - 소스(완전해야하는테이블)가 왼쪽이면 left join, 오른쪽이면 right join 양쪽이면 full outer join

-ANSI 문법
from 테이블a [LEFT | RIGHT | FULL] OUTER JOIN 테이블b ON 조인조건// 소스테이블의 방향 즉 모든 데이터가 나올 테이블 방향

- OUTER는 생략 가능.  // 대신 방향이 꼭 들어가니까  inner 와 구분이간다. ..

-오라클 JOIN 문법
- FROM 절에 조인할 테이블을 나열
- WHERE 절에 조인 조건을 작성
    - 타겟 테이블에 (+) 를 붙인다.
    - ""FULL OUTER JOIN은 지원하지 않는다.""
- OUTER는 생략 할 수 있다.	
**************************************************** */
-- 직원의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 부서명(dept.dept_name), 부서위치(dept.loc)를 조회 --.모든직원 정보 부서명부서위치. 
-- 부서가 없는 직원의 정보도 나오도록 조회. <<<(부서정보는 null)>>>. dept_name의 내림차순으로 정렬한다.
-- 소스 emp  타겟 dept



select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name,
        d.loc
from    emp e left join dept d on e.dept_id = d.dept_id
order by  4 desc;   -- dept_name 과 d.loc 가 null이라 매치가 안되지만 아우터 조인 이기때문에 조회가 되었다.

select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name,
        d.loc
from    emp e join dept d on e.dept_id = d.dept_id
order by  4 desc;     -- 이너 조인







select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name,
        d.loc
--from emp e left outer join dept d on e.dept_id = d.dept_id
from dept d right outer join emp e on d.dept_id = e.dept_id
order by dept_name desc;

select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name,
        d.loc
from    emp e ,dept d
where   e.dept_id = d.dept_id(+)  -- 플러스 빠지면 이너 조인이되서 널값을 제외한 데이터가 반환된다.
--where  d.dept_id(+)=e.dept_id    right 조인 
order by d.dept_id desc;


-- 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id)를 조회하는데 !!!!!!! 
-- 부서_id가 80 인 직원들은(직원들만) 부서명(dept.dept_name)과 부서위치(dept.loc) 도 같이 출력한다. (부서 ID가 80이 아니면 null이 나오도록)

select  e.emp_id,
        e.emp_name,
        e.dept_id,
        d.dept_name,
        d.loc
from    emp e left join dept d on e.dept_id = d.dept_id and d.dept_id = 80;

--from emp e,dept d
where e.dept_id = d.dept_id (+)
and d.dept_id(+) = 80;

-- 그냥 where 절에 dept_id = 80 이라고 넣으면 부서 id가 80 인 직원들만 나온다.
-- 근데 문제에서 모든 직원을 조회하고 dept_id가 80인 직원만 부서명과 부서위치를 추가 적으로 조회하라고 햇으니까 (80이 아닌 직원은 null)이것은 
--'join'에 대한 조건이기때문에 where 가아니라 from 에 join에 추가해준것이다.


select e.emp_id,
        e.emp_name,
        e.dept_id,  --d. dept _id 일때는 80인 애들만 나오지만 e.dept_id 조건에 안 맍는거지 값은 갖고 있으니까 가 나온다. 
        d.dept_name, --d.dept_id 로 하면 80이 아닌애들은 'null' 이니까  // 소스테이블은 값이 다나오자노아 // 
        d.loc
from emp e left outer join dept d on e.dept_id = d.dept_id and d.dept_id =80; 

-- 주로 타겟테이블에 추가 조건을 붙인다.//이너조인은 결과가 어차피똑같다 값이 없으면 안갖고오니까
--where d.dept_id = 80;  -- from 에서 조인 테이블을 만들고 나서 // 80이아닌 애들을 where 가 걸렀다.
--80인 직원들만 조회된다. 하지만 예제에서는 모든 직원들의 이름 부서 아이디 까지 나오고 80 인애들은 추가로 부서명과 위치까지 나오게 해야한다.
--  where 는 from 에서  조인 테이블(가상의 테이블)을 다만들고 조건에 안맞는건 다자른거고
--  from  에 조건을 마저 넣었을때는 애초에 처음부터 조건에 맞는 애들을 픽하고 없는애들은 null(outer join 이니까./ inner 는 널을 안넣고 다빼버리잖아!)을 넣는다.
-- 작동하는 순서가 from 이먼저고 where 이라는 것을 잊지 말고 생각해보면 된다.
-- 오라클 문법 
select e.emp_id,
        e.emp_name,
        e.dept_id,  --d. dept _id 일때는 80인 애들만 나오지만 e.dept_id 조건에 안 맍는거지 값은 갖고 있으니까 가 나온다. 
        d.dept_name, --d.dept_id 로 하면 80이 아닌애들은 'null' 이니까  // 소스테이블은 값이 다나오자노아 
        d.loc
from emp e, dept d -- 여기는 join 할 테이블만 넣고 
where e.dept_id = d.dept_id(+)  -- join 연산
and    d.dept_id= 80;  -- 행에대한 조건 where 에 넣엇을 때랑 같은 값이 나온다.


select e.emp_id,
        e.emp_name,
        e.dept_id,  --d. dept _id 일때는 80인 애들만 나오지만 e.dept_id 일때는 소스테이블이니까 조건에 안 맞아도 값은 갖고 있으니까 다 온다. 
        d.dept_name, --d.dept_id 로 하면 80이 아닌애들은 'null' 이니까  // 소스테이블은 값이 다나오자노아 
        d.loc
from emp e, dept d  -- 여기는 join 할 테이블만 넣고 
where e.dept_id = d.dept_id(+)  -- join 연산 // 여기서 타겟 테이블에 (+) 추가 
and    d.dept_id(+)= 80;  -- 타겟테이블 에 대한 join 연산



-- 질의 결과 복사해서 엑셀에 복사 붙여넣기 하면 볼수 있다.

--TODO: 직원_id(emp.emp_id)가 100, 110, 120, 130, 140인 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title) 을 조회. 
-- 업무명이 없을 경우 '미배정' 으로 조회  ---> null 인경우도 출력 하라는 말이니까

select  e.emp_id,
        e.emp_name,
        nvl(j.job_title,'미배정')"업무명"
from    emp e left join job j on e.job_id = j.job_id
where   e.emp_id in (100,110,120,130,140);



select  e.emp_id,
        e.emp_name,
        nvl(j.job_title,'미배정')
from emp e left join job j on e.job_id = j.job_id 
where emp_id in (100,110,120,130);

-- inner join  null 값을 반환하지 않으니까 미배정 또한 없다.
select  e.emp_id,
        e.emp_name,
        nvl(j.job_title,'미배정')
from emp e join job j on e.job_id = j.job_id 
where emp_id in (100,110,120,130);

-- 오라클 
select  e.emp_id,
        e.emp_name,
        nvl(j.job_title,'미배정')
from emp e, job j
where e.job_id = j.job_id(+)
and emp_id in (100,110,120,130);

select*
from emp
where emp_id in (100, 110, 120, 130, 140);


--TODO: 부서의 ID(dept.dept_id), 부서이름(dept.dept_name)과 그 부서에 속한 직원들의 수를 조회. 
--      직원이 없는 부서는 0이 나오도록 조회하고 직원수가 많은 부서 순서로 조회.

select  d.dept_id,
        d.dept_name,
        count(e.emp_id)"직원수" -- 직원 관련 pk 컬럼 count() not null 이어야 하니까
       -- count(*) 를 하면 행수를 세기 때문에 소스테이블의 행을 다 count
       --(dept는 소스테이블이라 다 나온다)를 다 count 하기때문에 직원수가 없어도 행을 count한다. 
from dept d left join emp e on e.dept_id = d.dept_id
group by d.dept_id,d.dept_name;




select  d.dept_id,
        d.dept_name,
        count(emp_id)  -- 직원 관련 pk 컬럼 count() not null 이야야 하니까
from dept d left join emp e on e.dept_id = d.dept_id

group by d.dept_id, d.dept_name
order by 3 desc;

select  d.dept_id,
        d.dept_name,
        count(*)
from dept d , emp e --순서 상관은 없다.
where d.dept_id = e.dept_id(+)
group by d.dept_id, d.dept_name
order by 3 desc;


-- * 는 행수를 세기 때문에  그리고 부서가 소스테이블이라 값이 널이 라도 나오니까 행을 세면 직원이 없는 부서의 행 까지 세서 반환한다.
--/직원수를 보려면 emp_id로 해야한다. 조건에 맞지않아 null 인애들을 빼고 세니까


-- TODO: EMP 테이블에서 부서_ID(emp.dept_id)가 90 인 직원들의 id(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name), 
--입사일(emp.hire_date)을 조회.  입사일은 yyyy-mm-dd 형식으로 출력  //셀프 조인>?
--부하 e1// 상사 e2
select  e1.emp_id,
        e1.emp_name,
        e2.emp_name"상사이름",
        e1.dept_id,
        to_char(e1.hire_date,'yyyy-mm-dd')
from    emp e1, emp e2
where   e1.mgr_id = e2.emp_id(+)
and     e1.dept_id = 90;


select  e1.emp_id,
        e1.emp_name,
        e2.emp_name"상사이름",
        e1.dept_id,
        to_char(e1.hire_date,'yyyy-mm-dd')
from    emp e1 join emp e2 on e1.mgr_id = e2.emp_id
where   e1.dept_id = 90;

90	100	Steven	Steven	2003-06-17
90	101	Neena	Steven	2005-09-21
90	102	Lex	Steven	2001-01-13





select *
from emp
where dept_id = 90;

select  e1.dept_id,
        e1.emp_id "직원 id",
        e1.emp_name 직원이름,
        e2.emp_name 상사이름,
        to_char(e1.hire_date, 'yyyy-mm-dd')"직원 입사일"
from emp e1 left join emp e2 on e1.mgr_id = e2.emp_id
            
where   e1.dept_id = 90 ;
            

select  e1.dept_id,
        e1.emp_id "직원 id",
        e1.emp_name 직원이름,
        e2.emp_name 상사이름,
        to_char(e1.hire_date, 'yyyy-mm-dd')"직원 입사일"
from emp e1, emp e2
where e1.mgr_id = e2.emp_id(+)
and e1.dept_id = 90 ;     
        
        
--TODO 2003년~2005년 사이에 입사한 직원의 id(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 입사일(emp.hire_date),
--     상사이름(emp.emp_name), 상사의입사일(emp.hire_date), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.
-- 2003년에서 2005년 사이 입사한 직원은 모두 나오도록 조회한다.    -- emp job emp(상사) dept  4개의 테이블이 필요함 물리적으론 3개지만  
-- fk 가 not null 이면 inner 를 쓰면 되고 null 이 가능하면 outer 가 나을 수 있고 둘다 모르겠으면 outer 조인을 하면 된다.!!
-- 소스 e1( 직원)

select  e1.emp_id,
        e1.emp_name,
        j.job_title,
        e1.salary,
        e1.hire_date,
        e2.emp_name 상사이름,
        e2.hire_date 상사입사일,
        d.dept_name,
        d.loc,
        d2.dept_name"상사 부서이름",
        d2.loc "상사 부서위치"
from    emp e1 left join emp e2 on e1.mgr_id = e2.emp_id
               left join job j  on e1.job_id = j.job_id
               left join dept d on e1.dept_id = d.dept_id
               left join dept d2 on e2.dept_id= d2.dept_id
where to_char(e1.hire_date,'yyyy') between 2003 and 2005;


select  e1.emp_id "직원 ",
        e1.emp_name,
        j.job_title,
        e1.salary,
        e1.hire_date,
        e2.emp_name "상사이름",
        e2.hire_date,
        d.dept_name"직원 부서명",
        d.loc "직원부서의 위치",
        d2.loc"상사부서 위치"
        
from emp e1 left join job j on e1.job_id= j.job_id
            left join emp e2 on e1.emp_id =  e2.emp_id
            left join dept d on e1.dept_id = d.dept_id   -- d: 직원의 부서
            left join dept d2 on d2.dept_id = e2.dept_id  --d2: 상사의 부서
where to_char(e1.hire_date,'yyyy') between '2003' and '2005'
order by 1; 


select e1.* , j.*
from emp e1 left join job j on e1.job_id= j.job_id
            left join emp e2 on e1.emp_id =  e2.emp_id
            left join dept d on e1.dept_id = d.dept_id   -- d: 직원의 부서
            left join dept d2 on d2.dept_id = e2.dept_id  --d2: 상사의 부서
where to_char(e1.hire_date,'yyyy') between '2003' and '2005'
order by 1; 


--오라클  

select  e1.emp_id "직원 ",
        e1.emp_name,
        j.job_title,
        e1.salary,
        e1.hire_date,
        e2.emp_name "상사이름",
        e2.hire_date,
        d.dept_name"직원 부서명",
        d.loc "직원부서의 위치",
        d2.loc"상사의 부서명"
from emp e1, job j ,emp e2,dept d,dept d2
where e1.job_id = j.job_id(+)
and     e1.mgr_id = e2.emp_id(+)
and     e1.dept_id = d.dept_id(+)
and     d2.dept_id(+) = e2.dept_id
and to_char(e1.hire_date,'yyyy') between '2003' and '2005'
order by 1;
