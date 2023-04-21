import Foundation
import AVFoundation

public final class MovieRecordingQueue: NSObject, AVCaptureFileOutputRecordingDelegate {
    
    typealias VideoRecordingStartedResult = Result<Void, Error>
    typealias OnVideoRecordingStarted = (VideoRecordingStartedResult) -> Void
    
    typealias VideoRecordingFinishedResult = Result<URL, Error>
    typealias OnVideoRecordingFinished = (VideoRecordingFinishedResult) -> Void
    
    private weak var movieFileOutput: AVCaptureMovieFileOutput?
    private var movieRecording: Bool = false
    
    private var onVideoRecordingStarted: OnVideoRecordingStarted?
    private var onVideoRecordingFinished: OnVideoRecordingFinished?
    
    func startVideoRecording(to movieFileURL: URL,
                             with movieFileOutput: AVCaptureMovieFileOutput,
                             onVideoRecordingStarted: @escaping OnVideoRecordingStarted) {
        
        guard !movieRecording else {
            let reason = CameraError.MovieRecordingFailedReason.movieRecordingNotFinished
            let error = CameraError.movieRecordingFailed(reason: reason)
            onVideoRecordingStarted(.failure(error))
            return
        }
        
        self.movieFileOutput = movieFileOutput
        self.onVideoRecordingStarted = onVideoRecordingStarted
        
        movieFileOutput.startRecording(
            to: movieFileURL,
            recordingDelegate: self
        )
    }
    
    func stopVideoRecording(onVideoRecordingFinished: @escaping OnVideoRecordingFinished) {
        guard movieRecording else {
            let reason = CameraError.MovieRecordingFailedReason.movieRecordingNotStarted
            let error = CameraError.movieRecordingFailed(reason: reason)
            onVideoRecordingFinished(.failure(error))
            return
        }
        
        self.onVideoRecordingFinished = onVideoRecordingFinished
        
        movieFileOutput?.stopRecording()
    }
    
    // MARK: - AVCaptureFileOutputRecordingDelegate
    public func fileOutput(_ output: AVCaptureFileOutput,
                           didStartRecordingTo fileURL: URL,
                           from connections: [AVCaptureConnection]) {
        
        movieRecording = true
        
        onVideoRecordingStarted?(.success(()))
        onVideoRecordingStarted = nil
    }
    
    public func fileOutput(_ output: AVCaptureFileOutput,
                           didFinishRecordingTo outputFileURL: URL,
                           from connections: [AVCaptureConnection], error: Error?) {
        
        let result: VideoRecordingFinishedResult
        
        if let error {
            result = .failure(error)
        } else {
            result = .success(outputFileURL)
        }
        
        onVideoRecordingFinished?(result)
        onVideoRecordingFinished = nil
        
        movieRecording = false
    }
    
}
