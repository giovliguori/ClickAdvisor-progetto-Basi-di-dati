import pandas as pd
import os

def estrai_attributi_univoci(nome_file_json):
    cartella_corrente = os.path.dirname(os.path.abspath(__file__))
    percorso_input = os.path.join(cartella_corrente, nome_file_json)
    percorso_output = os.path.join(cartella_corrente, "lista_attributi_univoci.csv")

    # Usiamo un set per raccogliere le chiavi: i set eliminano automaticamente i duplicati
    attributi_totali = set()

    try:
        # Caricamento a pezzi per gestire file grandi
        reader = pd.read_json(percorso_input, lines=True, chunksize=10000)
        
        print("Scansione del file per estrarre gli attributi...")

        for chunk in reader:
            # Filtriamo i record che hanno il campo attributes non nullo
            chunk_attr = chunk['attributes'].dropna()

            for riga_attr in chunk_attr:
                # riga_attr è un dizionario (es. {"RestaurantsTakeOut": true, ...})
                if isinstance(riga_attr, dict):
                    # Aggiungiamo tutte le chiavi del dizionario al nostro set
                    attributi_totali.update(riga_attr.keys())

        # Convertiamo il set in un DataFrame e ordiniamo alfabeticamente
        df_final = pd.DataFrame(sorted(list(attributi_totali)), columns=['nome_attributo'])

        # Salvataggio in CSV
        df_final.to_csv(percorso_output, index=False, encoding='utf-8')
        
        print(f"\nSuccesso! Estratti {len(df_final)} attributi univoci.")
        print(f"File salvato: {percorso_output}")

    except Exception as e:
        print(f"Errore durante l'estrazione: {e}")

if __name__ == "__main__":
    # Il file business.json contiene gli attributi del business
    estrai_attributi_univoci('business.json')