#!/bin/bash -x

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

employeeAttendance
