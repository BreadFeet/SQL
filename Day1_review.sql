select *  from emp where hdate between '1998-01-01' and '2000-01-01';
select * from emp where deptno in ('10', '20');
select * from emp where deptno between 10 and 20;

select date_format(hdate, '%y-%M-%D') as hdate from emp
where hdate >= '2000-01-01';

select salary/12 as msalary from emp where salary/12 >=200;

select empname as Name from emp where empname like '%영%';

select *, count(*), sum(salary), avg(salary), std(salary), var_samp(salary), min(salary), max(salary) 
from emp group by manager having sum(salary) > 10000;
