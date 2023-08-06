import Foundation

public final class Countdown {
    
    private var timer: Timer?
    
    @Published
    public private(set) var count: TimeInterval = 0.0
    
    public init() { }
    
    deinit {
        brakeTimer()
    }
    
    public func start(count: TimeInterval) {
        self.count = count
        resumeTimer()
    }
    
    public func stop() {
        brakeTimer()
    }
    
}

private extension Countdown {
    
    func resumeTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.processTickOf(timer: timer)
        }
    }
    
    func processTickOf(timer: Timer) {
        count -= 1
        
        if count.isZero {
            timer.invalidate()
        }
    }
    
    func brakeTimer() {
        timer?.invalidate()
        timer = nil
        count = 0.0
    }
    
}
