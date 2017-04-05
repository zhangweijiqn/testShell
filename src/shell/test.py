import sys
import time

index = sys.argv[1]
print "Start [%s]: %s" % (index, time.ctime())
time.sleep(20)
print "End [%s]: %s" % (index, time.ctime())
