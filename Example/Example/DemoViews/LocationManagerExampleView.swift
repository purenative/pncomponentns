import SwiftUI
import CoreLocation
import PNComponents

@MainActor
class LocationManagerExampleState: ObservableObject {
    
    private let locationManager = LocationManager(
        desiredAccuracy: kCLLocationAccuracyBest,
        accessLevel: .whenInUse
    )
    
    @Published
    var requesting: Bool = false
    
    @Published
    var updating: Bool = false
    
    @Published
    var location: CLLocation?
    
    init() {
        locationManager.$location.assign(to: &$location)
    }
    
    func startUpdating() {
        updating = true
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdating() {
        updating = false
        locationManager.startUpdatingLocation()
    }
    
    func requestOnce() async {
        defer {
            updating = false
        }
        updating = true
        
        do {
            location = try await locationManager.requestCurrentLocation(onlyNewData: true)
            print("Location updated")
        } catch {
            print("Cant receive location:", error.localizedDescription)
        }
    }
    
}

struct LocationManagerExampleView: View {
    
    @StateObject
    var state = LocationManagerExampleState()
    
    var body: some View {
        VStack(spacing: 20) {
            if let location = state.location {
                Text("LAT: \(location.coordinate.latitude)")
                Text("LON: \(location.coordinate.longitude)")
            } else {
                Text("Location undefined")
            }
            
            if state.updating {
                Text("Stop location updates")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.orange)
                    .buttonAction({
                        state.stopUpdating()
                    })
            } else if state.requesting {
                Text("Requesting location")
            } else {
                Text("Start location updates")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.green)
                    .buttonAction({
                        state.startUpdating()
                    })
                
                Text("Request location once")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.blue)
                    .buttonAction({
                        Task {
                            await state.requestOnce()
                        }
                    })
            }
        }
        .padding(20)
    }
    
}

struct LocationManagerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        LocationManagerExampleView()
    }
}
