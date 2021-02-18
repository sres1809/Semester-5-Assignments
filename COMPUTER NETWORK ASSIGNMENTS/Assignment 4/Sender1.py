from queue import Queue
import time



def create_binary(data):
    binary = str(''.join(format(i, 'b') for i in bytearray(data, encoding='utf-8')))
    if len(binary) == 6:
        binary = "0" + binary
    return binary



def sender1(conn):
    ready_queue = Queue(maxsize=0)
    file = open("SenderFile1.txt", 'r')
    while 1:
        data = file.read(1)
        if not data:
            break
        bin = create_binary(data)
        for i in range(0,7):
            if bin[i] == "0":
                ready_queue.put(-1)
            else:
                ready_queue.put(1)
    file.close()
    ready_queue.put(0)

    walsh_code = [1, 1, 1, 1]
    pc = 0
    print("Walsh code for Sender 1 : " + str(walsh_code))
    while ready_queue.empty() == False:
        val = ready_queue.get()
        frame = []
        for i in range(0,4):
            frame.append(val*walsh_code[i])
        conn.send(frame)
        pc = pc+1
        time.sleep(0.000001)

    print("Packets from sender1: " + str(pc))
    print("Sender 1 complete")

