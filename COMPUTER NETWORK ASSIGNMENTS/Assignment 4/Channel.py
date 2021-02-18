
def channel(conn1, conn2, conn3, conn4, conn5, conn6, conn7, conn8):
    flag1 = 1
    flag2 = 1
    flag3 = 1
    flag4 = 1
    while 1:
        if flag1 == 1:
            frame1 = conn1.recv()
            if frame1[0] == 0:
                flag1 = 0
        else:
            frame1 = [0, 0, 0, 0]
            flag1 = -1

        if flag2 == 1:
            frame2 = conn3.recv()
            if frame2[0] == 0:
                flag2 = 0
        else:
            frame2 = [0, 0, 0, 0]
            flag2 = -1

        if flag3 == 1:
            frame3 = conn5.recv()
            if frame3[0] == 0:
                flag3 = 0
        else:
            frame3 = [0, 0, 0, 0]
            flag3 = -1

        if flag4 == 1:
            frame4 = conn7.recv()
            if frame4[0] == 0:
                flag4 = 0
        else:
            frame4 = [0, 0, 0, 0]
            flag4 = -1

        #print("Packets received in channel!")
        frame = []
        for i in range(4):
            val = frame1[i] + frame2[i] + frame3[i] + frame4[i]
            frame.append(val)

        if flag1 >= 0:
            conn2.send(frame)

        if flag2 >= 0:
            conn4.send(frame)

        if flag3 >= 0:
            conn6.send(frame)

        if flag4 >= 0:
            conn8.send(frame)

        if flag1 == -1 and flag2 == -1 and flag3 == -1 and flag4 == -1:
            break
