#Generate 100 numbers, count even
count = 0
for i in 1 to 100:
    num = random(0, 999)
    if num % 2 == 0:
        count += 1
print(count)

#given a list, find failed
failed = []
for test in test_list:
    if test.status == "FAIL":
        failed.append(test)

