from flask import Flask, render_template,Response
from slugify import slugify
from prometheus_client import make_wsgi_app
from werkzeug.serving import run_simple
from werkzeug.middleware.dispatcher import DispatcherMiddleware
from flask_prometheus_metrics import register_metrics
from flask_healthz import healthz,HealthError
import os


def liveness():
  pass

def readiness():
  pass

app = Flask(__name__)
app.register_blueprint(healthz, url_prefix='/healthz')

app.config.update(
  HEALTHZ = {
    "live": lambda: liveness(),
    "ready": lambda: readiness(),
  }
)

app.wsgi_app = DispatcherMiddleware(app.wsgi_app, {
    '/metrics': make_wsgi_app()
})


app.jinja_env.globals.update(slugify=slugify)


@app.route('/',  defaults={'u_path': ''})
@app.route('/<path:u_path>')
def index(u_path):
  back_color = os.environ.get("BGCOLOR")
  return render_template('index.html', upath = u_path,bgcolor = back_color )

register_metrics(app, app_version="v0.1.2", app_config="staging")

if __name__ == "__main__":
  app.run(host='0.0.0.0',port=3010)
