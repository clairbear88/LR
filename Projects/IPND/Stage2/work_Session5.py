import random

random_list = []
list_length = 20

while len(random_list) < list_length:
	#Replace each element in random_list with a random integer
	random_list.append(random.randint(0,10))

'''
# Example of a loop to count occurences of a number
index = 0
count = 0

while index < len(random_list):
	#count the occurences of 9 in random_list
	if random_list[index] == 9:
		count = count + 1
	index = index + 1
'''

#Inputs: randomly generated list
#Outputs: A Count of all occurences of all numbers from 0-1

#List to store counts:
count_list = [0] * 11
index = 0

while index < len(count_list):
	#loop through random_list count occurences of each value and store in count_list
	count = 0
	for number in random_list:
		if number == index:
			count += 1
	count_list[index] = count
	index += 1

#Inputs: count_list
#Outputs: table of each value and the number of occurences:
'''
number | occurrence
     0 | 1
     1 | 2
     2 | 3
     3 | 2
     4 | 2
     5 | 1
     6 | 1
     7 | 2
     8 | 3
     9 | 1
    10 | 2
'''

print 'number | occurence'
index = 0
num_len = len('number')
for number in count_list:
	num_spaces = num_len - len(str(index))
	print ' ' * num_spaces + str(index) + ' | ' + '*' * count_list[index]
	index += 1

