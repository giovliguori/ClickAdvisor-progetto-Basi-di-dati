import pandas as pd
import os

def converti_yelp_friends_final(nome_file_json):
    cartella_corrente = os.path.dirname(os.path.abspath(__file__))
    percorso_input = os.path.join(cartella_corrente, nome_file_json)
    percorso_output = os.path.join(cartella_corrente, "relazioni_user_friends.csv")

    try:
        # Carichiamo il file user.json (formato JSON Lines)
        reader = pd.read_json(percorso_input, lines=True, chunksize=10000)
        
        primo_chunk = True
        print("Filtraggio record 'None' in corso...")

        for chunk in reader:
            # 1. Selezioniamo user_id e la lista amici
            df = chunk[['user_id', 'friends']].copy()

            # 2. Trasformiamo la stringa in lista
            df['friends'] = df['friends'].str.split(', ')

            # 3. Esplodiamo la lista in righe singole
            df_esploso = df.explode('friends')

            # 4. PULIZIA AVANZATA:
            # Rimuoviamo i veri NULL (NaN)
            df_esploso = df_esploso.dropna(subset=['friends'])
            
            # Rimuoviamo la stringa "None" (comune in alcuni export di Yelp)
            # Rimuoviamo anche eventuali stringhe vuote
            valori_da_escludere = ['None', 'none', '', 'nan']
            df_esploso = df_esploso[~df_esploso['friends'].astype(str).isin(valori_da_escludere)]

            # 5. Salvataggio incrementale
            mode = 'w' if primo_chunk else 'a'
            header = primo_chunk
            df_esploso.to_csv(percorso_output, index=False, mode=mode, header=header, encoding='utf-8')
            
            primo_chunk = False

        print(f"\nFATTO! File pulito salvato in: {percorso_output}")

    except Exception as e:
        print(f"Errore: {e}")

if __name__ == "__main__":
    converti_yelp_friends_final('user.json')