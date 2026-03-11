import pandas as pd
import os

def converti_yelp_business_hours_filtered(nome_file_json):
    cartella_corrente = os.path.dirname(os.path.abspath(__file__))
    percorso_input = os.path.join(cartella_corrente, nome_file_json)
    percorso_output = os.path.join(cartella_corrente, "tabella_business_hours.csv")

    try:
        # Caricamento JSON Lines (one JSON-object per-line)
        reader = pd.read_json(percorso_input, lines=True, chunksize=5000)
        
        primo_chunk = True
        print("Elaborazione e filtraggio business in corso...")

        for chunk in reader:
            # 1. FILTRAGGIO INDIRIZZO: Rimuove record con address nullo o vuoto
            # La documentazione specifica 'address' come stringa
            chunk = chunk.dropna(subset=['address'])
            chunk = chunk[chunk['address'].astype(str).str.strip() != '']

            # 2. Selezioniamo business_id e hours, rimuovendo chi non ha orari
            df = chunk[['business_id', 'hours']].dropna(subset=['hours'])

            if df.empty:
                continue

            # 3. Trasformiamo l'oggetto 'hours' in colonne piatte
            hours_flat = pd.json_normalize(df['hours'])
            hours_flat.index = df.index
            
            df_combined = pd.concat([df['business_id'], hours_flat], axis=1)

            # 4. Trasformiamo da colonne a righe (Melt)
            df_melted = df_combined.melt(
                id_vars=['business_id'], 
                var_name='giorno', 
                value_name='orario'
            )

            # Rimuoviamo i giorni senza orario definito
            df_melted = df_melted.dropna(subset=['orario'])

            # 5. Suddivisione ora_apertura e ora_chiusura (formato HH:MM-HH:MM)
            df_melted[['ora_apertura', 'ora_chiusura']] = df_melted['orario'].str.split('-', expand=True)

            # Pulizia nomi colonne
            df_melted['giorno'] = df_melted['giorno'].str.replace('hours.', '', regex=False)

            # Selezione finale colonne
            risultato = df_melted[['business_id', 'giorno', 'ora_apertura', 'ora_chiusura']]

            # 6. Salvataggio incrementale
            mode = 'w' if primo_chunk else 'a'
            header = primo_chunk
            risultato.to_csv(percorso_output, index=False, mode=mode, header=header, encoding='utf-8')
            
            primo_chunk = False

        print(f"\nConversione completata! File salvato: {percorso_output}")

    except Exception as e:
        print(f"Errore durante l'elaborazione: {e}")

if __name__ == "__main__":
    converti_yelp_business_hours_filtered('business.json')