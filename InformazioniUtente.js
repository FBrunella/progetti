//RIVISTA (1)

import AsyncStorage from '@react-native-async-storage/async-storage';
import React, { useEffect, useState } from 'react';
import { Button, ScrollView, StyleSheet, Text, View } from 'react-native';
import { getUserInfo } from './ComController';


const InformazioniUtente = ({ navigation }) => {
    const [userInfo, setUserInfo] = useState(null);

    const saveCurrentPage = async (page) => {
        try {
            await AsyncStorage.setItem('@current_page', page);
        } catch (e) {
            console.error('Failed to save the current page.', e);
        }
    };
    const fetchUserInfo = async () => {
        try {
            const info = await getUserInfo();
            setUserInfo(info);
        } catch (error) {
            console.error('Errore nel recupero delle informazioni dell\'utente:', error);
        }
    };

    useEffect(() => {
        const initialize = async () => {
            await fetchUserInfo();
            saveCurrentPage("InformazioniUtente");
        };

        initialize();
    }, []);

    return (
        <ScrollView contentContainerStyle={styles.container}>
            <Text style={styles.title}>Informazioni Utente</Text>
            {userInfo ? (
                <>
                    <View style={styles.infoBox}>
                        <Text style={styles.label}>Nome: <Text style={styles.value}>{userInfo.firstName}</Text></Text>
                        <Text style={styles.label}>Cognome: <Text style={styles.value}>{userInfo.lastName}</Text></Text>
                        <Text style={styles.label}>Nome intero sulla carta: <Text style={styles.value}>{userInfo.cardFullName}</Text></Text>
                        <Text style={styles.label}>Numero carta: <Text style={styles.value}>{userInfo.cardNumber}</Text></Text>
                        <Text style={styles.label}>Mese scadenza carta: <Text style={styles.value}>{userInfo.cardExpireMonth}</Text></Text>
                        <Text style={styles.label}>Anno scadenza carta: <Text style={styles.value}>{userInfo.cardExpireYear}</Text></Text>
                        <Text style={styles.label}>CVV carta: <Text style={styles.value}>{userInfo.cardCVV}</Text></Text>

                    </View>
                    <View style={styles.buttonContainer}>
                        <Button
                            title="Modifica Dati Utente"
                            onPress={() => navigation.navigate('ModificaDatiUtente', { onGoBack: fetchUserInfo })}
                        />
                    </View>
                </>
            ) : (
                <Text style={styles.errorText}>Errore nel caricamento delle informazioni dell'utente..</Text>
            )}
        </ScrollView>
    );
};

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
    infoBox: {
        width: '90%',
        padding: 16,
        backgroundColor: '#fff',
        borderRadius: 8,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.8,
        shadowRadius: 2,
        elevation: 1,
        marginBottom: 20,
    },
    label: {
        fontSize: 18,
        fontWeight: 'bold',
        marginBottom: 5,
    },
    value: {
        fontSize: 18,
        fontWeight: 'normal',
    },
    buttonContainer: {
        width: '90%',
        marginTop: 20,
    },
    errorText: {
        fontSize: 18,
        color: 'red',
    },
});

export default InformazioniUtente;