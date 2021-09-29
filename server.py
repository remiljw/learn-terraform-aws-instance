import web, boto3, sys

region = 'us-east-1'
ec2 = boto3.client('ec2', region_name=region)


urls = (
    '/', 'hello',
    '/tags', 'tags',
    '/shutdown', 'shutdown'
)
app = web.application(urls, globals())

class hello:
    def GET(self):
        return "<h4>Not Much Going On Here</h4> \
        <a href='/tags'><button>See Tags</button></a><span>\
            <a href='/shutdown'><button>Shutdown Instance</button></a>"

class tags:
    def GET(self):
        name  = sys.argv[3]
        owner = sys.argv[4]
        return f"<p><b>Name</b> = {name}<br> <b>Owner</b> {owner}</p>\
        <a href='/'><button>Go back</button></a>"

class shutdown:
    def GET(self):
        id  = sys.argv[5]
        ec2.stop_instances(InstanceIds=[id])
        return f"<p> You have terminated EC2 instance {id}</p>"

if __name__ == "__main__":
    app.run()