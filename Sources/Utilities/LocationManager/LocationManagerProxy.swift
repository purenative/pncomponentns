import CoreLocation

final class LocationManagerProxy: NSObject, CLLocationManagerDelegate {
    
    private let locationManager: CLLocationManager
    private let accessLevel: LocationManagerAccessLevel
    private let currentLocationLock = NSLock()
    
    private var currentLocationHandler: ((Result<CLLocation, Error>) -> Void)?
    
    var onLocationUpdated: ((CLLocation) -> Void)?
    
    var location: CLLocation? {
        locationManager.location
    }
    
    public init(desiredAccuracy: CLLocationAccuracy, accessLevel: LocationManagerAccessLevel) {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = desiredAccuracy
        
        self.accessLevel = accessLevel
        
        super.init()
        
        locationManager.delegate = self
        
        updateLocationFromCache()
    }
    
    func requestCurrentLocation() async throws -> CLLocation {
        try await withCheckedThrowingContinuation { continuation in
            requestCurrentLocation { result in
                continuation.resume(with: result)
            }
        }
    }
    
    func startUpdatingLocation() {
        requestPermissions()
        
        DispatchQueue.main.async { [weak locationManager] in
            locationManager?.startUpdatingLocation()
        }
    }
    
    func endUpdatingLocation() {
        DispatchQueue.main.async { [weak locationManager] in
            locationManager?.stopUpdatingLocation()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            DispatchQueue.main.async { [weak self] in
                self?.onLocationUpdated?(lastLocation)
            }
            
            if let currentLocationHandler {
                currentLocationHandler(.success(lastLocation))
                self.currentLocationHandler = nil
                currentLocationLock.unlock()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let currentLocationHandler {
            currentLocationHandler(.failure(error))
            self.currentLocationHandler = nil
            currentLocationLock.unlock()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if let currentLocationHandler {
            requestCurrentLocation(onCompleted: currentLocationHandler)
        }
    }
    
}

private extension LocationManagerProxy {
    
    @discardableResult
    func requestPermissions() -> Bool {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestAuthorization(withAccessLevel: accessLevel)
            return false
        } else {
            return true
        }
    }
    
    func updateLocationFromCache() {
        guard let location else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.onLocationUpdated?(location)
        }
    }
    
    func requestCurrentLocation(onCompleted: @escaping (Result<CLLocation, Error>) -> Void) {
        currentLocationHandler = onCompleted
        guard requestPermissions() else {
            return
        }
        currentLocationLock.lock()
        startUpdatingLocation()
    }
    
}
