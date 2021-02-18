from queue import Queue
import multiprocessing
from CRC import add_CRC
import time
import random

timeout = 0.0025



def convert_binary(char):
    dataword = str(''.join(format(i, 'b') for i in bytearray(char, encoding='utf-8')))
    if len(dataword) == 6:
        dataword = "0" + dataword
    return dataword



def create_frame(data, frame_no):
    dataword = ""
    for i in range(0,len(data)):
        dataword= dataword + convert_binary(data[i])
    while len(dataword) < 28:
        dataword= dataword + "0"
    frame = "0101010" + "+" + "Rcvr_3" + multiprocessing.current_process().name + "55" + add_CRC(dataword) + frame_no
    return frame



def sender3(conn, packets_to_channel):
    global timeout
    ready_queue = Queue(maxsize=0)
    packet_sent = ""
    file = open("SenderFile3.txt", 'r')
    i = 1
    while 1:
        data = file.read(4)
        if not data:
            break
        frame = create_frame(data, str(i))
        ready_queue.put(frame)
        i = i+1
    file.close()


    while len(packet_sent) != 0 or ready_queue.empty() == False:
        if len(packet_sent) != 0:
            packet_sent = packet_sent[:55] + str(time.time())

        elif ready_queue.empty() == False:
            packet_sent = ready_queue.get_nowait()
            packet_sent = packet_sent + str(time.time())

        while(packets_to_channel.empty()==False):
            print("Attempt to acquire channel by sender 3 failed!")
            i = random.randrange(1,5)
            time.sleep(float(i / 100000))
            continue

        packets_to_channel.put(packet_sent)
        print("Sender 3 acquires the channel and sends packet!")

        if conn.poll(timeout):
            packet_received = conn.recv()
        else:
            print("Timeout elapsed in sender 3!")
            continue

        if packet_received[20:23] == "Ack":
            print("Acknowledgement received at sender 3!")
            packet_sent = ""

        else:
            print("Error message received at sender 3!")

    frame = "0101010" + "+" + "Rcvr_3" + multiprocessing.current_process().name + "END!"
    while (packets_to_channel.empty() == False):
        print("Attempt to acquire channel by sender 3 failed!")
        i = random.randrange(1, 5)
        time.sleep(i / 100000)
        continue
    packets_to_channel.put(frame)
    print("Sender 3 complete")
