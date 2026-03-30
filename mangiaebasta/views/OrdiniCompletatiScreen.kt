package com.example.mangiaebasta.views

import android.graphics.BitmapFactory
import android.util.Base64
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.NavHostController
import com.example.mangiaebasta.models.DetailedMenuItemWithImage
import com.example.mangiaebasta.viewmodels.MenuViewModel
import kotlinx.coroutines.launch
import com.example.mangiaebasta.viewmodels.IngredientsUiState
import com.example.mangiaebasta.viewmodels.OrdiniCompletatiUiState


@Composable
fun OrdiniCompletatiScreen(
    navController: NavController,
    menuViewModel: MenuViewModel
){
    LaunchedEffect(Unit) {
        menuViewModel.loadOrdiniCompletati()
    }

    val ui by menuViewModel.ordiniCompletatiUi.collectAsState()


    Scaffold(
        topBar = {
            Surface(tonalElevation = 3.dp) {
                Box(
                    Modifier
                        .fillMaxWidth()
                        .height(56.dp)
                        .padding(horizontal = 16.dp),
                    contentAlignment = Alignment.CenterStart
                ) {
                    Text("Storico ordini", style = MaterialTheme.typography.titleLarge)
                }
            }
        }
    ) { padding ->
        Box(
            Modifier
                .fillMaxSize()
                .background(MaterialTheme.colorScheme.background)
                .padding(padding)
        ) {
            when {
                ui.loading -> {
                    Column(
                        Modifier.fillMaxSize(),
                        verticalArrangement = Arrangement.Center,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) { CircularProgressIndicator() }
                }

                ui.items.isEmpty() -> {
                    Column(
                        Modifier.fillMaxSize().padding(16.dp),
                        verticalArrangement = Arrangement.Center,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) { Text("Nessun ordine completato.") }
                }


                else -> {
                    LazyColumn(
                        modifier = Modifier.fillMaxSize(),
                        contentPadding = PaddingValues(12.dp),
                        verticalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        items(ui.items) { row ->
                            CompletedOrderRow(
                                name = row.order.menu.name,
                                shortDesc = row.order.menu.shortDescription,
                                price = row.order.menu.price,
                                status = row.order.status,
                                base64Image = row.imageBase64
                            )
                        }
                    }
                }
            }
        }
    }
}


@Composable
private fun CompletedOrderRow(
    name: String,
    shortDesc: String,
    price: Double,
    status: String,
    base64Image: String?
){
    Row(
        Modifier
            .fillMaxWidth()
            .height(IntrinsicSize.Min)
            .padding(8.dp)
    ) {
        // TESTO A SINISTRA
        Column(
            Modifier
                .weight(1f)
                .padding(end = 12.dp)
        ) {
            Text(name, style = MaterialTheme.typography.titleMedium, maxLines = 1)
            Spacer(Modifier.height(4.dp))
            Text(shortDesc, style = MaterialTheme.typography.bodyMedium, maxLines = 2)
            Spacer(Modifier.height(8.dp))
            Text("Prezzo: €$price", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.primary)
            Text("Stato: $status", style = MaterialTheme.typography.bodySmall)
        }

        // IMMAGINE A DESTRA
        val imgBitmap = remember(base64Image) {
            base64Image?.let {
                try {
                    val bytes = Base64.decode(it, Base64.DEFAULT)
                    BitmapFactory.decodeByteArray(bytes, 0, bytes.size)?.asImageBitmap()
                } catch (_: Throwable) { null }
            }
        }
        Box(
            modifier = Modifier
                .width(96.dp)
                .fillMaxHeight(),
            contentAlignment = Alignment.Center
        ) {
            if (imgBitmap != null) {
                Image(
                    bitmap = imgBitmap,
                    contentDescription = name,
                    contentScale = ContentScale.Crop,
                    modifier = Modifier
                        .fillMaxWidth()
                        .aspectRatio(1f)
                        .background(MaterialTheme.colorScheme.surfaceVariant)
                )
            } else {
                // placeholder minimale
                Surface(
                    tonalElevation = 2.dp,
                    modifier = Modifier
                        .fillMaxWidth()
                        .aspectRatio(1f)
                ) { Box(Modifier.fillMaxSize()) }
            }
        }
    }
}


//
//package com.example.mangiaebasta.views
//
//import android.graphics.BitmapFactory
//import android.util.Base64
//import androidx.compose.foundation.Image
//import androidx.compose.foundation.background
//import androidx.compose.foundation.layout.*
//import androidx.compose.foundation.lazy.LazyColumn
//import androidx.compose.foundation.lazy.items
//import androidx.compose.foundation.rememberScrollState
//import androidx.compose.foundation.verticalScroll
//import androidx.compose.material3.*
//import androidx.compose.runtime.*
//import androidx.compose.ui.Alignment
//import androidx.compose.ui.Modifier
//import androidx.compose.ui.graphics.asImageBitmap
//import androidx.compose.ui.layout.ContentScale
//import androidx.compose.ui.unit.dp
//import androidx.navigation.NavController
//import androidx.navigation.NavHostController
//import com.example.mangiaebasta.models.DetailedMenuItemWithImage
//import com.example.mangiaebasta.viewmodels.MenuViewModel
//import kotlinx.coroutines.launch
//import com.example.mangiaebasta.viewmodels.IngredientsUiState
//import com.example.mangiaebasta.viewmodels.OrdiniCompletatiUiState
//
//
//@Composable
//fun OrdiniCompletatiScreen(
//    navController: NavController,
//    menuViewModel: MenuViewModel
//){
//    LaunchedEffect(Unit) {
//        menuViewModel.loadOrdiniCompletati()
//    }
//
//    val ui by menuViewModel.ordiniCompletatiUi.collectAsState()
//
//
//    Scaffold(
//        topBar = {
//            Surface(tonalElevation = 3.dp) {
//                Box(
//                    Modifier
//                        .fillMaxWidth()
//                        .height(56.dp)
//                        .padding(horizontal = 16.dp),
//                    contentAlignment = Alignment.CenterStart
//                ) {
//                    Text("Storico ordini", style = MaterialTheme.typography.titleLarge)
//                }
//            }
//        }
//    ) { padding ->
//        Box(
//            Modifier
//                .fillMaxSize()
//                .background(MaterialTheme.colorScheme.background)
//                .padding(padding)
//        ) {
//            when {
//                ui.loading -> {
//                    Column(
//                        Modifier.fillMaxSize(),
//                        verticalArrangement = Arrangement.Center,
//                        horizontalAlignment = Alignment.CenterHorizontally
//                    ) { CircularProgressIndicator() }
//                }
//
//                ui.items.isEmpty() -> {
//                    Column(
//                        Modifier.fillMaxSize().padding(16.dp),
//                        verticalArrangement = Arrangement.Center,
//                        horizontalAlignment = Alignment.CenterHorizontally
//                    ) { Text("Nessun ordine completato.") }
//                }
//
//
//                else -> {
//                    LazyColumn(
//                        modifier = Modifier.fillMaxSize(),
//                        contentPadding = PaddingValues(12.dp),
//                        verticalArrangement = Arrangement.spacedBy(12.dp)
//                    ) {
//                        items(ui.items) { row ->
//                            CompletedOrderRow(
//                                name = row.order.menu.name,
//                                shortDesc = row.order.menu.shortDescription,
//                                price = row.order.menu.price,
//                                status = row.order.status,
//                                base64Image = row.imageBase64
//                            )
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//
//@Composable
//private fun CompletedOrderRow(
//    name: String,
//    shortDesc: String,
//    price: Double,
//    status: String,
//    base64Image: String?
//){
//    Row(
//        Modifier
//            .fillMaxWidth()
//            .height(IntrinsicSize.Min)
//            .padding(8.dp)
//    ) {
//        // TESTO A SINISTRA
//        Column(
//            Modifier
//                .weight(1f)
//                .padding(end = 12.dp)
//        ) {
//            Text(name, style = MaterialTheme.typography.titleMedium, maxLines = 1)
//            Spacer(Modifier.height(4.dp))
//            Text(shortDesc, style = MaterialTheme.typography.bodyMedium, maxLines = 2)
//            Spacer(Modifier.height(8.dp))
//            Text("Prezzo: €$price", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.primary)
//            Text("Stato: $status", style = MaterialTheme.typography.bodySmall)
//        }
//
//        // IMMAGINE A DESTRA
//        val imgBitmap = remember(base64Image) {
//            base64Image?.let {
//                try {
//                    val bytes = Base64.decode(it, Base64.DEFAULT)
//                    BitmapFactory.decodeByteArray(bytes, 0, bytes.size)?.asImageBitmap()
//                } catch (_: Throwable) { null }
//            }
//        }
//        Box(
//            modifier = Modifier
//                .width(96.dp)
//                .fillMaxHeight(),
//            contentAlignment = Alignment.Center
//        ) {
//            if (imgBitmap != null) {
//                Image(
//                    bitmap = imgBitmap,
//                    contentDescription = name,
//                    contentScale = ContentScale.Crop,
//                    modifier = Modifier
//                        .fillMaxWidth()
//                        .aspectRatio(1f)
//                        .background(MaterialTheme.colorScheme.surfaceVariant)
//                )
//            } else {
//                // placeholder minimale
//                Surface(
//                    tonalElevation = 2.dp,
//                    modifier = Modifier
//                        .fillMaxWidth()
//                        .aspectRatio(1f)
//                ) { Box(Modifier.fillMaxSize()) }
//            }
//        }
//    }
//}



