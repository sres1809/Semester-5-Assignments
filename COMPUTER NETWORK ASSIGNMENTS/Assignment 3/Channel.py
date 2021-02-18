import random
import time


def channel(conn1, conn2, conn3, conn4, conn5, conn6, packets_to_channel):
    collision = False
    packet = packets_to_channel.get()
    while 1:
        if len(packet) != 24:
            i = random.randrange(0,60)
            if i>21 and i<54:
                packet = packet[:i]+"0"+packet[i:]

        time.sleep(0.000004)
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

        packet = packets_to_channel.get()
        if collision == True:
            if len(packet) != 24 or packet[8:12] == "Sndr":
                if packets_to_channel.empty() == False:
                    collision = True
                    print("Collision detected!")
                else:
                    collision = False
                packet = packets_to_channel.get()
        if packets_to_channel.empty() == False:
            collision = True
            print("Collision detected!")
        else:
            collision = False
