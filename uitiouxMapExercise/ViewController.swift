//
//  ViewController.swift
//  uitiouxMapExercise
//
//  Created by SunTelematics on 23/03/18.
//  Copyright © 2018 SunTelematics. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var myResArray = [[String:AnyObject]]()
    var tempDict : [String:AnyObject] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
//        callByAlamofire()
        callByUrlSession()
    }
    func callByUrlSession(){
    
    
        let urlString: String = "http://maps.google.com/maps/api/directions/json?origin=Chennai&destination=Madurai&sensor=false"
        let theURL = URL(string: urlString)
        
        // set up the session
//        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let session = NSURLSession(configuration: config)
        
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        let task = session.dataTask(with: theURL!) { (data, response, error) in
            guard error == nil else {
                print("error")
                return
            }
            guard let responseData = data else {
                print(" did not receive data")
                return
            }
            
            do{
                guard let myResponse = try JSONSerialization.jsonObject(with: responseData, options:[]) as? [String: AnyObject] else {
                    print("error")
                    return
                }
            
                _  = myResponse["geocoded_waypoints"] as! [[String:AnyObject]]

                let routesArr = myResponse["routes"] as! [[String:AnyObject]]
                let legsArr = routesArr[0]["legs"] as! [[String : AnyObject]]
                
                let stepsArr = legsArr[0]["steps"] as! [[String : AnyObject]]
                self.myResArray = stepsArr
                
                
                
                print(self.myResArray)
                
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
                
            }catch{
                print("error trying to convert data to JSON")
                return
            }
            
        
        
        }
        task.resume()
        
    }
    
    func callByAlamofire(){
        
       
        WebService().callDriveBookingAPI { (value, succ) in
            print("LoginVC - Response",value)
            if succ {
                                let geocoded_waypointsArr = (value as! [String:AnyObject])["geocoded_waypoints"] as! [[String:AnyObject]]
                
                let routesArr = (value as! [String:AnyObject])["routes"] as! [[String:AnyObject]]
                let legsArr = routesArr[0]["legs"] as! [[String : AnyObject]]
                
                let stepsArr = legsArr[0]["steps"] as! [[String : AnyObject]]
                self.myResArray = stepsArr
                
                
             
                print(self.myResArray)
                
                self.myTableView.reloadData()
            }
            else {
                print("Fail")
            }
        }
        
        
//        WebService().callDriveBookingAPI{ (value,success) in
//            print("LoginVC - Response",value)
//
//
//            if success {
////                let geocoded_waypointsArr = (value as! [String:AnyObject])["geocoded_waypoints"] as! [[String:AnyObject]]
////                let routesArr = (value as! [String:AnyObject])["routes"] as! [[String:AnyObject]]
////
////
////                let legsArr = routesArr[0]["legs"] as! [[String : AnyObject]]
////
////                let distanceDict = legsArr[0]["distance"]
////                distanceDict["text"]
//
//
////                guard let myResponse = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as? [String: AnyObject] else {
////                    print("error ")
////                    return
////                }
//
//                let myResponse = value as? [String : AnyObject]
//
//                let getData = myResponse["routes"]
//                let objectData = getData!.firstObject
//                let legsData = objectData!!["legs"]
//
//                let stepsData = legsData!!.firstObject!!["steps"]
//                self.myResArray = stepsData as! [[String:AnyObject]]
//                print(self.myResArray)
//
//                self.myTableView.reloadData()
//            }
//            else {
//                print("Fail")
//            }
//        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController : UITableViewDataSource,UITableViewDelegate{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myResArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("myCellID", forIndexPath: indexPath) as! MyCellClass
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellID", for: indexPath) as! MyCellClass
        tempDict.removeAll()
        tempDict = myResArray[indexPath.row]["distance"] as! [String:AnyObject]
        cell.distanceTextLabel.text =   "\(tempDict["text"]!)"
        cell.distanceValueLabel.text = "\(tempDict["value"]!)"
        
        tempDict.removeAll()
        tempDict = myResArray[indexPath.row]["duration"] as! [String:AnyObject]
        cell.durationTextLabel.text = "\(tempDict["text"]!)"
        cell.durationValueLabel.text = "\(tempDict["value"]!)"
        
        tempDict.removeAll()
        tempDict = myResArray[indexPath.row]["end_location"] as! [String:AnyObject]
        cell.endLat.text = "\(tempDict["lat"]!)"
        cell.endLng.text = "\(tempDict["lng"]!)"
        
        tempDict.removeAll()
        tempDict = myResArray[indexPath.row]["start_location"] as! [String:AnyObject]
        cell.startLat.text = "\(tempDict["lat"]!)"
        cell.startLng.text = "\(tempDict["lng"]!)"
        
        return cell
    }
}
class MyCellClass: UITableViewCell {
    
    @IBOutlet weak var distanceTextLabel: UILabel!
    @IBOutlet weak var distanceValueLabel: UILabel!
    
    
    @IBOutlet weak var durationTextLabel: UILabel!
    @IBOutlet weak var durationValueLabel: UILabel!
    
    
    @IBOutlet weak var endLat: UILabel!
    @IBOutlet weak var endLng: UILabel!
    
    @IBOutlet weak var startLat: UILabel!
    @IBOutlet weak var startLng: UILabel!
    
    
}
