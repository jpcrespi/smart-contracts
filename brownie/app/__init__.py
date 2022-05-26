from flask import Flask
from brownie import network
from app.docs import Docs
from app.contracts import contracts


def create_app():
    app = Flask(__name__)
    Docs(app)

    network.connect("ganache")
    contracts.load()

    from app.routes import bp as api_bp

    app.register_blueprint(api_bp)

    return app
