package com.example.mangiaebasta.views

import android.graphics.BitmapFactory
import android.util.Base64
import android.util.Log
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.example.mangiaebasta.models.MenuItemWithImage
import com.example.mangiaebasta.models.MenuMangione
import com.example.mangiaebasta.viewmodels.MenuViewModel
import com.example.mangiaebasta.viewmodels.RistorantiPlusUiState
import io.ktor.http.Url

@Composable
fun MenuMangioneScreen(
    navController: NavController,
    menuViewModel: MenuViewModel
){
    LaunchedEffect(Unit) {
        menuViewModel.loadInformazioniUtente()
        menuViewModel.loadMenuMangione()
    }

    val userUi by menuViewModel.informazioniUtenteUi.collectAsState()
    val menuUi by menuViewModel.menuMangioneUi.collectAsState()

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
        Column(
            Modifier
                .fillMaxSize()
                .background(MaterialTheme.colorScheme.background)
                .padding(padding)
        ) {
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(12.dp)
            ) {
                Column(Modifier.padding(16.dp)) {
                    when {
                        userUi.loading -> {
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                CircularProgressIndicator(modifier = Modifier.size(18.dp))
                                Spacer(Modifier.width(8.dp))
                                Text("Carico informazioni utente…")
                            }
                        }

                        userUi.data == null -> {
                            Text("Impossibile caricare le informazioni utente")
                        }

                        else -> {
                            val u = userUi.data!!

                            Text(
                                "${u.firstName} ${u.lastName}",
                                style = MaterialTheme.typography.titleMedium
                            )
                            Spacer(Modifier.height(4.dp))

                            val subActive = u.subscription

                            AssistChip(
                                onClick = {},
                                label = { Text(if (subActive) "Abbonamento attivo" else "Abbonamento non attivo") },
                            )
                            Spacer(Modifier.height(12.dp))

                            Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {

                                Button(
                                    onClick = {menuViewModel.attivaIscrizine()},
                                    enabled = !subActive
                                ) {
                                    Text("Attiva")
                                }

                                OutlinedButton(
                                    onClick = { menuViewModel.disattivaIscrizione() },
                                    enabled = subActive
                                ) { Text("Disattiva") }
                            }
                        }
                    }
                }
            }

            when {
                menuUi.loading -> {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        CircularProgressIndicator(modifier = Modifier.size(18.dp))
                        Spacer(Modifier.width(8.dp))
                        Text("Carico menu vicino a me")
                    }
                }

                menuUi.items.isEmpty() -> {
                    Text("Impossibile trovare menu vicino a me")
                }

                else -> {
                    val subAction = userUi.data?.subscription == true


                    LazyColumn(
                        modifier = Modifier.fillMaxSize(),
                        contentPadding = PaddingValues(12.dp),
                        verticalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        items(menuUi.items, key = { it.menu.mid }) { row ->
                            val m = row.menu
                            MangioneMenuRow(
                                name = m.name,
                                shortDesc = m.shortDescription,
                                price = m.price,
                                discount = m.discount ?: 0,
                                missedDiscount = m.missedDiscount ?: 0,
                                showDiscount = subAction,
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
private fun MangioneMenuRow(
    name: String,
    shortDesc: String,
    price: Double,
    discount: Int,
    missedDiscount: Int,
    showDiscount: Boolean,
    base64Image: String?
) {
    Row(
        Modifier
            .fillMaxWidth()
            .height(IntrinsicSize.Min)
            .padding(8.dp)
    ) {
        val imgBitmap = remember(base64Image) {
            base64Image?.let {
                try {
                    val bytes = Base64.decode(it, Base64.DEFAULT)
                    BitmapFactory.decodeByteArray(bytes, 0, bytes.size)?.asImageBitmap()
                } catch (_: Throwable) {
                    null
                }
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

        Spacer(Modifier.width(12.dp))

        Column(
            Modifier
                .weight(1f)
                .padding(end = 4.dp)
        ) {
            Text(
                name,
                style = MaterialTheme.typography.titleMedium,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
            Spacer(Modifier.height(4.dp))
            Text(
                shortDesc,
                style = MaterialTheme.typography.bodyMedium,
                maxLines = 2,
                overflow = TextOverflow.Ellipsis
            )
            Spacer(Modifier.height(8.dp))
            Text(
                "Prezzo: €$price",
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.primary
            )

            Spacer(Modifier.height(6.dp))
            if (showDiscount && discount > 0) {
                AssistChip(onClick = {}, label = { Text("Sconto: $discount%") })
            } else if (!showDiscount && missedDiscount > 0) {
                AssistChip(onClick = {}, label = { Text("Sconto perso: $missedDiscount%") })
            }
        }
    }
}




