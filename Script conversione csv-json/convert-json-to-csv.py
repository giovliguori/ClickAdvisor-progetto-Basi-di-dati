import pandas as pd
import os

def converti_json_a_csv(nome_file_json):
    # Ottiene il percorso della cartella dove si trova questo script
    cartella_corrente = os.path.dirname(os.path.abspath(__file__))
    
    # Costruisce i percorsi completi
    percorso_input = os.path.join(cartella_corrente, nome_file_json)
    nome_file_csv = nome_file_json.replace('.json', '.csv')
    percorso_output = os.path.join(cartella_corrente, nome_file_csv)

    try:
        # Carica il file JSON
        # Nota: se il JSON è una lista di oggetti, pandas lo converte automaticamente in tabella
        df = pd.read_json(percorso_input, lines=True)

        # Salva in CSV
        # index=False evita di aggiungere una colonna extra per i numeri di riga
        df.to_csv(percorso_output, index=False, encoding='utf-8')
        
        print(f"Successo! File convertito e salvato come: {nome_file_csv}")
        
    except FileNotFoundError:
        print(f"Errore: Il file '{nome_file_json}' non è stato trovato nella cartella dello script.")
    except Exception as e:
        print(f"Si è verificato un errore durante la conversione: {e}")

if __name__ == "__main__":
    # Inserisci qui il nome del tuo file (es. 'dati.json')
    file_da_convertire = 'review.json' 
    converti_json_a_csv(file_da_convertire)