from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Local host için CORS izni

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

# Kazançtan Memnuniyet tablosu modeli
class KazanctanMemnuniyet(db.Model):
    __tablename__ = 'isten_elde_edilen_kazanctan_duyulan_memnuniyet'
    yil = db.Column(db.Integer, primary_key=True)
    cok_memnun = db.Column(db.Float)
    memnun = db.Column(db.Float)
    orta = db.Column(db.Float)
    memnun_degil = db.Column(db.Float)
    hic_memnun_degil = db.Column(db.Float)
    kazanci_yok = db.Column(db.Float)

# Ortak fonksiyon: Tablo verilerini dönüştürmek için
def serialize_data(query_results, columns):
    return [
        {column: getattr(row, column) for column in columns}
        for row in query_results
    ]

# API endpoint: Mutluluk verisi
@app.route('/api/mutluluk_verisi', methods=['GET'])
def get_mutluluk_verisi():
    veriler = MutlulukVerisi.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'cok_mutlu', 'mutlu', 'orta', 'mutsuz', 'cok_mutsuz']))

# API endpoint: Güvenlik verisi
@app.route('/api/yasanilan_cevrede_guvende_hissetme', methods=['GET'])
def get_yasanilan_cevrede_guvende_hissetme():
    veriler = YasanilanCevredeGuvendeHissetme.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'cok_guvenli', 'guvenli', 'orta', 'guvensiz', 'cok_guvensiz']))

# API endpoint: Kazançtan Memnuniyet
@app.route('/api/kazanctan_memnuniyet', methods=['GET'])
def get_kazanctan_memnuniyet():
    veriler = KazanctanMemnuniyet.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'cok_memnun', 'memnun', 'orta', 'memnun_degil', 'hic_memnun_degil', 'kazanci_yok']))

# Dinamik tablo seçimi için API endpoint
@app.route('/api/veri', methods=['GET'])
def get_data():
    table = request.args.get('table')  # 'table' parametresini al
    if table == 'mutluluk_verisi':
        return get_mutluluk_verisi()
    elif table == 'yasanilan_cevrede_guvende_hissetme':
        return get_yasanilan_cevrede_guvende_hissetme()
    elif table == 'isten_elde_edilen_kazanctan_memnuniyet':
        return get_kazanctan_memnuniyet()
    else:
        return jsonify({'error': 'Invalid table name'}), 400

if __name__ == '__main__':
    app.run(debug=True)
