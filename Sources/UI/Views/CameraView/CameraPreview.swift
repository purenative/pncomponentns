import SwiftUI

public struct CameraPreview: UIViewRepresentable {
    
    let camera: Camera
    let videoGravity: CameraPreviewVideoGravity
    
    public init(camera: Camera, videoGravity: CameraPreviewVideoGravity) {
        self.camera = camera
        self.videoGravity = videoGravity
    }
    
    public func makeUIView(context: Context) -> CameraPreviewView {
        CameraPreviewView()
    }
    
    public func updateUIView(_ cameraPreviewView: CameraPreviewView, context: Context) {
        cameraPreviewView.set(videoGravity: videoGravity)
        cameraPreviewView.bindTo(camera: camera)
    }
    
}
