from flask_restful import Resource
from app.models.response import Response
from app.contracts import contracts


class Index(Resource):
    def get(self):
        data = {
            "address": contracts.token().address(),
            "name": contracts.token().name(),
            "symbol": contracts.token().symbol(),
            "decimals": contracts.token().decimals(),
            "totalSupply": contracts.token().totalSupply(),
        }
        return Response.data(data)
