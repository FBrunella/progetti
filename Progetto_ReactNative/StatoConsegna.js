import AsyncStorage from '@react-native-async-storage/async-storage';
import { useNavigation } from '@react-navigation/native';
import React, { useEffect, useState } from 'react';
import { Alert, StyleSheet, Text, View } from 'react-native';
import MapView, { Marker } from 'react-native-maps';

import { orderStatus } from './ComController';

const checkOID = async (navigation) => {
    try {
        const oid = await AsyncStorage.getItem('oid');
        if (oid === null) {
            Alert.alert(
                "Attenzione",
                "Non hai effettuato nessun ordine",
                [
                    {
                        text: "OK",
                        onPress: async () => {
                            await AsyncStorage.removeItem('@current_page'),

                            navigation.navigate('Home')
                        }
                    }
                ]
            );
            return false;
        }
        return true;
    } catch (e) {
        console.error('Errore nel recupero dell\'OID:', e);
        return false;
    }
};
const saveCurrentPage = async (page) => {
    try {
        await AsyncStorage.setItem('@current_page', page);
    } catch (e) {
        console.error('Errore nel salvataggio della pagina corrente:', e);
    }
};

// Visualizza lo stato della consegna richiamando le funzioni di ComController
const StatoConsegna = () => {
    const [dataCreazione, setDataCreazione] = useState('');
    const [Arrivo, setArrivo] = useState('');
    const [posizione, setPosizione] = useState('');
    const [deliveryLocation, setDeliveryLocation] = useState('');
    const [status, setStatus] = useState('');
    const [showMap, setShowMap] = useState(false);
    const navigation = useNavigation();




    useEffect(() => {
        const initialize = async () => {
            const oidExists = await checkOID(navigation);
            if (!oidExists) {
                return;
            }
    
            // Ottiene lo stato dell'ordine
            const fetchOrderStatus = async () => {
                try {
                    const status = await orderStatus(); 
                    // Estrai solo l'ora dalla stringa ISO
                    const oraCreazione = status.creationTimestamp.split("T")[1].split(".")[0]; // "15:06:11"
                    const oraArrivo = status.expectedDeliveryTimestamp ? status.expectedDeliveryTimestamp.split("T")[1].split(".")[0] : "Non disponibile"; // "15:06:11" o un messaggio di fallback
                
                    setDataCreazione(oraCreazione);  // Imposta solo l'orario di creazione
                    setPosizione(status.currentPosition);
                    setDeliveryLocation(status.deliveryLocation);
                    setStatus(status.status);
                    setArrivo(oraArrivo);  // Imposta solo l'orario di arrivo o un messaggio di fallback
                
                    //console.log("111:", oraArrivo);
                
                    if(status.status === "COMPLETED"){
                        setStatus("Consegnato");
                    }
                    if(status.status === "ON_DELIVERY"){
                        setStatus("In consegna");
                    }
                    if(status.expectedDeliveryTimestamp === undefined){
                        setArrivo("Il drone è arrivato a destinazione");
                    }
                } catch (error) {
                    console.error('Errore nel recupero dello stato dell\'ordine:', error);
                }
                
            };
    
            // Aggiorna lo stato dell'ordine ogni 5 secondi 
            fetchOrderStatus();

            const intervalId = setInterval(fetchOrderStatus, 5000); 
    
            return () => clearInterval(intervalId);
        };
        saveCurrentPage('StatoConsegna');

    
        initialize();
    }, []);
    

    useEffect(() => {
        // Timeout per aspettare che la mappa carichi i risultati dal server
        const timer = setTimeout(() => {
            setShowMap(true);
        }, 300);

        return () => clearTimeout(timer);
    }, []);

    return (
        <View style={styles.container}>
            <Text style={styles.statusText}>Stato della consegna: {status}</Text>
            <Text style={styles.statusText}>Ordine effettuato alle: {dataCreazione}</Text>
            <Text style={styles.statusText}>Ora di consegna: {Arrivo}</Text>
            {showMap && (
                <MapView
                    style={styles.map}
                    initialRegion={{
                        latitude: posizione?.lat || 0,
                        longitude: posizione?.lng || 0,
                        latitudeDelta: 0.01,
                        longitudeDelta: 0.01,
                    }}
                    showsUserLocation={true}
                >
                    {deliveryLocation && (
                        <Marker
                            coordinate={{
                                latitude: deliveryLocation.lat,
                                longitude: deliveryLocation.lng,
                            }}
                            title="Posizione di consegna"
                        />
                    )}
                    {posizione && (
                        <Marker
                            coordinate={{
                                latitude: posizione.lat,
                                longitude: posizione.lng,
                            }}
                            title="Posizione attuale drone"
                            pinColor="blue" 
                        />
                    )}
                </MapView>
            )}
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        padding: 10, 
    },
    statusText: {
        fontSize: 18,
        fontWeight: 'bold',
        marginVertical: 10, 
    },
    map: {
        width: '90%', 
        height: 300,  
        borderRadius: 10,
        borderWidth: 1,   
        borderColor: '#ddd', 
    },
});

export default StatoConsegna;
