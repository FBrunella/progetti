//RIVISTA, FUNZIONA (1)

import AsyncStorage from '@react-native-async-storage/async-storage';

export async function checkFirstRun() {
    try {
        // Controlla se l'app è già stata avviata in precedenza
        const hasAlreadyRun = await AsyncStorage.getItem("hasAlreadyRun");
        if (hasAlreadyRun) {
            //console.log("Not first run:", hasAlreadyRun);
            return; // Esce se non è la prima esecuzione
        }

        // Prima esecuzione
        //console.log("First run");
        await AsyncStorage.setItem("hasAlreadyRun", "true");

        const url = 'https://develop.ewlab.di.unimi.it/mc/2425/user';
        //console.log("Request URL:", url);

        // Effettua una richiesta POST al server
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        // Controlla il codice di stato della risposta
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        //console.log("Received data:", data);

        const { sid, uid } = data;

        if (!sid || !uid) {
            throw new Error("Missing SID or UID in the response");
        }

        // Salva SID e UID in AsyncStorage
        await AsyncStorage.setItem("SID", sid);
        await AsyncStorage.setItem("UID", uid.toString());
        //console.log("SID and UID saved successfully:", { sid, uid });

    } catch (error) {
        console.error("Errore durante checkFirstRun:", error);
    }
}

export async function resetFirstRun() {
    try {
        await AsyncStorage.removeItem("hasAlreadyRun");
        //console.log("Reset first run flag");
    } catch (error) {
        console.error("Errore durante il reset del flag di prima esecuzione:", error);
    }
}

