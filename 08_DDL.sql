
/* ***********************************************************************************
ddl - database �� ��ü�� ���� �Ѵ�.  -- ��ǥ������ table
- ���� - create
-���� - alter
-���� - drop


���̺� ����
- ����
create table ���̺�_�̸�(
  �÷� ����,
)

�������� ���� 
- �÷� ���� ����
    - �÷� ������ ���� ����
- ���̺� ���� ����
    - �÷� �����ڿ� ���� ����

- �⺻ ���� : constraint ���������̸� ��������Ÿ�� pk, unique,fk,check ��� 
- ���̺� ���� ���� ��ȸ
    - USER_CONSTRAINTS ��ųʸ� �信�� ��ȸ
    
���̺� ����
- ����
DROP TABLE ���̺��̸� [CASCADE CONSTRAINTS]
*********************************************************************************** */

create table parent_tb(
    no number constraint pk_parent_tb primary key,
    name nvarchar2(30) not null,
    birthday date default sysdate, -- �⺻�� ���� : insert �� ���� ���� ������ insert �� �⺻��.
    email varchar2(100) constraint uk_parent_tb_email unique, -- ����ũ ���� ����  : �ߺ��� ���� ���� ����.  (null �� ����)
    gender char(1) not null constraint ck_parent_tb_gender check (gender in ('M','F'))-- check key:���� ���� ����( m�� f�� �����Ŵ�)
);

desc parent_tb;
insert into parent_tb values(1,'ȫ�浿','2000/01/01','a@a.com','M');

insert into parent_tb (no,name,gender) values (2,'�̼���','M');  -- ������ �ȳ־����� ����Ʈ ��

insert into parent_tb values(3,'ȫ�浿',null,'b@a.com','M'); -- ��������� ���� ���� ������ ����Ʈ�� �ƴ϶� null �� insert �Ѵ�.


insert into parent_tb values(4,'ȫ�浿',null,'b@a.com','M');

--����� 46 �࿡�� �����ϴ� �� ���� �߻� -
--insert into parent_tb values(4,'ȫ�浿',null,'b@a.com','M')
--���� ���� -
--ORA-00001: ���Ἲ ���� ����(C##SCOTT_JOIN.UK_PARENT_TB_EMAIL)�� ����˴ϴ�  --> �������� �̸��� ������ ������ ã�� �� ���ִ�.
-- �̸����� ����ũ Ű�ε� ���� ���� ���� ������ �� ���̴�.

insert into parent_tb values(5,'�迵��',null,'c@a.com','m');

select * from parent_tb;


create table child_tb(
    no number, --pk
    jumin_num char(14) not null, --uk
    age number (3) default 0,  -- 10~90 (check)
    parent_no number, -- parent_tb �� �����ϴ� fk
    constraint pk_child_tb primary key(no),
    constraint uk_child_tb_jumin_num unique(jumin_num),
    constraint ch_child_tb_age check(age between 10 and 90),
    constraint fk_child_tb_parent_tb foreign key(parent_no) references parent_tb(no) -- �θ����̺��� �����̸Ӹ�Ű�� �����Ѵٰ� ���ش�.
);


--CONSTRAINT ���������̸� FOREIGN KEY(�÷�) REFERECES �θ����̺�(PK�÷�)






/* ************************************************************************************
ALTER : ���̺� ����

�÷� ���� ����

- �÷� �߰�
  ALTER TABLE ���̺��̸� ADD (�߰��� �÷����� [, �߰��� �÷�����])
  - �ϳ��� �÷��� �߰��� ��� ( ) �� ��������

- �÷� ����
  ALTER TABLE ���̺��̸� MODIFY (�������÷���  ���漳�� [, �������÷���  ���漳��])
	- �ϳ��� �÷��� ������ ��� ( )�� ���� ����
	- ����/���ڿ� �÷��� ũ�⸦ �ø� �� �ִ�.
		- ũ�⸦ ���� �� �ִ� ��� : ���� ���� ���ų� ��� ���� ���̷��� ũ�⺸�� ���� ���
	- �����Ͱ� ��� NULL�̸� ������Ÿ���� ������ �� �ִ�. (�� CHAR<->VARCHAR2 �� ����.)

- �÷� ����	
  ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸� [CASCADE CONSTRAINTS]
    - CASCADE CONSTRAINTS : �����ϴ� �÷��� Primary Key�� ��� �� �÷��� �����ϴ� �ٸ� ���̺��� Foreign key ������ ��� �����Ѵ�.
	- �ѹ��� �ϳ��� �÷��� ���� ����.
	
  ALTER TABLE ���̺��̸� SET UNUSED (�÷��� [, ..])
  ALTER TABLE ���̺��̸� DROP UNUSED COLUMNS
	- SET UNUSED ������ �÷��� �ٷ� �������� �ʰ� ���� ǥ�ø� �Ѵ�. 
	- ������ �÷��� ����� �� ������ ���� ��ũ���� ����� �ִ�. �׷��� �ӵ��� ������.
	- DROP UNUSED COLUMNS �� SET UNUSED�� �÷��� ��ũ���� �����Ѵ�. 

- �÷� �̸� �ٲٱ�
  ALTER TABLE ���̺��̸� RENAME COLUMN �����̸� TO �ٲ��̸�;
























**************************************************************************************  
���� ���� ���� ����   -- modify �� ���� ������ �ٽ� �������ϳ�.
-�������� �߰�
  ALTER TABLE ���̺�� ADD CONSTRAINT �������� ����

- �������� ����
  ALTER TABLE ���̺�� DROP CONSTRAINT ���������̸�
  PRIMARY KEY ����: ALTER TABLE ���̺�� DROP PRIMARY KEY [CASCADE]  -- �Ķ��̸Ӹ� Ű�� ���̺�� 1���ۿ� ���ȱ�/ ���̺�� �Ƚ�ε�
	- CASECADE : �����ϴ� Primary Key�� Foreign key ���� �ٸ� ���̺��� Foreign key ������ ��� �����Ѵ�.

- NOT NULL <-> NULL ��ȯ�� �÷� ������ ���� �Ѵ�.  -- 
   - ALTER TABLE ���̺�� MODIFY (�÷��� NOT NULL),  - ALTER TABLE ���̺�� MODIFY (�÷��� NULL)  
************************************************************************************ */
--customers ī���ؼ� cust ���̺� �����
--���� ������� �����̺�� ����
create table cust 
as 
select * from customers;   --- ����Ʈ�� ����� ���� ���̺��� ����°��̴�.

select * from cust;



create table cust2
as
select cust_id, cust_name, address from customers;  --�� ����� ���� ���� 
select * from cust2;


create table cust3
as
select *from  customers  ---> ������� ��� �÷� ���� ����� 
where 1 = 0;-- false

select * from cust3;


----
-- �߰�
alter table cust3 add(age number default 0 not null,point number);

-- ����
alter table cust3 modify(age number(3));

alter table cust3 modify(cust_email null); ---> not null > null �ιٲ�

alter table cust3 modify(cust_email not null);   

desc cust3;

-- �÷��� ���� 

alter table cust3 rename column cust_email to email;   --- Ŀ��Ʈ �̸��Ͽ��� .>>> �̸��Ϸ� �ٲ�

-- �÷� ����

alter table cust3 drop column age;  ---> �÷��� �ִ� �������� ���� ���� 

desc cust3;


select * from cust;
desc cust;

select * from cust;
alter table cust modify (cust_id number (2));  --- -99~99  -- �����Ͱ� �ֱ� ������ �ٲ��� ���Ѵ�. / ���� ������ ���� ������ �۾����� �ȵȴ�.
alter table cust modify (cust_id number (5));   -- 99999  �ø������� ���� �����Ϳ� ������ ��� �����ϴ�.
alter table cust add(age number(3) not null);   -- �÷� �߰� ���� �ȳ־����ϱ� null �� ���ߵǴµ�(((null�̾�� �Ǵµ�))���� ��� not null ����
select * from cust;

alter table cust3 modify (cust_id number (2));
rollback;  -- ��DML ; �� ���谡 �ִ°� ���� DDL���� �ѹ�/Ŀ���� ����̾ƴϴ�. ��������ʴ´�.
desc cust;

----- ���� ���� ����
-- �� ���̺��� ���� ���ǵ� ��ȸ (����Ŭ ����)
select * from user_constraints;
select * from user_constraints where table_name = 'CUST';  -- ==> �̶� ���̺� ���� �빮�ڷ� �����

alter table cust add constraint pk_cust primary key(cust_id); -- Ŀ��Ʈ ���̺� �����̸� �߰� 
alter table cust add constraint uk_cust_cust_email unique(cust_email);   -- ����ũ �߰�
alter table cust add constraint ch_cust_gender check(gender in ('M', 'F'));   -- ck �߰�

select * from user_constraints where table_name = 'CUST';

-- �����Ϸ��� ����ϰ� �ٽ� �߰� �ؾ���

-- ����
alter table cust drop constraint ch_cust_gender;
alter table cust drop constraint pk_cust;
alter table cust drop primary key;

select * from user_constraints where table_name = 'CUST';



--TODO: emp ���̺��� ī���ؼ� emp2�� ����(Ʋ�� ī��)

create table emp2
as 
select * from emp   -- �� ����Ʈ ���� ����� ���� emp2�� ����� �� 
where 1=0;             -- ���� �Ǵ� ������ �־��ָ� Ʋ�� ���� ���� �ȴ�// ���� �����Ͱ� �����ϱ�

select *from emp2;
desc emp2;
--TODO: gender �÷��� �߰�: type char(1)


alter table emp2 add(gender char(1));


desc emp2;
--TODO: email �÷� �߰�. type: varchar2(100),  not null  �÷�
alter table emp2 add (email varchar2(100) not null);  --==> �̰� ���� �� ���� �ȳ־�����

select *from emp2;


--TODO: jumin_num(�ֹι�ȣ) �÷��� �߰�. type: char(14), null ���. ������ ���� ������ �÷�.
--alter table cust add constraint uk_cust_cust_email unique(cust_email)


--alter table emp2 add (jumin_num char(14) unique);
alter table emp2 add (jumin_num char(14) constraint uk_emp2_jumin unique);
desc emp2;

select * from user_constraints where table_name='EMP2';
--TODO: emp_id �� primary key �� ����-------------------------------------------------d������� �� ����

alter table emp2 add constraint pk_emp2 primary key(emp_id);

select * from user_constraints where table_name='EMP2';
  
--TODO: gender �÷��� M, F �����ϵ���  �������� �߰�
alter table emp2 add constraint ck_emp2_gender check(gender in('M','F'));

 
--TODO: salary �÷��� 0�̻��� ���鸸 ������ �������� �߰�

select * from user_constraints where table_name='EMP2';


alter table emp2 add constraint ck_emp2_salary check(salary >0);
--TODO: email �÷��� null�� ���� �� �ֵ� �ٸ� ��� ���� ���� ������ ���ϵ��� ���� ���� ����
alter table emp2 modify (email null);

desc emp2;
--TODO: emp_name �� ������ Ÿ���� varchar2(100) ���� ��ȯ
alter table emp2 modify(emp_name varchar2(100));

desc emp2;

--TODO: job_id�� not null �÷����� ����

alter table emp2 modify(job_id not null); 



--TODO: dept_id�� not null �÷����� ����
alter table emp2 modify(dept_id not null); 


--TODO: job_id  �� null ��� �÷����� ����

desc emp2;
alter table emp2 modify(job_id null);
--TODO: dept_id  �� null ��� �÷����� ����

alter table emp2 modify(dept_id null);

--TODO: ������ ������ uk_emp2_email ���� ������ ����
desc emp2;

drop 



--TODO: ������ ������ ck_emp2_salary ���� ������ ����

alter table emp2 drop constraint ck_emp2_salary;

--TODO: primary key �������� ����

alter table emp2 drop primary key;

--TODO: gender �÷�����

alter table emp2 drop column gender;

--TODO: email �÷� ����

alter table emp2 drop column email;

desc emp2;


 Į���� ���� �߰� �Ҷ��� constraint ���� �׳� �÷� �̸� �� ������ Ÿ�� ���� �����ϰ�
 �÷� ���� ������ �����Ҷ��� constraint �� �ִ´� // ���� �Ȱ��� alter table
/* **************************************************************************************************************
-- ����Ŭ ����

������ : SEQUENCE
- �ڵ������ϴ� ���ڸ� �����ϴ� ����Ŭ ��ü
- ���̺� �÷��� �ڵ������ϴ� ������ȣ�� ������ ����Ѵ�.
	- �ϳ��� �������� ���� ���̺��� �����ϸ� �߰��� �� ������ �� �� �ִ�.

���� ����
CREATE SEQUENCE sequence�̸�

	[INCREMENT BY n]	
	[START WITH n]                		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]		  

- INCREMENT BY n: ����ġ ����. ������ 1
- START WITH n: ���� �� ����. ������ 0
	- ���۰� ������
	 - ����: MINVALUE ���� ũĿ�� ���� ���̾�� �Ѵ�.
	 - ����: MAXVALUE ���� �۰ų� ���� ���̾�� �Ѵ�.
- MAXVALUE n: �������� ������ �� �ִ� �ִ밪�� ����
- NOMAXVALUE : �������� ������ �� �ִ� �ִ밪�� ���������� ��� 10^27 �� ��. ���������� ��� -1�� �ڵ����� ����. 
- MINVALUE n :�ּ� ������ ���� ����
- NOMINVALUE :�������� �����ϴ� �ּҰ��� ���������� ��� 1, ���������� ��� -(10^26)���� ����
- CYCLE �Ǵ� NOCYCLE : �ִ�/�ּҰ����� ������ ��ȯ�� �� ����. NOCYCLE�� �⺻��(��ȯ�ݺ����� �ʴ´�.)
- CACHE|NOCACHE : ĳ�� ��뿩�� ����.(����Ŭ ������ �������� ������ ���� �̸� ��ȸ�� �޸𸮿� ����) NOCACHE�� �⺻��(CACHE�� ������� �ʴ´�. )


������ �ڵ������� ��ȸ
 - sequence�̸�.nextval  : ���� ����ġ ��ȸ
 - sequence�̸�.currval  : ���� �������� ��ȸ/// nextvall �� ���� �ѹ����ְ� ����Ѵ�.�׷��� 1���� �����Ѵٰ� �����ϸ�� 


������ ����
ALTER SEQUENCE ������ �������̸�
	[INCREMENT BY n]	               		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]	

������ �����Ǵ� ������ ������ �޴´�. (�׷��� start with ���� ��������� �ƴϴ�.)	  


������ ����
DROP SEQUENCE sequence�̸�
	
************************************************************************************************************** */

-- 1���� 1�� �ڵ������ϴ� ������
create sequence dept_id_seq;  -- �̸� ����: �������� ����� �÷���_seq

--seq�̸�.nextval()
select dept_id_seq.nextval from dual;
select dept_id_seq.currval from dual;

insert into dept values (dept_id_seq.nextval,'���μ�'||dept_id_seq.currval,'����');
select * from dept order by dept_id;





-- 1���� 50���� 10�� �ڵ����� �ϴ� ������

create sequence ex1_seq 
    increment by 10 
    maxvalue 50;


select ex1_seq.nextval from dual; -- �ƽ� ��� ������ ��������.




-- 100 ���� 150���� 10�� �ڵ������ϴ� ������

create sequence ex2_seq
    increment by 10
    start with 100
    maxvalue 150;
    
    
select ex2_seq.nextval from dual;



-- 100 ���� 150���� 10�� �ڵ������ϵ� �ִ밪�� �ٴٸ��� ��ȯ�ϴ� ������
-- ��ȯ(cycle)�� �Ҷ� ���� increment by ���): minvalue (�⺻�� : 1) ���� ����  ����Ŭ�� �Ҷ��� �׻� ���� ��������Ѵ�.
--      ;"""        ���� increment by ����: maxvalue ���� ����
drop sequence ex3_seq;    -- ĳ�ÿ��� ����Ŭ �������� ����Ʈ 6 ���� ���� ���� ���ؾ��Դ�.

create sequence ex3_seq
    increment by 10
    start with 100
    maxvalue 150   -- �ƽ���
    minvalue 100    -- �ι�° ����Ŭ ���۰� 
    cache  5
    cycle;

select ex3_seq.nextval from dual;   -- ����Ŭ �Ŀ��� 1���� �ٽ� ���´�~~



-- -1���� �ڵ� �����ϴ� ������  -1 ��

create sequence ex4_seq
    increment by -1;  -- �ڵ� ���� : ��ŸƮ �� �⺻���� -1

select ex4_seq.nextval from dual;



-- -1���� -50���� -10�� �ڵ� �����ϴ� ������
create sequence ex5_seq
    increment by -10
    start with -1   -- ���� ����
    minvalue -50;     -- �����ϱ�

select ex5_seq.nextval from dual;



-- 100 ���� -100���� -100�� �ڵ� �����ϴ� ������
create sequence ex6_seq
    increment by -100
    start with 100   --
    minvalue -100     -- max ����� �����ƴ�. ���ҽ� �ƽ���� �����尪�� -1 �̴�. - ���� max��� >= startvalue, ���� : �ι�� <=��ŸƮ ���
    maxvalue 100;

select ex6_seq.nextval from dual;


-- 15���� -15���� 1�� �����ϴ� ������ �ۼ�
create sequence ex7_seq
    increment by -1
    start with 15
    minvalue -15
    maxvalue 15;
    
select ex7_seq.nextval from dual;



-- -10 ���� 1�� �����ϴ� ������ �ۼ�
create sequence ex8_seq
    increment by 1
    start with -10
    minvalue -10;
-- ���� minvaluue 1�� �⺻�� . ���� : minvalud <= start with
    
select ex8_seq.nextval from dual;




-- Sequence�� �̿��� �� insert



-- TODO: �μ�ID(dept.dept_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 10�� �����ϴ� sequence
-- ������ ������ sequence�� ����ؼ�  dept_copy�� 5���� ���� insert.

create sequence dept_id_seq2
    start with 10
    increment by 10;



create table dept_copy
as
select *from dept where 1<>1;

insert into dept_copy values(dept_id_seq2.nextval,'��ȹ��','����');
insert into dept_copy values(dept_id_seq2.nextval,'��ȹ��','����');
insert into dept_copy values(dept_id_seq2.nextval,'��ߺ�','����');

select *from dept_copy;


-- TODO: ����ID(emp.emp_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 1�� �����ϴ� sequence
-- ������ ������ sequence�� ����� emp_copy�� ���� 5�� insert

create sequence emp_id_seq
    start with 10;
    
insert into emp2 values(emp_id_seq.nextval, 'ȫ�浿', null,null, '2021/01/05', 30000, null, null, null);
insert into emp2 values(emp_id_seq.nextval, '��浿', null,null, '2021/01/05', 30000, null, null, null);
insert into emp2 values(emp_id_seq.nextval, '���浿', null,null, '2021/01/05', 30000, null, null, null);

select * from emp2;
