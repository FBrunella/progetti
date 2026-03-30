package com.example.mangiaebasta.viewmodels

import android.util.Base64
import android.util.Log
import android.view.MenuItem
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.mangiaebasta.models.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

data class IngredientsUiState(
    val loading: Boolean = false,
    val items: List<Ingredienti> = emptyList(),
    val mostraSoloBio: Boolean = false
)

data class OrdiniCompletatiUi(
    val order: Ordini,
    val imageBase64: String?
)

data class OrdiniCompletatiUiState(
    val loading: Boolean = false,
    val items: List<OrdiniCompletatiUi> = emptyList()
)

data class RistorantiPlusUiState(
    val loading: Boolean = false,
    val items: List<RistorantiPlus> = emptyList()
)

data class InformazioniUtenteUiState(
    val loading: Boolean = false,
    val data: InformazioniUtente ?= null
)

data class MenuMangioneUi(
    val menu: MenuMangione,
    val imageBase64: String?
)

data class MenuMangioneUiState(
    val loading: Boolean = false,
    val items: List<MenuMangioneUi> = emptyList()
)

data class PopularMenuUi(
    val menu: PopularMenu,
    val imageBase64: String?
)

data class PopularMenuUiState(
    val loading: Boolean = false,
    val items: List<PopularMenuUi> = emptyList()
)

class MenuViewModel : ViewModel() {
    private val menuModel = MenuModel()
    private val orderModel = OrderModel()

    // --- LISTA MENU ---------------------------------------------------------------------------
    private val _menus = MutableStateFlow<List<MenuItemWithImage>>(emptyList())
    val menusUi: StateFlow<List<MenuItemWithImage>> = _menus

    // --- DETTAGLIO ----------------------------------------------------------------------------
    private val _selectedMenu = MutableStateFlow<DetailedMenuItemWithImage?>(null)
    val selectedMenu: StateFlow<DetailedMenuItemWithImage?> = _selectedMenu

    // --- STATO CARICAMENTO --------------------------------------------------------------------
    private val _isLoading = MutableStateFlow(false) // Cambiato da true a false
    val isLoading: StateFlow<Boolean> = _isLoading

    private val _ingredienti = MutableStateFlow(IngredientsUiState())
    val ingredientiUi: StateFlow<IngredientsUiState> = _ingredienti

    private val _ordini = MutableStateFlow(OrdiniCompletatiUiState())
    val ordiniCompletatiUi: StateFlow<OrdiniCompletatiUiState> = _ordini

    private val _plus = MutableStateFlow(RistorantiPlusUiState())
    val ristorantiPlusUi: StateFlow<RistorantiPlusUiState> = _plus

    private val _user = MutableStateFlow(InformazioniUtenteUiState())
    val informazioniUtenteUi: StateFlow<InformazioniUtenteUiState> = _user

    private val _mangione = MutableStateFlow(MenuMangioneUiState())
    val menuMangioneUi: StateFlow<MenuMangioneUiState> = _mangione

    private val _popular = MutableStateFlow(PopularMenuUiState())
    val popularMenusUi: StateFlow<PopularMenuUiState> = _popular


    /** Carica la lista dei menu */
    fun loadMenus() = viewModelScope.launch {
        _isLoading.value = true
        try {

            val menus = menuModel.getEvaluation()
            val withImages = menus.map { m ->
                val img = runCatching { menuModel.getMenuImage(m.mid, m.imageVersion) }.getOrNull()
                MenuItemWithImage(
                    mid = m.mid,
                    name = m.name,
                    price = m.price,
                    location = m.location,
                    imageVersion = m.imageVersion,
                    shortDescription = m.shortDescription,
                    deliveryTime = m.deliveryTime,
                    image = img,
                    evaluation = m.evaluation
                )
            }
            _menus.value = withImages
        } catch (_: Exception) {
            _menus.value = emptyList()
        } finally {
            _isLoading.value = false
        }

    }

    /** Carica i dettagli di un singolo menu */
    fun loadMenu(id: Int) = viewModelScope.launch {
        _selectedMenu.value = null
        _isLoading.value = true
        try {
            _selectedMenu.value = menuModel.getMenuDetails(id)
        } catch (_: Exception) {
            _selectedMenu.value = null
        } finally {
            _isLoading.value = false
        }
    }

    /** Effettua l'ordine e restituisce un eventuale messaggio d'errore */
    suspend fun orderMenu(menuId: Int): String? {
        _isLoading.value = true
        return try {
            orderModel.order(menuId)
            orderModel.saveLastOrder(_selectedMenu.value)
            null                                        // Successo
        } catch (e: Exception) {
            // Trasforma "API Error: …" in messaggio user-friendly
            e.message?.replace("API Error: ", "")
                ?: "Si è verificato un errore sconosciuto"
        } finally {
            _isLoading.value = false
        }
    }

    fun loadIngredienti(menuId: Int) = viewModelScope.launch {
        _ingredienti.value = _ingredienti.value.copy(loading = true)
        try {
            val list = menuModel.getMenuIngredienti(menuId)
            Log.d("ingredienti", "Menu $menuId ha ${list.size} ingredienit")
            _ingredienti.value = _ingredienti.value.copy(
                loading = false,
                items = list
            )
        }catch (e: Exception){
            _ingredienti.value = _ingredienti.value.copy(
                loading = false,
                items = emptyList()
            )
        }
    }

    fun toogleOnlyBio(){
        _ingredienti.value = _ingredienti.value.copy(
            mostraSoloBio = !_ingredienti.value.mostraSoloBio
        )
    }

    fun loadOrdiniCompletati() = viewModelScope.launch {
        _ordini.value = _ordini.value.copy(loading = true)

        try {
            val order = orderModel.getOrdiniCompletati()

            val withImage = order.map { o ->
                val img = runCatching {
                    menuModel.getMenuImage(o.menu.mid, o.menu.imageVersion)
                }.getOrNull()

                OrdiniCompletatiUi(order = o, imageBase64 = img)
            }

            _ordini.value = _ordini.value.copy(
                loading = false,
                items = withImage
            )
        }catch (e: Exception){
            _ordini.value = _ordini.value.copy(
                loading = false,
                items = emptyList()
            )
        }
    }

    fun loadRistorantiPlus() = viewModelScope.launch {
        _plus.value = _plus.value.copy(loading = true)

        try {
            val plus = menuModel.getRistorantiPlus()

            _plus.value = _plus.value.copy(
                loading = false,
                items = plus
            )

        }catch (e: Exception){
            _plus.value = _plus.value.copy(
                loading = false,
                items = emptyList()
            )
        }
    }

    fun loadInformazioniUtente() = viewModelScope.launch {
        _user.value = _user.value.copy(loading = true)


        try {
            val user = menuModel.getInformazioniUtente()

            _user.value = _user.value.copy(
                loading = false,
                data = user
            )
        }catch (e: Exception){
            _user.value = _user.value.copy(
                loading = false,
                data = null
            )
        }

    }

    fun loadMenuMangione() = viewModelScope.launch {
        _mangione.value = _mangione.value.copy(loading = true)

        try {
            val menu = menuModel.getMenuMangione()

            val withImage =  menu.map { m ->
                val img = runCatching {
                    menuModel.getMenuImage(m.mid, m.imageVersion)
                }.getOrNull()

                MenuMangioneUi(menu = m, imageBase64 = img)
            }

            _mangione.value = _mangione.value.copy(
                loading = false,
                items = withImage
            )
        }catch (e: Exception){
            _mangione.value = _mangione.value.copy(
                loading = false,
                items = emptyList()
            )
        }
    }

    fun attivaIscrizine() = viewModelScope.launch {
        val ok = runCatching { menuModel.attivaIscrizione() }.getOrElse { false }
        loadInformazioniUtente()
        loadMenuMangione()
    }

    fun disattivaIscrizione() = viewModelScope.launch {
        val ok = runCatching { menuModel.disattivaIscrizione() }.getOrElse { false }
        loadInformazioniUtente()
        loadMenuMangione()
    }


    fun loadPopularMenus() = viewModelScope.launch {
        _popular.value = _popular.value.copy(loading = true)
        try {
            val list = menuModel.getPopularMenus()
                // opzionale: se vuoi forzare l’ordinamento decrescente
            .sortedByDescending { it.orderCount }

            val withImages = list.map { m ->
                val img = runCatching { menuModel.getMenuImage(m.mid, m.imageVersion) }.getOrNull()
                PopularMenuUi(menu = m, imageBase64 = img)
            }
            _popular.value = PopularMenuUiState(
                loading = false,
                items = withImages
            )

        } catch (e: Exception) {
            _popular.value = PopularMenuUiState(loading = false, items = emptyList())
        }
    }

}