package com.example.mangiaebasta.models

import android.os.ParcelFileDescriptor
import android.webkit.WebStorage.Origin
import kotlinx.serialization.Serializable

@Serializable
data class MenuItem(
    val mid: Int,
    val name: String,
    val price: Double,
    val location: Location,
    val imageVersion: Int,
    val shortDescription: String,
    val deliveryTime: Int,
    val evaluation: Evaluation? = null
)

@Serializable
data class DetailedMenuItem(
    val mid: Int,
    val name: String,
    val price: Double,
    val location: Location,
    val imageVersion: Int,
    val shortDescription: String,
    val deliveryTime: Int,
    val longDescription: String
)

@Serializable
data class MenuItemWithImage(
    val mid: Int,
    val name: String,
    val price: Double,
    val location: Location,
    val imageVersion: Int,
    val shortDescription: String,
    val deliveryTime: Int,
    val image: String?,
    val evaluation: Evaluation? = null
)

@Serializable
data class DetailedMenuItemWithImage(
    val mid: Int,
    val name: String,
    val price: Double,
    val location: Location,
    val imageVersion: Int,
    val shortDescription: String,
    val deliveryTime: Int,
    val longDescription: String,
    val image: String?
)

@Serializable
data class Base64Response(
    val base64: String
)

@Serializable
data class Location(
    val lat: Double,
    val lng: Double,
    val deliveryTimestamp: String? = null // Add this optional field
)

@Serializable
data class Order(
    val oid: Int,
    val mid: Int,
    val uid: Int,
    val creationTimestamp: String,
    val status: String,
    val deliveryLocation: Location,
    val expectedDeliveryTimestamp: String? = null,
    val currentPosition: Location,
    val deliveryTimestamp: String? = null
)

@Serializable
data class DeliveryLocationWithSid(
    val sid: String,
    val deliveryLocation: Location
)

@Serializable
data class Profile(
    val firstName: String?,
    val lastName: String?,
    val cardFullName: String?,
    val cardNumber: Long?,
    val cardExpireMonth: Int?,
    val cardExpireYear: Int?,
    val cardCVV: Int?,
    val uid: Int,
)

@Serializable
data class User(
    val uid: Int,
    val sid: String
)

@Serializable
data class ProfileToUpdate(
    val firstName: String,
    val lastName: String,
    val cardFullName: String,
    val cardNumber: String,
    val cardExpireMonth: String,
    val cardExpireYear: String,
    val cardCVV: String,
    val sid: String
)

@Serializable
data class Ingredienti(
    val name: String,
    val description: String,
    val bio: Boolean,
    val origin: String
)

@Serializable
data class MenuOrdini(
    val shortDescription: String,
    val imageVersion: Int,
    val location: Location,
    val price: Double,
    val name: String,
    val mid: Int
)

@Serializable
data class Ordini(
    val oid: Int,
    val uid: Int,
    val creationTimestamp: String,
    val status: String,
    val deliveryLocation: Location,
    val deliveryTimestamp: String?,
    val menu: MenuOrdini
)

@Serializable
data class RistorantiPlus(
    val rid: Int,
    val name: String,
    val slogan: String,
    val base64: String,
    val location: Location
)

@Serializable
data class InformazioniUtente(
    val firstName: String,
    val lastName: String,
    val cardFullName: String,
    val cardNumber: String,
    val cardExpireMonth: Int,
    val cardExpireYear: Int,
    val cardCVV: String,
    val uid: Int,
    val lastOid: Int,
    val orderStatus: String,
    val subscription: Boolean
)

@Serializable
data class MenuMangione(
    val mid: Int,
    val name: String,
    val price: Double,
    val location: Location,
    val imageVersion: Int,
    val shortDescription: String,
    val deliveryTime: Int,
    val discount: Int? = null,
    val missedDiscount: Int? = null
)

@Serializable
data class Evaluation(
    val averageScore: Double,
    val reviewCnt: Int
)

@Serializable
data class PopularMenu(
    val mid: Int,
    val name: String,
    val price: Double,
    val imageVersion: Int,
    val orderCount: Int
)


