import SwiftUI
import PNComponents

struct CameraPreviewExampleView: View {
    
    let camera = try? Camera(
        startImmidiately: true,
        options: .photoCapturing,
        position: .front
    )
    
    var body: some View {
        if let camera {
            CameraPreview(
                camera: camera,
                videoGravity: .scaleAspectFill
            )
            .ignoresSafeArea()
        } else {
            Text("Camera initialization failed")
        }
    }
    
}

#if DEBUG
struct CameraPreviewExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreviewExampleView()
    }
}
#endif
