import com.google.android.gms.maps.MapsInitializer
import com.google.android.gms.maps.MapsInitializer.Renderer
import com.google.android.gms.maps.OnMapsSdkInitializedCallback

class MainActivity: FlutterActivity(), OnMapsSdkInitializedCallback {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    MapsInitializer.initialize(applicationContext, Renderer.LATEST, this)
  }

  override fun onMapsSdkInitialized(renderer: MapsInitializer.Renderer) {
    when (renderer) {
      Renderer.LATEST -> Log.d("NewRendererLog", "Se está utilizando la última versión del renderizador.")
      Renderer.LEGACY -> Log.d("NewRendererLog", "Se está utilizando la versión heredada del renderizador.")
    }
  }
}
