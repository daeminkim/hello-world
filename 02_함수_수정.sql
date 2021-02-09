/* *************************************
함수 - 문자열관련 함수
 UPPER()/ LOWER() : 대문자/소문자 로 변환
 INITCAP(): 단어 첫글자만 대문자 나머진 소문자로 변환
 LENGTH() : 글자수 조회
 LPAD(값, 크기, 채울값) : "값"을 지정한 "크기"의 고정길이 문자열로 만들고 모자라는 것은 왼쪽부터 "채울값"으로 채운다.
 RPAD(값, 크기, 채울값) : "값"을 지정한 "크기"의 고정길이 문자열로 만들고 모자라는 것은 오른쪽부터 "채울값"으로 채운다.
 SUBSTR(값, 시작index, 글자수) - "값"에서 "시작index"번째 글자부터 지정한 "글자수" 만큼의 문자열을 추출. 글자수 생략시 끝까지. 
 REPLACE(값, 찾을문자열, 변경할문자열) - "값"에서 "찾을문자열"을 "변경할문자열"로 바꾼다.
 LTRIM(값): 왼공백 제거
 RTRIM(값): 오른공백 제거
 TRIM(값): 양쪽 공백 제거
 ************************************* */
select  rtrim('   김대민 천재   '), 
        ltrim('   김대민 천재   '),
        trim('   김대민 천재   ')
from dual;

select rtrim('  mac북에   ')z,
        ltrim('   sql   ')z,
        trim('   깔고 싶어   ') z
from    dual;

select substr(123456789,2,5)--substr 값/ 시작 인덱스/ 글자수  / 값에서 시작 index부터 글자 수 까지 뽑아낸다./
from    dual;

select replace('김대민 바보','바보','천재')
from   dual;

select replace('김대민 잘생김','잘생김','귀여움')
from    dual;


select upper('abc'),
       lower('ABC'),
       INITCAP('asvbd  sdfhk sfd')  -- 각단어 의 첫번째글자
from dual;

select length('abcdef')
from dual;


select upper(emp_name)
from emp;

select *
from emp
where length(emp_name) >7;  --글자 개수


select * 
from emp 
where length(emp_name) >10;

select lpad('abc',10,'+') "A",  --글자수가 10개가 되게 '+'를 채운다. 문자열이라 ' ' 넣어야한다.
        length(lpad('abc',10)), -- 채울 문자를 주지않으면 공백으로 채운다.
        rpad('abc',10) "b",
       rpad('123456789',3) "c"   -- 문자수가 원래의 값보다 작으면 잘라낸다.
from dual;

select substr('123456789',2,5),   -- 2번째 글자부터 5번째글자ㅁ만 픽 한다.
        substr('123456789',2)          --  2번째부터 끝까지 
from dual;

select replace('010-1234-1234','010','###')from dual;
select trim ('  a   ') "A",
        ltrim('   a   ') "b",
        rtrim('   a   ') "c"
from dual;

--EMP 테이블에서 직원의 이름(emp_name)을 모두 대문자, 소문자, 첫글자 대문자, 이름 글자수를 조회
select upper(emp_name),
        lower(emp_name),
        initcap(emp_name),
        length(emp_name)
from emp;


-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 부서(dept_name)를 조회. 단 직원이름(emp_name)은 
--모두 대문자, 부서(dept_name)는 모두 소문자로 출력.
-- UPPER/LOWER

select emp_id,
        upper(emp_name),
        salary,
        lower(dept_name)
from    emp;





select  emp_id,
        upper(emp_name)"emp_name",
        salary,
        lower(dept_name)"부서 이름"
from    emp;
        
        
        

--(아래 2개는 비교값의 대소문자를 확실히 모르는 가정)
--TODO: EMP 테이블에서 직원의 이름(emp_name)이 PETER인 직원의 모든 정보를 조회하시오.



select  *
from    emp
where  upper(emp_name)='PETER';




select * from emp
where upper(emp_name)='PETER';



--TODO: EMP 테이블에서 업무(job)가 'Sh_Clerk' 인 직원의의  ID(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 조회


select  emp_id,
        emp_name,
        job,
        salary
from    emp 
where   initcap(job)='Sh_Clerk';

select  emp_id,
        emp_name,
        job,
        salary
from    emp
where   initcap(job) = 'Sh_Clerk';


--TODO: 직원 이름(emp_name) 의 자릿수를 15자리로 맞추고 글자수가 모자랄 경우 공백을 앞에 붙여 조회. 끝이 맞도록 조회
select lpad(emp_name,15)
from emp;

select lpad(emp_name,15)"직원 이름"   -- 공백 디폴트값이고// 아니면 채워넣을 문자를 넣으면됨ㅋ
from   emp;


--LPAD(값, 크기, 채울값) : "값"을 지정한 "크기"의 고정길이 문자열로 만들고 모자라는 것은 왼쪽부터 "채울값"으로 채운다.
    
--TODO: EMP 테이블에서 모든 직원의 이름(emp_name)과 급여(salary)를 조회.
--(단, "급여(salary)" 열을 길이가 7인 문자열로 만들고, 길이가 7이 안될 경우 왼쪽부터 빈 칸을 
-- '_'로 채우시오. EX) ______5000) -LPAD() 이용

select  emp_name,
        lpad(salary,7,'_')
from    emp;

select  emp_name,
        lpad(salary,7,'_') "급여",
        rpad(salary,7,'_')
from emp;






select  emp_name,
        lpad(salary,7,'*')"급여"
from    emp;

--to_char(salary, 'fm$999,999.00')"salary"

-- TODO: EMP 테이블에서 이름(emp_name)이 10글자 이상인 직원들의 이름(emp_name)과 이름의 글자수 조회select *

select  emp_name 이름,
        length(emp_name) 글자수
from    emp
where   length(emp_name)>=10;



select  emp_name,
        length(emp_name)"이름 글자수"
from emp
where length(emp_name) >10;




/* *************************************
함수 - 숫자관련 함수


-- 결과: 정수 , 실수
 round(값, 자릿수) : 자릿수이하에서 반올림 (양수 - 실수부, 음수 - 정수부, 기본값 : 0)
 trunc(값, 자릿수) : 자릿수이하에서 절삭(양수 - 실수부, 음수 - 정수부, 기본값: 0)-- 내림같은
 
 - 결과 : 정수
 ceil(값) : 올림
 floor(값) : 내림
 
 --
 mod(나뉘는수, 나누는수) : 나눗셈의 나머지 연산
 
************************************* */
select  round(124.234,1),
        trunc(567.654,-2),-- 소수점 자리수가 없다는 뜻 정수만 갖고온다. -1부터는 1의자리수 를 나ㅏ낸다. -2를 하면 500 이된다.
        ceil (8765.560),
        floor(9876.3456)
from    dual;

select round(1.2345,2),
        round(1.5678,2),
        round(1.2345,0)"k",  
        round(1.5676,0)"d",  -- 소수점은 숫자만큼 남겨둔다 생각하고 ,, 0은 1의 자리-1 십의자리 까지 표현 
        round(156.12,-1)
        
from dual;

select trunc(1.5678,2),
        trunc(156,-2)
from dual;

-- ceil/floor :실수 -> 정수 
select ceil(15.67),  --올림
        floor(15.67) -- 내림 
from dual;

select round(10/3 ,2)
from dual;

select mod(10,3) from dual;   -- 10을 3을로  나눴을대 나머지


--TODO: EMP 테이블에서 각 직원에 대해 직원ID(emp_id), 이름(emp_name), 급여(salary) 그리고 15% 인상된 급여(salary)를 
--조회하는 질의를 작성하시오.
--(단, 15% 인상된 급여는 올림해서 정수로 표시하고, 별칭을 "SAL_RAISE"로 지정.)

select  emp_id,
        emp_name,
        salary,
        ceil(salary*1.15) "SAL_RAISE"
from    emp;
        
select emp_id,
        emp_name,
        salary,
        ceil(salary*1.15) "SAL_RAISE"
from    emp;
        
    
--TODO: 위의 SQL문에서 인상 급여(sal_raise)와 급여(salary) 간의 차액을 추가로 조회 
--(직원ID(emp_id), 이름(emp_name), 15% 인상급여, 인상된 급여와 기존 급여(salary)와 차액)

select  emp_id,
        emp_name,
        ceil(salary*1.15)-salary"차액"
from    emp;







select emp_id,
        emp_name,
        ceil(salary*1.15) "SAL_RAISE",  -- 컬럼과 컬럼을 계산할때는 파생컬럼(파생변수)은 피연산자로 올 수 없다.
        
        ceil(salary*1.15)- salary "차액"
from    emp;


-- TODO: EMP 테이블에서 커미션이 있는 직원들의 직원_ID(emp_id), 이름(emp_name), 커미션비율(comm_pct),
-- 커미션비율(comm_pct)을 8% 인상한 결과를 조회.
--(단 커미션을 8% 인상한 결과는 소숫점 이하 2자리에서 반올림하고 별칭은 comm_raise로 지정)

select  emp_id,
        emp_name,
        comm_pct,
        round(comm_pct*1.08,2)"comm_rise"
from    emp
where   comm_pct is not null;





select  emp_id,
        emp_name,
        comm_pct,
        round(comm_pct *1.08,2)"comm_raise"
from emp
where    comm_pct is not null;

/* *************************************
함수 - 날짜관련 계산 및 함수

sysdate:실행시점의 일시!

Date +- 정수 : 일,날짜 계산.
months_between(d1, d2) -경과한 개월수(d1이 최근, d2가 과거)
add_months(d1, 정수) - 정수개월 지난 날짜. 마지막 날짜의 1개월 후는 달의 마지막 날이 된다. 
next_day(d1, '요일') - d1에서 첫번째 지정한 요일의 날짜. 요일은 한글(locale)로 지정한다.
last_day(d) - d 달의 마지막날.
extract(year|month|day from date) - date에서 year/month/day만 추출
************************************* */
select sysdate,
       to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')
from dual;  -- 실행한 날 // 매개 변수가 없으면 괄호 없음 // 함수임!!

select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')
from dual;

select sysdate +10,  -- 현재 10일후
        sysdate-10  -- 10일 전
from dual;

select  months_between('2020/08/15','2019/08/15'),  --months_between(d1,d2) d1,d2사이에 개월 수 계산
        months_between('2021/03/20','2020/04/29'),   -- 사이의 개울 수를 계산했는데 딱떨어지지 않을경우
        ceil(months_between('2021/03/20','2020/04/29')) --ceil 을 해서 해결 어차피 개월수는 지난거지
from dual;




select  months_between(sysdate, '2020/12/28')||'개월',
        months_between(sysdate, '2019/10/28')||'개월',   -- 앞에 최근 날짜를 써줘야함 
        ceil(months_between(sysdate, '2020/12/26'))||'개월'  -- ceil 을 써서 소수점으로 나오는 것을 올림으로 처리 했다.
from dual;

select add_months(sysdate,2)"2개월 후",  -- sysdate에 그냥 숫자를 더하면 날짜를 더하고 빼지만 add_months 를 월을 더한다.
        add_months(sysdate,-2)"2개월 전",-- sysdate 현재 부터 2개월 전 , 후
        add_months('2021/01/31',1)     -- 2월은 31일이 없어서  그달의 마지막 날이 나온다 계산 되는게 아니라
from    dual;
        
select  add_months('2030/02/23',2),
        add_months('2021/07/31',-2),
        next_day('2021/01/28','수요일')  -- 해당 날짜 다음에 바로오는 수요일의 날짜를 찾아준다.
from    dual;
 
        
        
from dual;

select next_day (sysdate,'금요일'),
        next_day(sysdate,'수요일')
from dual;

select last_day(sysdate)from dual; -- 그달의 마지막날
select last_day('2021/04/23') from dual;


select extract(year from '2021/04/23')
from    dual;



select extract(year from sysdate),
        extract(month from sysdate),
        extract(day from sysdate)
from dual;

select * from emp 
where extract (month from hire_date)= 11;  -- 11월에 입사한사람  hire_date 로부터 11월을 픽한다.


-- to_char(date값,'날짜형식')  : date를 문자열로 변환




--TODO: EMP 테이블에서 부서이름(dept_name)이 'IT'인 직원들의 '입사일(hire_date)로 부터 
--10일전', 입사일과 '입사일로 부터 10일후', 의 날짜를 조회. 

select  hire_date-10 "10일전",
        hire_date,
        hire_date+10 "10일후"
from    emp
where   dept_name = 'IT';




select  hire_date-10,
        hire_date,
        hire_date+10
from    emp
where   dept_name = 'IT';

--TODO: 부서가 'Purchasing' 인 직원의 이름(emp_name), 입사 6개월전과 입사일(hire_date), 6개월후 날짜를 조회.
select  emp_name,
        add_months(hire_date,+6),
        hire_date,
        add_months(hire_date,-6)
from    emp;

select emp_name,
       add_months(hire_date,-6) "6개월 전",
       hire_date"입사일",
       add_months(hire_date,+6) "6개월 후"
from   emp
where  dept_name = 'Purchasing';
    
     

--TODO: EMP 테이블에서 입사일과 입사일 2달 후, 입사일 2달 전 날짜를 조회.
select  emp_name,
        hire_date,
        add_months(hire_date,-2) "2달전",
        add_months(hire_date,+2) "2달후"
from    emp;





select emp_name,
       add_months(hire_date,-2) "2개월 전",
       hire_date"입사일",
       add_months(hire_date,+2) "2개월 후"
from   emp;

-- TODO: 각 직원의 이름(emp_name), 근무 개월수 (입사일에서 현재까지의 달 수)를 계산하여 조회.
--(단 근무 개월수가 실수 일 경우 정수로 반올림. 근무개월수 내림차순으로 정렬.)

select  emp_name,
        round(months_between(sysdate,hire_date))||'개월' "근무 개월"
from    emp
order by 2 desc;




select  emp_name,
        round(months_between(sysdate,hire_date))||'개월' "근무 개월수"
from    emp
order by 2 desc;
--order by "근무 개월수" desc;
--TODO: 직원 ID(emp_id)가 100 인 직원의 입사일 이후 첫번째 금요일의 날짜를 구하시오.
select next_day(hire_date,'금요일')
from    emp;





select  emp_id,
        next_day(hire_date,'금요일')
from emp
where emp_id = 100;


--next_day(sysdate,'수요일')

-- 기본적인 숫자나 날짜는 자동으로 바뀌기도 한다.

/* *************************************
함수 - 변환 함수

#####################################################################################
#				# = to_char() =>	#					#<=to_char()=	#			#
#   Number 타입	#					#  Character 타입	#				#  Date 타입	#
#				# <=to_number()=    #	    			#=to_date()=>	#			#
#####################################################################################

to_xxx(값, 형식)

to_char() : 숫자형, 날짜형을 문자형으로 변환
to_number() : 문자형을 숫자형으로 변환 
to_date() : 문자형을 날짜형으로 변환


형식(format)문자 
숫자 :
    0, 9 : 숫자가 들어갈 자릿수 지정. (9: 정수부 남는자리를 공백으로 채움, 0은 0으로 채움) - 실수부 남는 자리는 둘다 0으로 채운다.
           fm으로 시작하면 9일 경우 공백을 제거.
    . : 정수/실수부 구문자.
    ,: 정수부 단위구분자
    'L', '$' : 통화표시. L; 로컬통화기호// 오라클따라 다름
일시 :yyyy : 연도 4자리, yy: 연도 2자리(2000년대), rr: 연도2자리(50이상:90년대, 50미만:2000년대)
      mm: 월 2자리  (11, 05)
      dd: 일 2자리
      hh24: 시간(00 ~ 23) 2자리, hh(01 ~ 12)
      mi: 분 2자리
      ss: 초 2자리
      day(요일), 
      am 또는 pm : 오전/오후
************************************* */

-- 숫자 문자 // 문자 날짜// 끼리는 가능하지만 
-- 숫자 날짜 사이는 불가능 하다.

select 20+to_number('10,000','99,999') from dual; --to_number('값(문자)','형식(이런형식이다 라는걸 알려야함)')-->형식에 맞게 숫자로 바꿔야 한다는 것을
                                                    -- 알려주고 바꾸게 함

select 100+to_number('100,000','999,999')from dual;

select 10+to_number('1,000', '9,999') from dual;


select to_char(100000000, '999,999,999') 금액 from dual;
select to_char(100000000, '999,999,999,999') 금액 from dual;  -- 남는 자리수 앞부분을 공백으로 채웟다.
select to_char(100000000, '000,000,000,000') 금액 from dual;  -- 남는 자리수를 0 으로 채웟다.
 

select to_char(salary, 'fm9,999,999.00')금액  -- 결과를 보면 공백으로 채워졌어야하는데 fm 때문에 공백이 사라짐 /
from emp;                                       -- 그리고 실수부분은 0,9 둘다 0으로 채운다.

select to_char(salary, '9,999,999.99') 금액
from emp;

select 10+to_number('1,000.53', '9,999.99')
from dual;

select  to_char(12345678, '999,999,999')금액,  -- 바꿔야 되는 자리수 보다 형식으로 주어진자리수가 커서 앞에 공백으로 채웠다. 
        to_char(12345678, 'fm999,999,999')금,  -- fm 때문에 같은 값이지만 공백이없다.
        to_char(12345678, '999,999')금,        -- 문자열로 바꿔야하는 것보다 자리수가 적어서 결과값이 깨졌다.
        to_char(10000, '$99,999')금,         --  $ 표시 붙였고 L 은 로컬 통화 단위를 붙여준다.
        to_char(10000, 'L99,999')금
from dual;





select to_char(1234.567,'0,000.000'),
        to_char(1234.56, '000,000.000'),
        to_char(1234.56, '999,999.999')  -- 실수부는 둘다 0으로 표현 
from dual;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')"현재 시간 년월일",
        to_char(sysdate, 'yyyy')년도만,
        to_char(sysdate, 'day')날만,
        to_char(sysdate, 'dy')단축,
        to_char(sysdate, 'hh24:mi:ss')시간만,
        to_char(sysdate, 'yyyy"년"mm"월"dd"일"')
    
from dual;






select  to_char(sysdate,'yyyy/mm/dd hh24"시"mi"분"ss"초"'),
        to_char(sysdate,'yyyy"년도" mm"월" dd"일"'),
        to_char(sysdate, 'yyyy'),
        extract(year from sysdate)
from dual;

select to_date('2000/10', 'yyyy/mm')from dual;


-- EMP 테이블에서 업무(job)에 "CLERK"가 들어가는 직원들의 ID(emp_id), 이름(name), 업무(job), 급여(salary)를 조회
--(급여는 단위 구분자 , 를 사용하고 앞에 $를 붙여서 출력.)

select emp_id,
       emp_name,
        job,
        to_char(salary, 'fm$999,999.00')"salary"
from emp
where job LIKE '%CLERK%';


-- 문자열 '20030503' 를 2003년 05월 03일 로 출력.

select to_char(to_date('20030503', 'yyyymmdd'), 'yyyy"년"mm"월"dd"일"')
from dual;




-- TODO: 부서명(dept_name)이 'Finance'인 직원들의 ID(emp_id), 이름(emp_name)과 입사년도(hire_date) 4자리만 출력하시오. 
--(ex: 2004);  /// 이거 설명 잘듣기 !!
--to_char()

select  emp_id,
        emp_name,
        to_char(hire_date,'yyyy')
from    emp
where   dept_name = 'Finance';



select  emp_id,
        emp_name,
        extract(year from hire_date)
from emp;

select hire_date from emp;


select  emp_id,
        emp_name,
        to_char(hire_date, 'yyyy')"입사년도"
from emp
where dept_name = 'Finance';



--TODO: 직원들중 11월에 입사한 직원들의 직원ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회

select  emp_id,
        emp_name,
        hire_date
from    emp
--where   to_char(hire_date,'mm')=11;
where   extract(month from hire_date)=11;


--to_char()
select emp_id,
        emp_name,
        hire_date
from    emp
--where   to_char(hire_date,'mm')='11';   ---j외않돼
where extract (month from hire_date)= 11;

--TODO: 2006년에 입사한 모든 직원의 이름(emp_name)과 입사일(yyyy-mm-dd 형식)을 입사일(hire_date)의 오름차순으로 조회
--to_char()


select  emp_name,
        to_char(hire_date, 'yyyy-mm-dd')
from    emp
where   to_char(hire_date, 'yyyy')= 2006
order by hire_date;





select emp_name,
       to_char(hire_date,'yyyy-mm-dd')
from    emp
--where extract (year from hire_date) = 2006;
where to_char(hire_date, 'YYYY') ='2006';



--TODO: 2004년 05월 이후 입사한 직원 조회의 이름(emp_name)과 입사일(hire_date) 조회
select  emp_name,
        hire_date
from    emp
where   to_char(hire_date,'yyyymm') >200405
order by 2;






select emp_name,
        hire_date
from emp
--where hire_date > '2004/05/31'; 
where to_char(hire_date, 'yyyymm') > '200405'
order by 2;
  



--TODO: 문자열 '20100107232215' 를 2010년 01월 07일 23시 22분 15초 로 출력. (dual 테입블 사용)

select to_date('20100107232215','yyyymmddhh24miss')
from dual;  -->2010/01/07  결과


select to_char(to_date('20100107232215','yyyymmddhh24miss'),'yyyy"년" mm"월" dd"일" hh24"시" mi"분" ss"초"')
from dual;  -->2010년 01월 07일 23시 22분 15초 결과 
    --- 문자열을 date 타입으로 바꿔서 년도와 월 일 을 알려주고 , 다시 데이트 타입을 문자타입으로 바꾼다. 문자 타입을 문자타입으로 바꿀 수 없기 때문이다.



select to_char(to_date('20100107232215', 'yyyymmddhh24miss'),'yyyy"년" mm"월 "dd"일 "hh24"시 "mi"분 "ss"초"')
from dual;



--select to_char(to_date('20030503', 'yyyymmdd'), 'yyyy"년"mm"월"dd"일"')
--from dual;


/* *************************************
함수 - null 관련 함수 
NVL(expr,기본값) : expr 값이 null이면 기본값을 null이 아니면 exper 값을 반환
NVL2(expr, nn, null) - expr이 null이 아니면 nn, 널이면 세번째 반환
nullif(ex1, ex2) 둘이 같으면 null, 다르면 ex1

************************************* */
select NVL(null,0),
       nvl(null,'없음'),
       nvl(20,0)

from dual;

select nvl2(null, 'null아님', 'null임'),
        nvl2('dd', 'null아님', 'null임')
from    dual;

select nullif(10,10),
        nullif(20,10)
from dual;

-- EMP 테이블에서 직원 ID(emp_id), 이름(emp_name), 급여(salary), 커미션비율(comm_pct)을 조회. 
--단 커미션비율이 NULL인 직원은 0이 출력되도록 한다..
select  emp_id,
        emp_name,
        salary,
        nvl(comm_pct,0),
        nvl2(comm_pct,'커미션있음','커미션없음'),
       
from    emp;


select emp_id,
        emp_name,
        salary,
        nvl(comm_pct, 0) "커미션 유무",  --커미션이 null이면 기본값 '0'을 반환// null이아니면 comm_pct 값을 반환
        nvl2(comm_pct, '커미션 있음','커미션없음')"커미션 유무",  -- 커미션 유무 여부만 
        salary*nvl(comm_pct,0)
from emp;



--TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)을 조회. 
--부서가 없는 경우 '부서미배치'를 출력.

select  emp_id,
        emp_name,
        job,
        nvl(dept_name,'부서미배치')
from    emp
order by 4;





select  emp_id,
        emp_name,
        job,
        nvl(dept_name,'부서미배치')"부서 이름"
from    emp;

--TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션 (salary * comm_pct)을 조회. 
--커미션이 없는 직원은 0이 조회되록 한다.



select  emp_name,
        emp_id,
        salary,
        nvl(salary*comm_pct,0),
        nvl2(salary*comm_pct,'커미션 있음','커미션 없음')"커미션 유무"
from    emp;


select emp_id,
        salary,
        nvl(salary*comm_pct,'0') "커미션",
        NVL2(salary,salary*comm_pct,'')"커미션 2"  --다시 
from emp;


-------------------------------------------------

/* *************************************
DECODE함수와 CASE 문

- 동등비교 
decode(컬럼, [비교값, 출력값, ...] , else출력) 
-decode(): 오라클 함수 

-case 표준 구문
case문 동등비교 -- 표준 구문 어디서든 쓸수 이ㅆ다.
case 컬럼 when 비교값'10' then 출력값 'A'
              [when 비교값20 then 출력값'B']
              [else 출력값]
              end  -- 생략하면 null 값임
              
case문 조건문
case when 조건 then 출력값
       [when 조건 then 출력값]
       [else 출력값]
       end
       -- 조건 : where 절의 조건문 같은것들이 들어온다.

************************************* */
select  decode(dept_name, 'Shipping','배송',
                            'Sales','영업',
                            'Purchasing','구매',
                            'Marketing','마케팅',
                             null,'부서없음',
                             dept_name)dept,
        dept_name
from    emp
order by dept_name desc;

select decode(dept_name,  'Shipping','배송',
                          'Sales','영업',
                          'Purchasing','구매',
                          'Marketing','mk',
                          null,'부서 없음',
                          dept_name)dept,
        dept_name
from emp
order by dept_name desc;


select  dept_name, case dept_name when 'Shipping' then '배송'
                                when 'Sales'    then '영업'
                                else nvl(dept_name,'부서없음')end "dept"
                                
from  emp;
                            

select dept_name,
        case dept_name  when 'Shipping' then '배송'
                        when 'Sales' then '영업' 
                        when 'Purchasing' then '구매' 
                        else  nvl(dept_name,'부서 없음')end "DEPT"
from emp
order by 1 desc;


select dept_name real ,

            case when dept_name is null then '미배정' 
            else dept_name end dept_name
from emp
order by 1 desc;

select case when dept_name is null then '미배정'
            else dept_name end dept_name
from   emp;

--EMP테이블에서 급여와 급여의 등급을 조회하는데 급여 등급은 10000이상이면 '1등급', 10000미만이면 '2등급' 으로 나오도록 조회

select  salary,
        case when salary >=10000 then '1등급'
                    else '2등급' end
                    
from    emp;







select  salary,
        case when salary >= 10000 then '1등급'   -- 동등비교가 아니니까 case
             else '2등급'  end "salary"
from emp
order by 2;


--decode()/case 를 이용한 정렬
-- 직원들의 모든 정보를 조회한다. 단 정렬은 업무(job)가 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' 순서대로 먼저나오도록 한다. 
--(나머지 JOB은 상관없음)

select * from emp
order by decode (job, 'ST_CLERK', '1', 
                   'IT_PROG','2',
                   'PU-CLERK','3',
                   'SA_MAN','4',
                   job);



select *
FROM emp
order by decode(job, 'ST_CLERK', '1', 
                     'IT_PROG','2',
                     'PU-CLERK','3',
                     'SA_MAN','4',
                      JOB) ;
                    
select *
from emp
order by case job when 'ST_CLERK' then '1'
                  when 'IT_PROG' then'2'
                  when 'PU-CLERK'then'3'
                  when 'SA_MAN'then'4'
                  else job end ;

--TODO: EMP 테이블에서 업무(job)이 'AD_PRES'거나 'FI_ACCOUNT'거나 'PU_CLERK'인 직원들의 ID(emp_id), 이름(emp_name), 
--업무(job)을 조회. 
-- 업무(job)가 'AD_PRES'는 '대표', 'FI_ACCOUNT'는 '회계', 'PU_CLERK'의 경우 '구매'가 출력되도록 조회

select  emp_id,
        emp_name,
        case job when 'AD_PRES' then '대표'
                 when 'FI_ACCOUNT' then '회계'
                 when 'PU_CLERK'   then '구매'
                 else job end job
from    emp
where   job in ('AD_PRES','FI_ACCOUNT','PU_CLERK');


select  emp_id,
        emp_name,
        decode(job ,'AD_PRES' ,'대표',
                   'FI_ACCOUNT','회계',
                   'PU_CLERK','구매',
                    job)   ---- decode 는 무조건 , 로 구분을 하고 else 나 end 를 써줄 필요없이 그냥 마지막에 else 를 써주면 된다.
from    emp
where   job in ('AD_PRES','FI_ACCOUNT','PU_CLERK');





select  emp_id,
        emp_name,
        case job when 'AD_PRES' then '대표'
                 when 'FI_ACCOUNT' then '회계'
                 when  'FI_ACCOUNT'  then '구매'
                 else job end "job"
from    emp
order by 3 desc;

select  emp_id,
        emp_name,
        decode(job, 'AD_PRES', '대표',
                    'FI_ACCOUNT', '회계',
                    'FI_ACCOUNT', '구매')"job",
        case job when 'AD_PRES' then '대표'
                 when 'FI_ACCOUNT' then '회계'
                 when  'FI_ACCOUNT'  then '구매'
                 else job end "job2"
from emp
where job in ('AD_PRES','FI_ACCOUNT','FI_ACCOUNT');


--TODO: EMP 테이블에서 부서이름(dept_name)과 급여 인상분을 조회. 급여 인상분은 부서이름이 'IT' 이면 급여(salary)에 10%를 
--'Shipping' 이면 급여(salary)의 20%를 'Finance'이면 30%를 나머지는 0을 출력
-- decode 와 case문을 이용해 조회

select  dept_name,
        case when dept_name ='IT' then salary*0.1
             when dept_name = 'Shipping' then salary*0.2
             when dept_name = 'Finance' then salary*0.3
             else salary*0 end "급여 인상분",   -- 조건이 들어가나 값이 들어가냐에 따라 달라진다. // 이거는 case 조건문
        case dept_name when 'IT' then salary*0.1  -- 
                      when 'Shipping' then salary*0.2
                      when 'Finance'  then salary*0.3
                      else  salary*0 end "인상"
from    emp;


select  dept_name,
        salary "급여",
        case when dept_name = 'IT' then salary*0.10         -- 동등비교가 아니고 // 바로 조건을 넣어서 
             when dept_name = 'Shipping' then salary*0.20
             when dept_name = 'Finance' then salary*0.30
             else salary*0 end "급여인상분",
             
        decode (dept_name, 'IT', '인상안함',       -- decode 는 첫번째 컬럼의 타입과 같은 타입으로 맞춰진다.
                            'Shipping',salary*1.2,   -- 컬럼의 처음값에 숫자를 넣어도 문자열로 바꿔준다./ 
                            'Finance',salary*1.3,    --첫번째 컬럼의 타입을 기준으로 맞춰진다.
                            0)"인상된급여",
                            
        case  dept_name when'IT' then salary*0.10
                        when 'Shipping' then salary*0.20
                        when 'Finance' then salary*0.30
                        else salary*0 end "급여인상분2"   -- csse 문 then은 then 끼리 즉, 한컬럼의 값은 다같은 타입이여야 한다.!!
              
from    emp;



--TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 인상된 급여를 조회한다. 
--단 급여 인상율은 급여가 5000 미만은 30%, 5000이상 10000 미만는 20% 10000 이상은 10% 로 한다.
select  emp_id,
        emp_name,
        salary,
        case when salary < 5000 then salary*1.3
             when salary >=5000 then salary*1.2
             when salary < 10000 then salary*1.2
             else salary * 1.1 end  "급여별 인상률",
             
       case when salary < 5000 then salary*1.3
            when salary >= 10000 then salary*1.2
            else salary * 1.2 end "급여별 인상률2"
             -- where 절에 쓰는 연산자 다쓸 수 있다.. between , like , 등등 ~~!
             
from emp;
             



