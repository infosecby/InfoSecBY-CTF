from flask import Flask, request, render_template_string, render_template
import urllib
from urllib.parse import urlparse

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.errorhandler(404)
def page_not_found(e):
    url = urllib.parse.unquote(request.url)
    path = urlparse(url).path
    blacklist = ['_', '.', '[', ']', 'self', 'shell']
    for x in blacklist:
        if x in path:
            return "Looks like a hacking attempt!"
    template = '''
 <div class="center-content error">
 <h1>Oops! That page doesn't exist.</h1>
 <h3>%s</h3>
 </div>
 ''' % (url)
    
    return render_template_string(template), 404

if __name__ == "__main__":
    app.run(debug=False)
