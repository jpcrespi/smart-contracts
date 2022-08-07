from flask import Flask
from flasgger import Swagger


class Docs(object):

    swaggerTemplate = {
        "swagger": "2.0",
        "info": {
            "title": "Nativas API",
            "description": "API for Nativas project",
            "contact": {
                "responsibleOrganization": "ME",
                "responsibleDeveloper": "Me",
                "email": "jpcrespi@icloud.com",
                "url": "https://nativas.ar",
            },
            "termsOfService": "https:/nativas.ar/terms",
            "version": "1.0.0",
        },
        # "host": "mysite.com",  # overrides localhost:500
        "basePath": "/",  # base bash for blueprint registration
        "schemes": ["http", "https"],
        # "operationId": "getmyData",
    }

    swaggerConfig = {
        "title": "Nativas API",
        "uiversion": 3,
    }

    def __init__(self, app: Flask):
        app.config["SWAGGER"] = self.swaggerConfig
        Swagger(app, template=self.swaggerTemplate)
