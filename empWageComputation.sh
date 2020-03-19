#!/bin/bash

#CONSTANTS
WAGE_PER_HOUR=20
FULL_DAY_HOUR=8
PART_TIME_HOUR=4
FULL_TIME_EMPLOYEE=1
PART_TIME_EMPLOYEE=0
EMPLOYEE_PRESENT=1
MONTHLY_WORKING_DAYS=20
MONTHLY_MAX_WORKING_HOURS=100
DAYS_IN_MONTH=30

#variables
isEmployeePresent=0
wageForADay=0
employeeType=0
employeeWorkingTime=0
workingHoursForDay=0
daysEmployeeWorkedInMonth=0
employeeMonthlyWage=0
workingHoursForMonth=0
days=0

# data structure to store dailt wage
declare -A dailyWage

# function to check if employee is present or absent
# local variables
counter=0

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
empType=0

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

# function to get working hours
# param1 : employee working time, part time or full time
# local variable
workhours=0

function getWorkingHoursForDay() {
	case $employeeWorkingTime in  # setting working hours for a day according to employee type
		fulltime)
			workHours=$FULL_DAY_HOUR
			;;
		parttime)
			workHours=$PART_TIME_HOUR
			;;
	esac

	if [ $(( $MONTHLY_MAX_WORKING_HOURS-$workingHoursForMonth )) -lt $FULL_DAY_HOUR ] # tackling situation where perosn has worked for 96 hours but he comes next day for Full day(8 hours), he will still be paid only for 4 hours
	then
		workHours=$PART_TIME_HOUR
	fi

	echo $workHours
}


############# main program ############

echo "** Welcome to Employee Wage Computation **"

while [ $daysEmployeeWorkedInMonth -lt $MONTHLY_WORKING_DAYS ] && [ $workingHoursForMonth -lt $MONTHLY_MAX_WORKING_HOURS ] && [ $days -lt $DAYS_IN_MONTH ] # calculating wage for max of 100 hours or 20 days of work done or 30 days aka month gets over
do
	isEmployeePresent=$( employeeAttendance )

	if [ $isEmployeePresent = "present" ]  # cheking if employee is present or not
	then
		employeeWorkingTime=$( employeeType )  # setting employee's work time, part time or full time accordingly

		workingHoursForDay=$( getWorkingHoursForDay $employeeWorkingTime ) # getting working hours for day

		wageForADay=$( dailyEmployeeWage $WAGE_PER_HOUR $workingHoursForDay )  # calculating a day's wage for the employee if present

		(( daysEmployeeWorkedInMonth++ )) # incrementing worked day by 1 

		workingHoursForMonth=$(( $workingHoursForMonth+$workingHoursForDay )) # adding hours worked in day to monthly worked hours

	else
		wageForADay=0 # calcuating a day's wage for employee if absent
	fi

	dailyWage[$days]=$wageForADay # storing daily wage

	(( days++ )) # increasing a day

	employeeMonthlyWage=$(( $employeeMonthlyWage+$wageForADay ))
done


for var in ${!dailyWage[@]} # printing the dailywage alongside its day
do
	echo "Day "$var : ${dailyWage[$var]}
done
echo "Employee Wage for the month : $employeeMonthlyWage" # printing total monthly wage earned by employee
