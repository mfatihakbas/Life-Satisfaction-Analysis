from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app) #local host çalışma

# Database conn
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:1234@localhost:5432/mutluluk_duzeyi'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)


class MutlulukVerisi(db.Model):
    __tablename__ = 'mutluluk_verisi'
    yil = db.Column(db.Integer, primary_key=True)
    cok_mutlu = db.Column(db.Float)
    mutlu = db.Column(db.Float)
    orta = db.Column(db.Float)
    mutsuz = db.Column(db.Float)
    cok_mutsuz = db.Column(db.Float)

# Api conn
@app.route('/api/mutluluk_verisi', methods=['GET'])
def get_mutluluk_verisi():
    veriler = MutlulukVerisi.query.all()
    sonuc = [
        {
            'yil': veri.yil,
            'cok_mutlu': veri.cok_mutlu,
            'mutlu': veri.mutlu,
            'orta': veri.orta,
            'mutsuz': veri.mutsuz,
            'cok_mutsuz': veri.cok_mutsuz
        }
        for veri in veriler
    ]
    return jsonify(sonuc)

if __name__ == '__main__': #Flask run
    app.run(debug=True)
