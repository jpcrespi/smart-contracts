from flask_restful import Resource
from app.models.response import Response


class Index(Resource):
    def get(self):
        data = {
            "address": "",
            "name": "",
            "symbol": "",
            "decimals": 0,
            "totalSupply": 0,
        }
        return Response.data(data)
