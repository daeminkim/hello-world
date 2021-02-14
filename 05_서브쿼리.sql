/* **************************************************************************
��������(Sub Query)
- �����ȿ��� select ������ ����ϴ� ��.
- ���� ���� - ��������

���������� ���Ǵ� ��
 - select��, from��, where��, having��(order by , group by ���� �� ���� �ִ�.)
 
���������� ����
- ��� ������ ���Ǿ������� ���� ����
    - ��Į�� �������� - select ���� ���. �ݵ�� �������� ����� 1�� 1��(�� �ϳ�-��Į��) 0���� ��ȸ�Ǹ� null�� ��ȯ
    - �ζ��� �� - from ���� ���Ǿ� ���̺��� ������ �Ѵ�.
�������� ��ȸ��� ����� ���� ����
    - ������ �������� - ���������� ��ȸ��� ���� ������ ��.
    - ������ �������� - ���������� ��ȸ��� ���� �������� ��.
    - �ΰ��� ����� �� �ִ� �����ڰ� �ٸ���. 
���� ��Ŀ� ���� ����
    - ����(�񿬰�) �������� - ���������� ���������� �÷��� ������ �ʴ´�. ���������� ����� ���� ���������� �����ϴ� ������ �Ѵ�.
    - ���(����) �������� - ������������ ���������� �÷��� ����Ѵ�. 
                            ���������� ���� ����Ǿ� ������ �����͸� ������������ ������ �´��� Ȯ���ϰ��� �Ҷ� �ַ� ����Ѵ�.

- ���������� �ݵ�� ( ) �� ������� �Ѵ�.
************************************************************************** */
--������ ��������

-- ����_ID(emp.emp_id)�� 120���� ������ ���� ����(emp.job_id)���� 
-- ������ id(emp_id),�̸�(emp.emp_name), ����(emp.job_id), �޿�(emp.salary) ��ȸ

select  emp_id,
        emp_name,
        job_id,
        salary
from    emp
where  job_id = (select job_id from emp where emp_id =120);


select  job_id from emp where emp_id =120;  -- 120 �� ������ ���� �� ���ϴ� select 

select emp_id,
        emp_name,  -- ���� ����
        job_id,
        salary
from    emp
where job_id = (select  job_id from emp where emp_id =120);  
-- ��ȣ���� ���� ���� ���� /�׸��� ��ȸ��� ���� 1�� ������/ �ܵ����� ���� ==>���� ��������/



-- ����_id(emp.emp_id)�� 115���� ������ ���� ����(emp.job_id)�� �ϰ� ���� �μ�(emp.dept_id)�� ���� �������� ��ȸ�Ͻÿ�.
select job_id,dept_id from emp where emp_id =115; 

select * from emp 
where job_id = (select job_id from emp where emp_id =115)
and dept_id = (select dept_id from emp where emp_id =115);
--PU_MAN	30
select * from emp 
where (job_id,dept_id) = (select job_id,dept_id from emp where emp_id =115);


--pair ��� ��������  / ���� �ϳ��ε� / ������� ���� ���������� ����� �� �ִ�.// ������ �϶� ��ȣ�� ������� �о������� �Ҷ� Į���� 
select * from emp
where (job_id,dept_id) = (select job_id, dept_id
                        from emp 
                        where emp_id = 115);


-- ������ �� �޿�(emp.salary)�� ��ü ������ ��� �޿����� ���� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ��ȸ. �޿�(emp.salary) �������� ����.
-- �������� //
--���� ������ ���� ���� ���� ���� ���� ���� �� �� ������� ���� ���������� �����ϴµ� ����Ѵ�.(where���� ������ �ɷ�����)

select round(avg(salary),2) from emp; 


select  emp_id,
        emp_name,
        salary
from    emp
where   salary < (select round(avg(salary),2) from emp)
order by salary desc;


select emp_id,
        emp_name,
        salary
        
from emp
where salary < (select avg(salary) from emp)  -- where ������ �����Լ� ������.
order by salary desc;




-- ��ü ������ ��� �޿�(emp.salary) �̻��� �޴� �μ���  �̸�(dept.dept_name), �Ҽ��������� ��� �޿�(emp.salary) ���. 
-- ��ձ޿��� �Ҽ��� 2�ڸ����� ������ ��ȭǥ��($)�� ���� ������ ���

select  d.dept_name,
        to_char(round(avg(e.salary),2),'$999,999')
from    emp e left join dept d on e.dept_id = d.dept_id
group by d.dept_name
having avg(salary)> (select avg(salary)from emp) --���� avg(salary)�� ���� �׷캰 ��� �޿��Դϴ�
order by avg(salary);



-- TODO: ������ ID(emp.emp_id)�� 145�� �������� ���� ������ �޴� �������� //�̸�(emp.emp_name)�� �޿�(emp.salary) ��ȸ.
-- �޿��� ū ������� ��ȸ
select salary from emp where emp_id =145;


select  emp_name,
        salary
from    emp
where   salary > (select salary from emp where emp_id =145)
order by 2;

select  emp_name,
        salary
from    emp 
where salary > (select salary from emp where emp_id=145);


-- TODO: ������ ID(emp.emp_id)�� 150�� ������ ���� ����(emp.job_id)�� �ϰ� ���� ���(emp.mgr_id)�� ���� �������� 
-- id(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), ���(emp.mgr_id) �� ��ȸ

select  job_id,
        mgr_id
from    emp
where   emp_id = 150;


select  emp_id,
        emp_name,
        job_id,
        mgr_id
from    emp
where  (job_id,mgr_id)= (select   job_id,
                                   mgr_id
                                    from    emp
                                    where   emp_id = 150);

select job_id,
        mgr_id
from emp 
where emp_id = 150;

select  emp_id,
        emp_name,
        job_id "���� ����",
        mgr_id"���� mgr_id"
from    emp
where   (job_id, mgr_id)= (select  job_id, mgr_id from emp where emp_id =150);
-- pair �϶��� ��ȣ �����ֱ� 




-- TODO : EMP ���̺��� ���� �̸���(emp.emp_name)��  'John'�� ������ �߿��� �޿�(emp.salary)�� ���� ���� ������ salary(emp.salary)���� ���� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.

select  max(salary) from    emp where   emp_name = 'John';

select  emp_id,
        emp_name,
        salary,
        emp_id
from    emp
where   salary >(select  max(salary) from emp where   emp_name = 'John')
order by 1 ;

        






select salary from emp where emp_name = 'John';
8200
2700
14000
select  salary
from    emp 
where   emp_name = 'John';

select emp_id,
        emp_name,
        salary,
        emp_id
from    emp 
where  salary > all(select  salary
                    from    emp 
                    where   emp_name = 'John')  --all �� ������ ���� and �̴ϱ� ���� salary �� ���� ū �������� ũ�� ������ �ٸ��� �ؼ� �����ȴ�.
--where  salary > (select  max(salary)
--                 from    emp 
--                 where   emp_name = 'John')
order by 1;
-- �̸��� john �� �ֵ��� salary �� ���ϰ�  �� �����߿� ���� ū�Ŵϱ� all ��� ���� �ϴ°����� ã���� �ȴ�.


-- TODO: �޿�(emp.salary)�� ���� ���� ������ ���� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ.

select max(salary)
from emp;


select  dept_name,
        d.dept_id,
        e.emp_name,
        loc,
        salary
from    dept d left join emp e on e.dept_id = d.dept_id
where salary = (select max(salary)
                from emp);
-- �ƽ� �������� ���ϴ�  ����Ʈ ���� ���� salary �� �� �ϸ� �ȴ�.// salary �� �񱳸� �ؾ��ϴϱ� join �Ѵ�.

select *  from emp order by salary desc;


-- TODO: �޿�(emp.salary)�� ���� ���� �޴� �������� �̸�(emp.emp_name), �μ���(dept.dept_name), �޿�(emp.salary) ��ȸ. 
--       �޿��� �տ� $�� ���̰� ���������� , �� ���

select max(salary) from emp ;

select  e.emp_name,
        to_char(e.salary,'fm$9,999,999'),
        d.dept_name
from  emp e join dept d on e.dept_id = d.dept_id
where   salary = (select max(salary) from emp); 

select max(salary)
                from emp;
                
select  e.emp_name,
        d.dept_name,
        to_char(e.salary,'fm$999,999')
from    dept d left join emp e on e.dept_id = d.dept_id
where salary = (select max(salary)
                from emp);


-- TODO: ��� ����ID(emp.job_id) �� 'ST_CLERK'�� �������� ��� �޿����� ���� �޿��� �޴�//
--�������� ��� ������ ��ȸ. �� ���� ID�� 'ST_CLERK'�� �ƴ� �����鸸 ��ȸ.

select  round(avg(salary),2)
from    emp
where   job_id = 'ST_CLERK';

select * from emp 
where salary < (select  round(avg(salary),2)
                from    emp
                where   job_id = 'ST_CLERK')
and (job_id <> 'ST_CLERK' or job_id is null);



select *
from emp 
where (job_id != 'ST_CLERK' 
or job_id is null) -- nvl(job_id,'�̹�ġ') != 'ST_CLERK'
and salary<(select round(avg(salary),2)
            from emp
            where job_id = 'ST_CLERK'); 
-- job_id �� null �̰ų� stclerk �� �ƴ� ������ 




select round(avg(salary),2)
from emp e join job j on e.job_id = j.job_id
where j.job_id = 'ST_CLERK';
2817.65
select round(avg(salary),2)
from emp
where job_id = 'ST_CLERK';  --2817.65



-- TODO: 30�� �μ�(emp.dept_id) �� ��� �޿�(emp.salary)���� //�޿��� ���� �������� ��� ������ ��ȸ.
select *
from emp 
where salary>(select avg(salary) from emp where dept_id = 30)  --5150
order by salary;




-- TODO: EMP ���̺��� ����(emp.job_id)�� 'IT_PROG' �� �������� ��� �޿� �̻��� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� �޿� ������������ ��ȸ.

select avg(salary)
from    emp
where  job_id = 'IT_PROG';

select  emp_id,
        emp_name,
        salary
from    emp
where   salary >(select avg(salary)
                    from    emp
                    where  job_id = 'IT_PROG')
order by salary desc;





-- TODO: 'IT' �μ�(dept.dept_name)�� �ִ� �޿����� ���� �޴� ������ 
--ID(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date), �μ� ID(emp.dept_id), �޿�(emp.salary) ��ȸ
-- �Ի����� "yyyy�� mm�� dd��" �������� ���
-- �޿��� �տ� $�� ���̰� ���������� , �� ���

select  max(e.salary), 
        d.dept_name
from emp e join dept d on e.dept_id = d.dept_id 
where d.dept_name = 'IT'
group by d.dept_id,d.dept_name;   -- 27000


select  emp_id,
        emp_name,
        to_char(hire_date, 'yyyy"��"mm"��"dd"��"'),
        salary,
        dept_id
from    emp
where   salary > (select  max(e.salary)
                    from emp e join dept d on e.dept_id = d.dept_id 
                    where d.dept_name = 'IT');



select max(salary)   --9000
from dept d join emp e on d.dept_id = e.dept_id
where dept_name = 'IT';

select  e.emp_id,
        e.emp_name,
        to_char(e.hire_date, 'yyyy"��"mm"��"dd"��"')hire_date,
        TO_char(e.salary,'$999,999')salary,
        d.dept_id
from    emp e join dept d on e.dept_id = d.dept_id
where salary >(select max(salary)   --9000
                from dept d join emp e on d.dept_id = e.dept_id
                where dept_name = 'IT')
order by salary;

select max(salary)   --9000
                from dept d join emp e on d.dept_id = e.dept_id
                where dept_name = 'IT';


select max(salary)
from dept d join emp e on d.dept_id = e.dept_id
where d.dept_name = 'IT';  -- 9000

select  emp_id,
        emp_name,
        to_char(hire_date,'yyyy"��" mm"��" dd"��"'),
        dept_id,
        to_char(salary,'$999,999')
from    emp 
where salary > (select max(salary)
                from dept d join emp e on d.dept_id = e.dept_id
                where d.dept_name = 'IT')
order by salary desc;        






/* ----------------------------------------------
 ������ ��������
 - ���������� ��ȸ ����� �������� ���
 - where�� ������ ������
	- in
	- �񱳿����� any : ��ȸ�� ���� �� �ϳ��� ���̸� �� (where �÷� > any(��������) )  �������� ��� �� �Ϻ� ����or
	- �񱳿����� all : ��ȸ�� ���� ��ο� ���̸� �� (where �÷� > all(��������) ) �������� ��� �� ��� ����   and
------------------------------------------------*/
--'Alexander' �� �̸�(emp.emp_name)�� ���� ������(emp.mgr_id)�� 
-- ���� �������� ID(emp_id), �̸�(emp_name), ����(job_id), �Ի�⵵(hire_date-�⵵�����), �޿�(salary)�� ��ȸ
-- �޿��� �տ� $�� ���̰� ���������� , �� ���/// ������ ���� in �� ����. 


select emp_id,
        emp_name,
        job_id,
        to_char(hire_date, 'yyyy') "hire_year",
        to_char(salary, '$999,999') salary
from emp
where mgr_id in(select emp_id from emp
                where emp_name = 'Alexander');


-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ ���� �޿�(emp.salary)�� ���� �޴� ������ ��� ������ ��ȸ.
select salary from emp
where emp_id in (101,102,103);

select * from emp
where salary > all(select salary from emp
                where emp_id in (101,102,103));
                
                
select * from emp
where salary > (select max(salary)
                from emp 
                where emp_id in(101,102,103));
                

-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ �� �޿��� ���� ���� �������� �޿��� ���� �޴� ������ ��� ������ ��ȸ.
select * from emp
where salary > any (select salary
                    from emp 
                    where emp_id in(101,102,103))
order by salary;

select * from emp
where salary > (select min(salary)
                from emp 
                where emp_id in(101,102,103));

--TODO : �μ� ��ġ(dept.loc) �� 'New York'�� �μ��� �Ҽӵ� ������ ID(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id) �� sub query�� �̿��� ��ȸ
select  e.emp_id,
        e.emp_name,
        d.dept_id,
        d.loc
from    emp e join dept d on e.dept_id = d.dept_id
where   d.loc = 'New York';

select  emp_id,
        emp_name,
        dept_id
from emp
where dept_id in (select dept_id from dept where loc = 'New York');  -- ���� ���� �������ϱ�




-- TODO : �ִ� �޿�(job.max_salary)�� 6000������ ������ ����ϴ� ����(emp)�� ��� ������ sub query�� �̿��� ��ȸ.
--select *
--from emp 
--where salary > (sal



select *
from emp
where job_id in (select job_id from job where max_salary <=6000);

AD_ASST
PU_CLERK
ST_CLERK
SH_CLERK


-- TODO: �μ�_ID(emp.dept_id)�� 20�� �μ��� ������ ���� �޿�(emp.salary)�� ���� �޴� �������� ������  sub query�� �̿��� ��ȸ.

select salary
from  emp
where dept_id = 20;

select * from emp where salary > all(select salary
                                        from  emp
                                        where dept_id = 20);






select *
from emp
where salary > all(select salary from emp where dept_id =20);



-- TODO: �μ��� �޿��� ����� ���� ���� �μ��� ��� �޿�//���� ���� ���� �޴� �������� �̸�, �޿�, ������ sub query�� �̿��� ��ȸ
select min(round(avg(salary),2))"��ձ޿� ������"
from emp
group by dept_id;








select  emp_name,
        job_id,
        salary
from emp 
--where salary > (select min(avg(salary)) from emp group by dept_id);
where salary > any(select avg(salary) from emp group by dept_id);

-- TODO: ���� id(job_id)�� 'SA_REP' �� �������� ���� ���� �޿��� �޴� �������� ���� �޿��� �޴� �������� �̸�(emp_name), �޿�(salary), ����(job_id) �� sub query�� �̿��� ��ȸ.
select emp_name,
        salary,
        job_id
from emp
where salary > (select max(salary) from emp where job_id = 'SA_REP');
--where salary > all(select salary from emp where job_id = 'SA_REP');


-- �������� ���� ���� :  subquery ���� -> �������� ���� ����� ������ main  ������ ����.
/* ****************************************************************
���(����) ���� : ���� ���� ���� ���� �ɶ����� ���������� ����
������������ ��ȸ���� ���������� ���ǿ��� ����ϴ� ����.
<<<<<<���������� �����ϰ�>>>> �� ����� �������� ���������� �������� ���Ѵ�.
* ****************************************************************/
-- �� �μ�����(DEPT) �޿�(emp.salary)�� ���� ���� �޴� �������� id(emp.emp_id),//
--�̸�(emp.emp_name), ����(emp.salary), �ҼӺμ�ID(dept.dept_id) ��ȸ
--select  e.emp_id,
--        e.emp_name,
--        e.salary,
--        e.dept_id
--from   emp e
--where  salary = �ڱⰡ ���� �μ��� max salary;
--
--select max(salary)
--from      emp
--where dept_id = �ڱⰡ ���� �μ� id;

select  e.emp_id,
        e.emp_name,
        e.salary,
        e.dept_id
from   emp e
where  salary = (select max(salary)   -- main ������ ������ ���ϸ鼭 �������� �� �ᾴ��. //  where���� ���྿ �񱳸� �Ѵ�.
                    from      emp
                     where nvl(dept_id, 0) = nvl(e.dept_id,0)) --// null �� �μ��� �����ؼ� ���Ϸ���nvl ���//null �� is null �θ� ��ȸ �Ǿ��ϴϱ�
order by e.dept_id;


select distinct dept_id from emp order by 1;  --null �� is null �θ� ��ȸ �Ǿ��ϴϱ� 

/* ******************************************************************************************************************
EXISTS, NOT EXISTS ������ (���(����)������ ���� ���ȴ�)
-- ���������� ����� �����ϴ� ���� �����ϴ��� ���θ� Ȯ���ϴ� ����. ������ �����ϴ� ���� �������� ���ุ ������ ���̻� �˻����� �ʴ´�.

������ ���̺� (�� ���̺�)Transaction ���̺� ( �ֹ�) => ���� �ֹ���  ������ Ʈ�������ǿ� �������ϱ�
-- �������̺��� ������ �׵���� ���� �����ǰ� �ִ� ���� Ȯ�� �Ҵ� ����. ( �ִ��� exists,  ������ not exists)
-- ���߿� �ֹ��� ������ �ִ� ��.
**********************************************************************************************************************/


-- ������ �Ѹ��̻� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
select  d.dept_id,
        d.dept_name,
        d.loc
from    dept d 
where   exists (select * from emp e where e.dept_id=d.dept_id);  
 --�ִ°͸� ã�� ������  ���ݴ� ȿ�����̴�. // ���� ���θ� Ȯ��



select * from dept
where dept_id in (select distinct dept_id from emp);  --> ���� �Ͱ� ����� ������ ��� �κ��� ��ã�´�.

-- ������ �Ѹ� ���� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
select  d.dept_id,
        d.dept_name,
        d.loc
from    dept d 
where   not exists (select * from emp e where e.dept_id=d.dept_id); 

-- �μ�(dept)���� ����(emp.salary)�� 13000�̻��� �Ѹ��̶� �ִ� �μ���// �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
select *
from dept d
where exists (select * from emp e where d.dept_id = e.dept_id and salary >= 13000);

select * from emp where salary>=13000;




/* ******************************
�ֹ� ���� ���̺�� �̿�.
******************************* */
1.from 
2. where �༱�� (������ �ະ�� üũ -
--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ� �̻� �� ������ ��ȸ.  - �ֹ����̺� �ϳ��� ���� �Ǿ� �ִٸ� // �ֹ����̺� �ִ� ���
select *   -- ���� ���� �������� �� ���� ������ �ִ���  ���̵� �ֳ�
from customers c
where exists(select * from orders o where c.cust_id = o.cust_id);
-- �ֹ����̺� �ִ� �����̵�� �����̺� �ִ� �����̵� ���ٷ� �����ϰ� �ֹ����̺� �����̵� exists �ϴ� �ֵ��� ���� ��ȯ�Ѵ�.
-- �ֹ����̺� �մ� �����̵�� �����̺� �մ� �����̵𰡰��� // �� �ֹ����̺� �� ���̵� �վ�� ���� �� �ְ� ���̵ȴ�.
-- �� �྿ �� �� ���̺��� Ŀ��Ʈ ���̵� �ֹ����̺��� Ŀ��Ʈ ���̵�� ������ ���ٸ� �ֹ��� ���� ���¤����̴�.
--
--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ��� ���� ���� ������ ��ȸ.  - �ֹ����̺� �����̵� ���� ��� 
select *
from customers c
where not exists(select * from orders o where c.cust_id = o.cust_id);

--TODO: ��ǰ(products) �� �ѹ��̻� �ֹ��� ��ǰ ���� ��ȸ







select  *
from    products p
where  exists(select * from order_items i where p.product_id = i.product_id);


--TODO: ��ǰ(products)�� �ֹ��� �ѹ��� �ȵ� ��ǰ ���� ��ȸ
select  *
from    products p
where  not exists(select * from order_items i where p.product_id = i.product_id);

select *
from order_items;
select *
from products;

