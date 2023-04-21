import SwiftUI
import PNComponents
import AVFoundation

struct CameraPreviewExampleView: View {
    
    @State
    var camera = try? Camera(
        options: .movieRecording,
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
            guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("movie.mov") else {
                return
            }
            
            camera?.run(action: .startMovieRecording(movieFileURL: url), onResult: { result in
                print("Camera started")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    camera?.run(action: .stopMovieRecording, onResult: { result in
                        switch result {
                        case let .success(result):
                            if let movieURL = result.getRecordedMovieURL() {
                                print("Movie url:", movieURL)
                            } else {
                                print("No movie url")
                            }
                            
                        case let .failure(error):
                            print("Error:", error)
                        }
                    })
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
