import UIKit
import AVFoundation

public class CameraPreviewView: UIView {

    public override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
    public func set(videoGravity: CameraPreviewVideoGravity) {
        setupPreviewLayer { layer in
            layer.videoGravity = videoGravity.getAVLayerVideoGravity()
        }
    }
    
    func bindTo(camera: Camera) {
        setupPreviewLayer { layer in
            layer.session = camera.captureSession
        }
    }
    
    func unbindFromCamera() {
        setupPreviewLayer { layer in
            layer.session = nil
        }
    }

}

private extension CameraPreviewView {
    
    func setupPreviewLayer(_ setupBlock: (AVCaptureVideoPreviewLayer) -> Void) {
        guard let previewLayer = layer as? AVCaptureVideoPreviewLayer else {
            return
        }
        
        setupBlock(previewLayer)
    }
    
}
