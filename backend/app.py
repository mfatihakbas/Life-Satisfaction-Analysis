from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # local host için çalışma izni

# Database bağlantısı
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:1234@localhost:5432/mutluluk_duzeyi'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Mutluluk verisi tablosu modeli
class MutlulukVerisi(db.Model):
    __tablename__ = 'mutluluk_verisi'
    yil = db.Column(db.Integer, primary_key=True)
    cok_mutlu = db.Column(db.Float)
    mutlu = db.Column(db.Float)
    orta = db.Column(db.Float)
    mutsuz = db.Column(db.Float)
    cok_mutsuz = db.Column(db.Float)

# Güvenlik verisi tablosu modeli
class YasanilanCevredeGuvendeHissetme(db.Model):
    __tablename__ = 'yasanilan_cevrede_guvende_hissetme'
    yil = db.Column(db.Integer, primary_key=True)
    cok_guvenli = db.Column(db.Float)
    guvenli = db.Column(db.Float)
    orta = db.Column(db.Float)
    guvensiz = db.Column(db.Float)
    cok_guvensiz = db.Column(db.Float)

# Mutluluk verisi API endpoint
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

# Güvenlik verisi API endpoint
@app.route('/api/yasanilan_cevrede_guvende_hissetme', methods=['GET'])
def get_yasanilan_cevrede_guvende_hissetme():
    veriler = YasanilanCevredeGuvendeHissetme.query.all()
    sonuc = [
        {
            'yil': veri.yil,
            'cok_guvenli': veri.cok_guvenli,
            'guvenli': veri.guvenli,
            'orta': veri.orta,
            'guvensiz': veri.guvensiz,
            'cok_guvensiz': veri.cok_guvensiz
        }
        for veri in veriler
    ]
    return jsonify(sonuc)

# Dinamik tablo seçimi için API endpoint
@app.route('/api/veri', methods=['GET'])
def get_data():
    table = request.args.get('table')  # 'table' parametresini al
    if table == 'mutluluk_verisi':
        return get_mutluluk_verisi()
    elif table == 'yasanilan_cevrede_guvende_hissetme':
        return get_yasanilan_cevrede_guvende_hissetme()
    else:
        return jsonify({'error': 'Invalid table name'}), 400

if __name__ == '__main__':
    app.run(debug=True)
