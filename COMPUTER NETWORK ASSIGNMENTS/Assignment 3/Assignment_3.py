import multiprocessing

#from Sender1_1P import sender1
#from Sender2_1P import sender2
#from Sender3_1P import sender3
#from Receiver1_1P import receiver1
#from Receiver2_1P import receiver2
#from Receiver3_1P import receiver3

from Sender1_nonP import sender1
from Sender2_nonP import sender2
from Sender3_nonP import sender3
from Receiver1_nonP import receiver1
from Receiver2_nonP import receiver2
from Receiver3_nonP import receiver3

#from Sender1_pP import sender1
#from Sender2_pP import sender2
#from Sender3_pP import sender3
#from Receiver1_pP import receiver1
#from Receiver2_pP import receiver2
#from Receiver3_pP import receiver3

from Channel import *




if __name__ == "__main__":
    # creating processes
    #print("Implementation of 1-persistent CSMA:")
    #print("Implementation of non-persistent CSMA:")
    print("Implementation of p-persistent CSMA:")
    packets_to_channel = multiprocessing.Queue()
    sender1_conn, channel_conn1 = multiprocessing.Pipe()
    sender2_conn, channel_conn3 = multiprocessing.Pipe()
    sender3_conn, channel_conn5 = multiprocessing.Pipe()
    receiver1_conn, channel_conn2 = multiprocessing.Pipe()
    receiver2_conn, channel_conn4 = multiprocessing.Pipe()
    receiver3_conn, channel_conn6 = multiprocessing.Pipe()
    p1 = multiprocessing.Process(target=sender1, args=(sender1_conn,packets_to_channel), name= "Sndr_1")
    p2 = multiprocessing.Process(target=sender2, args=(sender2_conn,packets_to_channel), name= "Sndr_2")
    p3 = multiprocessing.Process(target=sender3, args=(sender3_conn,packets_to_channel), name= "Sndr_3")
    p4 = multiprocessing.Process(target=receiver1, args=(receiver1_conn,packets_to_channel), name= "Rcvr_1")
    p5 = multiprocessing.Process(target=receiver2, args=(receiver2_conn,packets_to_channel), name= "Rcvr_2")
    p6 = multiprocessing.Process(target=receiver3, args=(receiver3_conn,packets_to_channel), name= "Rcvr_3")
    p7 = multiprocessing.Process(target=channel, args=(channel_conn1, channel_conn2, channel_conn3, channel_conn4, channel_conn5, channel_conn6, packets_to_channel), name= "Chanel")

    # starting process 4
    p4.start()
    #print("Process 4 started!")

    # starting process 5
    p5.start()
    #print("Process 5 started!")

    # starting process 6
    p6.start()
    #print("Process 6 started!")

    # starting process 7
    p7.start()
    #print("Process 7 started!")

    # starting process 1
    p1.start()
    #print("Process 1 started!")

    # starting process 2
    p2.start()
    #print("Process 2 started!")

    # starting process 3
    p3.start()
    #print("Process 3 started!")


    # wait until process 1 is finished
    p1.join()
    #print("Process 1 terminated!")

    # wait until process 2 is finished
    p2.join()
    #print("Process 2 terminated!")

    # wait until process 3 is finished
    p3.join()
    #print("Process 3 terminated!")

    # wait until process 4 is finished
    p4.join()
    #print("Process 4 terminated!")

    # wait until process 5 is finished
    p5.join()
    #print("Process 5 terminated!")

    # wait until process 6 is finished
    p6.join()
    #print("Process 6 terminated!")

    # kill process 7
    p7.kill()
    p7.join()
    # print("Process 7 terminated!")

    # all processes finished
    print("Done!")