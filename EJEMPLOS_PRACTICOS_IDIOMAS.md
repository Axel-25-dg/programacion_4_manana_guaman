# 💻 EJEMPLOS PRÁCTICOS: Adaptación ShopApp → Proyecto Idiomas

## 1. Modelos de Datos Adaptados

### Antes (ShopApp)
```kotlin
// data/model/Product.kt
data class Product(
    val id: Int,
    val name: String,
    val price: Double,
    val stock: Int,
    val imageUrl: String?,
    val categoryId: Int?,
)
```

### Después (Idiomas)
```kotlin
// domain/model/LanguageCourse.kt
package com.languageapp.domain.model

data class LanguageCourse(
    val id: Int,
    val title: String,
    val description: String,
    val language: String,                    // "Spanish", "French", etc.
    val level: Level,
    val price: Double,
    val lessons: Int,
    val duration: String,                    // "4 weeks"
    val imageUrl: String?,
    val instructor: String,
    val rating: Double,
    val totalReviews: Int,
    val isActive: Boolean,
    val createdAt: String,
)

enum class Level {
    BEGINNER, INTERMEDIATE, ADVANCED, FLUENT
}

data class Lesson(
    val id: Int,
    val courseId: Int,
    val title: String,
    val description: String,
    val content: String,                      // Texto/HTML
    val videoUrl: String?,
    val order: Int,
    val duration: Int,                        // minutos
    val completed: Boolean = false,
)

data class Enrollment(
    val id: Int,
    val userId: Int,
    val courseId: Int,
    val status: EnrollmentStatus,
    val progress: Int,                        // 0-100
    val startDate: String,
    val completedAt: String?,
)

enum class EnrollmentStatus {
    ACTIVE, COMPLETED, CANCELLED
}
```

---

## 2. ViewModel Adaptado

### Antes (ProductsAdminViewModel)
```kotlin
@HiltViewModel
class ProductsAdminViewModel @Inject constructor(
    private val repository: ProductRepository,
    private val categoryRepository: CategoryRepository,
) : ViewModel() {
    
    private val _state = MutableStateFlow(ProductsAdminUiState())
    val state: StateFlow<ProductsAdminUiState> = _state.asStateFlow()
    
    fun createProduct(name: String, price: Double, stock: Int, categoryId: Int)
    fun updateProduct(id: Int, ...)
    fun deleteProduct(id: Int)
}
```

### Después (CoursesAdminViewModel)
```kotlin
// presentation/viewmodel/CoursesAdminViewModel.kt
package com.languageapp.presentation.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.languageapp.domain.model.*
import com.languageapp.domain.repository.CourseRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

// Estados UI
data class CoursesAdminUiState(
    val courses: List<LanguageCourse> = emptyList(),
    val isLoading: Boolean = false,
    val error: String? = null,
    val search: String = "",
    val languageFilter: String? = null,
    val levelFilter: Level? = null,
)

sealed interface CourseFormState {
    data object Idle : CourseFormState
    data object Saving : CourseFormState
    data class Success(val msg: String) : CourseFormState
    data class Error(val message: String) : CourseFormState
}

@HiltViewModel
class CoursesAdminViewModel @Inject constructor(
    private val courseRepository: CourseRepository,
) : ViewModel() {

    // ── Estados principales
    private val _state = MutableStateFlow(CoursesAdminUiState())
    val state: StateFlow<CoursesAdminUiState> = _state.asStateFlow()

    private val _formState = MutableStateFlow<CourseFormState>(CourseFormState.Idle)
    val formState: StateFlow<CourseFormState> = _formState.asStateFlow()

    // ── Idiomas disponibles (para dropdown)
    val languages = listOf("Spanish", "French", "German", "Portuguese")

    // ── Filtrado combinado: búsqueda + idioma + nivel
    val filtered: StateFlow<List<LanguageCourse>> = _state
        .map { s ->
            s.courses
                .filter { c ->
                    s.search.isBlank() || c.title.contains(s.search, ignoreCase = true)
                }
                .filter { c ->
                    s.languageFilter == null || c.language == s.languageFilter
                }
                .filter { c ->
                    s.levelFilter == null || c.level == s.levelFilter
                }
        }
        .stateIn(viewModelScope, SharingStarted.Eagerly, emptyList())

    init {
        loadCourses()
    }

    // ── Cargar cursos desde API
    fun loadCourses() {
        viewModelScope.launch {
            _state.update { it.copy(isLoading = true) }
            try {
                val courses = courseRepository.getCourses()
                _state.update { it.copy(courses = courses, isLoading = false) }
            } catch (e: Exception) {
                _state.update { 
                    it.copy(
                        error = e.message ?: "Error desconocido",
                        isLoading = false
                    )
                }
            }
        }
    }

    // ── Búsqueda en tiempo real
    fun search(query: String) {
        _state.update { it.copy(search = query) }
    }

    // ── Filtrar por idioma
    fun filterByLanguage(language: String?) {
        _state.update { it.copy(languageFilter = language) }
    }

    // ── Filtrar por nivel
    fun filterByLevel(level: Level?) {
        _state.update { it.copy(levelFilter = level) }
    }

    // ── Crear nuevo curso
    fun createCourse(
        title: String,
        description: String,
        language: String,
        level: Level,
        price: Double,
        lessons: Int,
        duration: String,
        instructor: String,
        imageUrl: String?,
    ) {
        viewModelScope.launch {
            _formState.value = CourseFormState.Saving
            try {
                val coursePayload = CoursePayload(
                    title = title,
                    description = description,
                    language = language,
                    level = level,
                    price = price,
                    lessons = lessons,
                    duration = duration,
                    instructor = instructor,
                    imageUrl = imageUrl,
                )
                courseRepository.createCourse(coursePayload)
                _formState.value = CourseFormState.Success("Curso creado exitosamente")
                loadCourses()
            } catch (e: Exception) {
                _formState.value = CourseFormState.Error(e.message ?: "Error")
            }
        }
    }

    // ── Editar curso
    fun updateCourse(
        id: Int,
        title: String,
        description: String,
        language: String,
        level: Level,
        price: Double,
        lessons: Int,
        duration: String,
        instructor: String,
        imageUrl: String?,
    ) {
        viewModelScope.launch {
            _formState.value = CourseFormState.Saving
            try {
                val coursePayload = CoursePayload(...)
                courseRepository.updateCourse(id, coursePayload)
                _formState.value = CourseFormState.Success("Curso actualizado")
                loadCourses()
            } catch (e: Exception) {
                _formState.value = CourseFormState.Error(e.message ?: "Error")
            }
        }
    }

    // ── Eliminar curso
    fun deleteCourse(id: Int) {
        viewModelScope.launch {
            try {
                courseRepository.deleteCourse(id)
                loadCourses()
            } catch (e: Exception) {
                _state.update { it.copy(error = e.message) }
            }
        }
    }
}
```

---

## 3. Repository Adaptado

### Antes (ProductRepository)
```kotlin
// domain/repository/ProductRepository.kt
interface ProductRepository {
    suspend fun getProducts(filters: ProductFilters): List<Product>
    suspend fun getProductById(id: Int): Product
    suspend fun createProduct(payload: ProductPayload): Product
    suspend fun updateProduct(id: Int, payload: ProductPayload): Product
    suspend fun deleteProduct(id: Int)
}

// data/repository/ProductRepositoryImpl.kt
class ProductRepositoryImpl @Inject constructor(
    private val apiService: ApiService,
    private val dao: ProductDao,
) : ProductRepository {
    override suspend fun getProducts(filters: ProductFilters): List<Product> {
        return try {
            val response = apiService.getProducts(
                search = filters.search,
                category = filters.category,
                page = filters.page,
            )
            dao.insertProducts(response.map { it.toDomain() })
            response.map { it.toDomain() }
        } catch (e: Exception) {
            dao.getAllProducts()  // Fallback a caché local
        }
    }
}
```

### Después (CourseRepository)
```kotlin
// domain/repository/CourseRepository.kt
interface CourseRepository {
    suspend fun getCourses(language: String? = null, level: Level? = null): List<LanguageCourse>
    suspend fun getCourseById(id: Int): LanguageCourse
    suspend fun getLessons(courseId: Int): List<Lesson>
    suspend fun createCourse(payload: CoursePayload): LanguageCourse
    suspend fun updateCourse(id: Int, payload: CoursePayload): LanguageCourse
    suspend fun deleteCourse(id: Int)
    suspend fun markLessonAsCompleted(courseId: Int, lessonId: Int)
}

// data/repository/CourseRepositoryImpl.kt
@Suppress("IMPLICIT_CAST_TO_ANY")
class CourseRepositoryImpl @Inject constructor(
    private val apiService: ApiService,
    private val courseDao: CourseDao,
    private val lessonDao: LessonDao,
) : CourseRepository {

    override suspend fun getCourses(language: String?, level: Level?): List<LanguageCourse> {
        return try {
            val response = apiService.getCourses(
                language = language,
                level = level?.name?.lowercase(),
            )
            // Guardar en caché local
            courseDao.insertCourses(response.map { it.toDomain() })
            response.map { it.toDomain() }
        } catch (e: Exception) {
            // Fallback a caché
            courseDao.getAllCourses()
        }
    }

    override suspend fun getCourseById(id: Int): LanguageCourse {
        return apiService.getCourseById(id).toDomain()
    }

    override suspend fun getLessons(courseId: Int): List<Lesson> {
        return try {
            val response = apiService.getLessons(courseId)
            lessonDao.insertLessons(response.map { it.toDomain() })
            response.map { it.toDomain() }
        } catch (e: Exception) {
            lessonDao.getLessonsByCourse(courseId)
        }
    }

    override suspend fun createCourse(payload: CoursePayload): LanguageCourse {
        val response = apiService.createCourse(payload)
        return response.toDomain()
    }

    override suspend fun updateCourse(id: Int, payload: CoursePayload): LanguageCourse {
        val response = apiService.updateCourse(id, payload)
        return response.toDomain()
    }

    override suspend fun deleteCourse(id: Int) {
        apiService.deleteCourse(id)
        courseDao.deleteCourse(id)
    }

    override suspend fun markLessonAsCompleted(courseId: Int, lessonId: Int) {
        apiService.markLessonCompleted(courseId, lessonId)
    }
}
```

---

## 4. UI - Pantalla de Cursos para Admin

### Antes (ProductsAdminScreen)
```kotlin
@Composable
fun ProductsAdminScreen(
    viewModel: ProductsAdminViewModel = hiltViewModel(),
) {
    val state by viewModel.state.collectAsState()
    val filtered by viewModel.filtered.collectAsState()
    
    Column(modifier = Modifier.fillMaxSize()) {
        // Búsqueda
        TextField(
            value = state.search,
            onValueChange = { viewModel.search(it) },
            label = { Text("Buscar producto") },
        )
        
        // Tabla
        LazyColumn {
            items(filtered) { product ->
                ProductRow(product, onEdit = {...}, onDelete = {...})
            }
        }
    }
}
```

### Después (CoursesAdminScreen)
```kotlin
// presentation/ui/admin/courses/CoursesAdminScreen.kt
package com.languageapp.presentation.ui.admin.courses

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.languageapp.domain.model.LanguageCourse
import com.languageapp.presentation.viewmodel.CoursesAdminViewModel

@Composable
fun CoursesAdminScreen(
    viewModel: CoursesAdminViewModel = hiltViewModel(),
) {
    val state by viewModel.state.collectAsState()
    val filtered by viewModel.filtered.collectAsState()
    val formState by viewModel.formState.collectAsState()

    var showFormDialog by remember { mutableStateOf(false) }
    var selectedCourse by remember { mutableStateOf<LanguageCourse?>(null) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(color = Color(0xFFFAFAFA))
            .padding(16.dp),
    ) {
        // ── Header
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Text(
                "Gestión de Cursos",
                fontSize = MaterialTheme.typography.headlineSmall.fontSize,
                fontWeight = FontWeight.Bold,
            )
            Button(
                onClick = {
                    selectedCourse = null
                    showFormDialog = true
                },
                modifier = Modifier.height(40.dp),
            ) {
                Icon(Icons.Default.Add, contentDescription = null, modifier = Modifier.size(18.dp))
                Spacer(Modifier.width(8.dp))
                Text("Nuevo Curso")
            }
        }

        // ── Filtros y búsqueda
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            TextField(
                value = state.search,
                onValueChange = { viewModel.search(it) },
                label = { Text("Buscar curso...") },
                modifier = Modifier
                    .weight(1f)
                    .height(50.dp),
                leadingIcon = { Icon(Icons.Default.Search, contentDescription = null) },
            )

            LanguageFilter(
                selectedLanguage = state.languageFilter,
                onLanguageSelect = { viewModel.filterByLanguage(it) },
            )

            LevelFilter(
                selectedLevel = state.levelFilter,
                onLevelSelect = { viewModel.filterByLevel(it) },
            )
        }

        // ── Tabla de cursos
        if (state.isLoading) {
            CircularProgressIndicator(modifier = Modifier.align(Alignment.CenterHorizontally))
        } else if (filtered.isEmpty()) {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .align(Alignment.CenterHorizontally),
                contentAlignment = Alignment.Center,
            ) {
                Text(
                    "No hay cursos disponibles",
                    style = MaterialTheme.typography.bodyLarge,
                    color = Color.Gray,
                )
            }
        } else {
            Surface(
                shape = MaterialTheme.shapes.medium,
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f),
            ) {
                LazyColumn {
                    items(filtered) { course ->
                        CourseRow(
                            course = course,
                            onEdit = {
                                selectedCourse = course
                                showFormDialog = true
                            },
                            onDelete = { viewModel.deleteCourse(course.id) },
                        )
                        HorizontalDivider()
                    }
                }
            }
        }

        // ── Mensaje de error
        if (state.error != null) {
            Snackbar(
                modifier = Modifier
                    .align(Alignment.CenterHorizontally)
                    .padding(top = 8.dp),
            ) {
                Text(state.error ?: "Error desconocido")
            }
        }
    }

    // ── Modal: Crear/Editar Curso
    if (showFormDialog) {
        CourseFormDialog(
            course = selectedCourse,
            onSave = { title, description, language, level, price, lessons, duration, instructor, imageUrl ->
                if (selectedCourse != null) {
                    viewModel.updateCourse(
                        id = selectedCourse!!.id,
                        title = title,
                        description = description,
                        language = language,
                        level = level,
                        price = price,
                        lessons = lessons,
                        duration = duration,
                        instructor = instructor,
                        imageUrl = imageUrl,
                    )
                } else {
                    viewModel.createCourse(
                        title = title,
                        description = description,
                        language = language,
                        level = level,
                        price = price,
                        lessons = lessons,
                        duration = duration,
                        instructor = instructor,
                        imageUrl = imageUrl,
                    )
                }
                showFormDialog = false
            },
            onDismiss = { showFormDialog = false },
            formState = formState,
        )
    }
}

// ── Fila de curso
@Composable
fun CourseRow(
    course: LanguageCourse,
    onEdit: () -> Unit,
    onDelete: () -> Unit,
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(12.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        // Imagen
        Surface(
            shape = MaterialTheme.shapes.small,
            color = Color.LightGray,
            modifier = Modifier.size(60.dp),
        ) {
            // En producción: usar coil/glide para cargar imagen
            Box(contentAlignment = Alignment.Center) {
                Icon(Icons.Default.Image, contentDescription = null)
            }
        }

        // Información
        Column(modifier = Modifier.weight(1f)) {
            Text(
                course.title,
                fontWeight = FontWeight.Bold,
                fontSize = MaterialTheme.typography.bodyMedium.fontSize,
            )
            Text(
                "${course.language} • ${course.level} • ${course.lessons} lecciones",
                fontSize = MaterialTheme.typography.bodySmall.fontSize,
                color = Color.Gray,
            )
            Text(
                "$${"%.2f".format(course.price)}",
                fontWeight = FontWeight.SemiBold,
                color = Color(0xFF4CAF50),
                fontSize = MaterialTheme.typography.labelMedium.fontSize,
            )
        }

        // Acciones
        IconButton(onClick = onEdit) {
            Icon(Icons.Default.Edit, contentDescription = "Editar", tint = Color.Blue)
        }
        IconButton(onClick = onDelete) {
            Icon(Icons.Default.Delete, contentDescription = "Eliminar", tint = Color.Red)
        }
    }
}

// ── Filtro de idioma
@Composable
fun LanguageFilter(
    selectedLanguage: String?,
    onLanguageSelect: (String?) -> Unit,
) {
    var expanded by remember { mutableStateOf(false) }
    val languages = listOf("Spanish", "French", "German", "Portuguese")

    Button(
        onClick = { expanded = true },
        modifier = Modifier.height(50.dp),
    ) {
        Text(selectedLanguage ?: "Idioma")
        Icon(Icons.Default.ExpandMore, contentDescription = null, modifier = Modifier.size(18.dp))
    }

    DropdownMenu(expanded = expanded, onDismissRequest = { expanded = false }) {
        DropdownMenuItem(
            text = { Text("Todos") },
            onClick = {
                onLanguageSelect(null)
                expanded = false
            },
        )
        languages.forEach { language ->
            DropdownMenuItem(
                text = { Text(language) },
                onClick = {
                    onLanguageSelect(language)
                    expanded = false
                },
            )
        }
    }
}

// ── Similar para LevelFilter...
@Composable
fun LevelFilter(
    selectedLevel: Any?,
    onLevelSelect: (Any?) -> Unit,
) {
    // Similar a LanguageFilter pero para Level enum
}
```

---

## 5. Pantalla de Cursos del Estudiante

### Student Course Catalog
```kotlin
// presentation/ui/client/courses/StudentCoursesScreen.kt
package com.languageapp.presentation.ui.client.courses

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Star
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.languageapp.domain.model.LanguageCourse
import com.languageapp.presentation.viewmodel.StudentCoursesViewModel

@Composable
fun StudentCoursesScreen(
    onCourseClick: (courseId: Int) -> Unit,
    viewModel: StudentCoursesViewModel = hiltViewModel(),
) {
    val courses by viewModel.courses.collectAsState()
    val isLoading by viewModel.isLoading.collectAsState()

    LaunchedEffect(Unit) {
        viewModel.loadCourses()
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
    ) {
        Text(
            "Descubre Cursos",
            fontSize = MaterialTheme.typography.headlineSmall.fontSize,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 16.dp),
        )

        if (isLoading) {
            CircularProgressIndicator(modifier = Modifier.align(Alignment.CenterHorizontally))
        } else {
            LazyVerticalGrid(
                columns = GridCells.Fixed(2),
                horizontalArrangement = Arrangement.spacedBy(12.dp),
                verticalArrangement = Arrangement.spacedBy(12.dp),
            ) {
                items(courses) { course ->
                    CourseCard(
                        course = course,
                        onClick = { onCourseClick(course.id) },
                    )
                }
            }
        }
    }
}

@Composable
fun CourseCard(
    course: LanguageCourse,
    onClick: () -> Unit,
) {
    Surface(
        shape = MaterialTheme.shapes.medium,
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onClick() },
        tonalElevation = 4.dp,
    ) {
        Column(modifier = Modifier.fillMaxWidth()) {
            // Imagen
            Surface(
                color = Color.LightGray,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(120.dp),
            ) {
                Box(contentAlignment = Alignment.Center) {
                    Icon(Icons.Default.Star, contentDescription = null, modifier = Modifier.size(40.dp))
                }
            }

            // Contenido
            Column(modifier = Modifier.padding(12.dp)) {
                Text(
                    course.title,
                    fontWeight = FontWeight.Bold,
                    fontSize = MaterialTheme.typography.bodyMedium.fontSize,
                    maxLines = 2,
                )
                Text(
                    course.instructor,
                    fontSize = MaterialTheme.typography.labelSmall.fontSize,
                    color = Color.Gray,
                )
                Spacer(Modifier.height(8.dp))
                
                // Rating y precio
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Icon(
                            Icons.Default.Star,
                            contentDescription = null,
                            modifier = Modifier.size(14.dp),
                            tint = Color(0xFFFFB800),
                        )
                        Text(
                            "${course.rating} (${course.totalReviews})",
                            fontSize = MaterialTheme.typography.labelSmall.fontSize,
                        )
                    }
                    Text(
                        "$${"%.2f".format(course.price)}",
                        fontWeight = FontWeight.Bold,
                        color = Color(0xFF4CAF50),
                    )
                }
            }
        }
    }
}
```

---

## 6. Pantalla de Lección

### Lesson View Screen
```kotlin
// presentation/ui/client/lessons/LessonViewScreen.kt
package com.languageapp.presentation.ui.client.lessons

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.languageapp.domain.model.Lesson
import com.languageapp.presentation.viewmodel.LessonViewModel

@Composable
fun LessonViewScreen(
    courseId: Int,
    lessonId: Int,
    onBack: () -> Unit,
    onNextLesson: (Int) -> Unit,
    viewModel: LessonViewModel = hiltViewModel(),
) {
    val lesson by viewModel.currentLesson.collectAsState()
    val isCompleted by viewModel.isCompleted.collectAsState()

    LaunchedEffect(lessonId) {
        viewModel.loadLesson(courseId, lessonId)
    }

    if (lesson == null) {
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
            CircularProgressIndicator()
        }
        return
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState()),
    ) {
        // Header
        TopAppBar(
            title = { Text(lesson!!.title) },
            navigationIcon = {
                IconButton(onClick = onBack) {
                    Icon(Icons.Default.ArrowBack, contentDescription = "Atrás")
                }
            },
        )

        Column(modifier = Modifier.padding(16.dp)) {
            // Video reproducer (si existe)
            lesson!!.videoUrl?.let {
                VideoPlayer(
                    videoUrl = it,
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(200.dp),
                )
                Spacer(Modifier.height(16.dp))
            }

            // Contenido de la lección
            Text(
                lesson!!.description,
                fontSize = MaterialTheme.typography.bodyMedium.fontSize,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(bottom = 8.dp),
            )

            HtmlContent(html = lesson!!.content)

            Spacer(Modifier.height(24.dp))

            // Información de duración
            Surface(
                color = Color(0xFFF0F0F0),
                shape = MaterialTheme.shapes.small,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(vertical = 8.dp),
            ) {
                Text(
                    "Duración: ${lesson!!.duration} minutos",
                    modifier = Modifier.padding(12.dp),
                    style = MaterialTheme.typography.bodySmall,
                )
            }

            Spacer(Modifier.height(24.dp))

            // Botones de acción
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(8.dp),
            ) {
                Button(
                    onClick = {
                        viewModel.markAsCompleted(courseId, lessonId)
                        onNextLesson(lessonId + 1)
                    },
                    modifier = Modifier
                        .weight(1f)
                        .height(48.dp),
                ) {
                    Text(if (isCompleted) "Completado ✓" else "Marcar como completado")
                }
            }
        }
    }
}

@Composable
fun VideoPlayer(
    videoUrl: String,
    modifier: Modifier = Modifier,
) {
    // En producción: usar ExoPlayer o YouTube player
    Surface(
        color = Color.Black,
        modifier = modifier,
        shape = MaterialTheme.shapes.small,
    ) {
        Box(contentAlignment = Alignment.Center) {
            Text(
                "🎥 Reproductor de video\n$videoUrl",
                color = Color.White,
                modifier = Modifier.padding(16.dp),
            )
        }
    }
}

@Composable
fun HtmlContent(html: String) {
    // En producción: usar una librería como MarkdownText o HtmlText
    Text(
        text = html.replace(Regex("<[^>]*>"), ""),  // Remover HTML tags (simplemente)
        modifier = Modifier.fillMaxWidth(),
    )
}
```

---

## 7. Inyección de Dependencias

### Hilt RepositoryModule
```kotlin
// di/RepositoryModule.kt
package com.languageapp.di

import com.languageapp.data.local.CourseDao
import com.languageapp.data.local.LessonDao
import com.languageapp.data.local.EnrollmentDao
import com.languageapp.data.remote.ApiService
import com.languageapp.data.repository.*
import com.languageapp.domain.repository.*
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

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
    fun provideLessonRepository(
        apiService: ApiService,
        lessonDao: LessonDao,
    ): LessonRepository =
        LessonRepositoryImpl(apiService, lessonDao)

    @Singleton
    @Provides
    fun provideEnrollmentRepository(
        apiService: ApiService,
        enrollmentDao: EnrollmentDao,
    ): EnrollmentRepository =
        EnrollmentRepositoryImpl(apiService, enrollmentDao)

    @Singleton
    @Provides
    fun provideAuthRepository(
        apiService: ApiService,
        tokenDataStore: TokenDataStore,
    ): AuthRepository =
        AuthRepositoryImpl(apiService, tokenDataStore)
}
```

---

## 8. Servicio API Adaptado

### Retrofit Service
```kotlin
// data/remote/ApiService.kt
package com.languageapp.data.remote

import com.languageapp.data.remote.dto.*
import retrofit2.http.*

interface ApiService {

    // ── CURSOS
    @GET("/api/courses/")
    suspend fun getCourses(
        @Query("language") language: String? = null,
        @Query("level") level: String? = null,
        @Query("search") search: String? = null,
    ): List<CourseDtoResponse>

    @GET("/api/courses/{id}/")
    suspend fun getCourseById(@Path("id") id: Int): CourseDtoResponse

    @POST("/api/courses/")
    suspend fun createCourse(@Body payload: CoursePayload): CourseDtoResponse

    @PUT("/api/courses/{id}/")
    suspend fun updateCourse(
        @Path("id") id: Int,
        @Body payload: CoursePayload,
    ): CourseDtoResponse

    @DELETE("/api/courses/{id}/")
    suspend fun deleteCourse(@Path("id") id: Int)

    // ── LECCIONES
    @GET("/api/courses/{courseId}/lessons/")
    suspend fun getLessons(@Path("courseId") courseId: Int): List<LessonDtoResponse>

    @GET("/api/courses/{courseId}/lessons/{lessonId}/")
    suspend fun getLessonById(
        @Path("courseId") courseId: Int,
        @Path("lessonId") lessonId: Int,
    ): LessonDtoResponse

    @PATCH("/api/courses/{courseId}/lessons/{lessonId}/complete/")
    suspend fun markLessonCompleted(
        @Path("courseId") courseId: Int,
        @Path("lessonId") lessonId: Int,
    ): CompletionResponse

    // ── INSCRIPCIONES
    @POST("/api/enrollments/")
    suspend fun createEnrollment(@Body payload: EnrollmentPayload): EnrollmentDtoResponse

    @GET("/api/enrollments/my-courses/")
    suspend fun getMyEnrollments(): List<EnrollmentDtoResponse>

    @GET("/api/enrollments/{id}/")
    suspend fun getEnrollment(@Path("id") id: Int): EnrollmentDtoResponse

    @DELETE("/api/enrollments/{id}/")
    suspend fun cancelEnrollment(@Path("id") id: Int)

    // ── UPLOAD IMÁGENES
    @Multipart
    @POST("/api/upload/course-image/")
    suspend fun uploadCourseImage(
        @Part file: MultipartBody.Part,
        @Query("courseId") courseId: Int,
    ): ImageUploadResponse
}

// ── DTOs
data class CourseDtoResponse(
    val id: Int,
    val title: String,
    val description: String,
    val language: String,
    val level: String,
    val price: Double,
    val lessons: Int,
    val duration: String,
    val imageUrl: String?,
    val instructor: String,
    val rating: Double,
    val totalReviews: Int,
    val isActive: Boolean,
    val createdAt: String,
) {
    fun toDomain() = LanguageCourse(
        id = id,
        title = title,
        description = description,
        language = language,
        level = Level.valueOf(level.uppercase()),
        price = price,
        lessons = lessons,
        duration = duration,
        imageUrl = imageUrl,
        instructor = instructor,
        rating = rating,
        totalReviews = totalReviews,
        isActive = isActive,
        createdAt = createdAt,
    )
}

data class LessonDtoResponse(
    val id: Int,
    val courseId: Int,
    val title: String,
    val description: String,
    val content: String,
    val videoUrl: String?,
    val order: Int,
    val duration: Int,
)

data class EnrollmentPayload(
    val courseId: Int,
)

data class EnrollmentDtoResponse(
    val id: Int,
    val userId: Int,
    val courseId: Int,
    val status: String,
    val progress: Int,
    val startDate: String,
    val completedAt: String?,
)

data class ImageUploadResponse(
    val url: String,
    val courseId: Int,
)

data class CompletionResponse(
    val success: Boolean,
    val message: String,
)
```

---

## 9. Resumen de Cambios Principales

```
CONCEPTOS REUTILIZABLES (Sin cambios):
✓ AuthViewModel + Pantallas de login/registro
✓ Patrón MVVM con Flows y StateFlow
✓ Hilt para inyección de dependencias
✓ Coroutines para operaciones asíncronas
✓ Jetpack Compose para UI

ADAPTACIONES NECESARIAS:
✗ Product          → LanguageCourse
✗ Category         → Language + Level
✗ Cart/Order       → CourseCart/Enrollment
✗ ProductsAdmin    → CoursesAdmin
✗ Repository API   → Endpoints de cursos

NUEVAS CARACTERÍSTICAS:
+ Lesson Player (con video)
+ Progress tracking
+ Enrollment management
+ Completion certificates
```
