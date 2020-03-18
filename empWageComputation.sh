#!/bin/bash -x

#CONSTANTS
WAGE_PER_HOUR=20
FULL_DAY_HOUR=8
PART_TIME_HOUR=4
FULL_TIME_EMPLOYEE=1
PART_TIME_EMPLOYEE=0
EMPLOYEE_PRESENT=1
EMPLOYEE_ABSENT=0
MONTHLY_WORKING_DAYS=20

#variables
isEmployeePresent
wageForADay
employeeType
employeeWorkingTime
workingHoursForDay
daysEmployeeWorkedForMonth=0
employeeMonthlyWage=0

# function to check if employee is present or absent
# local variables
counter

function employeeAttendance() {
	local counter=$(( RANDOM%2 ))
	if [ $counter -eq $EMPLOYEE_PRESENT ]
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
	echo $(($1*$2))
}


# fucntion to calculate employee type, Full time or Part time
# local variables
empType

function employeeType() {
	local empType=$((RANDOM%2))
	if [ $empType -eq $FULL_TIME_EMPLOYEE ]
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

while [ $daysEmployeeWorkedForMonth -lt $MONTHLY_WORKING_DAYS ]
do
	isEmployeePresent=$( employeeAttendance )

	if [ $isEmployeePresent = "present" ]  # cheking if employee is present or not
	then
		employeeWorkingTime=$( employeeType )  # setting employee's work time, part time or full time accordingly

		case $employeeWorkingTime in  # setting working hours for a day according to employee type
			fulltime)
				workingHoursForDay=$FULL_DAY_HOUR
				;;
			parttime)
				workingHoursForDay=$PART_TIME_HOUR
				;;
		esac

		wageForADay=$( dailyEmployeeWage $WAGE_PER_HOUR $workingHoursForDay )  # calculating a day's wage for the employee if present
	else
		wageForADay=0 # caculating a day;s wage for employee if absent
	fi

	employeeMonthlyWage=$(( $employeeMonthlyWage+$wageForADay))
	(( daysEmployeeWorkedForMonth++ ))
done

echo "Employee Wage for the month : $employeeMonthlyWage"
