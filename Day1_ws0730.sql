/* 1. 사원정보를 조회하시오
2000년 이후 입사자 중 김씨 성을 가진 직원을 조회 하시오
연봉이 낮은 순으로 정렬 하시오*/
select * from emp
where hdate > '2000-01-01' and empname like '김%'
order by salary;
​

/* 2. 월급이 150이상인 직원들 중에 이씨이또는 홍씨인 직원을 조회 하시오
월급이 높은 순으로 정렬 하시오*/
select * from emp
where round(salary/12, 2) > 150 and (empname like '이%' or empname like '홍%')
order by round(salary/12, 2) desc;
​

/* 3. 사원정보를 조회 하고자 한다.
출력 내용은 사번, 이름, 부서번호, 연봉, 세금, 세후연봉 을 출력 한다.
empno, enpname,deptno, salary, tax, afterwithholding
세금은 연봉에 8.9% 이다.
입사년과 salary를 기준으로 많은 순으로 정렬 하시오*/
select empno, empname, deptno, salary, salary*0.089 as tax, salary - salary*0.089 as afterwithhodling
from emp
order by DATE_FORMAT(hdate, '%Y'), salary;
​

/* 4. 사원정보를 조회 하고자 한다.
월급이 150에서 250사이의 직원들을 모든 정보를 조회 하시오
empno, enpname,deptno, salary, msalary, hmonth
단, 1월에 입사한 직원들만 조회 한다.*/
select empno, empname, deptno, salary, round(salary/12, 2) as msalary, DATE_FORMAT(hdate, '%m') as hmonth
from emp
where DATE_FORMAT(hdate, '%m') = 01;