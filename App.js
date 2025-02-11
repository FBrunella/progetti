import AsyncStorage from '@react-native-async-storage/async-storage';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import * as Location from 'expo-location';
import React, { useEffect } from 'react';
import { StyleSheet, Text, TouchableOpacity, View } from 'react-native';
import DettaglioMenu from './DettaglioMenu';
import InformazioniUtente from './InformazioniUtente';
import ListaMenu from './ListaMenu';
import Map from './Map';
import ModificaDatiUtente from './ModificaDatiUtente';
import StatoConsegna from './StatoConsegna';
import { checkFirstRun } from './checkPrimoAvvio';




//Creazione dello stackNavigator
const Stack = createStackNavigator();

//Salvataggio della pagina corrente (RIVEDERE POSIZIONE)
const saveCurrentPage = async (page) => {
  try {
    await AsyncStorage.setItem('@current_page', page);
  } catch (e) {
    console.error('Failed to save the current page.', e);
  }
};

//Ottiene la pagina corrente (RIVEDERE LA POSIZIONE)
const getCurrentPage = async () => {
  try {
    const page = await AsyncStorage.getItem('@current_page');
    return page;
  } catch (e) {
    console.error('Failed to fetch the current page.', e);
    return null;
  }
};

function HomeScreen({ navigation }) {


  useEffect( () => {

    const fetchData = async () => {
      await checkFirstRun();
    };
    fetchData();
    //console.log(fetchData);

    //Ottenere la pagina corrente (RIVEDERE POSIZIONE)
    const fetchCurrentPage = async () => {
      const page = await getCurrentPage();
      //console.log('Current page:', page);
      if (page) {
        navigation.navigate(page);
      }
    };
    fetchCurrentPage();
    const unsubscribe = navigation.addListener('focus', () => {
      saveCurrentPage('Home');
    });
  return unsubscribe;
  }, [navigation]);

  return (
    //Bottoni di navigazione
    <View style={styles.container}>
      <Text style={styles.welcomeText}>Benvenuto!</Text>
      <View style={styles.buttonContainer}>
        <TouchableOpacity
          style={styles.button}
          onPress={async () => {
            const autorizzazionePosizione = await AsyncStorage.getItem('autorizzazionePosizione');
            if(autorizzazionePosizione === 'true'){
            saveCurrentPage('InformazioniUtente');
            navigation.navigate('InformazioniUtente');
            } else {
              alert('Devi autorizzare la posizione per utilizzare questa funzione');
              locationPermissionAsync();
            }
          
          }}
        >
          <Text style={styles.buttonText}>Vai a Informazioni Utente</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.button}
          onPress={async () => {
            const autorizzazionePosizione = await AsyncStorage.getItem('autorizzazionePosizione');
            if(autorizzazionePosizione === 'true'){
            saveCurrentPage('Map');
            navigation.navigate('Map');
            } else {
              alert('Devi autorizzare la posizione per utilizzare questa funzione');
              locationPermissionAsync();
            }
          
          }}
        >
          <Text style={styles.buttonText}>Vai a Mappa</Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={styles.button}
          onPress={async () => {
            const autorizzazionePosizione = await AsyncStorage.getItem('autorizzazionePosizione');
            if(autorizzazionePosizione === 'true'){
            saveCurrentPage('ListaMenu');
            navigation.navigate('ListaMenu');
            } else {
              alert('Devi autorizzare la posizione per utilizzare questa funzione');
              locationPermissionAsync();
            }
            
          }}
        >
          <Text style={styles.buttonText}>Vai a Lista Menu</Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={styles.button}
          onPress={async () => {
            const autorizzazionePosizione = await AsyncStorage.getItem('autorizzazionePosizione');
            if(autorizzazionePosizione === 'true'){
            saveCurrentPage('StatoConsegna');
            navigation.navigate('StatoConsegna');
            } else {
              alert('Devi autorizzare la posizione per utilizzare questa funzione');
              locationPermissionAsync();
            }
          
          }}
        >
          <Text style={styles.buttonText}>Vai allo stato della consegna</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

//Ottenere i permessi per la posizione
async function locationPermissionAsync() {
  //console.log('locationPermissionAsync chiamata'); // Log per il debug

  let canUseLocation = false;
  const grantedPermission = await Location.getForegroundPermissionsAsync()
  if (grantedPermission.status === "granted") {
    await AsyncStorage.setItem('autorizzazionePosizione', 'true');
    canUseLocation = true;
  } else {
    const permissionResponse = await Location.requestForegroundPermissionsAsync()
    if (permissionResponse.status === "granted") {
      await AsyncStorage.setItem('autorizzazionePosizione', 'true');
      canUseLocation = true;
    } else {
      await AsyncStorage.setItem('autorizzazionePosizione', 'false');
      canUseLocation = false;
    }
  }
  if (canUseLocation) {
    if (canUseLocation) {
      
      //Ottenere la posizione corrente
      const location = await Location.getCurrentPositionAsync()
      //console.log("received location:", location.coords);
      await AsyncStorage.setItem('location', JSON.stringify(location.coords));

      //Aggiornare la posizione
      Location.watchPositionAsync(
        { accuracy: Location.Accuracy.High, timeInterval: 30000, distanceInterval: 1 },
        async (newLocation) => {
          //console.log("updated location:", newLocation.coords);
          await AsyncStorage.setItem('location', JSON.stringify(newLocation.coords));
        }
      );
    }
  }
}


export default function App() {

  //Richiama la richiesta di autorizzazione per la posizione
  locationPermissionAsync();

  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="InformazioniUtente" component={InformazioniUtente} />
        <Stack.Screen name="ModificaDatiUtente" component={ModificaDatiUtente} />
        <Stack.Screen name="Map" component={Map} />
        <Stack.Screen name="ListaMenu" component={ListaMenu} />
        <Stack.Screen name="DettaglioMenu" component={DettaglioMenu} />
        <Stack.Screen name="StatoConsegna" component={StatoConsegna} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 16,
  },
  welcomeText: {
    fontSize: 24,
    marginBottom: 20,
  },
  buttonContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  button: {
    width: '45%',
    padding: 10,
    margin: 5,
    backgroundColor: '#007BFF',
    borderRadius: 5,
    alignItems: 'center',
    textAlign: 'center',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    textAlign: 'center',
  },
});
