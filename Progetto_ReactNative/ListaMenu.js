//RIVISTA, FETCH image da rivedere perchè manca il DB

import AsyncStorage from '@react-native-async-storage/async-storage';
import React, { useEffect, useState } from 'react';
import { Button, FlatList, Image, StyleSheet, Text, View } from 'react-native';
import { getMenu } from './ComController.js';
import { getPhotoByMenuID, saveOrUpdatePhoto, printTable, getImageFromDB } from './PhotoDatabase.js';


export default function ListaMenu({ navigation }) {
    const [menu, setMenu] = useState([]);
    const [error, setError] = useState(null);
    
    const saveCurrentPage = async (page) => {
        try {
            await AsyncStorage.setItem('@current_page', page);
        } catch (e) {
            console.error('Failed to save the current page.', e);
        }
    };
    
    useEffect(() => {
        //Funzione che richiama comcontroller per ottenere i menu vicini
        async function fetchMenu() {
            try {
                const sidUtente = await AsyncStorage.getItem('SID');
                const posizione = await AsyncStorage.getItem('location');
                const { latitude, longitude } = JSON.parse(posizione);

                if (sidUtente !== null) {
                    const menuData = await getMenu(latitude, longitude, sidUtente);
                    setMenu(menuData);
                    //console.log("MENU:", menuData);
                } else {
                    throw new Error('SID utente non trovato');
                }
            } catch (error) {
                setError(error.message);
                console.error('Errore nel recupero del SID utente:', error);
            }
        }
        saveCurrentPage("ListaMenu");
        fetchMenu();
        
    }, []);



    if (error) {
        return (
            <View style={styles.container}>
                <Text style={styles.errorText}>{error}</Text>
            </View>
        );
    }

    return (
        <View style={styles.container}>
            <FlatList
                data={menu}
                keyExtractor={(item) => item.mid.toString()}
                renderItem={({ item }) => <MenuItem menu={item} navigation={navigation} />} 
            />
        </View>
    );
}

function MenuItem({ menu, navigation }) { 
    const [imageBase64, setImageBase64] = useState(null);
    const [error, setError] = useState(null);


    
    

    useEffect(() => {
        //chiamata per ottenere l'immagine (DA RIVEDERE PER INSERIRE DA UN DB DA CREARE)
        async function fetchImage() {
            try {

                //imageVersion
                const sidUtente = await AsyncStorage.getItem('SID');
                const url = `https://develop.ewlab.di.unimi.it/mc/2425/menu/${menu.mid}/image?sid=${sidUtente}`;
                const response = await fetch(url);
                //console.log('1 RISPOSTA:', response);


                if (!response.ok) {
                    throw new Error('Errore nel caricamento dell\'immagine');
                }

                const data = await response.json(); // Analizza il JSON restituito dal server
                const base64Data = data.base64; // Estrai la stringa Base64 dal campo "base64"

                // Aggiungi il prefisso base64 per React Native
                const prefixedBase64Data = `data:image/png;base64,${base64Data}`;
                //setImageBase64(prefixedBase64Data);
                saveOrUpdatePhoto(prefixedBase64Data, menu.imageVersion, menu.mid);
            } catch (error) {
                setError('Errore nel caricamento immagine');
                console.error('Errore nel caricamento immagine:', error);
            }
            const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

            async function fetchImageDB(mid) {
                try {
                    const menuID = mid; // Sostituisci con l'ID che vuoi cercare
                    const image = await getImageFromDB(menuID);
                    if (image) {
                        
                        //console.log(prefixedBase64Data);
                        //console.log("Image found:", photoBase64);
                        await delay(2000);
                        setImageBase64(image.Photo);
                    } else {
                        console.log("No image found for MenuID:", menuID);
                        await delay(2000);
                        window.location.reload();
                    }
                } catch (error) {
                    console.log("Errorr fetching image:", image);
                }
            }
            fetchImageDB(menu.mid);
        }

        fetchImage();
    }, [menu.mid]);

    return (
        <View style={styles.item}>
            <Text style={styles.name}>{menu.name}</Text>
            <Text style={styles.mid}>ID: {menu.mid}</Text>
            <Text style={styles.price}>€{menu.price}</Text>
            <Text style={styles.description}>{menu.shortDescription}</Text>
            <Text style={styles.deliveryTime}>Tempo di consegna: {menu.deliveryTime} minuti</Text>
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
            <Button
                title="Dettagli" style={styles.button}
                onPress={() => navigation.navigate('DettaglioMenu', { mid: menu.mid })} // Passa un oggetto con mid
            />
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    errorText: {
        color: 'red',
    },
    item: {
        padding: 10,
        marginVertical: 8,
        marginHorizontal: 16,
        backgroundColor: '#fff',
        borderRadius: 8,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.8,
        shadowRadius: 2,
        elevation: 1,
    },
    name: {
        fontSize: 18,
        fontWeight: 'bold',
    },
    mid: {
        fontSize: 14,
        color: '#666',
    },
    price: {
        fontSize: 16,
        color: '#000',
    },
    description: {
        fontSize: 14,
        color: '#666',
    },
    deliveryTime: {
        fontSize: 14,
        color: '#666',
    },
    image: {
        width: '100%',
        height: 200,
        resizeMode: 'contain',
        marginTop: 10,
    },
    button: {
        width: '100%',
        padding: 10,
        margin: 5,
        backgroundColor: '#007BFF',
        borderRadius: 5,
        alignItems: 'center',
        textAlign: 'center',
        marginTop: 10,
    },
});
