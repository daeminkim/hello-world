/* *************************************
�Լ� - ���ڿ����� �Լ�
 UPPER()/ LOWER() : �빮��/�ҹ��� �� ��ȯ
 INITCAP(): �ܾ� ù���ڸ� �빮�� ������ �ҹ��ڷ� ��ȯ
 LENGTH() : ���ڼ� ��ȸ
 LPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� ���ʺ��� "ä�ﰪ"���� ä���.
 RPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� �����ʺ��� "ä�ﰪ"���� ä���.
 SUBSTR(��, ����index, ���ڼ�) - "��"���� "����index"��° ���ں��� ������ "���ڼ�" ��ŭ�� ���ڿ��� ����. ���ڼ� ������ ������. 
 REPLACE(��, ã�����ڿ�, �����ҹ��ڿ�) - "��"���� "ã�����ڿ�"�� "�����ҹ��ڿ�"�� �ٲ۴�.
 LTRIM(��): �ް��� ����
 RTRIM(��): �������� ����
 TRIM(��): ���� ���� ����
 ************************************* */
select  rtrim('   ���� õ��   '), 
        ltrim('   ���� õ��   '),
        trim('   ���� õ��   ')
from dual;

select rtrim('  mac�Ͽ�   ')z,
        ltrim('   sql   ')z,
        trim('   ��� �;�   ') z
from    dual;

select substr(123456789,2,5)--substr ��/ ���� �ε���/ ���ڼ�  / ������ ���� index���� ���� �� ���� �̾Ƴ���./
from    dual;

select replace('���� �ٺ�','�ٺ�','õ��')
from   dual;

select replace('���� �߻���','�߻���','�Ϳ���')
from    dual;


select upper('abc'),
       lower('ABC'),
       INITCAP('asvbd  sdfhk sfd')  -- ���ܾ� �� ù��°����
from dual;

select length('abcdef')
from dual;


select upper(emp_name)
from emp;

select *
from emp
where length(emp_name) >7;  --���� ����


select * 
from emp 
where length(emp_name) >10;

select lpad('abc',10,'+') "A",  --���ڼ��� 10���� �ǰ� '+'�� ä���. ���ڿ��̶� ' ' �־���Ѵ�.
        length(lpad('abc',10)), -- ä�� ���ڸ� ���������� �������� ä���.
        rpad('abc',10) "b",
       rpad('123456789',3) "c"   -- ���ڼ��� ������ ������ ������ �߶󳽴�.
from dual;

select substr('123456789',2,5),   -- 2��° ���ں��� 5��°���ڤ��� �� �Ѵ�.
        substr('123456789',2)          --  2��°���� ������ 
from dual;

select replace('010-1234-1234','010','###')from dual;
select trim ('  a   ') "A",
        ltrim('   a   ') "b",
        rtrim('   a   ') "c"
from dual;

--EMP ���̺��� ������ �̸�(emp_name)�� ��� �빮��, �ҹ���, ù���� �빮��, �̸� ���ڼ��� ��ȸ
select upper(emp_name),
        lower(emp_name),
        initcap(emp_name),
        length(emp_name)
from emp;


-- TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �μ�(dept_name)�� ��ȸ. �� �����̸�(emp_name)�� 
--��� �빮��, �μ�(dept_name)�� ��� �ҹ��ڷ� ���.
-- UPPER/LOWER

select emp_id,
        upper(emp_name),
        salary,
        lower(dept_name)
from    emp;





select  emp_id,
        upper(emp_name)"emp_name",
        salary,
        lower(dept_name)"�μ� �̸�"
from    emp;
        
        
        

--(�Ʒ� 2���� �񱳰��� ��ҹ��ڸ� Ȯ���� �𸣴� ����)
--TODO: EMP ���̺��� ������ �̸�(emp_name)�� PETER�� ������ ��� ������ ��ȸ�Ͻÿ�.



select  *
from    emp
where  upper(emp_name)='PETER';




select * from emp
where upper(emp_name)='PETER';



--TODO: EMP ���̺��� ����(job)�� 'Sh_Clerk' �� ��������  ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ


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


--TODO: ���� �̸�(emp_name) �� �ڸ����� 15�ڸ��� ���߰� ���ڼ��� ���ڶ� ��� ������ �տ� �ٿ� ��ȸ. ���� �µ��� ��ȸ
select lpad(emp_name,15)
from emp;

select lpad(emp_name,15)"���� �̸�"   -- ���� ����Ʈ���̰�// �ƴϸ� ä������ ���ڸ� ������ʤ�
from   emp;


--LPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� ���ʺ��� "ä�ﰪ"���� ä���.
    
--TODO: EMP ���̺��� ��� ������ �̸�(emp_name)�� �޿�(salary)�� ��ȸ.
--(��, "�޿�(salary)" ���� ���̰� 7�� ���ڿ��� �����, ���̰� 7�� �ȵ� ��� ���ʺ��� �� ĭ�� 
-- '_'�� ä��ÿ�. EX) ______5000) -LPAD() �̿�

select  emp_name,
        lpad(salary,7,'_')
from    emp;

select  emp_name,
        lpad(salary,7,'_') "�޿�",
        rpad(salary,7,'_')
from emp;






select  emp_name,
        lpad(salary,7,'*')"�޿�"
from    emp;

--to_char(salary, 'fm$999,999.00')"salary"

-- TODO: EMP ���̺��� �̸�(emp_name)�� 10���� �̻��� �������� �̸�(emp_name)�� �̸��� ���ڼ� ��ȸselect *

select  emp_name �̸�,
        length(emp_name) ���ڼ�
from    emp
where   length(emp_name)>=10;



select  emp_name,
        length(emp_name)"�̸� ���ڼ�"
from emp
where length(emp_name) >10;




/* *************************************
�Լ� - ���ڰ��� �Լ�


-- ���: ���� , �Ǽ�
 round(��, �ڸ���) : �ڸ������Ͽ��� �ݿø� (��� - �Ǽ���, ���� - ������, �⺻�� : 0)
 trunc(��, �ڸ���) : �ڸ������Ͽ��� ����(��� - �Ǽ���, ���� - ������, �⺻��: 0)-- ��������
 
 - ��� : ����
 ceil(��) : �ø�
 floor(��) : ����
 
 --
 mod(�����¼�, �����¼�) : �������� ������ ����
 
************************************* */
select  round(124.234,1),
        trunc(567.654,-2),-- �Ҽ��� �ڸ����� ���ٴ� �� ������ ����´�. -1���ʹ� 1���ڸ��� �� ��������. -2�� �ϸ� 500 �̵ȴ�.
        ceil (8765.560),
        floor(9876.3456)
from    dual;

select round(1.2345,2),
        round(1.5678,2),
        round(1.2345,0)"k",  
        round(1.5676,0)"d",  -- �Ҽ����� ���ڸ�ŭ ���ܵд� �����ϰ� ,, 0�� 1�� �ڸ�-1 �����ڸ� ���� ǥ�� 
        round(156.12,-1)
        
from dual;

select trunc(1.5678,2),
        trunc(156,-2)
from dual;

-- ceil/floor :�Ǽ� -> ���� 
select ceil(15.67),  --�ø�
        floor(15.67) -- ���� 
from dual;

select round(10/3 ,2)
from dual;

select mod(10,3) from dual;   -- 10�� 3����  �������� ������


--TODO: EMP ���̺��� �� ������ ���� ����ID(emp_id), �̸�(emp_name), �޿�(salary) �׸��� 15% �λ�� �޿�(salary)�� 
--��ȸ�ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--(��, 15% �λ�� �޿��� �ø��ؼ� ������ ǥ���ϰ�, ��Ī�� "SAL_RAISE"�� ����.)

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
        
    
--TODO: ���� SQL������ �λ� �޿�(sal_raise)�� �޿�(salary) ���� ������ �߰��� ��ȸ 
--(����ID(emp_id), �̸�(emp_name), 15% �λ�޿�, �λ�� �޿��� ���� �޿�(salary)�� ����)

select  emp_id,
        emp_name,
        ceil(salary*1.15)-salary"����"
from    emp;







select emp_id,
        emp_name,
        ceil(salary*1.15) "SAL_RAISE",  -- �÷��� �÷��� ����Ҷ��� �Ļ��÷�(�Ļ�����)�� �ǿ����ڷ� �� �� ����.
        
        ceil(salary*1.15)- salary "����"
from    emp;


-- TODO: EMP ���̺��� Ŀ�̼��� �ִ� �������� ����_ID(emp_id), �̸�(emp_name), Ŀ�̼Ǻ���(comm_pct),
-- Ŀ�̼Ǻ���(comm_pct)�� 8% �λ��� ����� ��ȸ.
--(�� Ŀ�̼��� 8% �λ��� ����� �Ҽ��� ���� 2�ڸ����� �ݿø��ϰ� ��Ī�� comm_raise�� ����)

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
�Լ� - ��¥���� ��� �� �Լ�

sysdate:��������� �Ͻ�!

Date +- ���� : ��,��¥ ���.
months_between(d1, d2) -����� ������(d1�� �ֱ�, d2�� ����)
add_months(d1, ����) - �������� ���� ��¥. ������ ��¥�� 1���� �Ĵ� ���� ������ ���� �ȴ�. 
next_day(d1, '����') - d1���� ù��° ������ ������ ��¥. ������ �ѱ�(locale)�� �����Ѵ�.
last_day(d) - d ���� ��������.
extract(year|month|day from date) - date���� year/month/day�� ����
************************************* */
select sysdate,
       to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')
from dual;  -- ������ �� // �Ű� ������ ������ ��ȣ ���� // �Լ���!!

select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')
from dual;

select sysdate +10,  -- ���� 10����
        sysdate-10  -- 10�� ��
from dual;

select  months_between('2020/08/15','2019/08/15'),  --months_between(d1,d2) d1,d2���̿� ���� �� ���
        months_between('2021/03/20','2020/04/29'),   -- ������ ���� ���� ����ߴµ� ���������� �������
        ceil(months_between('2021/03/20','2020/04/29')) --ceil �� �ؼ� �ذ� ������ �������� ��������
from dual;




select  months_between(sysdate, '2020/12/28')||'����',
        months_between(sysdate, '2019/10/28')||'����',   -- �տ� �ֱ� ��¥�� ������� 
        ceil(months_between(sysdate, '2020/12/26'))||'����'  -- ceil �� �Ἥ �Ҽ������� ������ ���� �ø����� ó�� �ߴ�.
from dual;

select add_months(sysdate,2)"2���� ��",  -- sysdate�� �׳� ���ڸ� ���ϸ� ��¥�� ���ϰ� ������ add_months �� ���� ���Ѵ�.
        add_months(sysdate,-2)"2���� ��",-- sysdate ���� ���� 2���� �� , ��
        add_months('2021/01/31',1)     -- 2���� 31���� ���  �״��� ������ ���� ���´� ��� �Ǵ°� �ƴ϶�
from    dual;
        
select  add_months('2030/02/23',2),
        add_months('2021/07/31',-2),
        next_day('2021/01/28','������')  -- �ش� ��¥ ������ �ٷο��� �������� ��¥�� ã���ش�.
from    dual;
 
        
        
from dual;

select next_day (sysdate,'�ݿ���'),
        next_day(sysdate,'������')
from dual;

select last_day(sysdate)from dual; -- �״��� ��������
select last_day('2021/04/23') from dual;


select extract(year from '2021/04/23')
from    dual;



select extract(year from sysdate),
        extract(month from sysdate),
        extract(day from sysdate)
from dual;

select * from emp 
where extract (month from hire_date)= 11;  -- 11���� �Ի��ѻ��  hire_date �κ��� 11���� ���Ѵ�.


-- to_char(date��,'��¥����')  : date�� ���ڿ��� ��ȯ




--TODO: EMP ���̺��� �μ��̸�(dept_name)�� 'IT'�� �������� '�Ի���(hire_date)�� ���� 
--10����', �Ի��ϰ� '�Ի��Ϸ� ���� 10����', �� ��¥�� ��ȸ. 

select  hire_date-10 "10����",
        hire_date,
        hire_date+10 "10����"
from    emp
where   dept_name = 'IT';




select  hire_date-10,
        hire_date,
        hire_date+10
from    emp
where   dept_name = 'IT';

--TODO: �μ��� 'Purchasing' �� ������ �̸�(emp_name), �Ի� 6�������� �Ի���(hire_date), 6������ ��¥�� ��ȸ.
select  emp_name,
        add_months(hire_date,+6),
        hire_date,
        add_months(hire_date,-6)
from    emp;

select emp_name,
       add_months(hire_date,-6) "6���� ��",
       hire_date"�Ի���",
       add_months(hire_date,+6) "6���� ��"
from   emp
where  dept_name = 'Purchasing';
    
     

--TODO: EMP ���̺��� �Ի��ϰ� �Ի��� 2�� ��, �Ի��� 2�� �� ��¥�� ��ȸ.
select  emp_name,
        hire_date,
        add_months(hire_date,-2) "2����",
        add_months(hire_date,+2) "2����"
from    emp;





select emp_name,
       add_months(hire_date,-2) "2���� ��",
       hire_date"�Ի���",
       add_months(hire_date,+2) "2���� ��"
from   emp;

-- TODO: �� ������ �̸�(emp_name), �ٹ� ������ (�Ի��Ͽ��� ��������� �� ��)�� ����Ͽ� ��ȸ.
--(�� �ٹ� �������� �Ǽ� �� ��� ������ �ݿø�. �ٹ������� ������������ ����.)

select  emp_name,
        round(months_between(sysdate,hire_date))||'����' "�ٹ� ����"
from    emp
order by 2 desc;




select  emp_name,
        round(months_between(sysdate,hire_date))||'����' "�ٹ� ������"
from    emp
order by 2 desc;
--order by "�ٹ� ������" desc;
--TODO: ���� ID(emp_id)�� 100 �� ������ �Ի��� ���� ù��° �ݿ����� ��¥�� ���Ͻÿ�.
select next_day(hire_date,'�ݿ���')
from    emp;





select  emp_id,
        next_day(hire_date,'�ݿ���')
from emp
where emp_id = 100;


--next_day(sysdate,'������')

-- �⺻���� ���ڳ� ��¥�� �ڵ����� �ٲ�⵵ �Ѵ�.

/* *************************************
�Լ� - ��ȯ �Լ�

#####################################################################################
#				# = to_char() =>	#					#<=to_char()=	#			#
#   Number Ÿ��	#					#  Character Ÿ��	#				#  Date Ÿ��	#
#				# <=to_number()=    #	    			#=to_date()=>	#			#
#####################################################################################

to_xxx(��, ����)

to_char() : ������, ��¥���� ���������� ��ȯ
to_number() : �������� ���������� ��ȯ 
to_date() : �������� ��¥������ ��ȯ


����(format)���� 
���� :
    0, 9 : ���ڰ� �� �ڸ��� ����. (9: ������ �����ڸ��� �������� ä��, 0�� 0���� ä��) - �Ǽ��� ���� �ڸ��� �Ѵ� 0���� ä���.
           fm���� �����ϸ� 9�� ��� ������ ����.
    . : ����/�Ǽ��� ������.
    ,: ������ ����������
    'L', '$' : ��ȭǥ��. L; ������ȭ��ȣ// ����Ŭ���� �ٸ�
�Ͻ� :yyyy : ���� 4�ڸ�, yy: ���� 2�ڸ�(2000���), rr: ����2�ڸ�(50�̻�:90���, 50�̸�:2000���)
      mm: �� 2�ڸ�  (11, 05)
      dd: �� 2�ڸ�
      hh24: �ð�(00 ~ 23) 2�ڸ�, hh(01 ~ 12)
      mi: �� 2�ڸ�
      ss: �� 2�ڸ�
      day(����), 
      am �Ǵ� pm : ����/����
************************************* */

-- ���� ���� // ���� ��¥// ������ ���������� 
-- ���� ��¥ ���̴� �Ұ��� �ϴ�.

select 20+to_number('10,000','99,999') from dual; --to_number('��(����)','����(�̷������̴� ��°� �˷�����)')-->���Ŀ� �°� ���ڷ� �ٲ�� �Ѵٴ� ����
                                                    -- �˷��ְ� �ٲٰ� ��

select 100+to_number('100,000','999,999')from dual;

select 10+to_number('1,000', '9,999') from dual;


select to_char(100000000, '999,999,999') �ݾ� from dual;
select to_char(100000000, '999,999,999,999') �ݾ� from dual;  -- ���� �ڸ��� �պκ��� �������� ä�m��.
select to_char(100000000, '000,000,000,000') �ݾ� from dual;  -- ���� �ڸ����� 0 ���� ä�m��.
 

select to_char(salary, 'fm9,999,999.00')�ݾ�  -- ����� ���� �������� ä��������ϴµ� fm ������ ������ ����� /
from emp;                                       -- �׸��� �Ǽ��κ��� 0,9 �Ѵ� 0���� ä���.

select to_char(salary, '9,999,999.99') �ݾ�
from emp;

select 10+to_number('1,000.53', '9,999.99')
from dual;

select  to_char(12345678, '999,999,999')�ݾ�,  -- �ٲ�� �Ǵ� �ڸ��� ���� �������� �־����ڸ����� Ŀ�� �տ� �������� ä����. 
        to_char(12345678, 'fm999,999,999')��,  -- fm ������ ���� �������� �����̾���.
        to_char(12345678, '999,999')��,        -- ���ڿ��� �ٲ���ϴ� �ͺ��� �ڸ����� ��� ������� ������.
        to_char(10000, '$99,999')��,         --  $ ǥ�� �ٿ��� L �� ���� ��ȭ ������ �ٿ��ش�.
        to_char(10000, 'L99,999')��
from dual;





select to_char(1234.567,'0,000.000'),
        to_char(1234.56, '000,000.000'),
        to_char(1234.56, '999,999.999')  -- �Ǽ��δ� �Ѵ� 0���� ǥ�� 
from dual;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')"���� �ð� �����",
        to_char(sysdate, 'yyyy')�⵵��,
        to_char(sysdate, 'day')����,
        to_char(sysdate, 'dy')����,
        to_char(sysdate, 'hh24:mi:ss')�ð���,
        to_char(sysdate, 'yyyy"��"mm"��"dd"��"')
    
from dual;






select  to_char(sysdate,'yyyy/mm/dd hh24"��"mi"��"ss"��"'),
        to_char(sysdate,'yyyy"�⵵" mm"��" dd"��"'),
        to_char(sysdate, 'yyyy'),
        extract(year from sysdate)
from dual;

select to_date('2000/10', 'yyyy/mm')from dual;


-- EMP ���̺��� ����(job)�� "CLERK"�� ���� �������� ID(emp_id), �̸�(name), ����(job), �޿�(salary)�� ��ȸ
--(�޿��� ���� ������ , �� ����ϰ� �տ� $�� �ٿ��� ���.)

select emp_id,
       emp_name,
        job,
        to_char(salary, 'fm$999,999.00')"salary"
from emp
where job LIKE '%CLERK%';


-- ���ڿ� '20030503' �� 2003�� 05�� 03�� �� ���.

select to_char(to_date('20030503', 'yyyymmdd'), 'yyyy"��"mm"��"dd"��"')
from dual;




-- TODO: �μ���(dept_name)�� 'Finance'�� �������� ID(emp_id), �̸�(emp_name)�� �Ի�⵵(hire_date) 4�ڸ��� ����Ͻÿ�. 
--(ex: 2004);  /// �̰� ���� �ߵ�� !!
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
        to_char(hire_date, 'yyyy')"�Ի�⵵"
from emp
where dept_name = 'Finance';



--TODO: �������� 11���� �Ի��� �������� ����ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ

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
--where   to_char(hire_date,'mm')='11';   ---j�ܾʵ�
where extract (month from hire_date)= 11;

--TODO: 2006�⿡ �Ի��� ��� ������ �̸�(emp_name)�� �Ի���(yyyy-mm-dd ����)�� �Ի���(hire_date)�� ������������ ��ȸ
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



--TODO: 2004�� 05�� ���� �Ի��� ���� ��ȸ�� �̸�(emp_name)�� �Ի���(hire_date) ��ȸ
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
  



--TODO: ���ڿ� '20100107232215' �� 2010�� 01�� 07�� 23�� 22�� 15�� �� ���. (dual ���Ժ� ���)

select to_date('20100107232215','yyyymmddhh24miss')
from dual;  -->2010/01/07  ���


select to_char(to_date('20100107232215','yyyymmddhh24miss'),'yyyy"��" mm"��" dd"��" hh24"��" mi"��" ss"��"')
from dual;  -->2010�� 01�� 07�� 23�� 22�� 15�� ��� 
    --- ���ڿ��� date Ÿ������ �ٲ㼭 �⵵�� �� �� �� �˷��ְ� , �ٽ� ����Ʈ Ÿ���� ����Ÿ������ �ٲ۴�. ���� Ÿ���� ����Ÿ������ �ٲ� �� ���� �����̴�.



select to_char(to_date('20100107232215', 'yyyymmddhh24miss'),'yyyy"��" mm"�� "dd"�� "hh24"�� "mi"�� "ss"��"')
from dual;



--select to_char(to_date('20030503', 'yyyymmdd'), 'yyyy"��"mm"��"dd"��"')
--from dual;


/* *************************************
�Լ� - null ���� �Լ� 
NVL(expr,�⺻��) : expr ���� null�̸� �⺻���� null�� �ƴϸ� exper ���� ��ȯ
NVL2(expr, nn, null) - expr�� null�� �ƴϸ� nn, ���̸� ����° ��ȯ
nullif(ex1, ex2) ���� ������ null, �ٸ��� ex1

************************************* */
select NVL(null,0),
       nvl(null,'����'),
       nvl(20,0)

from dual;

select nvl2(null, 'null�ƴ�', 'null��'),
        nvl2('dd', 'null�ƴ�', 'null��')
from    dual;

select nullif(10,10),
        nullif(20,10)
from dual;

-- EMP ���̺��� ���� ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼Ǻ���(comm_pct)�� ��ȸ. 
--�� Ŀ�̼Ǻ����� NULL�� ������ 0�� ��µǵ��� �Ѵ�..
select  emp_id,
        emp_name,
        salary,
        nvl(comm_pct,0),
        nvl2(comm_pct,'Ŀ�̼�����','Ŀ�̼Ǿ���'),
       
from    emp;


select emp_id,
        emp_name,
        salary,
        nvl(comm_pct, 0) "Ŀ�̼� ����",  --Ŀ�̼��� null�̸� �⺻�� '0'�� ��ȯ// null�̾ƴϸ� comm_pct ���� ��ȯ
        nvl2(comm_pct, 'Ŀ�̼� ����','Ŀ�̼Ǿ���')"Ŀ�̼� ����",  -- Ŀ�̼� ���� ���θ� 
        salary*nvl(comm_pct,0)
from emp;



--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), ����(job), �μ�(dept_name)�� ��ȸ. 
--�μ��� ���� ��� '�μ��̹�ġ'�� ���.

select  emp_id,
        emp_name,
        job,
        nvl(dept_name,'�μ��̹�ġ')
from    emp
order by 4;





select  emp_id,
        emp_name,
        job,
        nvl(dept_name,'�μ��̹�ġ')"�μ� �̸�"
from    emp;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼� (salary * comm_pct)�� ��ȸ. 
--Ŀ�̼��� ���� ������ 0�� ��ȸ�Ƿ� �Ѵ�.



select  emp_name,
        emp_id,
        salary,
        nvl(salary*comm_pct,0),
        nvl2(salary*comm_pct,'Ŀ�̼� ����','Ŀ�̼� ����')"Ŀ�̼� ����"
from    emp;


select emp_id,
        salary,
        nvl(salary*comm_pct,'0') "Ŀ�̼�",
        NVL2(salary,salary*comm_pct,'')"Ŀ�̼� 2"  --�ٽ� 
from emp;


-------------------------------------------------

/* *************************************
DECODE�Լ��� CASE ��

- ����� 
decode(�÷�, [�񱳰�, ��°�, ...] , else���) 
-decode(): ����Ŭ �Լ� 

-case ǥ�� ����
case�� ����� -- ǥ�� ���� ��𼭵� ���� �̤���.
case �÷� when �񱳰�'10' then ��°� 'A'
              [when �񱳰�20 then ��°�'B']
              [else ��°�]
              end  -- �����ϸ� null ����
              
case�� ���ǹ�
case when ���� then ��°�
       [when ���� then ��°�]
       [else ��°�]
       end
       -- ���� : where ���� ���ǹ� �����͵��� ���´�.

************************************* */
select  decode(dept_name, 'Shipping','���',
                            'Sales','����',
                            'Purchasing','����',
                            'Marketing','������',
                             null,'�μ�����',
                             dept_name)dept,
        dept_name
from    emp
order by dept_name desc;

select decode(dept_name,  'Shipping','���',
                          'Sales','����',
                          'Purchasing','����',
                          'Marketing','mk',
                          null,'�μ� ����',
                          dept_name)dept,
        dept_name
from emp
order by dept_name desc;


select  dept_name, case dept_name when 'Shipping' then '���'
                                when 'Sales'    then '����'
                                else nvl(dept_name,'�μ�����')end "dept"
                                
from  emp;
                            

select dept_name,
        case dept_name  when 'Shipping' then '���'
                        when 'Sales' then '����' 
                        when 'Purchasing' then '����' 
                        else  nvl(dept_name,'�μ� ����')end "DEPT"
from emp
order by 1 desc;


select dept_name real ,

            case when dept_name is null then '�̹���' 
            else dept_name end dept_name
from emp
order by 1 desc;

select case when dept_name is null then '�̹���'
            else dept_name end dept_name
from   emp;

--EMP���̺��� �޿��� �޿��� ����� ��ȸ�ϴµ� �޿� ����� 10000�̻��̸� '1���', 10000�̸��̸� '2���' ���� �������� ��ȸ

select  salary,
        case when salary >=10000 then '1���'
                    else '2���' end
                    
from    emp;







select  salary,
        case when salary >= 10000 then '1���'   -- ����񱳰� �ƴϴϱ� case
             else '2���'  end "salary"
from emp
order by 2;


--decode()/case �� �̿��� ����
-- �������� ��� ������ ��ȸ�Ѵ�. �� ������ ����(job)�� 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' ������� ������������ �Ѵ�. 
--(������ JOB�� �������)

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

--TODO: EMP ���̺��� ����(job)�� 'AD_PRES'�ų� 'FI_ACCOUNT'�ų� 'PU_CLERK'�� �������� ID(emp_id), �̸�(emp_name), 
--����(job)�� ��ȸ. 
-- ����(job)�� 'AD_PRES'�� '��ǥ', 'FI_ACCOUNT'�� 'ȸ��', 'PU_CLERK'�� ��� '����'�� ��µǵ��� ��ȸ

select  emp_id,
        emp_name,
        case job when 'AD_PRES' then '��ǥ'
                 when 'FI_ACCOUNT' then 'ȸ��'
                 when 'PU_CLERK'   then '����'
                 else job end job
from    emp
where   job in ('AD_PRES','FI_ACCOUNT','PU_CLERK');


select  emp_id,
        emp_name,
        decode(job ,'AD_PRES' ,'��ǥ',
                   'FI_ACCOUNT','ȸ��',
                   'PU_CLERK','����',
                    job)   ---- decode �� ������ , �� ������ �ϰ� else �� end �� ���� �ʿ���� �׳� �������� else �� ���ָ� �ȴ�.
from    emp
where   job in ('AD_PRES','FI_ACCOUNT','PU_CLERK');





select  emp_id,
        emp_name,
        case job when 'AD_PRES' then '��ǥ'
                 when 'FI_ACCOUNT' then 'ȸ��'
                 when  'FI_ACCOUNT'  then '����'
                 else job end "job"
from    emp
order by 3 desc;

select  emp_id,
        emp_name,
        decode(job, 'AD_PRES', '��ǥ',
                    'FI_ACCOUNT', 'ȸ��',
                    'FI_ACCOUNT', '����')"job",
        case job when 'AD_PRES' then '��ǥ'
                 when 'FI_ACCOUNT' then 'ȸ��'
                 when  'FI_ACCOUNT'  then '����'
                 else job end "job2"
from emp
where job in ('AD_PRES','FI_ACCOUNT','FI_ACCOUNT');


--TODO: EMP ���̺��� �μ��̸�(dept_name)�� �޿� �λ���� ��ȸ. �޿� �λ���� �μ��̸��� 'IT' �̸� �޿�(salary)�� 10%�� 
--'Shipping' �̸� �޿�(salary)�� 20%�� 'Finance'�̸� 30%�� �������� 0�� ���
-- decode �� case���� �̿��� ��ȸ

select  dept_name,
        case when dept_name ='IT' then salary*0.1
             when dept_name = 'Shipping' then salary*0.2
             when dept_name = 'Finance' then salary*0.3
             else salary*0 end "�޿� �λ��",   -- ������ ���� ���� ���Ŀ� ���� �޶�����. // �̰Ŵ� case ���ǹ�
        case dept_name when 'IT' then salary*0.1  -- 
                      when 'Shipping' then salary*0.2
                      when 'Finance'  then salary*0.3
                      else  salary*0 end "�λ�"
from    emp;


select  dept_name,
        salary "�޿�",
        case when dept_name = 'IT' then salary*0.10         -- ����񱳰� �ƴϰ� // �ٷ� ������ �־ 
             when dept_name = 'Shipping' then salary*0.20
             when dept_name = 'Finance' then salary*0.30
             else salary*0 end "�޿��λ��",
             
        decode (dept_name, 'IT', '�λ����',       -- decode �� ù��° �÷��� Ÿ�԰� ���� Ÿ������ ��������.
                            'Shipping',salary*1.2,   -- �÷��� ó������ ���ڸ� �־ ���ڿ��� �ٲ��ش�./ 
                            'Finance',salary*1.3,    --ù��° �÷��� Ÿ���� �������� ��������.
                            0)"�λ�ȱ޿�",
                            
        case  dept_name when'IT' then salary*0.10
                        when 'Shipping' then salary*0.20
                        when 'Finance' then salary*0.30
                        else salary*0 end "�޿��λ��2"   -- csse �� then�� then ���� ��, ���÷��� ���� �ٰ��� Ÿ���̿��� �Ѵ�.!!
              
from    emp;



--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �λ�� �޿��� ��ȸ�Ѵ�. 
--�� �޿� �λ����� �޿��� 5000 �̸��� 30%, 5000�̻� 10000 �̸��� 20% 10000 �̻��� 10% �� �Ѵ�.
select  emp_id,
        emp_name,
        salary,
        case when salary < 5000 then salary*1.3
             when salary >=5000 then salary*1.2
             when salary < 10000 then salary*1.2
             else salary * 1.1 end  "�޿��� �λ��",
             
       case when salary < 5000 then salary*1.3
            when salary >= 10000 then salary*1.2
            else salary * 1.2 end "�޿��� �λ��2"
             -- where ���� ���� ������ �پ� �� �ִ�.. between , like , ��� ~~!
             
from emp;
             



