from flask import Blueprint
from flask_restful import Api
from .index import Index

bp = Blueprint("index", __name__)
api = Api(bp)
api.add_resource(Index, "/")
