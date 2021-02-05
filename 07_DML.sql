/* *********************************************************************
DML - ������ (��)�� �ٷ�� sql ��
    -insert  :create ����
    -select : read , retrieve��ȸ 
    -update : ����
    -delete: ���� 
    
    
INSERT �� - �� �߰�
����
 - �����߰� :
   - INSERT INTO ���̺�� (�÷� [, �÷�]) VALUES (�� [, ��[])
   - ��� �÷��� ���� ���� ��� �÷� ���������� ���� �� �� �ִ�.

 - ��ȸ����� INSERT �ϱ� (subquery �̿�)
   - INSERT INTO ���̺�� (�÷� [, �÷�])  SELECT ����
	- INSERT�� �÷��� ��ȸ��(subquery) �÷��� ������ Ÿ���� �¾ƾ� �Ѵ�.
	- ��� �÷��� �� ���� ��� �÷� ������ ������ �� �ִ�.
	
  
************************************************************************ */
desc dept;    -- ���̺� ���� ������  �ο��� ���� �ؼ� �÷� Ȯ�� �����ϴ�.
insert into  dept(dept_id, dept_name, loc) values(1000,'��ȹ��','����');  -- ��ü ������ ������ �÷�  �Ƚ�ε�
insert into  dept values(1100,'���ź�','�λ�');
commit ;   --���� ���� �������~!
            -- Ŀ�� ���� ���� //���� ���̺� ó���� �ض� ��� ���̴�
insert into  dept values(1100,'���ź�','�λ�');
insert into  dept values(1200,'���ź�','�λ�');
insert into  dept values(1300,'���ź�','�λ�');  -- Ŀ�� �������� �޸𸮿� �ӽ� �����Ѱ��̴�. ��ȸ�ϸ� ������� ������ �ѹ��� �ϸ� �������� ���� �� �մ�
rollback;   
-- �μ�Ʈ ������Ʈ ����Ʈ �ϱ� �� (������ Ŀ�Ի���)�� ������
-- Ŀ���� �ϸ� �ٽ� �� �ǵ���
-- commit ���� �ӽ÷� ó���Ȼ���. commit ���� ó���Ѱ� ( Ŀ���� ���ϸ� ������ ���ų� �ϸ� �����Ͱ� �����

select * from dept order by dept_id desc;

desc emp;

insert into emp values (1000,'ȫ�浿', 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);  
select * from emp order by emp_id desc;

insert into emp (emp_id,emp_name,hire_date,salary) values (1100,'�̼���','2000/10/20',5000);  
-- �÷��� ���������� ���� ���������� null �Էµȴ�. �ķ��� �������ϸ�
insert into emp values (1000,'�����', 'null',100,'2017/10/20',5000,null,20);  
-- Į������ �ȳ־������� ���ڸ��� null�� ������Ѵ�.

insert into emp values (17800,'ȫ��', 'FI_ACCOUNT',null,to_date('2017/01', 'yyyy/mm'),5000,0.1,20);  
-- ������ �ٲ�� ������ to_date�� �Է��������

--�̹� �ִ� pk ���� insert �Ϸ��� �ϸ� �μ�Ʈ ����������. ������ ���۸��ϸ� ������ �� ���ִ�.
insert into emp values (1000,'ȫ�浿', 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);  

insert into emp values (1000,null, 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);-- not null �÷��� null�� ������ ������.

insert into emp values (1000,'ȫ�浿', 'ȸ��',100,'2017/10/20',5000,0.1,20);
--emp �� job_id FK �÷� ->�θ����̺��� pk �÷��� �����ϴ� ���� ���� �� �ִ�.


-- ��� ������ Ÿ���� ũ�� ���� �� ū ���� �ִ� ��� ����.
insert into emp values (1000,'ȫ�浿ȫ�浿ȫ�浿', 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);

insert into emp values (1000000,'ȫ�浿', 'FI_ACCOUNT',100,'2017/10/20',5000,0.1,20);
-- ������ number (6) �̴�.
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
where dept_id =10;  -- ���� Ŀ�� ó��

select *  from emp_copy;


--TODO: �μ��� ������ �޿��� ���� ��� ���̺� ����. 
--      ��ȸ����� insert. ����: �հ�, ���, �ִ�, �ּ�, �л�, ǥ������
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

insert into salary_stat-- (dept_id, salary_sum, salary_avg, salary_max, salary_min, salary_var, salary_stddev) -- ��ü �÷��̶� �����ص���
select  dept_id,
        sum(salary),
        round(avg(salary),2),
        max(salary),
        min(salary),
        round(VARIANCE(salary),2) �л�,
        round(stddev(salary),2) ǥ������
from    emp 
group by dept_id
order by dept_id;
         


/* *********************************************************************
UPDATE : ���̺��� �÷��� ���� ����
UPDATE ���̺��
SET    ������ �÷� = ������ ��  [, ������ �÷� = ������ ��]
[WHERE ��������]

 - UPDATE: ������ ���̺� ����
 - SET: ������ �÷��� ���� ����
 - WHERE: ������ ���� ����. 
************************************************************************ */



-- ���� ID�� 200�� ������ �޿��� 5000���� ����
select * from emp where emp_id = 200;   -- 4400

update emp
set salary = 5000
where emp_id = 200;
commit;

select * from emp;
-- ���� ID�� 200�� ������ �޿��� 10% �λ��� ������ ����.   salary*1.1
select * from emp where emp_id = 200;

update emp
set salary = salary*1.1
where emp_id = 200;


-- �μ� ID�� 100�� ������ Ŀ�̼� ������ 0.2�� salary�� 3000�� ���� ������, ���_id�� 100 ����.
select * from emp where emp_id = 100;

update emp
set    comm_pct = 0.2,
       salary =  salary+3000,
       mgr_id = 100
where  emp_id = 100;
commit;



--update emp ,dept   -- �̷������� �ѹ��� ���� ���̺��� ���� �ٲܼ� �� ���� �����̺��� ���� �÷��� �����ϴ�.
--set    comm_pct = 0.2,
--       salary =  salary+3000,
--       mgr_id = 100
--where  emp_id = 100;

-- TODO: �μ� ID�� 100�� �������� �޿��� 100% �λ�
update emp
set salary = salary*2
where dept_id= 100;

--<<<<< ���� �ϴ� ����>>>>---
select * from emp where dept_id = 100;
--
--update emp
--set salary= salary*2
--where emp_id=100;


rollback;
-- TODO: IT �μ��� �������� �޿��� 3�� �λ�   --== dept_id 60�� ����Ƽ  select * from dept;

update emp
set salary =  salary*3
where dept_id in (select dept_id from dept where dept_name = 'IT');  -- ����� ����Ƽ��� �μ��� �������ϼ��� ������ in �� ����.
--where dept_id = 60



--<<<<<<<���� �ϴ� ����>>>>>>>>>
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
-- TODO: EMP2 ���̺��� ��� �����͸� MGR_ID�� NULL�� HIRE_DATE �� �����Ͻ÷� COMM_PCT�� 0.5�� ����.
update emp 
set     mgr_id = null,
        hire_date = sysdate,
        comm_pct = 0.5;
        
select * from emp;
rollback;

-- TODO: COMM_PCT �� 0.3�̻��� �������� COMM_PCT�� NULL �� ����.
update emp
set comm_pct = null
where comm_pct>=0.3;
rollback;
-- TODO: ��ü ��ձ޿����� ���� �޴� �������� �޿��� 50% �λ�.
select avg(salary) from emp ;
select * from emp where salary < (select avg(salary) from emp) ;

update emp 
set salary = salary *1.5
where salary < (select avg(salary) from emp);

select * from emp;

rollback;
/* *********************************************************************
DELETE : ���̺��� ���� ����
���� 
 - DELETE FROM ���̺�� [WHERE ��������]
   - WHERE: ������ ���� ����
************************************************************************ */

--delete from emp; ���̺� �ִ� �����͸� ��� ����



-- �μ����̺��� �μ�_ID�� 200�� �μ� ����

delete from dept
where dept_id = 200;
select * from dept;


-- �μ����̺��� �μ�_ID�� 10�� �μ� ����
select * from emp where dept_id=10;
select * from emp where emp_id =200;
delete from dept where dept_id=10;  --���̺� on delete set null �̶�� �־ 
rollback;

-- �����̺� �����θ� ���� ó�� �Ҽ� �ִ٤� �ѹ��� �������� ���̺��� �ȵ�.
-- delete �� �÷��̶� ����� ���� 


-- TODO: �μ� ID�� ���� �������� ����
select * from emp where dept_id is null;

delete from emp where dept_id is null;



-- TODO: ��� ����(emp.job_id)�� 'SA_MAN'�̰� �޿�(emp.salary) �� 12000 �̸��� �������� ����.
select * from emp where job_id = 'SA_MAN' and salary<12000;
delete from emp where job_id = 'SA_MAN' and salary<12000;

-- TODO: comm_pct �� null�̰� job_id �� IT_PROG�� �������� ����

select* from emp where comm_pct is null and job_id = 'IT_PROG';

delete from emp where comm_pct is null and job_id = 'IT_PROG';  -- �� �����ϸ� 0 ���� ���� ..������Ʈ�� ��������~~ 




-- TODO: job_id�� CLERK�� �� ������ �ϴ� ������ ����
select * from emp where job_id like '%CLERK';  --35�� ��
delete from emp where job_id like '%CLERK';

rollback;

select * from emp where emp_id = 100;   
-- job_id �� ����� ������ null �� ����� ������  ==> update Ư�� �÷��� ���� �ٲ۴�. /// delete �� ���� �ٳ���
update emp 
set job_id = null
where emp_id = 100;

