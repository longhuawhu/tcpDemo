__author__ = 'lh'

import socket

host = "localhost"
port = 8888
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((host, port))
s.listen(10);
while 1:
    sock, addr = s.accept()
    print "get connection form", sock.getpeername
    data = sock.recv(1024)
    if not data:
        break
    else:
        print  data
        data = "send from server" + data
        sock.send(data)

