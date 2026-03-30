package com.example.mangiaebasta.views

import android.graphics.BitmapFactory
import android.util.Base64
import android.util.Log
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
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.NavHostController
import com.example.mangiaebasta.models.DetailedMenuItemWithImage
import com.example.mangiaebasta.models.RistorantiPlus
import com.example.mangiaebasta.viewmodels.MenuViewModel
import kotlinx.coroutines.launch

@Composable
fun RistorantiPlusScreen(
    navController: NavController,
    menuViewModel: MenuViewModel
){
    LaunchedEffect(Unit) {
        menuViewModel.loadRistorantiPlus()
    }

   val ui by menuViewModel.ristorantiPlusUi.collectAsState()


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
                    Text("Ristoranti Plus", style = MaterialTheme.typography.titleLarge)
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
                    ) { Text("Nessun ristorante plus.") }
                }


                else -> {
                    LazyColumn(
                        modifier = Modifier.fillMaxSize(),
                        contentPadding = PaddingValues(12.dp),
                        verticalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        items(ui.items) { r ->
                            RistorantiPlusRow(r)
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun rememberBase64Image(base64: String?): androidx.compose.ui.graphics.ImageBitmap? {
    return remember(base64) {
        try {
            val clean = base64?.substringAfter(',', base64 ?: "")
            if (clean.isNullOrBlank()) return@remember null
            val bytes = Base64.decode(clean, Base64.DEFAULT)
            BitmapFactory.decodeByteArray(bytes, 0, bytes.size)?.asImageBitmap()
        } catch (_: Throwable) { null }
    }
}

@Composable
private fun RistorantiPlusRow( r: RistorantiPlus) {

    Column(
        Modifier
            .fillMaxWidth()
            .padding(8.dp)
    ) {
        Text(
            r.name,
            style = MaterialTheme.typography.titleMedium,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis
        )

        Spacer(Modifier.height(4.dp))

        Text(
            r.slogan,
            style = MaterialTheme.typography.bodyMedium,
            maxLines = 2,
            overflow = TextOverflow.Ellipsis
        )

        Spacer(Modifier.height(8.dp))

        val img = rememberBase64Image(r.base64)
        if (img != null) {
            Image(
                bitmap = img,
                contentDescription = r.name,
                contentScale = ContentScale.Crop,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(180.dp)
            )
        } else {
            Surface(
                tonalElevation = 2.dp,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(180.dp)
            ) { Box(Modifier.fillMaxSize()) }
        }

        Spacer(Modifier.height(12.dp))

        Button(
            onClick = {
                val lat = r.location.lat
                val lng = r.location.lng

                Log.d("ristorantiPlus", "Il ristorante numero: ${r.rid}, ha posizione: Latitudine = $lat e Longitudine = $lng")
            }
        ) {
            Text("Dettagli")
        }

    }
}
