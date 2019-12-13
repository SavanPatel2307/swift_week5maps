//
//  ViewController.swift
//  Week5withMaps
//
//  Created by Tilakbhai Suthar on 2019-10-04.
//  Copyright © 2019 Tilakbhai Suthar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var mapView: MKMapView!
    
    private let schools = ["Barrie", "Orilla", "Owen Sound"]
    
    private let levels = ["-2", "-1", "0", "+1", "+2"]
    
    private let schoolsDegrees = [
        0: ["latitude": 44.407380, "longitude": -79.656677],
        1: ["latitude": 44.58163, "longitude": -79.43334],
        2: ["latitude": 44.56828, "longitude": -80.91916]
    ]
    
    private let zoomLevels = [
        0: 2,
        1: 1,
        2: 0.5,
        3: 0.1,
        4: 0.01
    ]
    
    private let schoolsComponent = 0
    private let levelsComponent = 1
    
    private var latestLocation = ""
    
    private var coordinates = CLLocationCoordinate2D()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == schoolsComponent)
        {
            return schools.count
        }
        else {
            return levels.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:
        Int) -> String? {
        
        if (component == schoolsComponent){
            return schools[row]
        }
        else {
            return levels[row]
        }
        
    }
    
    
    private let food = [
        "Chicken Tandoori" , "Chicken masala" , "Chikken Tikka", "Panner Butter Masala",
        "Panner Tikka Masala", "Panner Pasanda", "Paneer Bhurji",
        "Veg Kholapuri", "Veg Kadai", "Veg Tawa", "Cauliflower Masala", "Bhindi",
        "Butter Naan", "Roti", "Paratha", "Kulcha"
        
    ]
    
    let simpleTableIdentifier = "simpleTableIdentifier";
    
    private var tableData = [
        "No data",
        "No data",
        "No data",
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default, reuseIdentifier: simpleTableIdentifier)
        }
        let image = UIImage(named: "arrow")
        cell?.imageView?.image = image
        let highlightedImage = UIImage(named: "blackarrow")
        cell?.imageView?.highlightedImage = highlightedImage
        
        cell?.textLabel?.text = food[indexPath.row]
        
        
        
        return cell!
    }
    
    //Mark: Table View Delegate methods
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return indexPath.row % 4
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.row == 0 ? nil : indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowValue = food[indexPath.row]
        let message = "You have ordered \(rowValue)"
        let controller = UIAlertController(title: "Row Selected", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes I did", style: .default, handler: nil)
        
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
    
    
    
    @IBAction func onLocateClick(_ sender: Any) {
        let schoolRow =
                pickerView.selectedRow(inComponent: schoolsComponent)
            let levelRow =
                pickerView.selectedRow(inComponent: levelsComponent)
            let school = schools[schoolRow]
            let level = levels[levelRow]
        
        
            let latitude = (schoolsDegrees[schoolRow]?["latitude"])!
            let longitude = schoolsDegrees[schoolRow]?["longitude"]
            
            
            let lanDelta = zoomLevels[levelRow]
            let lonDelta = zoomLevels[levelRow]
        
            let span = MKCoordinateSpan(latitudeDelta: lanDelta!, longitudeDelta: lonDelta!)

            coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude!)
            
            let region = MKCoordinateRegion(center: coordinates, span: span)
        
            mapView.setRegion(region, animated: true)
            
            latestLocation = String(school);
            tableData.insert(latestLocation, at: 0)
            tableView.reloadData()
    }
    
    @IBAction func onAddPinClick(_ sender: Any) {
       let annotation  = MKPointAnnotation()
        annotation.title = "New Pin"
        annotation.subtitle = "There's a pin here now!"
        annotation.coordinate = coordinates
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.selectRow(0, inComponent: schoolsComponent, animated: true)
        pickerView.selectRow(2, inComponent: levelsComponent, animated: true)
    }


}

