from flask import Blueprint
from werkzeug.exceptions import HTTPException
from app.models.response import Response
from .index import bp as index_bp
from .v1 import bp as v1_bp

bp = Blueprint("api", __name__)
bp.register_blueprint(index_bp)
bp.register_blueprint(v1_bp, url_prefix="/v1")


@bp.app_errorhandler(HTTPException)
def errorhandler(exception):
    return (
        Response.data(
            {
                "name": exception.name,
                "description": exception.description,
            },
            status=exception.code,
        ),
        exception.code,
    )
