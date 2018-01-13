from datetime import datetime
import subprocess
import ConfigParser
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    pi_dt = str(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    conf = ConfigParser.RawConfigParser()
    conf.read('config.cfg')
    print "Date..",pi_dt
    resultString =" "
    with open(conf.get('LogsLocations', 'flasklogfiles')+pi_dt+".txt", "w+") as output:
        subprocess.call(["python2", "/home/pi/Documents/MRI/code/RunningTasks.py"], stdout=output);

    with open (conf.get('LogsLocations', 'flasklogfiles')+pi_dt+'.txt') as f:
                lines = f.read().splitlines() 
    for line in lines:
        resultString += line+"<br/>"    
    print resultString
    return resultString
	 

if __name__ == '__main__':
        app.run(host='0.0.0.0')
