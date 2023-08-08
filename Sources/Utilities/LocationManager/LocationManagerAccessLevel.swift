import CoreLocation

public enum LocationManagerAccessLevel {
    
    case always
    case whenInUse
    
}

extension CLLocationManager {
    
    func requestAuthorization(withAccessLevel accessLevel: LocationManagerAccessLevel) {
        switch accessLevel {
        case .always:
            requestAlwaysAuthorization()
            
        case .whenInUse:
            requestWhenInUseAuthorization()
        }
    }
    
}
