from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Database bağlantısı
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

class YasanilanCevredeGuvendeHissetme(db.Model):
    __tablename__ = 'yasanilan_cevrede_guvende_hissetme'
    yil = db.Column(db.Integer, primary_key=True)
    cok_guvenli = db.Column(db.Float)
    guvenli = db.Column(db.Float)
    orta = db.Column(db.Float)
    guvensiz = db.Column(db.Float)
    cok_guvensiz = db.Column(db.Float)

class KazanctanMemnuniyet(db.Model):
    __tablename__ = 'isten_elde_edilen_kazanctan_duyulan_memnuniyet'
    yil = db.Column(db.Integer, primary_key=True)
    cok_memnun = db.Column(db.Float)
    memnun = db.Column(db.Float)
    orta = db.Column(db.Float)
    memnun_degil = db.Column(db.Float)
    hic_memnun_degil = db.Column(db.Float)
    kazanci_yok = db.Column(db.Float)

class RefahSeviyesi(db.Model):
    __tablename__ = 'refah_seviyesi'
    yil = db.Column(db.Integer, primary_key=True)
    en_dusuk = db.Column(db.Float)
    dusuk = db.Column(db.Float)
    orta = db.Column(db.Float)
    yuksek = db.Column(db.Float)
    en_yuksek = db.Column(db.Float)

class GuvenVeMutluluk(db.Model):
    __tablename__ = 'guven_ve_mutluluk'
    yil = db.Column(db.Integer, primary_key=True)
    cok_guvenli_cok_mutlu = db.Column(db.Float)
    guvensiz_mutsuz = db.Column(db.Float)

class KazancVeMutluluk(db.Model):
    __tablename__ = 'kazanc_ve_mutluluk'
    yil = db.Column(db.Integer, primary_key=True)
    cok_memnun_cok_mutlu = db.Column(db.Float)
    memnun_degil_mutsuz = db.Column(db.Float)

class RefahVeMutluluk(db.Model):
    __tablename__ = 'refah_ve_mutluluk'
    yil = db.Column(db.Integer, primary_key=True)
    en_dusuk_mutsuz = db.Column(db.Float)
    yuksek_cok_mutlu = db.Column(db.Float)

def serialize_data(query_results, columns):
    return [
        {column: getattr(row, column) for column in columns}
        for row in query_results
    ]

@app.route('/api/mutluluk_verisi', methods=['GET'])
def get_mutluluk_verisi():
    veriler = MutlulukVerisi.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'cok_mutlu', 'mutlu', 'orta', 'mutsuz', 'cok_mutsuz']))

@app.route('/api/yasanilan_cevrede_guvende_hissetme', methods=['GET'])
def get_yasanilan_cevrede_guvende_hissetme():
    veriler = YasanilanCevredeGuvendeHissetme.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'cok_guvenli', 'guvenli', 'orta', 'guvensiz', 'cok_guvensiz']))

@app.route('/api/kazanctan_memnuniyet', methods=['GET'])
def get_kazanctan_memnuniyet():
    veriler = KazanctanMemnuniyet.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'cok_memnun', 'memnun', 'orta', 'memnun_degil', 'hic_memnun_degil', 'kazanci_yok']))

@app.route('/api/refah_seviyesi', methods=['GET'])
def get_refah_seviyesi():
    veriler = RefahSeviyesi.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'en_dusuk', 'dusuk', 'orta', 'yuksek', 'en_yuksek']))

@app.route('/api/guven_ve_mutluluk', methods=['GET'])
def get_guven_ve_mutluluk():
    veriler = GuvenVeMutluluk.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'cok_guvenli_cok_mutlu', 'guvensiz_mutsuz']))

@app.route('/api/kazanc_ve_mutluluk', methods=['GET'])
def get_kazanc_ve_mutluluk():
    veriler = KazancVeMutluluk.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'cok_memnun_cok_mutlu', 'memnun_degil_mutsuz']))

@app.route('/api/refah_ve_mutluluk', methods=['GET'])
def get_refah_ve_mutluluk():
    veriler = RefahVeMutluluk.query.all()
    return jsonify(serialize_data(veriler, ['yil', 'en_dusuk_mutsuz', 'yuksek_cok_mutlu']))


@app.route('/api/veri', methods=['GET'])
def get_data():
    table = request.args.get('table') 
    if table == 'mutluluk_verisi':
        return get_mutluluk_verisi()
    elif table == 'yasanilan_cevrede_guvende_hissetme':
        return get_yasanilan_cevrede_guvende_hissetme()
    elif table == 'isten_elde_edilen_kazanctan_memnuniyet':
        return get_kazanctan_memnuniyet()
    elif table == 'refah_seviyesi':
        return get_refah_seviyesi()
    elif table == 'guven_ve_mutluluk':
        return get_guven_ve_mutluluk()
    elif table == 'kazanc_ve_mutluluk':
        return get_kazanc_ve_mutluluk()
    elif table == 'refah_ve_mutluluk':
        return get_refah_ve_mutluluk()
    else:
        return jsonify({'error': 'Invalid table name'}), 400

if __name__ == '__main__':
    app.run(debug=True)
