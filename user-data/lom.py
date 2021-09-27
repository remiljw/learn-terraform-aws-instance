from flask import Flask, render_template
from boto3 import ec
import sys

# Count the arguments
# arguments = len(sys.argv) - 1
app = Flask(__name__)

position = 1
@app.route("/", methods=['GET'])
def hello():
    return render_template('index.html')

@app.route("/tags", methods=['GET'])
def tags():
    return render_template('tags.html')

@app.route("/shutdown", methods=['GET'])
def shutdown():
    # conn = ec2.connect_to_region("us-east-1")
    # conn.stop_instances(instance_ids=[sys.argv[position]])
    return render_template('dead.html')



if __name__ == '__main__':
   app.run(debug = True)