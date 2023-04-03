import SwiftUI
import PNComponents
import AVFoundation

struct CameraPreviewExampleView: View {
    
    @State
    var camera = try? Camera(
        options: .photoCapturing,
        position: .front
    )
    
    @State
    var photoImage: UIImage?
    
    var body: some View {
        if let camera {
            ZStack {
                CameraPreview(
                    camera: camera,
                    videoGravity: .scaleAspectFill
                )
                .ignoresSafeArea()
                .onAppear(perform: {
                    camera.start()
                })
                .onDisappear(perform: {
                    camera.stop()
                })
                
                buildCapturePhotoButton()
                    .padding(24)
                    .alignment(.bottom)
            }
        } else {
            Text("Camera initialization failed")
        }
    }
                
    @ViewBuilder
    private func buildCapturePhotoButton() -> some View {
        ZStack {
            Color.white
            
            Text("Take photo")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
        }
        .frame(height: 40)
        .cornerRadius(10)
        .buttonAction({
            let settings = AVCapturePhotoSettings()
            camera?.run(action: .takePhoto(settings), onResult: { result in
                if let image = try? result.get().getCapturedImage() {
                    
                }
            })
        })
    }
    
}

#if DEBUG
struct CameraPreviewExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreviewExampleView()
    }
}
#endif
