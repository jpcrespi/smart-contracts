class Response(object):
    @classmethod
    def data(cls, data, status=200):
        return {
            "status": status,
            "data": data,
        }
