
def receiver3(conn):
    bin_list = []
    walsh_code = [1, 1, -1, -1]
    print("Walsh code for Receiver 4 : " + str(walsh_code))
    while 1:
        frame_received = conn.recv()
        val = 0
        #print("Packet received!")
        for i in range(0,4):
            val = val + frame_received[i]*walsh_code[i]
        if val == 0:
            break
        elif val == -4:
            bin_list.append(0)
        else:
            bin_list.append(1)

    print("Receiver 3 complete")
    line = ""
    for i in range(0, len(bin_list)-1, 7):
        decimal = 0
        for j in range(0,7):
            decimal = decimal*2 + bin_list[i+j]
        line = line + chr(decimal)

    file = open("ReceiverFile3.txt", 'w')
    file.writelines(line)
    file.close()
