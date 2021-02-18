import multiprocessing
import random
import time


def channel(conn1, conn2, conn3, conn4, conn5, conn6, packets_to_channel):

    while 1:
        #print("In channel!")
        packet = packets_to_channel.get()
        #print("Packet received in channel")
        i = random.randrange(0,100)
        if len(packet) != 24:
            if i < 54 and i > 22:
                packet = packet[:i] + "0" + packet[i + 1:]

            if i%3 == 0:
             time.sleep(0.0001)

        if packet[8:14] == "Sndr_1":
            conn1.send(packet)
            #print("Packet sent to sender 1")
        elif packet[8:14] == "Rcvr_1":
            conn2.send(packet)
            #print("Packet sent to receiver 1")
        elif packet[8:14] == "Sndr_2":
            conn3.send(packet)
            #print("Packet sent to sender 2")
        elif packet[8:14] == "Rcvr_2":
            conn4.send(packet)
            #print("Packet sent to receiver 2")
        elif packet[8:14] == "Sndr_3":
            conn5.send(packet)
            #print("Packet sent to sender 3")
        elif packet[8:14] == "Rcvr_3":
            conn6.send(packet)
            #print("Packet sent to receiver 3")