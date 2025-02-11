//RIVISTA funziona (1)

import AsyncStorage from '@react-native-async-storage/async-storage';
import { Alert } from 'react-native';

//Chiamata per creazione utente
export async function createUser() {
    const url = 'https://develop.ewlab.di.unimi.it/mc/2425/user';
    try {
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        const data = await response.json();
        const { sid, uid } = data;
        await AsyncStorage.setItem("SID", sid);
        await AsyncStorage.setItem("UID", uid.toString());
    } catch (error) {
        console.error('Errore nel recupero delle informazioni dell\'utente:', error);
    }
}

//Chiamata per ottenere informazioni utente
export async function getUserInfo() {
    const SID = await AsyncStorage.getItem("SID");
    const UID = await AsyncStorage.getItem("UID");
    const url = `https://develop.ewlab.di.unimi.it/mc/2425/user/${UID}?sid=${SID}`;
    try {
        const response = await fetch(url);
        const data = await response.json();
        //console.log("Data setted: ", data);
        return data;
    } catch (error) {
        console.error('Errore nel recupero delle informazioni dell\'utente:', error);
        return null;
    }
}

//Chiamata per aggiornare informazioni utente
export async function updateUserData(uid, updateData) {
    const BASE_URL = `https://develop.ewlab.di.unimi.it/mc/2425`;
    try {
        const SID = await AsyncStorage.getItem("SID");
        const bodyData = {
            ...updateData,
            sid: SID
        };
        const response = await fetch(`${BASE_URL}/user/${uid}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(bodyData)
        });

        if (response.status === 204) {
            return;
        }

        const data = await response.json();
        return data;

    } catch (error) {
        throw error;
    }
}

//Chiamata per eliminare l'ultimo ordine effettuato dall'utente
export async function deleteLastOrder() {
    const sidUtente = await AsyncStorage.getItem('SID');
    const response = await fetch(`https://develop.ewlab.di.unimi.it/mc/2425/order?sid=${sidUtente}`, {
        method: 'DELETE'
    });

    if(response.status === 401) {
        Alert.alert("Invalid session ID");
    }

    if(response.status === 204) {
        Alert.alert("No orders to delete");
    }

    if (!response.ok) {
        throw new Error('Errore nell\'eliminazione dell\'ultimo ordine');
    }
    //console.log('Ultimo ordine eliminato con successo');
}


//Chiamata per ottenere i menù vicini
export async function getMenu(latitude, longitude, sidUtente) {
    function roundToFourDecimals(num) {
        return Math.round(num * 10000) / 10000;
    }

    const roundedLatitude = roundToFourDecimals(latitude);
    const roundedLongitude = roundToFourDecimals(longitude);

    const response = await fetch(`https://develop.ewlab.di.unimi.it/mc/2425/menu?lat=${roundedLatitude}&lng=${roundedLongitude}&sid=${sidUtente}`);
    if (!response.ok) {
        throw new Error('Errore nel recupero del menu');
    }
    const data = await response.json();
    return data;
}

//Chiamata per ottenere informazioni menu?¿
export async function getMenuMid(mid, latitude, longitude, sidUtente) {
    function roundToFourDecimals(num) {
        return Math.round(num * 10000) / 10000;
    }

    const roundedLatitude = roundToFourDecimals(latitude);
    const roundedLongitude = roundToFourDecimals(longitude);
    const response = await fetch(`https://develop.ewlab.di.unimi.it/mc/2425/menu/${mid}?lat=${roundedLatitude}&lng=${roundedLongitude}&sid=${sidUtente}`);
    if (!response.ok) {
        throw new Error('Errore nel recupero del menu');
    }
    const data = await response.json();
    //console.log("RISPOSTA GET: ", data);
    return data;
}

//Chiamata per ordinare un menu con gestione degli errori in risposta
export async function ordinaMenu(mid, sidUtente, latitude, longitude) {
    try {
        //console.log('Ordino il menu con MID:', mid);
        const response = await fetch(`https://develop.ewlab.di.unimi.it/mc/2425/menu/${mid}/buy`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                sid: sidUtente,
                deliveryLocation: {
                    lat: latitude,
                    lng: longitude
                }
            })
        });
        //console.log('Risposta:', response);
        if (response.status === 403) {
            Alert.alert(
                'Errore di pagamento',
                'Per favore, inserisci i dati della tua carta per completare l\'ordine.',
                [{ text: 'OK' }]
            );
            //throw new Error('Errore di pagamento: dati della carta mancanti');
        }
        if (response.status === 409) {
            Alert.alert(
                'Hai già un ordine in consegna',
                'Per favore, attendi la consegna dell\'ordine precedente prima di effettuare un nuovo ordine.',
                [{ text: 'OK' }]
            );
            //throw new Error('Hai già un ordine in consegna');
        }
        if (response.status === 200) {
            Alert.alert(
                'Ordine effettuato con successo',
                'Il tuo ordine è stato effettuato con successo. Puoi seguire lo stato della consegna nella sezione "Stato consegna".',
                [{ text: 'OK' }]
            );
        }
        if (!response.ok) {
            //const errorText = await response.text();
            //console.error('Errore nel corpo della risposta:', errorText);
            //throw new Error('Errore nell\'ordine del menu');
        }

        const data = await response.json();
        //console.log('Ordine effettuato con successo:', data);

        // Salva l'oid nell'AsyncStorage
        if (data.oid) {
            await AsyncStorage.setItem('oid', JSON.stringify(data.oid));
            //console.log('OID salvato nell\'AsyncStorage:', data.oid);
        }

        return data;
    } catch (error) {
        console.error('Errore:', error);
        throw error;
    }
}


//Chiamata per sapere lo stato di un ordine
export async function orderStatus() {
    const oid = await AsyncStorage.getItem('oid');
    const sidUtente = await AsyncStorage.getItem('SID');
    const response = await fetch(`https://develop.ewlab.di.unimi.it/mc/2425/order/${oid}?sid=${sidUtente}`);

    if (!response.ok) {
    }
    const data = await response.json();
    //console.log('1 Stato dell\'ordine:', data);

    return data;
}

//Chiamata per ottenere l'immagine di un menu
export async function fetchImage(mid) {
    try {
        const sidUtente = await AsyncStorage.getItem('SID');
        const url = `https://develop.ewlab.di.unimi.it/mc/2425/menu/${mid}/image?sid=${sidUtente}`;
        const response = await fetch(url);

        if (!response.ok) {
            throw new Error('Errore nel caricamento dell\'immagine');
        }

        const data = await response.json(); // Analizza il JSON restituito dal server
        const base64Data = data.base64; // Estrai la stringa Base64 dal campo "base64"

        // Aggiungi il prefisso base64 per React Native
        const prefixedBase64Data = `data:image/png;base64,${base64Data}`;
        setImageBase64(prefixedBase64Data);
    } catch (error) {
        setError('Errore nel caricamento immagine');
        console.error('Errore nel caricamento immagine:', error);
    }
}

export async function getIngredienti(mid) {
    try {
        const sid = await AsyncStorage.getItem('SID'); 
        const url = `https://develop.ewlab.di.unimi.it/mc/2425/menu/${mid}/ingredients?sid=${sid}`;
        const response = await fetch(url);

        if(!response.ok) {
            throw new Error('Errore nel recupero degli ingredienti');
        }

        const data = await response.json();
        console.log('Ingredienti1: ', data);
        return data;
    } catch (error) {
        console.error('Errore nel recupero degli ingredienti:', error);
    }
}