//
//  ViewController.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/5/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit
import MapKit

// назва - default треба замінити
final class MobileInfoViewController: UIViewController {

    // тут краще мати обєкт а не обєкт і відразу запит
    // тобі треба запит зробити на viewDidLoad і дотого ж треба отримати результ того що користувач вибрав - completion(_ accessGranted: Bool, error: Error?) або шось таке
    private var currentLocation = LocationService.shared.requestLocation()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let device = MobileDevice()

        /*

         "Device type" : "",
         "Workplace" : "",
         "Inventory number" : "",
         "Project" : "",
         "Sticker" : "",
         "Department/Project device" : "",
         "Responsible person" : ""

         для цих полів треба додати буде введення інформації вручну з таблички наприклад з статичниси целами
 */

        let dict = device.getMobileDeviceInfo()
        print(dict)
    }

    // MARK: - IBActions
    
    @IBAction func clicked(_ sender: Any) { //private

        // нуль бо в тебе ще нічого не почалося і це default значення яке ти сам і вказав
        //        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        //ти ж час пишеш код і те шо ти вказав те і отримаєш
        // + можна ж продебажити і глянути чого тут 0,0
        print(currentLocation.latitude, currentLocation.longitude) // first time always (0,0). Need some observer or I don't know(
        self.currentLocation = LocationService.shared.requestLocation()
        print(self.currentLocation)
    }
}
