package com.ute.tts


import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Button
import android.widget.MediaController
import android.widget.VideoView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat


class MainActivityMultimedia : AppCompatActivity() {


    private lateinit var webView: WebView
    private lateinit var videoView: VideoView


    private val youtubeWatchUrl = "https://www.youtube.com/watch?v=6BODDyZRF6A"
    private val youtubeEmbedUrl="https://www.youtube.com/embed/kXYiU_JCYtU?playsinline=1&rel=0"


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main_multimedia)


        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(16, systemBars.top + 16, 16, systemBars.bottom + 16)
            insets
        }


        webView = findViewById(R.id.webViewYouTube)


        val ws: WebSettings = webView.settings
        ws.javaScriptEnabled = true
        ws.domStorageEnabled = true
        ws.mediaPlaybackRequiresUserGesture = false
        ws.loadWithOverviewMode = true
        ws.useWideViewPort = true


        webView.webChromeClient = WebChromeClient()
        webView.webViewClient = WebViewClient()


        val html = """
           <!DOCTYPE html>
           <html>
           <head>
               <meta name="viewport" content="width=device-width, initial-scale=1.0">
               <style>
                   html, body {
                       margin: 0;
                       height: 100%;
                       background: #000;
                   }
                   iframe {
                       width: 100%;
                       height: 100%;
                       border: 0;
                   }
               </style>
           </head>
           <body>
               <iframe
                   src="$youtubeEmbedUrl"
                   allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                   allowfullscreen>
               </iframe>
           </body>
           </html>
       """.trimIndent()


        webView.loadDataWithBaseURL(
            "https://www.youtube.com",
            html,
            "text/html",
            "UTF-8",
            null
        )


        findViewById<Button>(R.id.btnOpenYouTube).setOnClickListener {
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(youtubeWatchUrl))
            startActivity(intent)
        }


        videoView = findViewById(R.id.videoViewMp4)


        val mediaController = MediaController(this)
        mediaController.setAnchorView(videoView)
        videoView.setMediaController(mediaController)


        val videoUri: Uri = Uri.parse("android.resource://$packageName/${R.raw.demo}")
        videoView.setVideoURI(videoUri)


        videoView.setOnPreparedListener { mp ->
            mp.isLooping = false
            videoView.start()
        }
    }


    override fun onBackPressed() {
        if (this::webView.isInitialized && webView.canGoBack()) {
            webView.goBack()
        } else {
            super.onBackPressed()
        }
    }
}