#!/bin/bash -x

#CONSTANTS
WAGE_PER_HOUR=20
FULL_DAY_HOUR=8

#variables
isEmployeePresent
wageForADay

echo "** Welcome to Employee Wage Computation **"

# function to check if employee is present or absent
function employeeAttendance() {
	local counter=$(( RANDOM%2 ))
	if [ $counter -eq 1 ]
	then
		echo "present"
	else
		echo "absent"
	fi
}

# funcion to calculate employee wage
# param1 : wage per hour
# param2 : working hours of employee
function dailyEmployeeWage() {
	echo $(( $1*$2 ))
}


isEmployeePresent=$( employeeAttendance )

if [ $isEmployeePresent = "present" ]
then
	wageForADay=$( dailyEmployeeWage $WAGE_PER_HOUR $FULL_DAY_HOUR )
else 
	wageforADay=0
fi
