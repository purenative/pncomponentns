import CoreLocation

@MainActor
public class LocationManager {
    
    private let proxy: LocationManagerProxy
    
    @Published
    public private(set) var location: CLLocation?
    
    public init(desiredAccuracy: CLLocationAccuracy, accessLevel: LocationManagerAccessLevel) {
        proxy = LocationManagerProxy(
            desiredAccuracy: desiredAccuracy,
            accessLevel: accessLevel
        )
        
        proxy.onLocationUpdated = { [weak self] newLocation in
             self?.location = newLocation
        }
    }
    
    public func requestCurrentLocation(onlyNewData: Bool = false) async throws -> CLLocation {
        if !onlyNewData, let lastLocation = proxy.location {
            location = lastLocation
            return lastLocation
        } else {
            let newLocation = try await proxy.requestCurrentLocation()
            return newLocation
        }
    }
    
    public func startUpdatingLocation() {
        proxy.startUpdatingLocation()
    }
    
    public func endUpdatingLocation() {
        proxy.endUpdatingLocation()
    }
    
}
