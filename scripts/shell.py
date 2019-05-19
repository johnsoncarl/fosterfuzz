import subprocess
import shlex


command = 'truffle develop'
file = open("log.txt", 'w')
process = subprocess.Popen(shlex.split(command), stdout=subprocess.PIPE)
while True:
	output = process.stdout.readline()
	if output == '' and process.poll() is not None:
		break
	if output:
		print (">> " + str(output.strip().decode('utf-8')))
		file.write(">> " + str(output.strip().decode('utf-8'))  + "\n")

#file.close()
rc = process.poll()
print(rc)

