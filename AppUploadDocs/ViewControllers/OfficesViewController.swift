//
//  OfficesViewController.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 6/01/22.
//
import UIKit
import MapKit
import CoreLocation


class OfficesViewController: UIViewController{
    
    let service = ServiceSophos()
    
    //var dataSourceCities : Office?
    @IBOutlet weak var mapContainer : UIView!
    
    var locationManager : CLLocationManager?
    var userLocation : CLLocation?
    private var map : MKMapView?
    
    
    
    
    var objOffice: ResultOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start and auth location
        requestLocation()
          
        
    }
    // MARK: -
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // get Cities
        bllGetOffices()

    }
    
    // MARK: - locationManager AUTH location
    
    func locationManager(_ manager: CLLocationManager,
            didChangeAuthorization status: CLAuthorizationStatus){
        
        if status == .authorizedAlways{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    // TODO: do stuff
                }
            }
        }
    
    }
    
    // MARK: - Funciones comunes
    // logica de negocio para obtener las oficinas

    private func bllGetOffices() {
        service.getOfficesAPI()
        service.completionHandlerGetOffices { [weak self] (ofices, status, message) in
            if status {
                guard let self = self else {return}
                guard let _ofices = ofices else {return}
                self.objOffice = _ofices
                
                self.setupMap()
            }
        
        }
    }
    
    
    private func requestLocation(){
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
    }
    
    private func setupMap(){
        map = MKMapView(frame: mapContainer.bounds)
        
        mapContainer.addSubview(map ?? UIView())
        // agregar los marcadores de las oficinas
        setUpMarker()
        
        // ubicarse en el lugar actual de las coordenadas capturas al iniciar el dispositivo
       if userLocation != nil {
            guard let ubicacionUsuario = userLocation else {return}
            
            let currentLocation = CLLocationCoordinate2D(latitude: ubicacionUsuario.coordinate.latitude, longitude: ubicacionUsuario.coordinate.longitude)
            
            let spans = MKCoordinateSpan(latitudeDelta: 0.50, longitudeDelta: 0.50)
            let region = MKCoordinateRegion(center: currentLocation, span: spans)
            map?.setRegion(region, animated: true)
            
        }
        
    }
    
    private func setUpMarker(){
        let officies = self.objOffice?.Items
        // Recorre el obje de oficinas
        officies?.forEach( { office in
            // convertir latitud y longitud de string a double
            let latitud = (office.Latitud as NSString).doubleValue
            
            let longitud = (office.Longitud as NSString).doubleValue
            
        // creando el marcador
            let marker = MKPointAnnotation()
            marker.coordinate = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
            
            marker.title = office.Ciudad
            marker.subtitle = office.Nombre
            
            map?.addAnnotation(marker)
            })
        //end ForEach
        
    }

}

// MARK: - OfficesViewController
extension OfficesViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let bestLocation = locations.last else {
            print("No trajo ubicaciòn")
            return
        }
        
        // ya se tiene la location
        userLocation = bestLocation
        
    }
    
}
