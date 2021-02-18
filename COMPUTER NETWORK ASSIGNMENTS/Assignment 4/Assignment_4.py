import multiprocessing

from Sender1 import sender1
from Sender2 import sender2
from Sender3 import sender3
from Sender4 import sender4
from Receiver1 import receiver1
from Receiver2 import receiver2
from Receiver3 import receiver3
from Receiver4 import receiver4

from Channel import channel




if __name__ == "__main__":
    # creating processes
    print("Implementation of CDMA:")
    sender1_conn, channel_conn1 = multiprocessing.Pipe()
    sender2_conn, channel_conn3 = multiprocessing.Pipe()
    sender3_conn, channel_conn5 = multiprocessing.Pipe()
    sender4_conn, channel_conn7 = multiprocessing.Pipe()
    receiver1_conn, channel_conn2 = multiprocessing.Pipe()
    receiver2_conn, channel_conn4 = multiprocessing.Pipe()
    receiver3_conn, channel_conn6 = multiprocessing.Pipe()
    receiver4_conn, channel_conn8 = multiprocessing.Pipe()
    p1 = multiprocessing.Process(target=sender1, args=(sender1_conn,), name= "Sndr_1")
    p2 = multiprocessing.Process(target=sender2, args=(sender2_conn,), name= "Sndr_2")
    p3 = multiprocessing.Process(target=sender3, args=(sender3_conn,), name= "Sndr_3")
    p4 = multiprocessing.Process(target=sender4, args=(sender4_conn,), name= "Sndr_4")
    p5 = multiprocessing.Process(target=receiver1, args=(receiver1_conn,), name= "Rcvr_1")
    p6 = multiprocessing.Process(target=receiver2, args=(receiver2_conn,), name= "Rcvr_2")
    p7 = multiprocessing.Process(target=receiver3, args=(receiver3_conn,), name= "Rcvr_3")
    p8 = multiprocessing.Process(target=receiver4, args=(receiver4_conn,), name= "Rcvr_4")
    p9 = multiprocessing.Process(target=channel, args=(channel_conn1, channel_conn2, channel_conn3, channel_conn4, channel_conn5, channel_conn6, channel_conn7, channel_conn8), name= "Chanel")


    # starting process 9
    p9.start()
    # print("Process 9 started!")

    # starting process 5
    p5.start()
    #print("Process 5 started!")

    # starting process 6
    p6.start()
    #print("Process 6 started!")

    # starting process 7
    p7.start()
    #print("Process 7 started!")

    # starting process 8
    p8.start()
    # print("Process 8 started!")

    # starting process 1
    p1.start()
    # print("Process 1 started!")

    # starting process 2
    p2.start()
    # print("Process 2 started!")

    # starting process 3
    p3.start()
    # print("Process 3 started!")

    # starting process 4
    p4.start()
    # print("Process 4 started!")

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

    # wait until process 7 is finished
    p7.join()
    # print("Process 7 terminated!")

    # wait until process 8 is finished
    p8.join()
    # print("Process 8 terminated!")

    # kill process 9
    p9.kill()
    p9.join()
    # print("Process 9 terminated!")

    # all processes finished
    print("Done!")