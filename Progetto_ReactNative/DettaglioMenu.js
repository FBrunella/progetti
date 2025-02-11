//RIVISTO  manca fetch image perchè manca il DB


import AsyncStorage from '@react-native-async-storage/async-storage';
import React, { useEffect, useState } from 'react';
import { StyleSheet, Text, View, Image, ScrollView, Button } from 'react-native';
import { getMenuMid } from './ComController';
import { ordinaMenu } from './ComController';
import { getIngredienti } from './ComController';



export default function DettaglioMenu({navigation, route}) {
    const [menuDetails, setMenuDetails] = useState(null);
    const [error, setError] = useState(null);
    const { mid } = route.params;
    const [imageBase64, setImageBase64] = useState(null);
    const [sidUtente, setSidUtente] = useState(null);
    const [lat, setLat] = useState(null);
    const [lng, setLng] = useState(null);

    useEffect(() => {
        //Mostra i dettagli del menu richiedendo a comcontroller
        async function fetchMenuDetails() {
            
                const sidUtente = await AsyncStorage.getItem('SID');
                setSidUtente(sidUtente);
                const posizione = await AsyncStorage.getItem('location');
                setLat(JSON.parse(posizione).latitude);
                setLng(JSON.parse(posizione).longitude);
                const { latitude, longitude } = JSON.parse(posizione);

                if (mid && sidUtente && posizione) {
                    const detailsData = await getMenuMid(mid, latitude, longitude, sidUtente);
                    setMenuDetails(detailsData);
                } else {
                    throw new Error('Dati mancanti');
                }

                console.log("Ingredienti: ", getIngredienti(mid));
        

        }
        //Chiamata per le immagini (DA RIVEDERE PER DB DA CREARE)
        async function fetchImage() {
            try {
                const sidUtente = await AsyncStorage.getItem('SID');
                const url = `https://develop.ewlab.di.unimi.it/mc/2425/menu/${mid}/image?sid=${sidUtente}`;
                const response = await fetch(url);
        
                if (!response.ok) {
                    throw new Error('Errore nel caricamento dell\'immagine');
                }
        
                const data = await response.json();
                const base64Data = data.base64;
        
                const prefixedBase64Data = `data:image/png;base64,${base64Data}`;
                setImageBase64(prefixedBase64Data);
            } catch (error) {
                setError('Errore nel caricamento immagine');
                console.error('Errore nel caricamento immagine:', error);
            }
        }

        fetchImage();
        fetchMenuDetails();
    }, []);

    if (error) {
        return (
            <View style={styles.container}>
                <Text style={styles.errorText}>{error}</Text>
            </View>
        );
    }

    if (!menuDetails) {
        return (
            <View style={styles.container}>
                <Text>Caricamento dettagli del menu...</Text>
            </View>
        );
    }



    return (
        <ScrollView contentContainerStyle={styles.container}>
            <Text style={styles.title}>{menuDetails.name}</Text>
            {imageBase64 ? (
                <Image
                    source={{ uri: imageBase64 }}
                    style={styles.image}
                />
            ) : error ? (
                <Text style={styles.errorText}>{error}</Text>
            ) : (
                <Text>Caricamento immagine...</Text>
            )}

            <Text style={styles.price}>€{menuDetails.price}</Text>
            <Text style={styles.description}>{menuDetails.shortDescription}</Text>
            <Text style={styles.description}>{menuDetails.longDescription}</Text>
            <Text style={styles.deliveryTime}>Tempo di consegna: {menuDetails.deliveryTime} minuti</Text>

            <Button title="ORDINA ORA !" onPress={() => {
                ordinaMenu(menuDetails.mid, sidUtente, lat, lng);
            }} />
            

        </ScrollView>
    );
}

const styles = StyleSheet.create({
    container: {
        flexGrow: 1,
        justifyContent: 'center',
        alignItems: 'center',
        padding: 20,
    },
    title: {
        fontSize: 24,
        fontWeight: 'bold',
        marginBottom: 20,
    },
    price: {
        fontSize: 20,
        color: '#000',
        marginBottom: 10,
    },
    description: {
        fontSize: 16,
        color: '#666',
        marginBottom: 10,
    },
    deliveryTime: {
        fontSize: 16,
        color: '#666',
        marginBottom: 10,
    },
    image: {
        width: '100%',
        height: 200,
        resizeMode: 'contain',
        marginTop: 10,
    },
    errorText: {
        color: 'red',
    },
});
