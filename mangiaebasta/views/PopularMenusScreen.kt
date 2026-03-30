package com.example.mangiaebasta.views

import android.graphics.BitmapFactory
import android.util.Base64
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.example.mangiaebasta.viewmodels.MenuViewModel
import com.example.mangiaebasta.viewmodels.PopularMenuUi

@Composable
fun PopularMenusScreen(
    navController: NavController,
    menuViewModel: MenuViewModel
) {
    LaunchedEffect(Unit) { menuViewModel.loadPopularMenus() }

    val ui by menuViewModel.popularMenusUi.collectAsState()

    Scaffold(
        topBar = {
            Surface(tonalElevation = 3.dp) {
                Box(
                    Modifier
                        .fillMaxWidth()
                        .height(56.dp)
                        .padding(horizontal = 16.dp),
                    contentAlignment = Alignment.CenterStart
                ) { Text("Menu popolari", style = MaterialTheme.typography.titleLarge) }
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
                        Modifier
                            .fillMaxSize()
                            .padding(16.dp),
                        verticalArrangement = Arrangement.Center,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) { Text("Nessun menu popolare.") }
                }
                else -> {
                    LazyColumn(
                        modifier = Modifier.fillMaxSize(),
                        contentPadding = PaddingValues(12.dp),
                        verticalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        itemsIndexed(ui.items) { index, row ->
                            PopularMenuRowSimple(
                                rank = index + 1, // 1), 2), 3) ...
                                name = row.menu.name,
                                price = row.menu.price,
                                orderCount = row.menu.orderCount,
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
private fun PopularMenuRowSimple(
    rank: Int,
    name: String,
    price: Double,
    orderCount: Int,
    base64Image: String?
) {
    Row(
        Modifier
            .fillMaxWidth()
            .height(IntrinsicSize.Min)
            .padding(8.dp)
    ) {

        Box(
            modifier = Modifier
                .width(32.dp)
                .fillMaxHeight(),
            contentAlignment = Alignment.Center
        ) {
            Text("${rank})", style = MaterialTheme.typography.titleMedium)
        }

        Spacer(Modifier.width(8.dp))

        val imgBitmap = remember(base64Image) {
            base64Image?.let {
                try {
                    val clean = it.substringAfter("base64,", it)
                    val bytes = Base64.decode(clean, Base64.DEFAULT)
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
        ) {
            Text(name, style = MaterialTheme.typography.titleMedium, maxLines = 1)
            Spacer(Modifier.height(8.dp))
            Text("Prezzo: €$price", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.primary)
            Text("Ordini ultimo mese: $orderCount", style = MaterialTheme.typography.bodySmall)
        }
    }
}

