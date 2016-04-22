__author__ = 'lh'

import socket
import threading
import time

def tcpAction(sock, addr):
    print('accept new connection from ', addr)
    sock.send(b'welcome')
    while True:
        data = sock.recv(1024)
        time.sleep(1)
        if not data or data.decode('utf-8') == 'exit':
            break
        else:
            print data;
            data = 'echo: ' + data;
            print data
            sock.send((b'%s!\x0D\x0A' % data.decode('utf-8')).encode('utf-8'))


host = "localhost"
port = 53883
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((host, port))
s.listen(10)


while 1:
    sock, addr = s.accept()
    t = threading.Thread(target = tcpAction, args = (sock, addr))
    t.start()


