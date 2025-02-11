//DA RIVEDERE DEVE USARE LE FUNZIONI DI COMCONTROLLER

import AsyncStorage from '@react-native-async-storage/async-storage';
import React, { useEffect, useState } from 'react';
import { ActivityIndicator, Button, ScrollView, StyleSheet, Text, TextInput } from 'react-native';
import { getUserInfo, updateUserData } from './ComController';

const ModificaDatiUtente = ({ route, navigation }) => {
    const [UID, setUID] = useState(null);
    const [userData, setUserData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [cardFullName, setCardFullName] = useState('');
    const [cardNumber, setCardNumber] = useState('');
    const [cardExpireMonth, setCardExpireMonth] = useState('');
    const [cardExpireYear, setCardExpireYear] = useState('');
    const [cardCVV, setCardCVV] = useState('');
    const [uid, setUid] = useState('');
    const [lastOid, setLastOid] = useState('');
    const [orderStatus, setOrderStatus] = useState('');


    useEffect(() => {
        const fetchSIDandUID = async () => {
            const uid = await AsyncStorage.getItem("UID");
            setUID(uid);
            //console.log("UID 1:", uid);
        };

        fetchSIDandUID();
    }, []);

    useEffect(() => {
        const fetchData = async () => {
            if (UID) {
                try {
                    const data = await getUserInfo();
                    setUserData(data);
                    setFirstName(data.firstName);
                    setLastName(data.lastName);
                    setCardFullName(data.cardFullName);
                    setCardNumber(data.cardNumber);
                    setCardExpireMonth(data.cardExpireMonth);
                    setCardExpireYear(data.cardExpireYear);
                    setCardCVV(data.cardCVV);
                    setUid(data.uid);
                    setLastOid(data.lastOid);
                    setOrderStatus(data.orderStatus);
                    setLoading(false);
                } catch (error) {
                    console.error(error);
                    setLoading(false);
                }
            }
        };

        fetchData();
    }, [UID]);


    const handleUpdate = async () => {
        try {
            await updateUserData(UID, {
                firstName,
                lastName,
                cardFullName,
                cardNumber,
                cardExpireMonth,
                cardExpireYear,
                cardCVV,
                uid,
                lastOid,
                orderStatus
            });
            alert('Dati aggiornati con successo');
            if (route.params?.onGoBack) {
                route.params.onGoBack();
            }
            navigation.goBack();
        } catch (error) {
            console.error(error);
            alert('Errore durante l\'aggiornamento dei dati');
        }
    };

    if (loading) {
        return <ActivityIndicator size="large" color="#0000ff" />;
    }

    return (
        <ScrollView contentContainerStyle={styles.container}>
            <Text style={styles.title}>Modifica Dati Utente</Text>
            <TextInput
                style={styles.input}
                placeholder="Nome"
                placeholderTextColor="#888" 

                value={firstName}
                onChangeText={setFirstName}
            />
            <TextInput
                style={styles.input}
                placeholder="Cognome"
                placeholderTextColor="#888" 

                value={lastName}
                onChangeText={setLastName}
            />
            <TextInput
                style={styles.input}
                placeholder="Nome intero sulla carta"
                placeholderTextColor="#888" 

                value={cardFullName}
                onChangeText={setCardFullName}
            />
            <TextInput
                style={styles.input}
                placeholder="Numero carta"
                placeholderTextColor="#888" 

                value={cardNumber}
                onChangeText={setCardNumber}
            />
            <TextInput
                style={styles.input}
                placeholder="Mese scadenza carta"
                placeholderTextColor="#888" 

                value={cardExpireMonth}
                onChangeText={setCardExpireMonth}
            />
            <TextInput
                style={styles.input}
                placeholder="Anno scadenza carta"
                placeholderTextColor="#888" 

                value={cardExpireYear}
                onChangeText={setCardExpireYear}
            />
            <TextInput
                style={styles.input}
                placeholder="CVV carta"
                placeholderTextColor="#888" 

                value={cardCVV}
                onChangeText={setCardCVV}
            />



            <Button title="Aggiorna Dati" onPress={handleUpdate} />
        </ScrollView>
    );
};

const styles = StyleSheet.create({
    container: {
        flexGrow: 1,
        justifyContent: 'center',
        alignItems: 'center',
        padding: 16,
        backgroundColor: '#f5f5f5',
    },
    title: {
        fontSize: 24,
        fontWeight: 'bold',
        marginBottom: 16,
        color: '#333',
    },
    input: {
        width: '90%',
        padding: 10,
        marginVertical: 10,
        backgroundColor: '#fff',
        borderRadius: 8,
        borderColor: '#ccc',
        borderWidth: 1,
    },
});

export default ModificaDatiUtente;