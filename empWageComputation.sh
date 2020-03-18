#!/bin/bash -x

#CONSTANTS
WAGE_PER_HOUR=20
FULL_DAY_HOUR=8
PART_TIME_HOUR=4
FULL_TIME_EMPLOYEE=1
PART_TIME_EMPLOYEE=0

#variables
isEmployeePresent
wageForADay
employeeType

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

# fucntion to calculate employee type, Full time or Part time
function employeeType() {
	local empType=$((RANDOM%2))
	if [ $empType -eq $FULL_TYPE_EMPLOYEE ]
	then
		echo "fulltime"
	fi
	if [ $empType -eq $PART_TIME_EMPLOYEE ]
	then
		echo "parttime"
	fi
}


############# main program ############

echo "** Welcome to Employee Wage Computation **"

isEmployeePresent=$( employeeAttendance )

if [ $isEmployeePresent = "present" ]
then
	wageForADay=$( dailyEmployeeWage $WAGE_PER_HOUR $FULL_DAY_HOUR )
else 
	wageforADay=0
fi
