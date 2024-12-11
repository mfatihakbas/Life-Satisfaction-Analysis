from sqlalchemy import create_engine
import pandas as pd

engine = create_engine('postgresql://postgres:1234@localhost:5432/mutluluk_duzeyi')

df = pd.read_csv(r'C:\\Users\Baris\\Documents\\GitHub\\Life-Satisfaction-Analysis\\database\\isten_elde_edilen_kazanctan_duyulan_memnuniyet.csv')

df.to_sql('isten_elde_edilen_kazanctan_duyulan_memnuniyet', engine, if_exists='append', index=False)

print("Veri başarıyla PostgreSQL'e eklendi.")