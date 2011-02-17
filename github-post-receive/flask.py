#!/usr/bin/env python
# A github post-receive hook handler, runs some shell command on each HTTP POST to PORT.
# flask.py PORT 'SOME SHELL COMMAND'

import sys
from subprocess import *
from flask import Flask

def system(cmd):
    print ''.join(Popen(cmd, shell=True, stdout=PIPE, stderr=PIPE, close_fds=True).communicate())

app = Flask(__name__)

@app.route("/", methods=['POST'])
def post():
    cmd = sys.argv[2]
    print "Received POST, running: "+cmd
    system(cmd)
    return 'ok'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(sys.argv[1]), debug=True)
