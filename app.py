"""Flask web app for QuakeWatch."""

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    """Return a greeting message."""
    return "Hello, World!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
