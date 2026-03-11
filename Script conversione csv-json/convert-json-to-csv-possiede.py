import pandas as pd
import os

def converti_yelp_business_attributes_filtered(nome_file_json):
    cartella_corrente = os.path.dirname(os.path.abspath(__file__))
    percorso_input = os.path.join(cartella_corrente, nome_file_json)
    percorso_output = os.path.join(cartella_corrente, "relazioni_business_attributi.csv")

    # Mappatura ID fornita
    mapping_attributi = {
        'AcceptsInsurance': 'AE99EEF79B1D458FAFB4B7',
        'AgesAllowed': '9A5CB276BBB940A7AC872D',
        'Alcohol': '0BEBCFDE79A44239B19E05',
        'Ambience': '3ECAD055666D476DAE1FF4',
        'BYOB': '383EDA2EE19449BF988CBD',
        'BYOBCorkage': '0A63798FC01F4D81B473D1',
        'BestNights': '2C3C51A2FF8D46449129CE',
        'BikeParking': 'DCD12A73C74E4EBA86BEC4',
        'BusinessAcceptsBitcoin': '4C23722D40C24F32A1999F',
        'BusinessAcceptsCreditCards': 'EC22620424C145EEB46017',
        'BusinessParking': 'E1AE44DDEC624D9DAB776B',
        'ByAppointmentOnly': 'D66CFECAF1BC430B9A82A7',
        'Caters': '82625055A14A4935B35D8E',
        'CoatCheck': 'BE43FA3175A74C2EACDBE6',
        'Corkage': '6C5521D4FD794193A51287',
        'DietaryRestrictions': '7C73526F94CF4BEA8F95BE',
        'DogsAllowed': '600156C6F9F341F58A629D',
        'DriveThru': 'BFCA787684FB4C5E9A7F68',
        'GoodForDancing': '7F8FE7A0D9D04928AFA8E0',
        'GoodForKids': 'BF395DA5ABAA4ADF81A228',
        'GoodForMeal': '5A3AB4220B1343EEB9DA45',
        'HairSpecializesIn': 'AEBEC3742A3746FF823778',
        'HappyHour': '61F6543657AD4886967397',
        'HasTV': '466B5CA098AC4687A1C725',
        'Music': '9875271F88934FA6A20B73',
        'NoiseLevel': 'ED661A95BE034A05B7CA59',
        'Open24Hours': 'DA5CFBCE467D49609AC512',
        'OutdoorSeating': '8A0D7454F6C54ADDB6B080',
        'RestaurantsAttire': '6A0671048D8A48DBAA5418',
        'RestaurantsCounterService': 'F87D6C20A29F42E688E188',
        'RestaurantsDelivery': 'F7926BC08646411DAFBD4A',
        'RestaurantsGoodForGroups': 'EF757388EB344C088497AB',
        'RestaurantsPriceRange2': '58F6F22508214D468E6C3E',
        'RestaurantsReservations': '6BEA55A4F41D4AFE8F7344',
        'RestaurantsTableService': 'C23EF93E79C64765864E31',
        'RestaurantsTakeOut': '78CD22B04B8445BDB95755',
        'Smoking': 'E52365702C014D7F9FB26A',
        'WheelchairAccessible': '90D9C99476084766A8E93C',
        'WiFi': '81FC7B48CCBE47F8931F6A'
    }

    try:
        # Caricamento JSON Lines (one JSON-object per-line)
        reader = pd.read_json(percorso_input, lines=True, chunksize=10000)
        primo_chunk = True

        print("Elaborazione relazioni Business-Attributi con filtro indirizzo...")

        for chunk in reader:
            # 1. FILTRO INDIRIZZO: Ignora i business con campo address vuoto 
            chunk = chunk.dropna(subset=['address'])
            chunk = chunk[chunk['address'].astype(str).str.strip() != '']
            
            # Se il chunk è vuoto dopo il filtro, passa al successivo
            if chunk.empty:
                continue

            # 2. Selezioniamo business_id e attributes
            df = chunk[['business_id', 'attributes']].dropna(subset=['attributes'])
            
            # 3. TRASFORMAZIONE: Esplodiamo il dizionario attributes
            df['attr_items'] = df['attributes'].apply(lambda x: list(x.items()) if isinstance(x, dict) else [])
            df_esploso = df.explode('attr_items').dropna(subset=['attr_items'])
            
            # Estraiamo chiave (nome_attributo) e valore dalla tupla
            df_esploso[['nome_attributo', 'valore']] = pd.DataFrame(df_esploso['attr_items'].tolist(), index=df_esploso.index)
            
            # 4. FILTRO VALORE TRUE: Teniamo solo gli attributi attivi
            df_esploso['valore_clean'] = df_esploso['valore'].astype(str).str.lower()
            df_final = df_esploso[df_esploso['valore_clean'].isin(['true', "u'true'", '1'])].copy()
            
            # 5. MAPPATURA ID: Sostituiamo il nome con l'ID fornito
            df_final['id_attributo'] = df_final['nome_attributo'].map(mapping_attributi)
            
            # Rimuoviamo gli attributi che non compaiono nella tua lista
            df_final = df_final.dropna(subset=['id_attributo'])
            
            # Selezione colonne finali
            output_chunk = df_final[['business_id', 'id_attributo']]
            
            # 6. Salvataggio incrementale
            mode = 'w' if primo_chunk else 'a'
            header = primo_chunk
            output_chunk.to_csv(percorso_output, index=False, mode=mode, header=header, encoding='utf-8')
            
            primo_chunk = False

        print(f"Completato! File generato: {percorso_output}")

    except Exception as e:
        print(f"Errore: {e}")

if __name__ == "__main__":
    converti_yelp_business_attributes_filtered('business.json')