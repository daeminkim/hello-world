/* **************************************************************************
집계(Aggregation) 함수와 GROUP BY, HAVING
************************************************************************** */

/* ************************************************************
집계함수, 그룹함수, 다중행 함수
- 인수(argument)는 컬럼. -- 
  - sum(): 전체합계
  - avg(): 평균
  - min(): 최소값
  - max(): 최대값
  - stddev(): 표준편차
  - variance(): 분산  --표준 편차의 제곱
  - count(): 개수
        - 인수: 
            - 컬럼명: null을 제외한 개수  -- 널은 값이없는 거니까 
            -  *: 총 행수(null을 포함)

- count(*) 를 제외하고 모든 집계함수는 null은 빼고 계산한다.
- sum, avg, stddev, variance: number 타입에만 사용가능.
- min, max, count :  모든 타입에 다 사용가능.
************************************************************* */

-- EMP 테이블에서 급여(salary)의 총합계, 평균, 최소값, 최대값, 표준편차, 분산, 총직원수를 조회 
select  sum(salary),
        round(avg(salary),2),
        min(salary),
        max(salary),
        round(stddev(salary),2),
        round(variance(salary),2)
from     emp;








-- EMP 테이블에서 가장 최근 입사일(hire_date)과 가장 오래된 입사일을 조회
select min(hire_date)"가장오래",
       max(hire_date)"가장 최근"
from emp;



-- EMP 테이블의 부서(dept_name) 의 개수를 조회
select count(distinct dept_name)
from emp;


select count(dept_name)
from emp;



-- emp 테이블에서 job 종류의 개수 조회
select count(distinct job)
from emp;

select count(distinct dept_name)
from emp;

select count(distinct nvl(dept_name, '미배치'))"부서명"
        
-- count 가 null을 세지 않으니까 nvl을 이용해서 널값을 넣어 주고 카운트를 한다.

from emp;



--TODO:  커미션 비율(comm_pct)이 있는 직원의 수를 조회
select count(*)
from   emp
where  comm_pct is not null;

select   
       count(*)"커피션O"
from emp 
where comm_pct is not null;


select count(comm_pct)
from emp;


--TODO: 커미션 비율(comm_pct)이 없는 직원의 수를 조회
select count(*)
from   emp
where  comm_pct is null;




select count(emp_id),  
       count(*)"커미션x"
from emp 
where comm_pct is  null;


select count(*) - count(comm_pct)
from emp;



--TODO: 가장 큰 커미션비율(comm_pct)과 과 가장 적은 커미션비율을 조회
select  min(comm_pct),
        max(comm_pct)
from    emp;






select max(comm_pct),
       min(comm_pct)
from   emp;   -- null 은 다 제외하고 

--TODO:  커미션 비율(comm_pct)의 평균을 조회. 
--소수점 이하 2자리까지 출력

select round(sum(comm_pct)/count(comm_pct),2)
from   emp;

select  round(avg (comm_pct),2),
        round(avg (nvl(comm_pct,0)),2) -- nvl을 이용해서 null 을 0으로 만들어서 평균을 구했다.
from emp;


                                --커미션이 없는 (널은) 직원 빼고  다더해서 나눈거 
select round(avg(comm_pct),2),  --커미션이 있는 직원들의 평균 커미션// 전체 직원이의 평균이 아님
       round(avg(nvl(comm_pct,0)),2)  -- 커미션이 없는 사람은 0 을 넣고 전체직원의 커미션 평균
from   emp;                    



--TODO: 직원 이름(emp_name) 중 사전식으로 정렬할때 가장 나중에 위치할 이름을 조회.
select emp_name
from   emp
order by 1 desc;



select max(emp_name)   --max 알파벳 제일 마지막거// min 알파벳 제일 처음 
from emp;

select emp_name from emp order by 1 desc;


--TODO: 급여(salary)에서 최고 급여액과 최저 급여액의 차액을 출력

select max(salary)-min(salary)
from  emp;




select max(salary)-min(salary)"급여 차액"
from emp;

--TODO: 가장 긴 이름(emp_name)이 몇글자 인지 조회.
select max(length(emp_name))
from emp;

select emp_name
from emp
where length(emp_name)=(select max(length(emp_name)) from emp);






select max(length(emp_name))
from emp;

select emp_name
from emp
where length(emp_name) = (select max(length(emp_name)) from emp);
--where length(emp_name) = max(length(emp_name)) ; --where 절에는 그룹합수(집계함수)를 사용 못함.

--TODO: EMP 테이블의 부서(dept_name)가 몇종류가 있는지 조회. 

select  count(distinct(dept_name))"null 제외",
        count(distinct nvl(dept_name,'이름 없음'))"null 포함"
from    emp;

--NVL2("값", "지정값1", "지정값2")
-- NVL("값", "지정값")


-- 고유값들의 개수
select count(distinct nvl(dept_name,'이름 없음'))"부서 종류null 포함",
       count(distinct dept_name)"null제외 한 부서"
       --distinct nvl(dept_name,'이름 없음')
from emp;



/* *****************************************************
group by 절
- 특정 컬럼(들)의 <<<<값>>>별로 나눠 집계할 때 나누는 <<<<기준컬럼>>>>>>을 지정하는 구문.
--컬럼의 값별로 분류할때
	- 예) 업무별 급여평균 (job 별). 부서-업무별 급여 합계. 성별 나이평균
- 구문: group by 컬럼명 [, 컬럼명]
	- 컬럼: 분류형(범주형, 명목형) - 부서별 급여 평균, 성별 급여 합계
	- select의 where 절 다음에 기술한다.
	- select 절에는 group by 에서 선언한 컬럼들만 집계함수와 같이 올 수 있다
*******************************************************/

-- 업무(job)별 급여의 총합계, 평균, 최소값, 최대값, 표준편차, 분산, 직원수를 조회

select  job,
        sum(salary),
        round(avg(salary),2),
        min(salary),
        max(salary),
        count(*)
        
from    emp
group by job;
        



select  job,
        sum(salary) "sum",
        round(avg(salary),2) "avg",
        min (salary)"min",
        max (salary)"max",
        round(stddev(salary),2) "stddev",
        round(variance(salary),2)"var",
        count(*)"count"
from    emp
group by job;

--select distinct job from emp;


-- 입사연도 별 직원들의 급여 평균.
select  --to_char(hire_date,'yyyy')입사연도,
        round(avg(salary),2)평균
        
from    emp
--group by to_char(hire_date,'yyyy');
group by extract( year from hire_date);



select  extract (year from hire_date),
        round(avg(salary),2)
from   emp
group by extract (year from hire_date);


-- 부서명(dept_name) 이 'Sales'이거나 'Purchasing' 인 직원들의 업무별 (job) 직원수를 조회

select  job,
        dept_name,-- select 절에는 group by 에서 선언한 컬럼들만 집계함수와 같이 올 수 있다
        count(*)
from    emp
where  dept_name in('Sales','Purchasing')
group by dept_name,job;


select dept_name,
        job,
        count(*)"직원수"
from emp
where dept_name in ('Sales','Purchasing')
group by dept_name,job

order by 1; 








-- 부서(dept_name), 업무(job) 별 최대 평균급여(salary)를 조회.
select  job,
        dept_name,
        round(avg(salary),2)"평균급여"
from   emp
group by job,dept_name
order by 3 ;

select salary
from    emp;

select min(salary)
from    emp;






select  dept_name,
        job,
        max(salary)"최대 급여"
from emp
group by dept_name,job
order by 3 desc;



select  dept_name,
        job,
        max(salary)"최대급여 "
from emp
group by dept_name,job
order by 3;



-- 급여(salary) 범위별 직원수를 출력. 급여 범위는 10000 미만,  10000이상 두 범주.

select  count(*),
        case when salary <10000 then '10000미만'
            else '10000이상' end "범주"
from emp
group by case when salary <10000 then '10000미만'
            else '10000이상' end;
--DECODE함수와 CASE 문
--  함수에 내용 더있음 예제도 
--- 동등비교 
--decode(컬럼, [비교값, 출력값, ...] , else출력) 
---decode(): 오라클 함수 
--
---case 표준 구문
--case문 동등비교 -- 표준 구문 어디서든 쓸수 이ㅆ다.
--case 컬럼 when 비교값'10' then 출력값 'A'
--              [when 비교값20 then 출력값'B']
--              [else 출력값]
--              end  -- 생략하면 null 값임
--              
--case문 조건문
--case when 조건 then 출력값
--       [when 조건 then 출력값]
--       [else 출력값]
--       end
--       -- 조건 : where 절의 조건문 같은것들이 들어온다.








select case when salary <10000 then '10000 미만'
            else '10000이상' end "범주",
        count(*)
from emp
group by case when salary <10000 then '10000 미만'
            else '10000이상' end ;



--TODO: 부서별(dept_name) 직원수를 조회
select  dept_name,
        count(*)
from emp
group by dept_name;






select  dept_name"부서이름",
        count(*)"직원수"
from emp
group by dept_name;


--TODO: 업무별(job) 직원수를 조회. 직원수가 많은 것부터 정렬.

select  job,
        count(*)
from   emp
group by job
order by 2 desc;










select  job,
        count(*)"직원수"
from  emp
group by job
order by 2 desc;

--TODO: 부서명(dept_name), 업무(job)별 직원수, 최고급여(salary)를 조회. 부서이름으로 오름차순 정렬.

select  dept_name,
        job,
        count(*),
        max(salary)
from emp
group by  dept_name,job
order by  dept_name;







select  dept_name,
        job,
        max(salary)"최고 급여",
        count(*)
from    emp
group by dept_name,job
order by dept_name ;

select * from emp
order by dept_name ;


--TODO: EMP 테이블에서 입사연도별(hire_date) 총 급여(salary)의 합계을 조회. 
--(급여 합계는 자리구분자 , 를 넣으시오. ex: 2,000,000)
select  extract( year from hire_date)연도,
        --to_char(hire_date,'yyyy'),
        ltrim (to_char(sum(salary),'999,999,999'))급여
from    emp
--group by to_char(hire_date,'yyyy');
group by extract( year from hire_date);






select  trim(extract (year from hire_date))"연도",
        to_char(sum(salary),'fm$9,999,999')"합계"
from emp
group by extract (year from hire_date)
order by 1;
--group by to_char(hire_date,'yyyy')


--TODO: 업무(job)와 입사년도(hire_date)별 평균 급여(salary)을 조회
select  to_char(hire_date,'yyyy')연도,
        job 업무,
        round(avg(salary),2) "평균 급여"
from emp 
group by job,to_char(hire_date,'yyyy')
order by 1;


select  job"업무",
        extract(year from hire_date)"입사년도",
        round(avg(salary),2)"평균급여"

from emp
group by job,extract(year from hire_date)
order by 2;



--TODO: 부서별(dept_name) 직원수 조회하는데 부서명(dept_name)이 null인 것은 제외하고 조회.
select  dept_name,
        count(*)
from    emp
where   dept_name is not null
group by dept_name;







select  dept_name,
        count(*)
from emp
where dept_name is not null
group by dept_name
order by 1;

select emp_id from emp;


--TODO 급여 범위별 직원수를 출력. 급여 범위는 5000 미만, 5000이상 10000 미만, 10000이상 20000미만, 20000이상. 
select  
        case when salary <5000 then '5000미만'
              when salary <10000 then '5000이상~10000미만'
              when salary <20000 then  '10000이상~20000미만'
              else '20000이상' end "급여범위",
        count(*)

from    emp
group by case when salary <5000 then '5000미만'
              when salary <10000 then '5000이상~10000미만'
              when salary <20000 then  '10000이상~20000미만'
              else '20000이상' end; 
              
              


select case   when salary < 5000 then '5000미만'
              when salary <10000 then '10000미만'
              when salary < 20000 then '20000미만'
              else '20000이상' end "급여 범위",
        count(*)
from emp
group by case when salary < 5000 then '5000미만'
              when salary <10000 then '10000미만'
              when salary < 20000 then '20000미만'
              else '20000이상' end 
order by 1;
              
              
select case   when salary < 5000 then '5000미만'
              when salary between 5000 and 9999.99 then '10000미만'
              when salary between 10000 and 19999.9 then '20000미만'
              else '20000이상' end "급여 범위",
        count(*)
from emp
group by case when salary < 5000 then '5000미만'
              when salary between 5000 and 9999.99 then '10000미만'
              when salary between 10000 and 19999.9 then '20000미만'
              else '20000이상' end 
order by 1;
              



/* **************************************************************
having 절
- 집계결과에 대한 행 제약 조건
- group by 다음 order by 전에 온다.
- 구문
    having 제약조건  --연산자는 where절의 연산자를 사용한다. 피연산자는 집계함수(의 결과)
    
    -- where 는 테이블에 있는 값만을 조회하는것// having d은 그룹을 통해 만들어진 값을조회
************************************************************** */
select  dept_name,
        count(*) "직원수"
from emp
group by dept_name
having count(*)>= 10  --집계결과를 비교 하여 True 인그룹만 남기겨서 부서명, 개수를 알려줌 
order by 2 desc;

-- 직원수가 10명 이상인 부서의(부서별) 급여합계 // having은 그룹을 거르고 select는 거기서 만족하는 애들의 값을 보여주는 것을 쓴다.

select sum(salary),
        dept_name,
        count(*)
from   emp
group by dept_name
having count(*)>= 10;





select  dept_name,
        to_char(sum(salary), 'fm999,999')"급여합계"
from    emp
group by dept_name
having count(*)>10;  -- 집계결과를 갖고 할때 




select  dept_name,
        to_char(sum(salary), '$999,999')"급여합계"
from emp
group by dept_name
having count(*)>= 10  --집계결과를 비교 하여 True 인그룹만 남기겨서 부서명, 개수를 알려줌 
order by 2 desc;


-- 직원수가 10 이상인 부서의 부서명(dept_name)과 직원수를 조회
select  dept_name"부서명",
        count(*)"직원수"
from emp
group by dept_name
having count(*)>=10;
 
--TODO: 15명 이상이 입사한 년도(연도 별) (그 해에) 입사한 직원수를 조회.
select  to_char(hire_date,'yyyy')입사년도,
        count(*)직원수
from    emp
group by  to_char(hire_date,'yyyy')
having  count(*)>=15;






select  extract( year from hire_date)"입사년도",
        count(*)"입사 직원수",
        max(salary)"그중 급여 top"
        
from   emp
group by extract( year from hire_date)
--group by to char(hire_date,'yyyy')
having count(*)>=15;

--TODO: 그 업무(job)을 담당하는 직원의 수가 10명 이상인 업무(job)명과 담당 직원수를 조회

select  job,
        count(*)
from    emp
group by job
having count(*)>=10;



select  job "업무",
        count(*)"직원수"
from  emp
group by job
having count(*) >=10;

--TODO: 평균 급여가(salary) $5000이상인 부서의 이름(dept_name)과 평균 급여(salary), 직원수를 조회

--select  dept_name,
--        salary,
--        count(*)
--from    emp
--where  avg(salary)>=5000; **where 에서는 그룹함수가 허가되지 않는다.

select  dept_name,
        round(avg(salary)),
        count(*)
from    emp
group by dept_name
having avg(salary)>=5000;

select dept_name 부서이름,
       ceil(avg(salary))평균급여,
       count(*)"직원수"
from   emp
group by dept_name
having avg(salary) >= 5000
order by 2;



--TODO: 평균급여가 $5,000 이상이고 총급여가 $50,000 이상인 부서의 부서명(dept_name), 평균급여와 총급여를 조회
select  dept_name,
        round(avg(salary),2)부서별평균급여,
        sum(salary)부서총급여
from    emp
group by dept_name
having round(avg(salary),2) >= 5000
and sum(salary) >= 50000;


select distinct(dept_name)
from emp;  -- 부서가 12개니까 부서별로 12 개 그룹으로 나눈뒤에 그룹별로(부서별) 평균급여 총급여를 구해서 select 한다.




select dept_name 부서이름,
       round(avg(salary),2)"평균 급여",
       sum(salary)총급여
from   emp
group by dept_name  -- 전체 그룹 12개로 나뉜다. 부서별 급여 평균을 select 에 넣음, 그리고 having에 맞는 애들 
having avg(salary) >= 5000 
and sum(salary)>=50000;

select distinct(dept_name)
from emp;

--TODO 직원이 """2명 이상인 부서들"""의 이름과 급여의 표준편차를 조회
        

select dept_name"부서명",
       round(STDDEV(salary),2)"표준 편차",
        count(*)"직원수"
from emp
group by dept_name
having count(*)>= 2; -- 1명일때는 표준편차가 의미가 없다.



/* **************************************************************
- rollup : group by의 확장.
  - group by로 묶어서 집계 할 경우 누적집계(중간집계나 총집계)를 부분 집계에 추가해서 조회한다.
  - 구문 : group by rollup(컬럼명 [,컬럼명,..])
  -- 맨 마지막엔 총 집계 



- grouping(), grouping_id()  -- 결과적으로는 grouping_id  만 쓰는게 나음 
  - rollup 이용한 집계시 컬럼이 각 행의 집계에 참여했는지 여부를 반환하는 함수.
  - case/decode를 이용해 레이블을 붙여 가독성을 높일 수 있다.
  - 반환값
	- 0 : 참여한 경우
	- 1 : 참여 안한 경우.
 

- grouping() 함수 //  롤업을 썻을때만 쓴다 
 - 구문: grouping(groupby컬럼)
 - select 절에 사용되며 rollup이나 cube와 함께 사용해야 한다.
 - group by의 컬럼이 집계함수의 집계에 참여했는지 여부를 반환
	- 반환값 0 : 참여함(부분집계함수 결과), 반환값 1: 참여 안함(누적집계의 결과)
 - 누적 집계인지 부분집계의 결과인지를 알려주는 알 수 있다. 



- grouping_id (함수)  // 롤업을 썻을때만 쓴다
  - 구문: grouping_id(groupby 컬럼, ..)
  - 전달한 컬럼이 집계에 사용되었는지 여부 2진수(0: 참여 안함, 1: 참여함)로 반환 한뒤 10진수로 변환해서 반환한다.
 
************************************************************** */

-- EMP 테이블에서 업무(job) 별 급여(salary)의 평균과 평균의 총계도 같이나오도록 조회.

select  nvl(job,'총계'),
        round(avg(salary),2)
from    emp
group by rollup (job);






select  job,
        round(avg(salary),2)"평균"
from    emp
group by rollup(job);


-- EMP 테이블에서 업무(JOB) 별 급여(salary)의 평균과 평균의 총계도 같이나오도록 조회.
-- 업무 컬럼에  소계나 총계이면 '총평균'을  일반 집계이면 업무(job)을 출력
select  decode(grouping(job),0,job,
                             1,'총계')job,
        round(avg(salary),2)"평균"
from    emp
group by rollup(job);


select  case grouping(job) when 0 then job
                           when 1 then '총계'
                           end job,
        round(avg(salary),2)"평균"
from    emp
group by rollup(job);






select  decode(grouping(job),0,job,     -- 0은 분류에썼던거니까 잡을 그대로 쓰면되고 1인거는 안쓰인거니까 총평균
                             1,'총평균') job,
        count(*) "직원수합계",
        round(avg(salary),2)"평균"
        
from    emp
group by rollup(job);

select case grouping (job) when 0 then job
                else '총평균' end job,
                
        count(*),
        round(avg(salary),2)"평균"
from emp 
group by rollup(job);


select  decode(grouping_id(job),0,job,     -- 0은 분류에썼던거니까 잡을 그대로 쓰면되고 1인거는 안쓰인거니까 총평균
                             1,'총평균') job,
        count(*) "직원수합계",
        round(avg(salary),2)"평균"
        
from    emp
group by rollup(job);






-- EMP 테이블에서 부서(dept_name), 업무(job) 별 salary의 합계와 직원수를 소계와 총계가 나오도록 조회

select  case grouping_id(dept_name,job) when 0 then nvl(dept_name,'미배치')||'-'||job
                                        when 1 then nvl(dept_name,'미배치')|| job||'-'||'소계'
                                        else '총계' end label,
        sum(salary),
        count(*)
from    emp
group by rollup (dept_name,job);







select  grouping(dept_name),
        grouping(job),
        sum(salary)"급여합계",
        round(avg(salary),2)"직원 평균"
from emp
group by rollup(dept_name, job)
order by 1;

-- dept_name  2의 1승  ,  job 2의 0제곱  // 각각 참여 여부를 곱해서 더함다. 
select grouping_id(dept_name, job),
--0, nvl(dept_name, '미배치')||'-'||job,
----                                          1, nvl(dept_name,'미배치')||' 소계',
----                                          3, '총계')label,
        count(*) "직원수 합계",
        round(avg(salary),2)"직원수 평균"
from emp
group by rollup(dept_name, job);



select decode(grouping_id(dept_name, job),0, nvl(dept_name, '미배치')||'-'||job,
                                          1, nvl(dept_name,'미배치')||' 소계',
                                          3, '총계')label,
        count(*) "직원수 합계",
        round(avg(salary),2)"직원수 평균"
from emp
group by rollup(dept_name, job);



--# 총계/소계 행의 경우 :  총계는 '총계', 중간집계는 '계' 로 출력
--TODO: 부서별(dept_name) 별 최대 salary와 최소 salary를 조회
select  dept_name,
        max(salary),
        min(salary)
from    emp
group by rollup (dept_name);







select  nvl(decode(grouping (dept_name),0,dept_name,
                                    1, '총계'),'미배치')"부서명",
        max(salary)"최대 급여",
        min(salary)"최소 급여"
from    emp
group by rollup (dept_name);










select decode((grouping_id(dept_name)),0,dept_name,
                                                  1,'총계 ') "dept_name",
       max(salary),
       min(salary)
from emp    
group by rollup(dept_name);


--TODO: 상사_id(mgr_id) 별 직원의 수와 총계를 조회하시오.
select  case grouping_id(mgr_id) when 1 then '총계'
                                 else nvl(to_char(mgr_id,'999'),'없음') end "mgr_id",
        count(*)
from emp 
group by rollup (mgr_id);


select decode(grouping_id(mgr_id),1,'총계',
                                 0,mgr_id)mgr_id,
       count(*)
from emp
group by rollup (mgr_id);







select  decode(grouping_id(mgr_id), 1, '총계', mgr_id) "상사 id",  -- decode ()의 반환값의 type을 첫행의 값에 맞춥니다.
                                                                -- 그래서 총계라는 문자열을 맨 첫 행에 두면 다음 반환값들이
        count(*)"직원수"                                          --문자가 아니여도 문자열로 자동으로 바꾸어 반환합니다.
from emp                                                         --여기선 직원수가 숫자 이므로 첫행에 문자를 넣어줘야 에러를 피할수있습니다.
group by rollup(mgr_id); 



--select  decode(grouping(mgr_id),0,mgr_id,
--                                1,'총계'),
--        count(*)   
--from emp
--group by rollup (mgr_id);   -- 이렇게 첫행이 숫자인데 마지막행을 문자컬럼으로 넣어주면 안됨

--TODO: 입사연도(hire_date의 year)별 직원들의 수와 연봉 합계 그리고 총계가 같이 출력되도록 조회.

select  decode(grouping_id(to_char(hire_date,'yyyy')),0,to_char(hire_date,'yyyy'),
                                                      1,'총계')입사년도,
                                                     
        count(*)직원수,
        sum(salary)연봉합계
from    emp 
group by rollup (to_char(hire_date,'yyyy'));
---case 로 해보기
select  case grouping_id(to_char(hire_date,'yyyy')) when 0 then to_char(hire_date,'yyyy')
                                                    else '총계' end 입사년도,
                                                     
        count(*)직원수,
        sum(salary)연봉합계
from    emp 
group by rollup (to_char(hire_date,'yyyy'));


select  decode(grouping_id(extract(year from hire_date)),1,'소계',
                                                        0,extract(year from hire_date))"입사년도",
                                                               
        count(*), 
        sum(salary)
        
from   emp
group by rollup(extract(year from hire_date));


select decode(grouping_id(to_char(hire_date,'yyyy')),1,'총계',to_char(hire_date,'yyyy'))"입사년도",
        count(*),
        sum(salary)
from emp
group by rollup(to_char(hire_date,'yyyy'));




--TODO: 부서별(dept_name), 입사년도별 평균 급여(salary) 조회. 부서별 집계와 총집계가 같이 나오도록 조회

select  decode(grouping_id(dept_name,extract( year from hire_date)),0,dept_name,
                                                                   1,nvl(dept_name,'없음')||'소계', 
                                                                   3,'총계')부서명,
        round(avg(salary),2)"평균 급여"
from emp
group by rollup (dept_name,extract( year from hire_date));










select decode(grouping_id(dept_name,to_char(hire_date,'yyyy')),
                                                            0, dept_name||'-'||to_char(hire_date,'yyyy'),
                                                            1,dept_name||'소계',
                                                            '총계')"laber",
        to_char(hire_date,'yyyy'),
        round(avg(salary),2) "평균급여"

from emp
group by rollup(dept_name,to_char(hire_date,'yyyy')); -- 두개다 만족하는애 와 부서가 null 인사람 평균 맨마지막은 전체 평균







--5 select 컬럼 dept_name,sum(salary)
--1 from 테이블  emp
--2 where 행 조건 is not null
--3 group by 그룹 기준 컬럼 (부서 등등) dept_name
--4 having ""그룹""을 나눠야 그룹에서  선택 조건을 찾음  count(*)>10
--6 order by 정렬 
