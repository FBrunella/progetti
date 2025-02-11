//RIVISTA (1)

import AsyncStorage from '@react-native-async-storage/async-storage';
import React, { useEffect, useState } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import MapView, { Marker } from 'react-native-maps';
import { getMenu } from './ComController';

const MapScreen = () => {
  const [initialRegion, setInitialRegion] = useState(null);
  const [markers, setMarkers] = useState([]);

  const saveCurrentPage = async (page) => {
    try {
        await AsyncStorage.setItem('@current_page', page);
    } catch (e) {
        console.error('Failed to save the current page.', e);
    }
};

  useEffect(() => {
    //Ottiene la location che ho salvato nell'asyncstorage
    const getLocation = async () => {
      try {
        const location = await AsyncStorage.getItem('location');
        if (location) {
          const { latitude, longitude } = JSON.parse(location);
          setInitialRegion({
            latitude,
            longitude,
            latitudeDelta: 0.0922,
            longitudeDelta: 0.0421,
          });
        }
      } catch (error) {
        console.log(error);
      }
    };

    const posMenu = async () => {
      //Ottiene la posizione dei menu vicini per farli vedere sulla mappa
      try {
        const sidUtente = await AsyncStorage.getItem('SID');
        const posizione = await AsyncStorage.getItem('location');
        const { latitude, longitude } = JSON.parse(posizione);
        const menu = await getMenu(latitude, longitude, sidUtente);

        const menuItems = menu;
        const newMarkers = menuItems.map(item => ({
          latitude: item.location.lat,
          longitude: item.location.lng,
          title: item.name,
          description: item.shortDescription,
        }));
        setMarkers(newMarkers);
      } catch (error) {
        console.error('Errore nel recupero del menu:', error);
      }
    };
    saveCurrentPage("Map");
    getLocation();
    posMenu();
  }, []);

  if (!initialRegion) {
    return (
      <View style={styles.container}>
        <Text>Loading...</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <MapView
        style={styles.map}
        initialRegion={initialRegion}
        showsUserLocation={true}
      >
        {markers.map((marker, index) => (
          <Marker
            key={index}
            coordinate={{ latitude: marker.latitude, longitude: marker.longitude }}
            title={marker.title}
            description={marker.description}
          />
        ))}
      </MapView>

      
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  map: {
    flex: 1,
  },
  modalContent: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default MapScreen;