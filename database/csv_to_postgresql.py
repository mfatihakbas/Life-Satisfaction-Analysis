from sqlalchemy import create_engine
import pandas as pd

# PostgreSQL bağlantı dizesini buraya kendi bilgilerinize göre düzenleyin
engine = create_engine('postgresql://postgres:1234@localhost:5432/mutluluk_verisi')

# CSV dosyasını pandas ile ISO-8859-1 kodlamasıyla okuyun
df = pd.read_csv(r'C:\\Users\\Baris\\Documents\\GitHub\\Life-Satisfaction-Analysis\\database\\mutluluk_verisi.csv', encoding='ISO-8859-1')

# Veriyi PostgreSQL'e ekleyin
df.to_sql('mutluluk_verisi', engine, if_exists='append', index=False)

print("Veri başarıyla PostgreSQL'e eklendi.")