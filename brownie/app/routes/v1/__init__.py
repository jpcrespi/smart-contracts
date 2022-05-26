from flask import Blueprint
from .token import bp as token_bp
from .offset import bp as offset_bp

bp = Blueprint("v1", __name__)
bp.register_blueprint(token_bp, url_prefix="/token")
bp.register_blueprint(offset_bp, url_prefix="/offset")
