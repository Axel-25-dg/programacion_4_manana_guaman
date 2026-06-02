# 📱 INFORME: Arquitectura y Funcionalidades de ShopApplication

## 📋 Tabla de Contenidos
1. [Arquitectura General](#arquitectura-general)
2. [Módulos Principales](#módulos-principales)
3. [Flujo de Autenticación](#03-login-y-registro)
4. [Sistema de Navegación](#04-navegación)
5. [Gestión de Carrito](#05-carrito)
6. [Gestión de Órdenes](#06-órdenes)
7. [Panel de Administración](#07-administración)
8. [CRUDs Administrativos](#cruds-administrativos)
9. [Subida de Imágenes](#12-subir-imágenes)
10. [Integración en Proyecto de Idiomas](#integración-en-tu-proyecto)

---

## 🏗️ Arquitectura General

### Stack Tecnológico
```
┌─────────────────────────────────────────┐
│        Jetpack Compose (UI)             │
├─────────────────────────────────────────┤
│   MVVM + Repository Pattern + Flows     │
├─────────────────────────────────────────┤
│  Hilt (Inyección de Dependencias)       │
├─────────────────────────────────────────┤
│  Coroutines + StateFlow (Reactividad)   │
├─────────────────────────────────────────┤
│  Room (Base de datos local)             │
│  Retrofit (API REST)                    │
├─────────────────────────────────────────┤
│      Backend REST API (Django)          │
└─────────────────────────────────────────┘
```

### Estructura de Carpetas
```
ShopAplication/
├── data/                    # Capa de datos
│   ├── local/              # Base de datos Room
│   ├── remote/             # API REST (Retrofit)
│   ├── repository/         # Implementaciones repositorios
│   └── dto/                # Transfer Objects
├── domain/                  # Lógica empresarial
│   ├── model/              # Modelos de datos
│   └── repository/         # Interfaces repositorios
├── presentation/           # UI (Jetpack Compose)
│   ├── navigation/         # Rutas y NavGraph
│   ├── ui/
│   │   ├── auth/          # Login y Registro
│   │   ├── admin/         # Panel administrativo
│   │   ├── client/        # Interfaz cliente
│   │   └── uipublic/      # Catálogo público
│   ├── viewmodel/         # ViewModels MVVM
│   └── components/        # Componentes reutilizables
├── di/                     # Inyección de dependencias
└── theme/                  # Temas y estilos
```

### Patrón de Flujo de Datos
```
UI (Composables) 
    ↓ (Eventos: click, input)
ViewModel 
    ↓ (Llamadas a repository)
Repository 
    ↓ (Obtiene datos)
Data Layer (Local/Remote)
    ↑ (Return Response)
Repository 
    ↓ (Emite StateFlow)
ViewModel 
    ↓ (Actualizaciones de estado)
UI (Recomposición reactiva)
```

---

## 📦 Módulos Principales

### 1️⃣ **Modelos de Datos** (`domain/model/`)

#### **User.kt**
```kotlin
data class User(
    val id: Int,
    val username: String,
    val email: String,
    val firstName: String,
    val lastName: String,
    val isStaff: Boolean,      // ← Determina si es admin
    val isActive: Boolean,
    val dateJoined: String,
    val numOrders: Int,
)
```
**Uso:** Almacena información del usuario logueado.

#### **Product.kt**
```kotlin
data class Product(
    val id: Int,
    val name: String,
    val description: String,
    val price: Double,
    val priceWithTax: Double,
    val stock: Int,
    val inStock: Boolean,
    val imageUrl: String?,     // ← URL de imagen desde backend
    val categoryId: Int?,
    val categoryName: String?,
)
```
**Uso:** Representa un producto en el catálogo.

#### **Order.kt**
```kotlin
enum class OrderStatus(val value: String, val label: String) {
    PENDING("pending", "Pendiente"),
    CONFIRMED("confirmed", "Confirmado"),
    SHIPPED("shipped", "Enviado"),
    DELIVERED("delivered", "Entregado"),
    CANCELLED("cancelled", "Cancelado"),
}

data class Order(
    val id: Int,
    val username: String,
    val status: OrderStatus,
    val total: Double,
    val numItems: Int,
    val items: List<OrderItem>,
    val createdAt: String,
    val updatedAt: String,
)
```
**Uso:** Representa una orden de compra con su estado y artículos.

#### **Category.kt**
```kotlin
data class Category(
    val id: Int,
    val name: String,
    val description: String?,
)
```
**Uso:** Categoriza productos.

---

## 🔐 03. Login y Registro

### Flow de Autenticación
```
┌──────────────────┐
│  LoginScreen     │ ← Usuario ingresa credenciales
└────────┬─────────┘
         │ viewModel.login(username, password)
         ↓
┌──────────────────────────────────────────┐
│  AuthViewModel                           │
│  ├─ Llama: authRepository.login()        │
│  └─ Emite: _uiState (Loading→Success)    │
└────────┬─────────────────────────────────┘
         │ authRepository.login()
         ↓
┌──────────────────────────────────────────┐
│  AuthRepositoryImpl                       │
│  ├─ POST /api/auth/login/                │
│  ├─ Guarda token + usuario en DataStore  │
│  └─ Retorna User                         │
└────────┬─────────────────────────────────┘
         │
         ↓
┌──────────────────────────────────────────┐
│  NavGraph verifica:                      │
│  ├─ isAuthenticated: true                │
│  ├─ isStaff: true  → AdminDashboard      │
│  └─ isStaff: false → HomeScreen          │
└──────────────────────────────────────────┘
```

### Archivos Clave

**AuthViewModel.kt**
```kotlin
@HiltViewModel
class AuthViewModel @Inject constructor(
    private val authRepository: AuthRepository,
    private val tokenDataStore: TokenDataStore,
) : ViewModel() {
    
    val uiState: StateFlow<AuthUiState>        // Idle, Loading, Success, Error
    val currentUser: StateFlow<LoggedUser?>    // Usuario actual
    val isAuthenticated: StateFlow<Boolean>    // ¿Está logueado?
    val isStaff: StateFlow<Boolean>            // ¿Es administrador?
    
    fun login(username: String, password: String)
    fun register(userData: UserPayload)
    fun logout()
    private fun restoreSession()  // Al arrancar la app
}
```

**LoginScreen.kt** - Pasos:
1. Ingresa usuario/contraseña
2. Llama `viewModel.login(username, password)`
3. ViewModel emite `AuthUiState.Loading`
4. Backend retorna token + usuario
5. Se guarda en `TokenDataStore` (encriptado)
6. UI reacciona: navega a Home o AdminDashboard según `isStaff`

**RegisterScreen.kt** - Pasos:
1. Ingresa datos (email, nombre, contraseña)
2. Validaciones locales
3. Llama `viewModel.register(UserPayload)`
4. Backend crea usuario
5. Token se guarda automáticamente

**Persistencia de Sesión:**
```kotlin
// Al arrancar la app:
restoreSession() {
    val snapshot = authRepository.getStoredUser()
    if (snapshot != null && authRepository.isLoggedIn()) {
        _currentUser.value = LoggedUser(...)
    }
}
// Si hay sesión válida → No pide login
```

---

## 🗺️ 04. Navegación

### NavGraph.kt - Sistema de Rutas
```kotlin
sealed class Screen(val route: String) {
    data object Login              : Screen("login")
    data object Register           : Screen("register")
    data object Home               : Screen("home")
    data object Catalog            : Screen("catalog")
    data object ProductDetail      : Screen("product/{productId}")
    data object Orders             : Screen("orders")
    data object OrderDetail        : Screen("order/{orderId}")
    data object Profile            : Screen("profile")
    data object AdminDashboard     : Screen("admin/dashboard")
    data object AdminCategories    : Screen("admin/categories")
    data object AdminProducts      : Screen("admin/products")
    data object AdminOrders        : Screen("admin/orders")
    data object AdminUsers         : Screen("admin/users")
}
```

### Control de Acceso por Rol
```kotlin
// Al arrancar: verifica estado de autenticación
val startDestination = when {
    !isAuthenticated → Screen.Login.route
    isStaff          → Screen.AdminDashboard.route    // Admin ve panel
    else             → Screen.Home.route              // Usuario normal
}
```

### BottomNavBar - Navegación Inferior
```kotlin
// Solo se muestra en rutas públicas (Home, Catalog, Orders, Profile)
if (showBottomBar) {
    BottomNavBar(
        navController = navController,
        cartCount = cartCount,              // Muestra número de items en carrito
        onCartClick = { showCart = true },  // Abre modal del carrito
    )
}
```

### Navegación Programática
```kotlin
// Navegar:
navController.navigate(Screen.ProductDetail.route.replace("{productId}", "123"))

// Con pop back:
navController.navigate("home") {
    popUpTo("login") { inclusive = true }
}
```

---

## 🛒 05. Carrito

### CartViewModel - Gestión del Carrito

**Estructura:**
```kotlin
data class CartItem(
    val product: Product,
    val quantity: Int,
)

sealed interface CheckoutState {
    data object Idle
    data object Loading
    data class Success(val orderId: Int)
    data class Error(val message: String)
}

@HiltViewModel
class CartViewModel @Inject constructor(
    private val orderRepository: OrderRepository,
) : ViewModel() {
    private val _items = MutableStateFlow<List<CartItem>>(emptyList())
    val items: StateFlow<List<CartItem>>
    
    val totalItems: StateFlow<Int>      // Suma de cantidades
    val subtotal: StateFlow<Double>     // Sin impuesto
    val totalWithTax: StateFlow<Double> // Con impuesto
    
    val checkoutState: StateFlow<CheckoutState>
}
```

**Operaciones:**
```kotlin
// Añadir producto
fun addItem(product: Product, quantity: Int = 1) {
    // Si ya existe: incrementa cantidad
    // Si no existe: añade nuevo CartItem
    // Validación: no excede stock
}

// Actualizar cantidad
fun updateQuantity(productId: Int, quantity: Int)

// Eliminar producto
fun removeItem(productId: Int)

// Vaciar carrito
fun clearCart()

// Checkout (crear orden)
fun checkout(orderRepository): Result<Order>
```

### CartBottomSheet - UI del Carrito

**Pasos:**
1. Usuario hace click en ícono carrito (mostrado en BottomBar)
2. Se abre BottomSheet con:
   - Lista de items con cantidad y precio
   - Botones ±/Eliminar para cada item
   - Resumen: Subtotal, Impuesto, Total
   - Botón "Proceder al checkout"
3. Si NO está autenticado → Redirige a Login
4. Si está autenticado:
   - Envía orden al backend
   - `checkoutState` cambia a `Loading`
   - Backend crea Order
   - UI muestra éxito o error
   - Carrito se vacía

---

## 📦 06. Órdenes

### Flujo de Órdenes del Cliente

**OrdersScreen.kt**
```kotlin
// Muestra todas las órdenes del usuario logueado
// Estados visibles: Pendiente, Confirmado, Enviado, Entregado, Cancelado
// Click en orden → OrderDetailScreen
```

**OrderDetailScreen.kt**
```kotlin
// Detalle de una orden:
// - ID, fecha, estado
// - Lista de items: producto, cantidad, precio unitario
// - Total
// - Botones (según estado): Cancelar orden, etc.
```

**ViewModel:**
```kotlin
@HiltViewModel
class OrdersClientViewModel @Inject constructor(
    private val orderRepository: OrderRepository,
) : ViewModel() {
    
    val orders: StateFlow<List<Order>>
    val isLoading: StateFlow<Boolean>
    
    fun loadOrders()
    fun getOrderDetail(orderId: Int): StateFlow<Order>
    fun cancelOrder(orderId: Int)
}
```

---

## ⚙️ 07. Administración

### DashboardScreen - Panel Principal Admin

**Componentes:**
```kotlin
// KPI Cards - Métricas principales:
KpiCard(
    title = "Ventas Hoy",
    value = "$1,250",
    icon = ShoppingCart,
)
KpiCard(
    title = "Órdenes Pendientes",
    value = "12",
    icon = Clock,
)
KpiCard(
    title = "Usuarios Activos",
    value = "456",
    icon = Users,
)
KpiCard(
    title = "Stock Bajo",
    value = "3",
    icon = AlertCircle,
)
```

**Acceso:** Solo `isStaff = true`

**DashboardViewModel:**
```kotlin
@HiltViewModel
class DashboardViewModel @Inject constructor(
    private val orderRepository: OrderRepository,
    private val userRepository: UserRepository,
    // etc...
) : ViewModel() {
    
    val totalSales: StateFlow<Double>
    val pendingOrders: StateFlow<Int>
    val activeUsers: StateFlow<Int>
    val lowStockProducts: StateFlow<Int>
}
```

---

## 📊 CRUDs Administrativos

### 08. CRUD Categorías

**Estructura:**
```
CategoriesAdminScreen
├─ Tabla/Lista categorías
├─ Búsqueda
├─ Botón "Nuevo"
├─ Botones Editar/Eliminar por fila
└─ Modal: CategoryFormSheet

CategoryFormSheet
├─ Campo nombre
├─ Campo descripción
├─ Botones: Guardar/Cancelar
└─ Validaciones
```

**ViewModel:**
```kotlin
@HiltViewModel
class CategoriesAdminViewModel @Inject constructor(
    private val repository: CategoryRepository,
) : ViewModel() {
    
    val categories: StateFlow<List<Category>>
    val isLoading: StateFlow<Boolean>
    val formState: StateFlow<FormState>
    
    fun loadCategories()
    fun createCategory(name: String, description: String)
    fun updateCategory(id: Int, name: String, description: String)
    fun deleteCategory(id: Int)
}
```

**Operaciones:**
```
CREATE:  POST   /api/admin/categories/
READ:    GET    /api/admin/categories/
UPDATE:  PUT    /api/admin/categories/{id}/
DELETE:  DELETE /api/admin/categories/{id}/
```

---

### 09. CRUD Productos

**Características:**
```
ProductsAdminScreen
├─ Campo búsqueda (by nombre)
├─ Filtros:
│  ├─ Con stock / Sin stock
│  ├─ Activos / Inactivos
│  └─ Por categoría
├─ Tabla con datos:
│  ├─ Nombre
│  ├─ Precio
│  ├─ Stock
│  ├─ Estado
│  └─ Acciones (Editar, Eliminar, Reabastecimiento)
├─ Botón "Nuevo Producto"
└─ Modales:
   ├─ ProductFormSheet (Crear/Editar)
   └─ RestockDialog (Aumentar stock)
```

**ViewModel:**
```kotlin
enum class ProductStockFilter {
    ALL, IN_STOCK, OUT_OF_STOCK, ACTIVE, INACTIVE
}

@HiltViewModel
class ProductsAdminViewModel @Inject constructor(
    private val repository: ProductRepository,
    private val categoryRepository: CategoryRepository,
) : ViewModel() {
    
    val state: StateFlow<ProductsAdminUiState>
    val categories: StateFlow<List<Category>>
    
    // Filtrado combinado (búsqueda + filtro de stock)
    val filtered: StateFlow<List<Product>>
    
    fun search(query: String)
    fun applyStockFilter(filter: ProductStockFilter)
    fun createProduct(payload: ProductPayload)
    fun updateProduct(id: Int, payload: ProductPayload)
    fun deleteProduct(id: Int)
    fun restockProduct(id: Int, newStock: Int)
}
```

**ProductFormSheet:**
```kotlin
// Campos:
TextField(label = "Nombre", value = product.name)
TextField(label = "Descripción", value = product.description)
TextField(label = "Precio", value = product.price, keyboardType = Decimal)
TextField(label = "Stock", value = product.stock, keyboardType = Number)
Dropdown(label = "Categoría", options = categories)
Switch(label = "Activo", value = product.isActive)
```

**Operaciones:**
```
CREATE:  POST   /api/admin/products/
READ:    GET    /api/admin/products/?search=...&stock_filter=...&category=...
UPDATE:  PUT    /api/admin/products/{id}/
DELETE:  DELETE /api/admin/products/{id}/
RESTOCK: PATCH  /api/admin/products/{id}/restock/ { "stock": 100 }
```

---

### 10. CRUD Pedidos (Órdenes)

**Características:**
```
OrdersAdminScreen
├─ Tabla de órdenes:
│  ├─ ID
│  ├─ Cliente
│  ├─ Estado (dropdown editable)
│  ├─ Total
│  ├─ Fecha
│  └─ Botón "Ver detalle"
├─ Filtros por estado
└─ Click fila → OrderAdminDetailScreen

OrderAdminDetailScreen
├─ Info orden (ID, fecha, cliente)
├─ Tabla de items (producto, qty, precio)
├─ Total
└─ Dropdown para cambiar estado
```

**ViewModel:**
```kotlin
@HiltViewModel
class OrdersAdminViewModel @Inject constructor(
    private val repository: OrderRepository,
) : ViewModel() {
    
    val orders: StateFlow<List<Order>>
    val isLoading: StateFlow<Boolean>
    
    fun loadOrders()
    fun updateOrderStatus(orderId: Int, newStatus: OrderStatus)
    fun getOrderDetail(orderId: Int): StateFlow<Order>
}
```

**Operaciones:**
```
READ:   GET    /api/admin/orders/
UPDATE: PATCH  /api/admin/orders/{id}/ { "status": "shipped" }
DETAIL: GET    /api/admin/orders/{id}/
```

---

### 11. CRUD Usuarios

**Características:**
```
UsersAdminScreen
├─ Tabla usuarios:
│  ├─ ID
│  ├─ Nombre
│  ├─ Email
│  ├─ Rol (Staff: Sí/No)
│  ├─ Estado (Activo/Inactivo)
│  ├─ Órdenes
│  └─ Acciones (Editar, Eliminar)
├─ Búsqueda
├─ Botón "Nuevo Usuario"
└─ Modal: UserFormSheet

UserFormSheet
├─ Campos:
│  ├─ Nombre de usuario
│  ├─ Email
│  ├─ Nombre
│  ├─ Apellido
│  ├─ Contraseña (solo al crear)
│  ├─ Switch: ¿Es Staff?
│  └─ Switch: ¿Activo?
└─ Botones: Guardar/Cancelar
```

**ViewModel:**
```kotlin
@HiltViewModel
class UsersAdminViewModel @Inject constructor(
    private val repository: UserRepository,
) : ViewModel() {
    
    val users: StateFlow<List<User>>
    val isLoading: StateFlow<Boolean>
    
    fun loadUsers()
    fun createUser(payload: UserPayload)
    fun updateUser(id: Int, payload: UserPayload)
    fun deleteUser(id: Int)
    fun toggleStaffRole(userId: Int, isStaff: Boolean)
    fun toggleActive(userId: Int, isActive: Boolean)
}
```

**Operaciones:**
```
CREATE: POST   /api/admin/users/
READ:   GET    /api/admin/users/
UPDATE: PUT    /api/admin/users/{id}/
DELETE: DELETE /api/admin/users/{id}/
```

---

## 📸 12. Subida de Imágenes

### Arquitectura Multipart/Form-Data

**Backend (Django):**
```python
# Endpoint para subir imagen
POST /api/upload/product-image/
Content-Type: multipart/form-data

Body:
- file: <binary image>
- productId: 123

Response:
{
    "url": "https://api.example.com/media/products/img_123.jpg",
    "productId": 123
}
```

**Frontend (Android):**

**ImageUploadViewModel:**
```kotlin
@HiltViewModel
class ImageUploadViewModel @Inject constructor(
    private val uploadRepository: UploadRepository,
) : ViewModel() {
    
    private val _uploadState = MutableStateFlow<UploadState>(UploadState.Idle)
    val uploadState: StateFlow<UploadState> = _uploadState.asStateFlow()
    
    fun uploadImage(uri: Uri, productId: Int) {
        viewModelScope.launch {
            _uploadState.value = UploadState.Loading
            try {
                val imageUrl = uploadRepository.uploadProductImage(uri, productId)
                _uploadState.value = UploadState.Success(imageUrl)
            } catch (e: Exception) {
                _uploadState.value = UploadState.Error(e.message ?: "Error")
            }
        }
    }
}
```

**UI - Image Picker:**
```kotlin
// Opción 1: Usar composable para galería
var selectedImageUri by remember { mutableStateOf<Uri?>(null) }

val pickImage = rememberLauncherForActivityResult(
    contract = ActivityResultContracts.GetContent()
) { uri ->
    if (uri != null) {
        selectedImageUri = uri
        uploadViewModel.uploadImage(uri, productId)
    }
}

Button(onClick = { pickImage.launch("image/*") }) {
    Text("Seleccionar imagen")
}

// Mostrar preview
if (selectedImageUri != null) {
    Image(
        painter = rememberAsyncImagePainter(selectedImageUri),
        contentDescription = "Preview",
        modifier = Modifier.size(200.dp),
        contentScale = ContentScale.Crop,
    )
}

// Estado de carga
when (val state = uploadState.collectAsState().value) {
    is UploadState.Loading -> CircularProgressIndicator()
    is UploadState.Success -> {
        Text("Imagen subida: ${state.url}")
        // Actualizar producto con URL
    }
    is UploadState.Error -> Text("Error: ${state.message}")
    else -> {}
}
```

**Repository:**
```kotlin
class UploadRepositoryImpl @Inject constructor(
    private val apiService: ApiService,
) : UploadRepository {
    
    override suspend fun uploadProductImage(uri: Uri, productId: Int): String {
        val file = File(uri.path)
        val requestBody = file.asRequestBody("image/*".toMediaType())
        val body = MultipartBody.Part.createFormData("file", file.name, requestBody)
        
        val response = apiService.uploadProductImage(body, productId)
        return response.url
    }
}
```

**Retrofit Service:**
```kotlin
interface ApiService {
    @Multipart
    @POST("/api/upload/product-image/")
    suspend fun uploadProductImage(
        @Part file: MultipartBody.Part,
        @Query("productId") productId: Int,
    ): ImageUploadResponse
}

data class ImageUploadResponse(
    val url: String,
    val productId: Int,
)
```

---

## 🔄 Integración en tu Proyecto de Idiomas

### Estrategia de Adaptación

#### 1️⃣ **Copiar la Estructura Base**
```
TuProyectoIdiomas/
├── data/              # (copiar estructura)
├── domain/            # (copiar estructura)
└── presentation/      # (copiar estructura)
```

#### 2️⃣ **Adaptar Modelos de Datos**

**De:** `Product.kt`
**Para:** `Language.kt` / `Course.kt` / `Lesson.kt`

```kotlin
// Ejemplo: Cursos de Idiomas
data class LanguageCourse(
    val id: Int,
    val title: String,                    // "Spanish Basics"
    val description: String,
    val language: String,                 // "Spanish", "French", etc
    val level: String,                    // "Beginner", "Intermediate", "Advanced"
    val price: Double,
    val priceWithTax: Double,
    val lessons: Int,                     // Cantidad de lecciones
    val duration: String,                 // "4 weeks"
    val imageUrl: String?,
    val categoryId: Int?,                 // Categoría (idioma)
    val instructor: String,
    val isActive: Boolean,
    val createdAt: String,
)

data class Lesson(
    val id: Int,
    val courseId: Int,
    val title: String,
    val content: String,
    val videoUrl: String?,
    val order: Int,
    val duration: Int,                    // en minutos
)
```

#### 3️⃣ **Adaptar ViewModels**

**De:** `ProductsAdminViewModel.kt`
**Para:** `CoursesAdminViewModel.kt`

```kotlin
enum class CourseFilter {
    ALL, SPANISH, FRENCH, GERMAN, PORTUGUESE
}

@HiltViewModel
class CoursesAdminViewModel @Inject constructor(
    private val courseRepository: CourseRepository,
    private val languageRepository: LanguageRepository,
) : ViewModel() {
    
    private val _state = MutableStateFlow(CoursesAdminUiState())
    val state: StateFlow<CoursesAdminUiState> = _state.asStateFlow()
    
    // Filtrado por idioma + búsqueda
    val filtered: StateFlow<List<LanguageCourse>> = _state
        .map { s ->
            s.courses
                .filter { c -> 
                    s.search.isBlank() || c.title.contains(s.search, ignoreCase = true)
                }
                .filter { c ->
                    s.languageFilter == null || c.language == s.languageFilter
                }
        }
        .stateIn(viewModelScope, SharingStarted.Eagerly, emptyList())
    
    fun createCourse(courseData: CoursePayload)
    fun updateCourse(id: Int, courseData: CoursePayload)
    fun deleteCourse(id: Int)
    fun addLesson(courseId: Int, lessonData: LessonPayload)
}
```

#### 4️⃣ **Adaptar Interfaces de Usuario**

**De:** `ProductsAdminScreen.kt`
**Para:** `CoursesAdminScreen.kt`

```kotlin
@Composable
fun CoursesAdminScreen(
    viewModel: CoursesAdminViewModel = hiltViewModel(),
) {
    val state by viewModel.state.collectAsState()
    val filtered by viewModel.filtered.collectAsState()
    val languages by viewModel.languages.collectAsState()
    
    // Tabla de cursos
    LazyColumn {
        items(filtered) { course ->
            CourseRow(
                course = course,
                onEdit = { /* Abre modal */ },
                onDelete = { viewModel.deleteCourse(course.id) },
                onAddLesson = { /* Abre modal */ },
            )
        }
    }
}

@Composable
fun CourseFormSheet(
    onSave: (CoursePayload) -> Unit,
    onDismiss: () -> Unit,
) {
    // Campos:
    // - Título
    // - Descripción
    // - Dropdown idioma
    // - Nivel (Beginner/Intermediate/Advanced)
    // - Precio
    // - Imagen
    // - Duración
    // - Instructor
}
```

#### 5️⃣ **Adaptar Carrito → Carrito de Cursos**

**De:** `CartViewModel.kt`
**Para:** `CourseCartViewModel.kt`

```kotlin
data class CourseCartItem(
    val course: LanguageCourse,
    val quantity: Int = 1,  // Normalmente siempre 1 para cursos
    val purchaseDate: String,
)

@HiltViewModel
class CourseCartViewModel @Inject constructor(
    private val orderRepository: OrderRepository,  // Reutilizar
    private val enrollmentRepository: EnrollmentRepository,
) : ViewModel() {
    
    private val _items = MutableStateFlow<List<CourseCartItem>>(emptyList())
    val items: StateFlow<List<CourseCartItem>> = _items.asStateFlow()
    
    val totalPrice: StateFlow<Double> = _items
        .map { it.sumOf { item -> item.course.priceWithTax } }
        .stateIn(viewModelScope, SharingStarted.Eagerly, 0.0)
    
    fun addCourseToCart(course: LanguageCourse)
    fun removeCourseFromCart(courseId: Int)
    fun checkout(): Result<Enrollment>  // Crear inscripción
}
```

#### 6️⃣ **Adaptar Órdenes → Inscripciones**

**De:** `Order.kt`
**Para:** `Enrollment.kt`

```kotlin
enum class EnrollmentStatus {
    ACTIVE, COMPLETED, CANCELLED, PAUSED
}

data class Enrollment(
    val id: Int,
    val userId: Int,
    val courseId: Int,
    val status: EnrollmentStatus,
    val progress: Int,                    // 0-100%
    val startDate: String,
    val expectedEndDate: String,
    val completedAt: String?,
)
```

#### 7️⃣ **Adaptar Dashboard Admin**

```kotlin
@Composable
fun LanguageCourseDashboard(
    viewModel: DashboardViewModel = hiltViewModel(),
) {
    // KPIs para cursos:
    KpiCard(title = "Inscripciones Hoy", value = "23", icon = Users)
    KpiCard(title = "Cursos Activos", value = "12", icon = BookOpen)
    KpiCard(title = "Estudiantes Totales", value = "1,245", icon = School)
    KpiCard(title = "Ingresos Este Mes", value = "$4,500", icon = TrendingUp)
}
```

#### 8️⃣ **Adaptar Inyección de Dependencias**

**Di/RepositoryModule.kt:**
```kotlin
@Module
@InstallIn(SingletonComponent::class)
object RepositoryModule {
    
    @Singleton
    @Provides
    fun provideCourseRepository(
        apiService: ApiService,
        courseDao: CourseDao,
    ): CourseRepository =
        CourseRepositoryImpl(apiService, courseDao)
    
    @Singleton
    @Provides
    fun provideEnrollmentRepository(
        apiService: ApiService,
    ): EnrollmentRepository =
        EnrollmentRepositoryImpl(apiService)
    
    @Singleton
    @Provides
    fun provideLanguageRepository(
        apiService: ApiService,
    ): LanguageRepository =
        LanguageRepositoryImpl(apiService)
}
```

#### 9️⃣ **Adaptar Navegación**

**NavGraph.kt:**
```kotlin
sealed class Screen(val route: String) {
    // Public
    data object Login              : Screen("login")
    data object CourseCatalog      : Screen("catalog")
    data object CourseDetail       : Screen("course/{courseId}")
    
    // Student
    data object MyCourses          : Screen("my-courses")
    data object LessonView         : Screen("course/{courseId}/lesson/{lessonId}")
    
    // Admin
    data object AdminDashboard     : Screen("admin/dashboard")
    data object AdminCourses       : Screen("admin/courses")
    data object AdminStudents      : Screen("admin/students")
    data object AdminEnrollments   : Screen("admin/enrollments")
}
```

---

## 📋 Checklist de Implementación

### Fase 1: Setup Base
- [ ] Copiar estructura de carpetas
- [ ] Copiar `build.gradle.kts`, `AndroidManifest.xml`
- [ ] Copiar configuración de Hilt
- [ ] Copiar temas y estilos

### Fase 2: Modelos de Datos
- [ ] Crear `LanguageCourse.kt`, `Lesson.kt`, `Enrollment.kt`
- [ ] Crear `LanguagePayload.kt`, `EnrollmentFilters.kt`
- [ ] Crear DTOs para API

### Fase 3: Capa de Datos
- [ ] Crear `CourseRepository` (interfaz) y `CourseRepositoryImpl`
- [ ] Crear `EnrollmentRepository`
- [ ] Adaptar `AuthRepository`
- [ ] Crear DAOs Room para cache local

### Fase 4: ViewModels
- [ ] Crear `CoursesAdminViewModel`
- [ ] Crear `StudentCoursesViewModel`
- [ ] Crear `LessonViewModel`
- [ ] Crear `CourseCartViewModel`

### Fase 5: UI - Admin
- [ ] Crear `CoursesAdminScreen` + formulario
- [ ] Crear `LessonEditor`
- [ ] Crear Dashboard adaptado
- [ ] Crear `StudentManagementScreen`

### Fase 6: UI - Student
- [ ] Crear `CourseDetailScreen`
- [ ] Crear `LessonViewScreen` (reproductor + contenido)
- [ ] Crear `MyCoursesScreen`
- [ ] Crear `CourseCheckoutScreen`

### Fase 7: Integración
- [ ] Configurar rutas en `NavGraph`
- [ ] Conectar repositorios en DI
- [ ] Integración de API REST
- [ ] Testing end-to-end

---

## 🎯 Resumen Técnico

### Conceptos Clave Reutilizables

| Concepto | Uso en ShopApp | Adaptación para Idiomas |
|----------|---|---|
| **Product** | Productos físicos | Cursos, Lecciones |
| **Cart** | Compra de múltiples productos | Carrito de cursos (inscripción) |
| **Order** | Transacción completada | Enrollment (inscripción del estudiante) |
| **Category** | Clasificación de productos | Idiomas, Niveles |
| **Admin CRUD** | Gestión de inventario | Gestión de contenido educativo |
| **Authentication** | Login/Registro | Reutilizar tal cual |
| **Image Upload** | Fotos de productos | Fotos de cursos e instructor |

### Diferencias Principales

```
SHOP APP                  →  IDIOMAS APP
─────────────────────────────────────────
Producto comprable       →  Contenido para aprender
Transacción pago         →  Inscripción (puede ser gratis)
Inventario/Stock         →  Disponibilidad de cursos
Cliente único/orden      →  Estudiante/Inscripción
Admin: Vender            →  Admin: Enseñar
```

### Ruta de Datos Típica

```
Estudiante
    ↓ (Navega a catálogo)
CourseCatalogScreen
    ↓ (Click en curso)
CourseDetailScreen + LessonPreview
    ↓ (Añade al carrito)
CourseCartViewModel.addCourseToCart()
    ↓ (Checkout)
EnrollmentRepository.createEnrollment()
    ↓
Backend: POST /api/courses/enroll/
    ↓
Enrollment creada ✓
    ↓
MyCoursesScreen muestra nuevo curso
    ↓
Estudiante accede a lecciones
LessonViewScreen con reproductor + contenido
```

---

## 📞 Preguntas Frecuentes

**P: ¿Puedo reutilizar `CartViewModel` directamente?**  
**R:** Parcialmente. El concepto es igual, pero cambia la lógica de checkout. Para idiomas, probablemente no necesites carrito con múltiples items. Considera simplificar a un modal de confirmación.

**P: ¿Cómo manejo acceso a lecciones por estudiante?**  
**R:** En `LessonViewScreen`, valida que el usuario tenga `Enrollment.ACTIVE` para ese curso. Backend debe validar permisos.

**P: ¿Puedo usar Room para caché local?**  
**R:** Sí. Implementa `@Entity` para `LanguageCourse`, `Lesson`, y sincroniza con backend al abrir la app.

**P: ¿Cómo implemento reproducción de video?**  
**R:** Usa `VideoView` o `ExoPlayer` en `LessonViewScreen`. Backend retorna URL del video (almacenado en S3, YouTube, etc).

**P: ¿Autenticación es igual?**  
**R:** Sí, reutiliza `AuthViewModel`, `LoginScreen`, `RegisterScreen` sin cambios.

---

## 📚 Archivos Principales a Reutilizar

```
✓ AuthViewModel.kt
✓ LoginScreen.kt
✓ RegisterScreen.kt
✓ BottomNavBar.kt (adaptado)
✓ NavGraph.kt (adaptado)
✓ CartViewModel.kt (simplificado)
✓ DashboardScreen.kt (adaptado)
✓ CategoriesAdminViewModel.kt (→ CoursesAdminViewModel)
✓ AdminScaffold.kt (reutilizable)
✓ TokenDataStore.kt
✓ Hilt configuration
✓ Tema y colores (adaptar a tu marca)
```

---

**✅ Este informe te proporciona una guía completa para integrar la arquitectura de ShopApplication en tu proyecto de idiomas. Puedes empezar por copiar la base y adaptarla módulo por módulo.**
