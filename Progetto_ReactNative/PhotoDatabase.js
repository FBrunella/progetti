import * as SQLite from 'expo-sqlite';

export async function openDB() {
    this.db = await SQLite.openDatabaseAsync('databaseName');
    const query = 'CREATE TABLE IF NOT EXISTS Photos (Photo TEXT , Version INTEGER, MenuID INTEGER PRIMARY KEY);';
    try {
        await this.db.execAsync(query);
    } catch (err) {
        console.log(err);
    }
}


export async function saveOrUpdatePhoto(photoBase64, version, menuID) {
    if (!this.db) {
        await openDB();
    }
    const selectQuery = 'SELECT * FROM Photos WHERE Photo = ?';
    const insertQuery = 'INSERT INTO Photos (Photo, Version, MenuID) VALUES (?, ?, ?)';
    const updateQuery = 'UPDATE Photos SET Version = ?, MenuID = ? WHERE Photo = ?';

    try {
        const result = await this.db.getFirstAsync(selectQuery, [photoBase64]);
        if (result) {
            if (result.Version < version) {
                await this.db.runAsync(updateQuery, [version, menuID, photoBase64]);
                //console.log("Photo updated", version, menuID, photoBase64);
            } else {
                //console.log("Photo already up-to-date", version, menuID);
            }
        } else {
            await this.db.runAsync(insertQuery, [photoBase64, version, menuID]);
            //console.log("Photo saved");
        }
    } catch (err) {
        console.log(err);
    }
}

    // recupera l'immagine dal database
export async function getImageFromDB(mid) {
        const query = "SELECT * FROM Photos WHERE MenuID = ?";
        try {
            const result = await this.db.getFirstAsync(query, [mid]);
            return result;
        } catch (error) {
            //console.log("Error fetching image:", error);
        }
        return result;
}
