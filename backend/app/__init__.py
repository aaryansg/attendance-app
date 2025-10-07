from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

import os


db = SQLAlchemy()
cors = CORS()

def create_app():
    app = Flask(__name__)
    
    app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'your-secret-key-change-in-production')
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///attendance.db'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    
    
    db.init_app(app)
    cors.init_app(app)
    
    with app.app_context():
        from . import models
        from . import routes
        app.register_blueprint(routes.bp)
        db.create_all()
        print("tables created")  
        print("Tables in database:", db.metadata.tables.keys())
  
    return app
