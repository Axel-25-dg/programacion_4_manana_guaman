package com.ute.tts

import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity

class MainActivityContador : AppCompatActivity() {

    private var contador = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main_contador)

        val textView = findViewById<TextView>(R.id.textViewContador)
        val btnSumar = findViewById<Button>(R.id.btnSumar)
        val btnRestar = findViewById<Button>(R.id.btnRestar)
        val btnReset = findViewById<Button>(R.id.btnReset)

        fun actualizarTexto() {
            textView.text = contador.toString()
        }

        btnSumar.setOnClickListener {
            contador++
            actualizarTexto()
        }

        btnRestar.setOnClickListener {
            if (contador > 0) contador--
            actualizarTexto()
        }

        btnReset.setOnClickListener {
            contador = 0
            actualizarTexto()
        }

        actualizarTexto()
    }
}