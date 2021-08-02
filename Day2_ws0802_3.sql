/* 1. 2000 년 이후 입사 한 사원들의 정보를 출력
사번, 이름, 타이틀, 부서, 지역*/
select empno, empname, titlename, deptname, deptloc
from emp, dept, title 
where emp.titleno = title.titleno and emp.deptno = dept.deptno and year(hdate) >= '2000';


/* 2. 부서 이름 별 월급의 평균을 구하시오
단, 평균이 3000 이상인 부서만 출력*/
select deptname, avg(salary) as avg_salary
from emp, dept
where emp.deptno = dept.deptno
group by emp.deptno;

​
/*3. 대구  지역의 직원 들의 평균 연봉을 구하시오(경기지역이 없어서 임의로 바꿈)*/
select deptloc, avg(salary) as avg_salary
from emp, dept
where emp.deptno = dept.deptno and deptloc = '대구';


/*4. 홍영자 직원와 같은 부서 직원들의 근무 월수를 구하시오*/
select deptno, timestampdiff(month, hdate, curdate()) as monthdiff 
from emp
where deptno = (select deptno from emp where empname = '홍영자');
​

/*5. 입사 년수가 가장 많은 직원 순으로 정렬 하여 순위를 정한다.
이름, 부서명, 직위, 년수*/
select empname as name, deptname, titlename, timestampdiff(year, hdate, curdate()) as yeardiff
from emp, dept, title
where emp.deptno = dept.deptno and emp.titleno = title.titleno
order by yeardiff desc; 
