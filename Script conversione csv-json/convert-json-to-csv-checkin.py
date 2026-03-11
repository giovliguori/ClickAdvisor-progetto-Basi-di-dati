import pandas as pd
import os

def converti_yelp_checkins(nome_file_json):
    cartella_corrente = os.path.dirname(os.path.abspath(__file__))
    percorso_input = os.path.join(cartella_corrente, nome_file_json)
    percorso_output = os.path.join(cartella_corrente, "tabella_checkins.csv")

    try:
        # Carichiamo il file checkin.json (una riga per oggetto JSON) 
        # Usiamo chunksize per gestire la mole di dati in modo efficiente
        reader = pd.read_json(percorso_input, lines=True, chunksize=10000)
        
        primo_chunk = True
        print("Elaborazione check-in in corso...")

        for chunk in reader:
            # 1. Selezioniamo le colonne business_id e date
            df = chunk[['business_id', 'date']].copy()

            # 2. TRASFORMAZIONE: Il campo 'date' è una stringa separata da virgole 
            # La trasformiamo in una lista per poter usare explode
            df['date'] = df['date'].str.split(', ')

            # 3. Esplodiamo la lista: ogni timestamp diventa una riga separata
            df_esploso = df.explode('date')

            # 4. Pulizia: rimuoviamo eventuali valori nulli o stringhe "None"
            df_esploso = df_esploso.dropna(subset=['date'])
            df_esploso = df_esploso[~df_esploso['date'].astype(str).isin(['None', 'none', ''])]

            # 5. Salvataggio incrementale
            mode = 'w' if primo_chunk else 'a'
            header = primo_chunk
            df_esploso.to_csv(percorso_output, index=False, mode=mode, header=header, encoding='utf-8')
            
            primo_chunk = False

        print(f"\nOperazione completata! File salvato: {percorso_output}")

    except Exception as e:
        print(f"Errore durante l'elaborazione: {e}")

if __name__ == "__main__":
    converti_yelp_checkins('checkin.json')