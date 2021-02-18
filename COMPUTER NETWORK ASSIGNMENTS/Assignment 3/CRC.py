

def xor(a, b):
	result = []
	for i in range(1, len(b)):
		if a[i] == b[i]:
			result.append('0')
		else:
			result.append('1')
	return ''.join(result)


def division(divident, divisor):
	pick = len(divisor)
	tmp = divident[0 : pick]
	while pick < len(divident):
		if tmp[0] == '1':
			tmp = xor(divisor, tmp) + divident[pick]
		else:
			tmp = xor('0'*pick, tmp) + divident[pick]
		pick += 1

	if tmp[0] == '1':
		tmp = xor(divisor, tmp)
	else:
		tmp = xor('0'*pick, tmp)
	checkword = tmp
	return checkword





def ret_rem(data, poly):
    length = len(poly)
    data = data + '0' * (length - 1)
    remainder = division(data, poly)
    return remainder





def add_CRC(dataword):
    poly="10011"
    rem= ret_rem(dataword,poly)
    codeword=dataword+rem
    return codeword





def check_CRC(codeword):
    poly="10011"
    rem= ret_rem(codeword,poly)
    for i in range(len(rem)):
        if rem[i]=='1':
            #print("Error is detected using CRC scheme!")
            return False
    #print("No error is detected using CRC scheme!")
    return True