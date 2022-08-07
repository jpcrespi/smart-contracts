from flask_restful import Resource
from app.models.response import Response
from flasgger import swag_from


class Index(Resource):
    @swag_from("../../docs/index.yml")
    def get(self):
        data = {
            "name": "Nativas API",
            "version": 1.0,
        }
        return Response.data(data), 200
