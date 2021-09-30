import web, boto3, sys

region = 'us-east-1'
ec2 = boto3.client('ec2', region_name=region)

arguments = len(sys.argv) - 1
position = 1
render = web.template.render("templates/")

urls = (
    '/', 'hello',
    '/tags', 'tags',
    '/shutdown', 'shutdown'
)
app = web.application(urls, globals())

class hello:
    def GET(self):
        return render.index()

class tags:
    def GET(self):
        name  = sys.argv[3]
        owner = sys.argv[4]
        return render.tags(name, owner)

class shutdown:
    def GET(self):
        id  = sys.argv[5]
        ec2.stop_instances(InstanceIds=[id])
        return render.shutdown(id)

if __name__ == "__main__":
    app.run()