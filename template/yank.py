import sys

fname = str(sys.argv[1])     	# take argument from terminal

f = open(fname,'r')		# open file specified in sys.arg[1]
g = open('output.tmp','w')	# open file for writing
c = 0				# on-off switch
while 1==1:			
   line = f.readline()		# read 'f' line by line
   if str(sys.argv[3]) in line:	# break at line containing sys.arg[3]
      break
   if c == 1:			# write to output file once writing is 'on'
      g.write(line)
   if str(sys.argv[2]) in line:	# switch on writing at line containing sys.arg[2]
         c = 1			
g.close()



