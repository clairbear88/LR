'''
What are my inputs?
What do i need to do with that input?
What needs to be output?
-step through the code
-use print command to debug
-separate each step into separate functions
-Test often
'''

#Input: Birthday and current date
#What: Calculate my age in days. compensate for leap year: every 4 years 1 extra day
#Output: number of days in my age

'''
daysofmonths = [31,28,31,30,31,30,31,31,30,31,30,31]
month_names = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']


def end_leap_year():
	end_leap_year=0
	if year==y2 and m2 in month_names[:last_month_index]:
		end_leap_year+=1
		return True
	if year==y1 and m1 in month_names[:first_month_index]:
		end_leap_year-=1
		return True
	return False

def num_of_leap_year(y1,y2):
	count=0
	for year in range(y1,y2):
		if year % 4 !=0:
			#print count
			return count
		elif year % 100 !=0:
			count+=1
			#print count
			return count
		elif year % 400 !=0:
			count+=1
			#print count
			return count
		elif end_leap_year(year)==True:
			end_leap_year-=1
		else:
			#print count
			return count

def my_age_in_days(y1,m1,d1,y2,m2,d2):
	first_month_index = month_names.index(m1)
	last_month_index = month_names.index(m2)
	leap_year_days = num_of_leap_year(y1,y2) * 366
	not_leap_years = (y2 - y1) - num_of_leap_year(y1,y2)

	def extra_days(m):
		extra_days=0
		if m==m1:
			for element in daysofmonths[:first_month_index]:
				extra_days+=element - d1
		else:
			for element in daysofmonths[:last_month_index]:
				extra_days+=element + d2
		return extra_days

	not_leap_year_days = (not_leap_years - 1) * 365
	days = int(leap_year_days) + int(not_leap_year_days) + int(extra_days(m2)) - int(extra_days(m1)) + int(end_leap_year)
	return  days

print 'my_age_days: '+str(my_age_in_days(1988,'Jan',8,2016,'Jan',31))
print my_age_in_days(1988,'Jan',8,2016,'Jan',31)
'''


'''
What are the inputs?
What are the outputs?
Work through some examples by hand.
Simple mechanical solution
Don't optimize prematurely, simple and correct.
'''

#Psuedo Code:
'''
days=0
while date1 is before date2:
	date1 = day after date1  #this is nextDay()
	days+=1
returns days
'''
def nextDay(year, month, day):
	'''Warning: this version incorrectly assumes all months have 30 days!'''
	if day < 30:
		return year, month, day + 1
	else:
		if month < 12:
			return year, month + 1, 1
		else:
			return year + 1, 1, 1

def dateIsBefore(year1, month1, day1, year2, month2, day2):
	'''
	Returns True if year1-month1-day1 is before year2-month2-day2.
	otherwise, returns False.
	'''
	if year1 < year2:
		return True
	if year1 == year2:
		if month1 < month2:
			return True
		if month1 == month2:
			return day1 < day2
	return False


def daysBetweenDates(year1, month1, day1, year2, month2, day2):
	"""
	Returns the number of days between year1/month1/day1
	and year2/month2/day2. Assumes inputs are valid dates
	in Gregorian calendar, and the first date is not after
	the second.
	"""
	days=0
	while dateIsBefore(year1, month1, day1, year2, month2, day2):
		year1, month1, day1 = nextDay(year1, month1, day1)
		days += 1
	print days
	return days


def test():
    test_cases = [((2012,9,30,2012,10,30),30),
                  ((2012,1,1,2013,1,1),360),
                  ((2012,9,1,2012,9,4),3)]

    for (args, answer) in test_cases:
        result = daysBetweenDates(*args)
        if result != answer:
            print "Test with data:", args, "failed"
        else:
            print "Test case passed!"

test()

