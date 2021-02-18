import multiprocessing
from CRC import check_CRC
import time
import random



def decode_frame(frame):
    codeword = frame[22:55]
    return codeword



def decode_codeword(codeword):
    data = ""
    for i in range(0, len(codeword), 7):
        temp = codeword[i:i + 7]
        decimal = int(temp, 2)
        data = data + chr(decimal)
    return data


def frame_number(data):
    return int(data[-1])



def create_packet(frame_number, message):
    ack = "0101010" + "+" + "Sndr_1" + multiprocessing.current_process().name + message + frame_number
    return ack


def receiver1(conn, packets_to_channel):
    char_list = []
    while 1:
        packet_received = conn.recv()
        # print("Packet received at receiver 1!")
        if len(packet_received) == 24:
            break
        codeword = decode_frame(packet_received)
        correct = check_CRC(codeword[:32])
        if correct == False:
            print("Error detected in receiver 1")
            packet = create_packet(codeword[-1], "ERR")
            while (packets_to_channel.empty() == False):
                print("Attempt to acquire channel by receiver 1 failed!")
                i = random.randrange(1, 5)
                time.sleep(float(i / 100000))
                continue
            packets_to_channel.put(packet)
        else:
            packet = create_packet(codeword[-1], "Ack")
            while (packets_to_channel.empty() == False):
                print("Attempt to acquire channel by receiver 1 failed!")
                i = random.randrange(1, 10)
                time.sleep(i / 100000)
                continue
            packets_to_channel.put(packet)
            print("Acknowledgement sent from receiver 1")
            data = decode_codeword(codeword[:28])
            char_list.append(data + codeword[32])

    print("Receiver 1 complete")
    char_list = list(set(char_list))
    char_list.sort(key=frame_number)
    line = []
    for chars in char_list:
        line.append(chars[:4])
    file = open("ReceiverFile1.txt", 'w')
    file.writelines(line)
    file.close()
