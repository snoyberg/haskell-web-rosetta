#!/usr/bin/env python                                                                                                                                                                                                                       
# A github post-receive hook handler, runs some shell command on each HTTP POST to PORT.                                                                                                                                                    
# pyramid.py PORT 'SOME SHELL COMMAND'                                                                                                                                                                                              

import sys
from subprocess import *
from paste.httpserver import serve
from pyramid.config import Configurator
from pyramid.response import Response

def system(cmd):
    print ''.join(Popen(cmd, shell=True, stdout=PIPE, stderr=PIPE, close_fds=True).communicate())

def post(request):
    cmd = sys.argv[2]
    print "Received POST, running: "+cmd
    system(cmd)
    return Response('ok')

if __name__ == '__main__':
    config = Configurator()
    config.add_view(post)
    app = config.make_wsgi_app()
    serve(app, host='0.0.0.0',port=int(sys.argv[1]))
