import pandas as pd
import os

def crea_relazione_business_categorie(file_json_business, file_csv_anagrafica):
    cartella_corrente = os.path.dirname(os.path.abspath(__file__))
    percorso_business = os.path.join(cartella_corrente, file_json_business)
    percorso_anagrafica = os.path.join(cartella_corrente, file_csv_anagrafica)
    percorso_output = os.path.join(cartella_corrente, "relazioni_business_categorie.csv")

    try:
        # 1. Carichiamo l'anagrafica categorie per creare un dizionario di mappatura
        print("Caricamento anagrafica categorie...")
        df_anagrafica = pd.read_csv(percorso_anagrafica)
        # Creiamo un dizionario { 'Nome Categoria': 'ID_Casuale' }
        mappa_categorie = dict(zip(df_anagrafica['nome_categoria'], df_anagrafica['category_id']))

        # 2. Processiamo business.json a pezzi
        reader = pd.read_json(percorso_business, lines=True, chunksize=10000)
        primo_chunk = True

        print("Generazione tabella di collegamento business <-> categorie...")

        for chunk in reader:
            # Filtro consueto: ignora business senza indirizzo
            chunk = chunk.dropna(subset=['address'])
            chunk = chunk[chunk['address'].astype(str).str.strip() != '']
            
            # Selezioniamo solo business_id e le categorie (stringa separata da virgole)
            df = chunk[['business_id', 'categories']].dropna(subset=['categories'])

            # Trasformiamo la stringa in lista
            df['categories'] = df['categories'].str.split(', ')

            # Esplodiamo la lista: ogni categoria diventa una riga
            df_esploso = df.explode('categories')

            # Pulizia spazi bianchi residui
            df_esploso['categories'] = df_esploso['categories'].str.strip()

            # 3. Mappatura: Sostituiamo il nome della categoria con il suo ID
            df_esploso['category_id'] = df_esploso['categories'].map(mappa_categorie)

            # Rimuoviamo eventuali righe che non hanno trovato corrispondenza nell'anagrafica
            df_final = df_esploso.dropna(subset=['category_id'])

            # Selezioniamo le colonne finali richieste
            risultato = df_final[['business_id', 'category_id']]

            # 4. Salvataggio incrementale
            mode = 'w' if primo_chunk else 'a'
            header = primo_chunk
            risultato.to_csv(percorso_output, index=False, mode=mode, header=header, encoding='utf-8')
            
            primo_chunk = False

        print(f"\nOperazione completata con successo!")
        print(f"File generato: {percorso_output}")

    except Exception as e:
        print(f"Errore: {e}")

if __name__ == "__main__":
    # Assicurati che i nomi dei file siano corretti
    crea_relazione_business_categorie('business.json', 'anagrafica_categorie.csv')