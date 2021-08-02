/* 1. 직원정보를 출력 한다. 직원의 연봉 정보와 연봉의 세금 정보를 같이 출력 한다.
세금은 10% */
select *, salary*0.1 as tax from emp;
​

/* 2. 직원정보 중 2001 이전에 입사 하였고 연봉이 4000만원 미만인 직원을 조회*/
select * from emp 
where hdate < '2001-01-01' and salary < 4000;


/*강사님 방법*/
select * from emp 
where year(hdate) < 2001 and salary < 4000;


/* 3. manager가 있는 직원 중 이름에 '자' 가 들어가 있는 직원정보 조회 */
select * from emp
where (manager is not NULL) and (empname like '%자%');

​
/* 4. 연봉이 2000미만은 '하' 4000미만은 '중' 4000이상은 '고' 를 출력 */
alter table emp add salarylevel char(1);
update emp set salarylevel = '하' where salary < 2000;
update emp set salarylevel = '중' where (2000 <= salary) and (salary < 4000);
update emp set salarylevel = '고' where salary >= 4000;
select * from emp;


/* 강사님 방법  */
select empname, salary, 
case when(salary < 2000) then '하'
     when(salary >= 2000 and salary < 4000) then '중'
	  else '고'
	  end          # 오래전 방식이라 end로 끝맺어줘야 한다
	  as salarylevel
from emp;


/* 5. 부서 별 연봉의 평균을 구하시오
단, 평균이 3000 이상인 부서만 출력 */
select deptno, avg(salary) as avg_salary
from emp
group by deptno
having avg_salary >= 3000;


/* 6. 부서 별 대리와 사원 연봉의 평균을 구하시오
단, 평균이 2500 이상인 부서만 출력 */
select deptno, t1.titleno, titlename, avg(salary) as avg_salary
from emp t1, title t2
where t1.titleno = t2.titleno
group by deptno, t1.titleno
having titlename in ('대리', '사원') and avg_salary >= 2500;   

# 조건을 걸 때 group by-having으로 하면 where-group by보다 느릴 수 있다

select deptname, titlename, avg(salary) as avg_salary
from emp e left outer join dept d using(deptno)
           left outer join title t using(titleno)
where titlename = '대리' or titlename = '사원' 
group by deptname, titlename
having avg_salary > 2500; 


/* 6-1. 사원정보를 출력 하시오. 이름, 부서명, 지역명, 직위*/
select empname, deptname, deptloc, titlename
from emp e inner join dept d on e.deptno=d.deptno
           inner join title t on e.titleno=t.titleno;

           
/* 6-2.부서별, 직위별 연봉의 평균을 구하시오*/
select deptname, titlename, avg(salary)
from emp e join dept d on e.deptno=d.deptno
 			  join title t on e.titleno=t.titleno
group by deptname, titlename;


/* 7. 2000년 부터 2002년에 입사는 직원들의
연봉의 평균을 구하시오 */
select year(hdate), avg(salary)
from (select *, year(hdate) from emp where year(hdate) between 2000 and 2002) as t1
group by year(hdate);

select year(hdate) as year_hdate, avg(salary)
from emp
group by year(hdate)
having year_hdate between 2000 and 2002;
​

/* 8. 부서 별 월급의 합의 ranking을 1위부터 조회 하시오 */
select deptno, sum(salary) as sum_salary
from emp
group by deptno
order by sum_salary desc;
​

/* 9. 서울에서 근무하는 직원들을 조회 하시오*/
select *
from dept, emp
where dept.deptno = emp.deptno and deptloc = '서울';

​
/* 10. 이영자가 속한 부서의 직원들을 조회 하시오 */
select *
from emp
where deptno in (select deptno from emp where empname = '이영자');

select *
from emp
where deptno in '30';

/* 11. 김강국의 타이틀과 같은 직원들을 조회 하시오 */
select *
from emp
where titleno in (select titleno from emp where empname='김강국');
