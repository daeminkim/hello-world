/* **************************************************************************
����(Aggregation) �Լ��� GROUP BY, HAVING
************************************************************************** */

/* ************************************************************
�����Լ�, �׷��Լ�, ������ �Լ�
- �μ�(argument)�� �÷�. -- 
  - sum(): ��ü�հ�
  - avg(): ���
  - min(): �ּҰ�
  - max(): �ִ밪
  - stddev(): ǥ������
  - variance(): �л�  --ǥ�� ������ ����
  - count(): ����
        - �μ�: 
            - �÷���: null�� ������ ����  -- ���� ���̾��� �Ŵϱ� 
            -  *: �� ���(null�� ����)

- count(*) �� �����ϰ� ��� �����Լ��� null�� ���� ����Ѵ�.
- sum, avg, stddev, variance: number Ÿ�Կ��� ��밡��.
- min, max, count :  ��� Ÿ�Կ� �� ��밡��.
************************************************************* */

-- EMP ���̺��� �޿�(salary)�� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, ���������� ��ȸ 
select  sum(salary),
        round(avg(salary),2),
        min(salary),
        max(salary),
        round(stddev(salary),2),
        round(variance(salary),2)
from     emp;








-- EMP ���̺��� ���� �ֱ� �Ի���(hire_date)�� ���� ������ �Ի����� ��ȸ
select min(hire_date)"�������",
       max(hire_date)"���� �ֱ�"
from emp;



-- EMP ���̺��� �μ�(dept_name) �� ������ ��ȸ
select count(distinct dept_name)
from emp;


select count(dept_name)
from emp;



-- emp ���̺��� job ������ ���� ��ȸ
select count(distinct job)
from emp;

select count(distinct dept_name)
from emp;

select count(distinct nvl(dept_name, '�̹�ġ'))"�μ���"
        
-- count �� null�� ���� �����ϱ� nvl�� �̿��ؼ� �ΰ��� �־� �ְ� ī��Ʈ�� �Ѵ�.

from emp;



--TODO:  Ŀ�̼� ����(comm_pct)�� �ִ� ������ ���� ��ȸ
select count(*)
from   emp
where  comm_pct is not null;

select   
       count(*)"Ŀ�Ǽ�O"
from emp 
where comm_pct is not null;


select count(comm_pct)
from emp;


--TODO: Ŀ�̼� ����(comm_pct)�� ���� ������ ���� ��ȸ
select count(*)
from   emp
where  comm_pct is null;




select count(emp_id),  
       count(*)"Ŀ�̼�x"
from emp 
where comm_pct is  null;


select count(*) - count(comm_pct)
from emp;



--TODO: ���� ū Ŀ�̼Ǻ���(comm_pct)�� �� ���� ���� Ŀ�̼Ǻ����� ��ȸ
select  min(comm_pct),
        max(comm_pct)
from    emp;






select max(comm_pct),
       min(comm_pct)
from   emp;   -- null �� �� �����ϰ� 

--TODO:  Ŀ�̼� ����(comm_pct)�� ����� ��ȸ. 
--�Ҽ��� ���� 2�ڸ����� ���

select round(sum(comm_pct)/count(comm_pct),2)
from   emp;

select  round(avg (comm_pct),2),
        round(avg (nvl(comm_pct,0)),2) -- nvl�� �̿��ؼ� null �� 0���� ���� ����� ���ߴ�.
from emp;


                                --Ŀ�̼��� ���� (����) ���� ����  �ٴ��ؼ� ������ 
select round(avg(comm_pct),2),  --Ŀ�̼��� �ִ� �������� ��� Ŀ�̼�// ��ü �������� ����� �ƴ�
       round(avg(nvl(comm_pct,0)),2)  -- Ŀ�̼��� ���� ����� 0 �� �ְ� ��ü������ Ŀ�̼� ���
from   emp;                    



--TODO: ���� �̸�(emp_name) �� ���������� �����Ҷ� ���� ���߿� ��ġ�� �̸��� ��ȸ.
select emp_name
from   emp
order by 1 desc;



select max(emp_name)   --max ���ĺ� ���� ��������// min ���ĺ� ���� ó�� 
from emp;

select emp_name from emp order by 1 desc;


--TODO: �޿�(salary)���� �ְ� �޿��װ� ���� �޿����� ������ ���

select max(salary)-min(salary)
from  emp;




select max(salary)-min(salary)"�޿� ����"
from emp;

--TODO: ���� �� �̸�(emp_name)�� ����� ���� ��ȸ.
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
--where length(emp_name) = max(length(emp_name)) ; --where ������ �׷��ռ�(�����Լ�)�� ��� ����.

--TODO: EMP ���̺��� �μ�(dept_name)�� �������� �ִ��� ��ȸ. 

select  count(distinct(dept_name))"null ����",
        count(distinct nvl(dept_name,'�̸� ����'))"null ����"
from    emp;

--NVL2("��", "������1", "������2")
-- NVL("��", "������")


-- ���������� ����
select count(distinct nvl(dept_name,'�̸� ����'))"�μ� ����null ����",
       count(distinct dept_name)"null���� �� �μ�"
       --distinct nvl(dept_name,'�̸� ����')
from emp;



/* *****************************************************
group by ��
- Ư�� �÷�(��)�� <<<<��>>>���� ���� ������ �� ������ <<<<�����÷�>>>>>>�� �����ϴ� ����.
--�÷��� ������ �з��Ҷ�
	- ��) ������ �޿���� (job ��). �μ�-������ �޿� �հ�. ���� �������
- ����: group by �÷��� [, �÷���]
	- �÷�: �з���(������, �����) - �μ��� �޿� ���, ���� �޿� �հ�
	- select�� where �� ������ ����Ѵ�.
	- select ������ group by ���� ������ �÷��鸸 �����Լ��� ���� �� �� �ִ�
*******************************************************/

-- ����(job)�� �޿��� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, �������� ��ȸ

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


-- �Ի翬�� �� �������� �޿� ���.
select  --to_char(hire_date,'yyyy')�Ի翬��,
        round(avg(salary),2)���
        
from    emp
--group by to_char(hire_date,'yyyy');
group by extract( year from hire_date);



select  extract (year from hire_date),
        round(avg(salary),2)
from   emp
group by extract (year from hire_date);


-- �μ���(dept_name) �� 'Sales'�̰ų� 'Purchasing' �� �������� ������ (job) �������� ��ȸ

select  job,
        dept_name,-- select ������ group by ���� ������ �÷��鸸 �����Լ��� ���� �� �� �ִ�
        count(*)
from    emp
where  dept_name in('Sales','Purchasing')
group by dept_name,job;


select dept_name,
        job,
        count(*)"������"
from emp
where dept_name in ('Sales','Purchasing')
group by dept_name,job

order by 1; 








-- �μ�(dept_name), ����(job) �� �ִ� ��ձ޿�(salary)�� ��ȸ.
select  job,
        dept_name,
        round(avg(salary),2)"��ձ޿�"
from   emp
group by job,dept_name
order by 3 ;

select salary
from    emp;

select min(salary)
from    emp;






select  dept_name,
        job,
        max(salary)"�ִ� �޿�"
from emp
group by dept_name,job
order by 3 desc;



select  dept_name,
        job,
        max(salary)"�ִ�޿� "
from emp
group by dept_name,job
order by 3;



-- �޿�(salary) ������ �������� ���. �޿� ������ 10000 �̸�,  10000�̻� �� ����.

select  count(*),
        case when salary <10000 then '10000�̸�'
            else '10000�̻�' end "����"
from emp
group by case when salary <10000 then '10000�̸�'
            else '10000�̻�' end;
--DECODE�Լ��� CASE ��
--  �Լ��� ���� ������ ������ 
--- ����� 
--decode(�÷�, [�񱳰�, ��°�, ...] , else���) 
---decode(): ����Ŭ �Լ� 
--
---case ǥ�� ����
--case�� ����� -- ǥ�� ���� ��𼭵� ���� �̤���.
--case �÷� when �񱳰�'10' then ��°� 'A'
--              [when �񱳰�20 then ��°�'B']
--              [else ��°�]
--              end  -- �����ϸ� null ����
--              
--case�� ���ǹ�
--case when ���� then ��°�
--       [when ���� then ��°�]
--       [else ��°�]
--       end
--       -- ���� : where ���� ���ǹ� �����͵��� ���´�.








select case when salary <10000 then '10000 �̸�'
            else '10000�̻�' end "����",
        count(*)
from emp
group by case when salary <10000 then '10000 �̸�'
            else '10000�̻�' end ;



--TODO: �μ���(dept_name) �������� ��ȸ
select  dept_name,
        count(*)
from emp
group by dept_name;






select  dept_name"�μ��̸�",
        count(*)"������"
from emp
group by dept_name;


--TODO: ������(job) �������� ��ȸ. �������� ���� �ͺ��� ����.

select  job,
        count(*)
from   emp
group by job
order by 2 desc;










select  job,
        count(*)"������"
from  emp
group by job
order by 2 desc;

--TODO: �μ���(dept_name), ����(job)�� ������, �ְ�޿�(salary)�� ��ȸ. �μ��̸����� �������� ����.

select  dept_name,
        job,
        count(*),
        max(salary)
from emp
group by  dept_name,job
order by  dept_name;







select  dept_name,
        job,
        max(salary)"�ְ� �޿�",
        count(*)
from    emp
group by dept_name,job
order by dept_name ;

select * from emp
order by dept_name ;


--TODO: EMP ���̺��� �Ի翬����(hire_date) �� �޿�(salary)�� �հ��� ��ȸ. 
--(�޿� �հ�� �ڸ������� , �� �����ÿ�. ex: 2,000,000)
select  extract( year from hire_date)����,
        --to_char(hire_date,'yyyy'),
        ltrim (to_char(sum(salary),'999,999,999'))�޿�
from    emp
--group by to_char(hire_date,'yyyy');
group by extract( year from hire_date);






select  trim(extract (year from hire_date))"����",
        to_char(sum(salary),'fm$9,999,999')"�հ�"
from emp
group by extract (year from hire_date)
order by 1;
--group by to_char(hire_date,'yyyy')


--TODO: ����(job)�� �Ի�⵵(hire_date)�� ��� �޿�(salary)�� ��ȸ
select  to_char(hire_date,'yyyy')����,
        job ����,
        round(avg(salary),2) "��� �޿�"
from emp 
group by job,to_char(hire_date,'yyyy')
order by 1;


select  job"����",
        extract(year from hire_date)"�Ի�⵵",
        round(avg(salary),2)"��ձ޿�"

from emp
group by job,extract(year from hire_date)
order by 2;



--TODO: �μ���(dept_name) ������ ��ȸ�ϴµ� �μ���(dept_name)�� null�� ���� �����ϰ� ��ȸ.
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


--TODO �޿� ������ �������� ���. �޿� ������ 5000 �̸�, 5000�̻� 10000 �̸�, 10000�̻� 20000�̸�, 20000�̻�. 
select  
        case when salary <5000 then '5000�̸�'
              when salary <10000 then '5000�̻�~10000�̸�'
              when salary <20000 then  '10000�̻�~20000�̸�'
              else '20000�̻�' end "�޿�����",
        count(*)

from    emp
group by case when salary <5000 then '5000�̸�'
              when salary <10000 then '5000�̻�~10000�̸�'
              when salary <20000 then  '10000�̻�~20000�̸�'
              else '20000�̻�' end; 
              
              


select case   when salary < 5000 then '5000�̸�'
              when salary <10000 then '10000�̸�'
              when salary < 20000 then '20000�̸�'
              else '20000�̻�' end "�޿� ����",
        count(*)
from emp
group by case when salary < 5000 then '5000�̸�'
              when salary <10000 then '10000�̸�'
              when salary < 20000 then '20000�̸�'
              else '20000�̻�' end 
order by 1;
              
              
select case   when salary < 5000 then '5000�̸�'
              when salary between 5000 and 9999.99 then '10000�̸�'
              when salary between 10000 and 19999.9 then '20000�̸�'
              else '20000�̻�' end "�޿� ����",
        count(*)
from emp
group by case when salary < 5000 then '5000�̸�'
              when salary between 5000 and 9999.99 then '10000�̸�'
              when salary between 10000 and 19999.9 then '20000�̸�'
              else '20000�̻�' end 
order by 1;
              



/* **************************************************************
having ��
- �������� ���� �� ���� ����
- group by ���� order by ���� �´�.
- ����
    having ��������  --�����ڴ� where���� �����ڸ� ����Ѵ�. �ǿ����ڴ� �����Լ�(�� ���)
    
    -- where �� ���̺� �ִ� ������ ��ȸ�ϴ°�// having d�� �׷��� ���� ������� ������ȸ
************************************************************** */
select  dept_name,
        count(*) "������"
from emp
group by dept_name
having count(*)>= 10  --�������� �� �Ͽ� True �α׷츸 ����ܼ� �μ���, ������ �˷��� 
order by 2 desc;

-- �������� 10�� �̻��� �μ���(�μ���) �޿��հ� // having�� �׷��� �Ÿ��� select�� �ű⼭ �����ϴ� �ֵ��� ���� �����ִ� ���� ����.

select sum(salary),
        dept_name,
        count(*)
from   emp
group by dept_name
having count(*)>= 10;





select  dept_name,
        to_char(sum(salary), 'fm999,999')"�޿��հ�"
from    emp
group by dept_name
having count(*)>10;  -- �������� ���� �Ҷ� 




select  dept_name,
        to_char(sum(salary), '$999,999')"�޿��հ�"
from emp
group by dept_name
having count(*)>= 10  --�������� �� �Ͽ� True �α׷츸 ����ܼ� �μ���, ������ �˷��� 
order by 2 desc;


-- �������� 10 �̻��� �μ��� �μ���(dept_name)�� �������� ��ȸ
select  dept_name"�μ���",
        count(*)"������"
from emp
group by dept_name
having count(*)>=10;
 
--TODO: 15�� �̻��� �Ի��� �⵵(���� ��) (�� �ؿ�) �Ի��� �������� ��ȸ.
select  to_char(hire_date,'yyyy')�Ի�⵵,
        count(*)������
from    emp
group by  to_char(hire_date,'yyyy')
having  count(*)>=15;






select  extract( year from hire_date)"�Ի�⵵",
        count(*)"�Ի� ������",
        max(salary)"���� �޿� top"
        
from   emp
group by extract( year from hire_date)
--group by to char(hire_date,'yyyy')
having count(*)>=15;

--TODO: �� ����(job)�� ����ϴ� ������ ���� 10�� �̻��� ����(job)��� ��� �������� ��ȸ

select  job,
        count(*)
from    emp
group by job
having count(*)>=10;



select  job "����",
        count(*)"������"
from  emp
group by job
having count(*) >=10;

--TODO: ��� �޿���(salary) $5000�̻��� �μ��� �̸�(dept_name)�� ��� �޿�(salary), �������� ��ȸ

--select  dept_name,
--        salary,
--        count(*)
--from    emp
--where  avg(salary)>=5000; **where ������ �׷��Լ��� �㰡���� �ʴ´�.

select  dept_name,
        round(avg(salary)),
        count(*)
from    emp
group by dept_name
having avg(salary)>=5000;

select dept_name �μ��̸�,
       ceil(avg(salary))��ձ޿�,
       count(*)"������"
from   emp
group by dept_name
having avg(salary) >= 5000
order by 2;



--TODO: ��ձ޿��� $5,000 �̻��̰� �ѱ޿��� $50,000 �̻��� �μ��� �μ���(dept_name), ��ձ޿��� �ѱ޿��� ��ȸ
select  dept_name,
        round(avg(salary),2)�μ�����ձ޿�,
        sum(salary)�μ��ѱ޿�
from    emp
group by dept_name
having round(avg(salary),2) >= 5000
and sum(salary) >= 50000;


select distinct(dept_name)
from emp;  -- �μ��� 12���ϱ� �μ����� 12 �� �׷����� �����ڿ� �׷캰��(�μ���) ��ձ޿� �ѱ޿��� ���ؼ� select �Ѵ�.




select dept_name �μ��̸�,
       round(avg(salary),2)"��� �޿�",
       sum(salary)�ѱ޿�
from   emp
group by dept_name  -- ��ü �׷� 12���� ������. �μ��� �޿� ����� select �� ����, �׸��� having�� �´� �ֵ� 
having avg(salary) >= 5000 
and sum(salary)>=50000;

select distinct(dept_name)
from emp;

--TODO ������ """2�� �̻��� �μ���"""�� �̸��� �޿��� ǥ�������� ��ȸ
        

select dept_name"�μ���",
       round(STDDEV(salary),2)"ǥ�� ����",
        count(*)"������"
from emp
group by dept_name
having count(*)>= 2; -- 1���϶��� ǥ�������� �ǹ̰� ����.



/* **************************************************************
- rollup : group by�� Ȯ��.
  - group by�� ��� ���� �� ��� ��������(�߰����質 ������)�� �κ� ���迡 �߰��ؼ� ��ȸ�Ѵ�.
  - ���� : group by rollup(�÷��� [,�÷���,..])
  -- �� �������� �� ���� 



- grouping(), grouping_id()  -- ��������δ� grouping_id  �� ���°� ���� 
  - rollup �̿��� ����� �÷��� �� ���� ���迡 �����ߴ��� ���θ� ��ȯ�ϴ� �Լ�.
  - case/decode�� �̿��� ���̺��� �ٿ� �������� ���� �� �ִ�.
  - ��ȯ��
	- 0 : ������ ���
	- 1 : ���� ���� ���.
 

- grouping() �Լ� //  �Ѿ��� �������� ���� 
 - ����: grouping(groupby�÷�)
 - select ���� ���Ǹ� rollup�̳� cube�� �Բ� ����ؾ� �Ѵ�.
 - group by�� �÷��� �����Լ��� ���迡 �����ߴ��� ���θ� ��ȯ
	- ��ȯ�� 0 : ������(�κ������Լ� ���), ��ȯ�� 1: ���� ����(���������� ���)
 - ���� �������� �κ������� ��������� �˷��ִ� �� �� �ִ�. 



- grouping_id (�Լ�)  // �Ѿ��� �������� ����
  - ����: grouping_id(groupby �÷�, ..)
  - ������ �÷��� ���迡 ���Ǿ����� ���� 2����(0: ���� ����, 1: ������)�� ��ȯ �ѵ� 10������ ��ȯ�ؼ� ��ȯ�Ѵ�.
 
************************************************************** */

-- EMP ���̺��� ����(job) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.

select  nvl(job,'�Ѱ�'),
        round(avg(salary),2)
from    emp
group by rollup (job);






select  job,
        round(avg(salary),2)"���"
from    emp
group by rollup(job);


-- EMP ���̺��� ����(JOB) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
-- ���� �÷���  �Ұ質 �Ѱ��̸� '�����'��  �Ϲ� �����̸� ����(job)�� ���
select  decode(grouping(job),0,job,
                             1,'�Ѱ�')job,
        round(avg(salary),2)"���"
from    emp
group by rollup(job);


select  case grouping(job) when 0 then job
                           when 1 then '�Ѱ�'
                           end job,
        round(avg(salary),2)"���"
from    emp
group by rollup(job);






select  decode(grouping(job),0,job,     -- 0�� �з�������Ŵϱ� ���� �״�� ����ǰ� 1�ΰŴ� �Ⱦ��ΰŴϱ� �����
                             1,'�����') job,
        count(*) "�������հ�",
        round(avg(salary),2)"���"
        
from    emp
group by rollup(job);

select case grouping (job) when 0 then job
                else '�����' end job,
                
        count(*),
        round(avg(salary),2)"���"
from emp 
group by rollup(job);


select  decode(grouping_id(job),0,job,     -- 0�� �з�������Ŵϱ� ���� �״�� ����ǰ� 1�ΰŴ� �Ⱦ��ΰŴϱ� �����
                             1,'�����') job,
        count(*) "�������հ�",
        round(avg(salary),2)"���"
        
from    emp
group by rollup(job);






-- EMP ���̺��� �μ�(dept_name), ����(job) �� salary�� �հ�� �������� �Ұ�� �Ѱ谡 �������� ��ȸ

select  case grouping_id(dept_name,job) when 0 then nvl(dept_name,'�̹�ġ')||'-'||job
                                        when 1 then nvl(dept_name,'�̹�ġ')|| job||'-'||'�Ұ�'
                                        else '�Ѱ�' end label,
        sum(salary),
        count(*)
from    emp
group by rollup (dept_name,job);







select  grouping(dept_name),
        grouping(job),
        sum(salary)"�޿��հ�",
        round(avg(salary),2)"���� ���"
from emp
group by rollup(dept_name, job)
order by 1;

-- dept_name  2�� 1��  ,  job 2�� 0����  // ���� ���� ���θ� ���ؼ� ���Դ�. 
select grouping_id(dept_name, job),
--0, nvl(dept_name, '�̹�ġ')||'-'||job,
----                                          1, nvl(dept_name,'�̹�ġ')||' �Ұ�',
----                                          3, '�Ѱ�')label,
        count(*) "������ �հ�",
        round(avg(salary),2)"������ ���"
from emp
group by rollup(dept_name, job);



select decode(grouping_id(dept_name, job),0, nvl(dept_name, '�̹�ġ')||'-'||job,
                                          1, nvl(dept_name,'�̹�ġ')||' �Ұ�',
                                          3, '�Ѱ�')label,
        count(*) "������ �հ�",
        round(avg(salary),2)"������ ���"
from emp
group by rollup(dept_name, job);



--# �Ѱ�/�Ұ� ���� ��� :  �Ѱ�� '�Ѱ�', �߰������ '��' �� ���
--TODO: �μ���(dept_name) �� �ִ� salary�� �ּ� salary�� ��ȸ
select  dept_name,
        max(salary),
        min(salary)
from    emp
group by rollup (dept_name);







select  nvl(decode(grouping (dept_name),0,dept_name,
                                    1, '�Ѱ�'),'�̹�ġ')"�μ���",
        max(salary)"�ִ� �޿�",
        min(salary)"�ּ� �޿�"
from    emp
group by rollup (dept_name);










select decode((grouping_id(dept_name)),0,dept_name,
                                                  1,'�Ѱ� ') "dept_name",
       max(salary),
       min(salary)
from emp    
group by rollup(dept_name);


--TODO: ���_id(mgr_id) �� ������ ���� �Ѱ踦 ��ȸ�Ͻÿ�.
select  case grouping_id(mgr_id) when 1 then '�Ѱ�'
                                 else nvl(to_char(mgr_id,'999'),'����') end "mgr_id",
        count(*)
from emp 
group by rollup (mgr_id);


select decode(grouping_id(mgr_id),1,'�Ѱ�',
                                 0,mgr_id)mgr_id,
       count(*)
from emp
group by rollup (mgr_id);







select  decode(grouping_id(mgr_id), 1, '�Ѱ�', mgr_id) "��� id",  -- decode ()�� ��ȯ���� type�� ù���� ���� ����ϴ�.
                                                                -- �׷��� �Ѱ��� ���ڿ��� �� ù �࿡ �θ� ���� ��ȯ������
        count(*)"������"                                          --���ڰ� �ƴϿ��� ���ڿ��� �ڵ����� �ٲپ� ��ȯ�մϴ�.
from emp                                                         --���⼱ �������� ���� �̹Ƿ� ù�࿡ ���ڸ� �־���� ������ ���Ҽ��ֽ��ϴ�.
group by rollup(mgr_id); 



--select  decode(grouping(mgr_id),0,mgr_id,
--                                1,'�Ѱ�'),
--        count(*)   
--from emp
--group by rollup (mgr_id);   -- �̷��� ù���� �����ε� ���������� �����÷����� �־��ָ� �ȵ�

--TODO: �Ի翬��(hire_date�� year)�� �������� ���� ���� �հ� �׸��� �Ѱ谡 ���� ��µǵ��� ��ȸ.

select  decode(grouping_id(to_char(hire_date,'yyyy')),0,to_char(hire_date,'yyyy'),
                                                      1,'�Ѱ�')�Ի�⵵,
                                                     
        count(*)������,
        sum(salary)�����հ�
from    emp 
group by rollup (to_char(hire_date,'yyyy'));
---case �� �غ���
select  case grouping_id(to_char(hire_date,'yyyy')) when 0 then to_char(hire_date,'yyyy')
                                                    else '�Ѱ�' end �Ի�⵵,
                                                     
        count(*)������,
        sum(salary)�����հ�
from    emp 
group by rollup (to_char(hire_date,'yyyy'));


select  decode(grouping_id(extract(year from hire_date)),1,'�Ұ�',
                                                        0,extract(year from hire_date))"�Ի�⵵",
                                                               
        count(*), 
        sum(salary)
        
from   emp
group by rollup(extract(year from hire_date));


select decode(grouping_id(to_char(hire_date,'yyyy')),1,'�Ѱ�',to_char(hire_date,'yyyy'))"�Ի�⵵",
        count(*),
        sum(salary)
from emp
group by rollup(to_char(hire_date,'yyyy'));




--TODO: �μ���(dept_name), �Ի�⵵�� ��� �޿�(salary) ��ȸ. �μ��� ����� �����谡 ���� �������� ��ȸ

select  decode(grouping_id(dept_name,extract( year from hire_date)),0,dept_name,
                                                                   1,nvl(dept_name,'����')||'�Ұ�', 
                                                                   3,'�Ѱ�')�μ���,
        round(avg(salary),2)"��� �޿�"
from emp
group by rollup (dept_name,extract( year from hire_date));










select decode(grouping_id(dept_name,to_char(hire_date,'yyyy')),
                                                            0, dept_name||'-'||to_char(hire_date,'yyyy'),
                                                            1,dept_name||'�Ұ�',
                                                            '�Ѱ�')"laber",
        to_char(hire_date,'yyyy'),
        round(avg(salary),2) "��ձ޿�"

from emp
group by rollup(dept_name,to_char(hire_date,'yyyy')); -- �ΰ��� �����ϴ¾� �� �μ��� null �λ�� ��� �Ǹ������� ��ü ���







--5 select �÷� dept_name,sum(salary)
--1 from ���̺�  emp
--2 where �� ���� is not null
--3 group by �׷� ���� �÷� (�μ� ���) dept_name
--4 having ""�׷�""�� ������ �׷쿡��  ���� ������ ã��  count(*)>10
--6 order by ���� 
