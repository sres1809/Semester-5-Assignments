from queue import Queue
import multiprocessing
from CRC import add_CRC
import time


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
    #print("In sender 3")
    ready_queue = Queue(maxsize=0)
    sent_queue = Queue(maxsize=0)
    file = open("SenderFile3.txt", 'r')
    i = 1
    while 1:
        data = file.read(4)
        if not data:
            break
        frame = create_frame(data, str(i))
        #print(frame)
        ready_queue.put(frame)
        i = i+1
    file.close()




    while sent_queue.empty() == False or ready_queue.empty() == False:
        if sent_queue.empty() == False:
            packet_sent = sent_queue.get_nowait()
            packet_sent = packet_sent[:55] + str(time.time())
            packets_to_channel.put(packet_sent)
            print("Packet sent from sender 3 ")
            sent_queue.put_nowait(packet_sent)

        elif ready_queue.empty() == False:
            packet_sent = ready_queue.get_nowait()
            packet_sent = packet_sent + str(time.time())
            packets_to_channel.put(packet_sent)
            print("Packet sent from sender 3")
            sent_queue.put_nowait(packet_sent)


        packet_received = conn.recv()
        if time.time() - float(packet_sent[55:]) > timeout:
            print("Timeout exceeded in s3!")

        elif packet_received[20:23] == "Ack":
            print("Acknowledgement received at s3!")
            packet = sent_queue.get_nowait()

        else:
            print("Error message received at s3!")

    frame = "0101010" + "+" + "Rcvr_3" + multiprocessing.current_process().name + "END!"
    packets_to_channel.put(frame)
    print("Sender 3 complete")





