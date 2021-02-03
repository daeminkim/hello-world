select *
from emp e, dept d    -- ����Ŭ ������ ũ�ν� ���� 
--where e.dept_id = d.dept_id;  -- where �� ���� �ϸ�  ��� �����Ͱ� ���´� 2889�� �� ���´�. emp ���̺� * dept ���Ժ� //* ũ�ν� �����̴�.
order by 1;                     -- �ҽ� ���̺� �ϳ��� dept ������ �ϳ��� �ٺپ  �����Ͱ����� �þ��. ������ ���� �ʾұ� ������ �� join �Ѵ�.
-- īƼ�� �� : ���� ������ �߸��ؼ� �����̺��� ��� ����� cross�� join �Ȱ�.
-- n���� ���̺�-> join  ���� �ּ� n-1�� �� �־���Ѵ�~~~
-- �Ƚ� ���ο����� ũ�ν� ���� ������ ���Ͼ� ����. �ֳ��ϸ� on ���� ������ error�� �߻��ϱ� �����̴�.~

select * from emp cross join dept;  --(�Ƚ� ������ ũ�ν� ���� ����)
/* ****************************************
����(JOIN) �̶�
- 2�� �̻��� ���̺� �ִ� �÷����� ���ļ� ������ ���̺��� ����� ��ȸ�ϴ� ����� ���Ѵ�.
 	- �ҽ����̺� : ���� ���� �о�� �Ѵٰ� �����ϴ� ���̺�- ���� ������ ���̺�
	- Ÿ�����̺� : �ҽ��� ���� �� �ҽ��� ������ ����� �Ǵ� ���̺�-�߰�����,�ΰ�����
 
- id�� 100�� ������ id�� �̸�,����,�μ��̸�, �μ���ġ: �ҽ�:����, Ÿ��:�μ�
- id�� 100�� �μ��� �̸�, ��ġ, �Ҽ������� �̸�, ����: �ҽ�:�μ�, Ÿ��:����
 
- �� ���̺��� ��� ��ĥ���� ǥ���ϴ� ���� ���� �����̶�� �Ѵ�.
    - ���� ���꿡 ���� ��������
        - Equi join  , non-equi join 
- ������ ����
    - Inner Join 
        - ���� ���̺��� ���� ������ �����ϴ� ��鸸 ��ģ��. 
    - Outer Join
        - ���� ���̺�(�ҽ����̺�)�� ����� ��� ����ϰ� �ٸ� �� ���̺��� ���� ������ �����ϴ� �ุ ��ģ��. ���������� �����ϴ� ���� ���� ��� NULL�� ��ģ��.
        - ���� : Left Outer Join,  Right Outer Join, Full Outer Join
    - Cross Join
        - �� ���̺��� �������� ��ȯ�Ѵ�. 
- ���� ����
    - ANSI ���� ����
        - ǥ�� SQL ����
        - ����Ŭ�� 9i ���� ����.
    - ����Ŭ ���� ����
        - ����Ŭ ���� �����̸� �ٸ� DBMS�� �������� �ʴ´�.
**************************************** */        
-- �θ� - �ڽ� ���̺� : �θ�.pkĮ�� = �ڽ�.fkĮ��

/* ****************************************
-- inner join : ANSI ���� ����
FROM  ���̺�a ��Ī INNER JOIN ���̺�b ��Ī ON ��������(����) 

- inner�� ���� �� �� �ִ�.
**************************************** */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ� ID, �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select  e.emp_id, 
        e.emp_name, 
        e.hire_date, 
        d.dept_id,
        d.dept_name
from    emp e inner join dept d on e.dept_id = d.dept_id;

select emp_name from emp where dept_id is null;

-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ.
select  e.emp_id,   
        e.emp_name,
        to_char(e.hire_date, 'yyyy"��"') hire_year,
        d.dept_name
--from    emp e inner join dept d on e.dept_id = d.dept_id
from    emp e join dept d on e.dept_id = d.dept_id --inner�� ���� ����. 
where   e.emp_id = 100;

-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select  e.emp_id,
        e.emp_name,
        e.salary,
        j.job_id,
        j.job_title,
        d.dept_id,
        d.dept_name
from    emp e join job j on e.job_id = j.job_id 
              join dept d on e.dept_id = d.dept_id;


-- �μ�_ID(dept.dept_id)�� 30�� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc), �� �μ��� �Ҽӵ� ������ �̸�(emp.emp_name)�� ��ȸ.
-- �ҽ����̺�: �μ�(�θ�), Ÿ�����̺�: ����(�ڽ�)
select  d.dept_name,
        d.loc,
        e.emp_name
from    dept d join emp e on d.dept_id = e.dept_id
where   d.dept_id = 30;

select * from dept where   dept_id = 30;
select * from emp where dept_id=30;


-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. �޿� ��� ������������ ����

select e.emp_id,
       e.emp_name,
       e.salary,
       s.grade||' ���'
from   emp e join salary_grade s on e.salary between s.low_sal and s.high_sal
order by 4;


--TODO 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.

select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name,
        d.loc
from emp e join dept d on e.dept_id = d.dept_id
where e.emp_id between 200 and 299
order by e.emp_id;




--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.

select  e.emp_id,
        e.emp_name,
        e.job_id,
        d.dept_name,
        d.loc
from emp e join dept d on e.dept_id = d.dept_id
           join job j  on e.job_id = j.job_id
where e.job_id = 'FI_ACCOUNT'
order by e.emp_id;



--TODO Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� //�������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.

select  e.emp_id,
        e.emp_name,
        e.salary,
        e.comm_pct,
        d.dept_name,
        d.loc
from emp e join dept d on e.dept_id = d.dept_id
where e.comm_pct is not null
order by e.emp_id;






--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. �μ�_ID �� ������������ ����.

select  d.dept_id,
        d.dept_name,
        d.loc,
        e.emp_id,
        e.emp_name,
        e.job_id
from dept d join emp e on d.dept_id = e.dept_id  -- �θ� �ҽ� �̴�.
where d.loc = 'New York'
order by d.dept_id;
            
select * from emp;

--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.

select  e.emp_id,
        e.emp_name,
        e.job_id,
        j.job_title
from emp e join job j on e.job_id = j.job_id;  -- pk �� fk �� ����

-- �� ���̵� null �ξֵ��� �̽Ἥ  �����Ͱ� 101�� �̴�. 


              
-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ   

select  e.emp_id,
        e.emp_name,
        e.salary,
        j.job_title,
        d.dept_name
from emp e join job j on e.job_id = j.job_id
           join dept d on e.dept_id = d.dept_id
where e.emp_id = 200;


-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name), ������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����

select  d.dept_name,
        d.loc,
        e.emp_name,
        j.job_title
--from emp e join dept d on e.dept_id = d.dept_id
from dept d join emp e on d.dept_id =  e.dept_id
            join job j  on e.job_id = j.job_id -- �״�� �̾� ���̸� �ȴ�.
where d.dept_name = 'Shipping'
order by 3 desc;   -- ���谡 ���� ���̺� �ΰ��� ������ ����� �ִ� ����Ǿ� �ִ� �ָ� ����ͼ� join �Ѵ�.
                    -- ������ �̾� ���δٰ� �����ϸ� �ȴ�. ������ �ִ� �ֵ鳢��


-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���

select e.emp_id,
        e.emp_name,
        e.hire_date,
        d.loc,
        to_char(e.hire_date, 'yyyy/mm/dd')
from emp e join dept d on e.dept_id = d.dept_id
where d.loc = 'San Francisco';


-- TODO �μ��� �޿�(salary)�� ����� ��ȸ. �μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.

select  d.dept_id,
        d.dept_name,
        to_char(round(avg(salary), 2), '$999,999') salary_���
from emp e join dept d on e.dept_id = d.dept_id
group by d.dept_id, d.dept_name  -- ���⼭ d.dept_id ��  pk �� �� �� ��Ȯ�ϰ� �׷��� ������ ���� �߰���
order by 3 desc;


select  dept_id,
        avg(salary)
from   emp 
group by dept_id;


--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����

select e.emp_id,
       e.emp_name,
       j.job_title,
       e.salary,
       s.grade||' ���',
       d.dept_name
    from   emp e join salary_grade s on e.salary between s.low_sal and s.high_sal
             join job j on e.job_id = j.job_id
             join dept d on e.dept_id = d.dept_id 
order by 5 desc;


--TODO �μ��� �޿������(salary_grade.grade) 1�� �����ִ� �μ��̸�(dept.dept_name)�� 1����� ������ ��ȸ. �������� ���� �μ� ������� ����.
-- ���谡 ���� ���̺���� ���� �ؾ��Ѵ�.
select * from salary_grade;

select  d.dept_name,
        count(*) ������ 
from emp e join dept d on e.dept_id = d.dept_id
           join salary_grade s on e.salary between s.low_sal and s.high_sal
where s.grade = 1
group by d.dept_id, d.dept_name   -- �����̸Ӹ� ���� �ؾ� �з��� �ߵȴ� // dept_name �� ���� ���� ���� ���� ���� ������ id(pk��)���� �׷��ϴ°� ����.
order by 1;


/* ###################################################################################### 
����Ŭ ���� 
- Join�� ���̺���� from���� �����Ѵ�.
- Join ������ where���� ����Ѵ�. 

###################################################################################### */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���

select  e.emp_id,
        e.emp_name,
        extract(year from e.hire_date),
        d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id;


-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���

select  e.emp_id,
        e.emp_name,
        e.hire_date,
        d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id
and e.emp_id = 100 ;   -- ���ι��� where  �� ������ �������.



-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ

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

--TODO 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select  e.emp_id,
        e.emp_name,
        e.salary,
        d.dept_name
from  emp e,
      dept d
where e.dept_id = d.dept_id
and e.emp_id between 200 and 299
order by 1;


--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.

select  e.emp_id,
        e.emp_name,
        e.job_id,
        d.dept_name,
        d.loc
from emp e, dept d
where e.dept_id = d.dept_id
and e.job_id = 'FI_ACCOUNT'
order by e.emp_id;




--TODO Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.

select  e.emp_id,
        e.emp_name,
        e.salary,
        e.comm_pct,
        d.dept_name
from emp e, dept d 
where e.comm_pct is not null
and e.dept_id = d.dept_id;


--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. �μ�_ID �� ������������ ����.
select d.dept_id,
        d.dept_name �μ��̸�,
        d.loc ��ġ,
        e.emp_id,
        e.emp_name,
        e.job_id
from dept d, emp e
where d.dept_id = e.dept_id
and d.loc = 'New York'
order by d.dept_id;



--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.
select  e.emp_id,
        e.emp_name,
        e.job_id,
        j.job_title
from emp e, job j
where e.job_id = j.job_id;



-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ              

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


-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name), ������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����

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



-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���

select  e.emp_id,
        e.emp_name,
        to_char(e.hire_date,'yyyy-mm-dd')
from dept d, emp e
where d.dept_id=e.dept_id
and d.loc = 'San Francisco';



--TODO �μ��� �޿�(salary)�� ����� ��ȸ. �μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.

select  to_char(round(avg(e.salary),2),'fm$999,999.99'),
        d.dept_name
        
from dept d, emp e
where d.dept_id = e.dept_id
group by d.dept_id, d.dept_name
order by 1 desc;  -- ���ڸ� ���ڷ� �ٲٸ鼭 ������ �ȸ´ٸ� ������ �ִ� �÷� �̸��� �ְ� �����Ѵ�.//


--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. ���� id ������������ ����
select e.emp_id,
       e.emp_name,
       e.salary,
       s.grade||' ���'
       
from   emp e, salary_grade s 
where e.salary between s.low_sal and s.high_sal
order by 1 ;




--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����

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

        



--TODO �μ��� �޿������(salary_grade.grade) 1�� �����ִ� "�μ����� 1��� �μ��̸�(dept.dept_name)�� 1����� ������ ��ȸ."" �������� ���� �μ� ������� ����.

select  
        d.dept_name,  -- d �� ���̺� ������ �÷��̸� �Ƚᵵ ������ ����� ���� ��Ǥ��� �Ⱦ��� �ϸ� �򰥷��� ���ش�.
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
--        count(*) ������ 
--from emp e join dept d on e.dept_id = d.dept_id
--           join salary_grade s on e.salary between s.low_sal and s.high_sal
--where s.grade = 1
--group by d.dept_id, d.dept_name   -- �����̸Ӹ� ���� �ؾ� �з��� �ߵȴ� // dept_name �� ���� ���� ���� ���� ���� ������ id(pk��)���� �׷��ϴ°� ����.
--order by 1;


/* ****************************************************
Self ����
- ���������� �ϳ��� ���̺��� �ΰ��� ���̺�ó�� �����ϴ� ��.// ���� ������ Ư���÷��� �����̸Ӹ�Ű�� ����//�ΰ��� ���̺�� �����ٰ� �����ϰ� ��ȸ�ϸ�  
**************************************************** */
--������ ID(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name)�� ��ȸ






select  e1.emp_id ,
        e1.emp_name �����̸�,
        e1.mgr_id,
        e2.emp_name ����̸�,
        e2.salary
from emp e1 join emp e2 on e1.mgr_id = e2.emp_id; -- e1: ��������table  e2:������� table

-- �������� �ٽ� �����غ�

select * from emp
where emp_id=100;


select  e1.emp_id ,
        e1.emp_id �����̸�,
        e1.mgr_id,
        e2.emp_name ����̸�,
        e2.salary
from emp e1, emp e2
where e1.mgr_id = e2.emp_id;

-- TODO : EMP ���̺��� ���� ID(emp.emp_id)�� 110�� ������ �޿�(salary)���� ���� �޴� �������� id(emp.emp_id), 
-- �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.
select * from emp
where emp_id=110;  --8200

select  e2.emp_id,
        e2.emp_name,
        e2.salary
from emp e1 join emp e2 on e1.salary < e2.salary
where e1.emp_id =110
order by e2.salary;--e1 �� id 110  e2: ��ȸ�� �������� 110���� �޿� ������



/* ****************************************************
�ƿ��� ���� (Outer Join)

- �������̺� �ҽ����̺��� ���� ��� ���̰� Ÿ�� ���̺��� ���� ���� ������ �����ϴ� �͸� ���δ�.

-����� ���� (���� ����� ������ ���� ����� �ص� ���̵���) 
 - �ҽ�(�����ؾ��ϴ����̺�)�� �����̸� left join, �������̸� right join �����̸� full outer join

-ANSI ����
from ���̺�a [LEFT | RIGHT | FULL] OUTER JOIN ���̺�b ON ��������// �ҽ����̺��� ���� �� ��� �����Ͱ� ���� ���̺� ����

- OUTER�� ���� ����.  // ��� ������ �� ���ϱ�  inner �� �����̰���. ..

-����Ŭ JOIN ����
- FROM ���� ������ ���̺��� ����
- WHERE ���� ���� ������ �ۼ�
    - Ÿ�� ���̺� (+) �� ���δ�.
    - ""FULL OUTER JOIN�� �������� �ʴ´�.""
- OUTER�� ���� �� �� �ִ�.	
**************************************************** */
-- ������ id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �μ���(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ --.������� ���� �μ���μ���ġ. 
-- �μ��� ���� ������ ������ �������� ��ȸ. <<<(�μ������� null)>>>. dept_name�� ������������ �����Ѵ�.
-- �ҽ� emp  Ÿ�� dept
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
where   e.dept_id = d.dept_id(+)  -- �÷��� ������ �̳� �����̵Ǽ� �ΰ��� ������ �����Ͱ� ��ȯ�ȴ�.
--where  d.dept_id(+)=e.dept_id    right ���� 
order by d.dept_id desc;


-- ��� ������ id(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id)�� ��ȸ�ϴµ� !!!!!!! 
-- �μ�_id�� 80 �� ��������(�����鸸) �μ���(dept.dept_name)�� �μ���ġ(dept.loc) �� ���� ����Ѵ�. (�μ� ID�� 80�� �ƴϸ� null�� ��������)
select e.emp_id,
        e.emp_name,
        e.dept_id,  --d. dept _id �϶��� 80�� �ֵ鸸 �������� e.dept_id ���ǿ� �� ���°��� ���� ���� �����ϱ� �� ���´�. 
        d.dept_name, --d.dept_id �� �ϸ� 80�� �ƴѾֵ��� 'null' �̴ϱ�  // �ҽ����̺��� ���� �ٳ����ڳ�� // 
        d.loc
from emp e left outer join dept d on e.dept_id = d.dept_id and d.dept_id =80; -- �ַ� Ÿ�����̺� �߰� ������ ���δ�.//�̳������� ����� �����ǶȰ��� ���� ������ �Ȱ�����ϱ�
--where d.dept_id = 80;  -- from ���� ���� ���̺��� ����� ���� // 80�̾ƴ� �ֵ��� where �� �ɷ���.
--80�� �����鸸 ��ȸ�ȴ�. ������ ���������� ��� �������� �̸� �μ� ���̵� ���� ������ 80 �ξֵ��� �߰��� �μ���� ��ġ���� ������ �ؾ��Ѵ�.
--  where �� from ����  ���� ���̺�(������ ���̺�)�� �ٸ���� ���ǿ� �ȸ´°� ���ڸ��Ű�
--  from  �� ������ ���� �־������� ���ʿ� ó������ ���ǿ� �´� �ֵ��� ���ϰ� ���¾ֵ��� null(outer join �̴ϱ�./ inner �� ���� �ȳְ� �ٻ������ݾ�!)�� �ִ´�.
-- �۵��ϴ� ������ from �̸����� where �̶�� ���� ���� ���� �����غ��� �ȴ�.
-- ����Ŭ ���� 
select e.emp_id,
        e.emp_name,
        e.dept_id,  --d. dept _id �϶��� 80�� �ֵ鸸 �������� e.dept_id ���ǿ� �� ���°��� ���� ���� �����ϱ� �� ���´�. 
        d.dept_name, --d.dept_id �� �ϸ� 80�� �ƴѾֵ��� 'null' �̴ϱ�  // �ҽ����̺��� ���� �ٳ����ڳ�� 
        d.loc
from emp e, dept d -- ����� join �� ���̺� �ְ� 
where e.dept_id = d.dept_id(+)  -- join ����
and    d.dept_id= 80;  -- �࿡���� ���� where �� �־��� ���� ���� ���� ���´�.


select e.emp_id,
        e.emp_name,
        e.dept_id,  --d. dept _id �϶��� 80�� �ֵ鸸 �������� e.dept_id �϶��� �ҽ����̺��̴ϱ� ���ǿ� �� �¾Ƶ� ���� ���� �����ϱ� �� �´�. 
        d.dept_name, --d.dept_id �� �ϸ� 80�� �ƴѾֵ��� 'null' �̴ϱ�  // �ҽ����̺��� ���� �ٳ����ڳ�� 
        d.loc
from emp e, dept d  -- ����� join �� ���̺� �ְ� 
where e.dept_id = d.dept_id(+)  -- join ���� // ���⼭ Ÿ�� ���̺� (+) �߰� 
and    d.dept_id(+)= 80;  -- Ÿ�����̺� �� ���� join ����



-- ���� ��� �����ؼ� ������ ���� �ٿ��ֱ� �ϸ� ���� �ִ�.

--TODO: ����_id(emp.emp_id)�� 100, 110, 120, 130, 140�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title) �� ��ȸ. 
-- �������� ���� ��� '�̹���' ���� ��ȸ
select  e.emp_id,
        e.emp_name,
        nvl(j.job_title,'�̹���')
from emp e left join job j on e.job_id = j.job_id 
where emp_id in (100,110,120,130);

-- inner join  null ���� ��ȯ���� �����ϱ� �̹��� ���� ����.
select  e.emp_id,
        e.emp_name,
        nvl(j.job_title,'�̹���')
from emp e join job j on e.job_id = j.job_id 
where emp_id in (100,110,120,130);

-- ����Ŭ 
select  e.emp_id,
        e.emp_name,
        nvl(j.job_title,'�̹���')
from emp e, job j
where e.job_id = j.job_id(+)
and emp_id in (100,110,120,130);

select*
from emp
where emp_id in (100, 110, 120, 130, 140);


--TODO: �μ��� ID(dept.dept_id), �μ��̸�(dept.dept_name)�� �� �μ��� ���� �������� ���� ��ȸ. 
--      ������ ���� �μ��� 0�� �������� ��ȸ�ϰ� �������� ���� �μ� ������ ��ȸ.

select  d.dept_id,
        d.dept_name,
        count(emp_id)  -- ���� ���� pk �÷� count() not null �̾߾� �ϴϱ�
from dept d left join emp e on e.dept_id = d.dept_id 
group by d.dept_id, d.dept_name
order by 3 desc;

select  d.dept_id,
        d.dept_name,
        count(*)
from dept d , emp e --���� ����� ����.
where d.dept_id = e.dept_id(+)
group by d.dept_id, d.dept_name
order by 3 desc;


-- * �� ����� ���� ������  �׸��� �μ��� �ҽ����̺��̶� ���� ���� �� �����ϱ� ���� ���� ������ ���� �μ��� �� ���� ���� ��ȯ�Ѵ�.
--/�������� ������ emp_id�� �ؾ��Ѵ�. ���ǿ� �����ʾ� null �ξֵ��� ���� ���ϱ�


-- TODO: EMP ���̺��� �μ�_ID(emp.dept_id)�� 90 �� �������� id(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name), 
--�Ի���(emp.hire_date)�� ��ȸ.  �Ի����� yyyy-mm-dd �������� ���  //���� ����>?

select *
from emp
where dept_id = 90;

select  e1.dept_id,
        e1.emp_id "���� id",
        e1.emp_name �����̸�,
        e2.emp_name ����̸�,
        to_char(e1.hire_date, 'yyyy-mm-dd')"���� �Ի���"
from emp e1 left join emp e2 on e1.mgr_id = e2.emp_id
            
where   e1.dept_id = 90 ;
            

select  e1.dept_id,
        e1.emp_id "���� id",
        e1.emp_name �����̸�,
        e2.emp_name ����̸�,
        to_char(e1.hire_date, 'yyyy-mm-dd')"���� �Ի���"
from emp e1, emp e2
where e1.mgr_id = e2.emp_id(+)
and e1.dept_id = 90 ;     
        
        
--TODO 2003��~2005�� ���̿� �Ի��� ������ id(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), �Ի���(emp.hire_date),
--     ����̸�(emp.emp_name), ������Ի���(emp.hire_date), �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.
-- 2003�⿡�� 2005�� ���� �Ի��� ������ ��� �������� ��ȸ�Ѵ�.    -- emp job emp(���) dept  4���� ���̺��� �ʿ��� ���������� 3������  
-- fk �� not null �̸� inner �� ���� �ǰ� null �� �����ϸ� outer �� ���� �� �ְ� �Ѵ� �𸣰����� outer ������ �ϸ� �ȴ�.!!
-- �ҽ� e1( ����)
select  e1.emp_id "���� ",
        e1.emp_name,
        j.job_title,
        e1.salary,
        e1.hire_date,
        e2.emp_name "����̸�",
        e2.hire_date,
        d.dept_name"���� �μ���",
        d.loc "�����μ��� ��ġ",
        d2.loc"����� �μ���"
        
from emp e1 left join job j on e1.job_id= j.job_id
            left join emp e2 on e1.emp_id =  e2.emp_id
            left join dept d on e1.dept_id = d.dept_id   -- d: ������ �μ�
            left join dept d2 on d2.dept_id = e2.dept_id  --d2: ����� �μ�
where to_char(e1.hire_date,'yyyy') between '2003' and '2005'
order by 1; 


select e1.* , j.*
from emp e1 left join job j on e1.job_id= j.job_id
            left join emp e2 on e1.emp_id =  e2.emp_id
            left join dept d on e1.dept_id = d.dept_id   -- d: ������ �μ�
            left join dept d2 on d2.dept_id = e2.dept_id  --d2: ����� �μ�
where to_char(e1.hire_date,'yyyy') between '2003' and '2005'
order by 1; 


--����Ŭ  

select  e1.emp_id "���� ",
        e1.emp_name,
        j.job_title,
        e1.salary,
        e1.hire_date,
        e2.emp_name "����̸�",
        e2.hire_date,
        d.dept_name"���� �μ���",
        d.loc "�����μ��� ��ġ",
        d2.loc"����� �μ���"
from emp e1, job j ,emp e2,dept d,dept d2
where e1.job_id = j.job_id(+)
and     e1.mgr_id = e2.emp_id(+)
and     e1.dept_id = d.dept_id(+)
and     d2.dept_id(+) = e2.dept_id
and to_char(e1.hire_date,'yyyy') between '2003' and '2005'
order by 1;
