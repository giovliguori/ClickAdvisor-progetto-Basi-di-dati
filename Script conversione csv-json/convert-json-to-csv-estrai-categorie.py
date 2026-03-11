import pandas as pd
import os
import secrets
import string

def genera_id_casuale(lunghezza=22):
    # Genera una stringa alfanumerica casuale (stile Yelp ID)
    alfabeto = string.ascii_letters + string.digits + "-_"
    return ''.join(secrets.choice(alfabeto) for _ in range(lunghezza))

def estrai_categorie_univoche_con_id(nome_file_json):
    cartella_corrente = os.path.dirname(os.path.abspath(__file__))
    percorso_input = os.path.join(cartella_corrente, nome_file_json)
    percorso_output = os.path.join(cartella_corrente, "anagrafica_categorie.csv")

    categorie_totali = set()

    try:
        # 1. Scansione del file per raccogliere i nomi delle categorie
        reader = pd.read_json(percorso_input, lines=True, chunksize=10000)
        print("Scansione business.json e filtraggio per indirizzo...")

        for chunk in reader:
            # Filtro address vuoto
            chunk = chunk.dropna(subset=['address'])
            chunk = chunk[chunk['address'].astype(str).str.strip() != '']
            
            # Estrazione categorie
            chunk_cats = chunk['categories'].dropna()
            for riga_cat in chunk_cats:
                lista_cat = [c.strip() for c in riga_cat.split(',')]
                categorie_totali.update(lista_cat)

        # 2. Creazione della tabella finale
        lista_nomi = sorted(list(categorie_totali))
        
        # Creiamo una lista di ID casuali, uno per ogni categoria univoca
        lista_ids = [genera_id_casuale() for _ in range(len(lista_nomi))]

        # Creazione del DataFrame con le colonne nell'ordine richiesto
        df_final = pd.DataFrame({
            'category_id': lista_ids,
            'nome_categoria': lista_nomi
        })

        # 3. Salvataggio in CSV
        df_final.to_csv(percorso_output, index=False, encoding='utf-8')
        
        print(f"\nSuccesso! Generate {len(df_final)} categorie con ID univoci.")
        print(f"File salvato: {percorso_output}")

    except Exception as e:
        print(f"Errore: {e}")

if __name__ == "__main__":
    estrai_categorie_univoche_con_id('business.json')