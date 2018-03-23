//
//  CallService.swift
//  DriveBooking
//
//  Created by Raja Bhuma on 12/05/17.
//  Copyright © 2017 Sun Telematics Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class WebService {
        
    func callDriveBookingAPI(completion: @escaping (_ Data:(Any),_ IsSuccess:Bool) -> ()) {
        
        let theUrlString = "http://maps.google.com/maps/api/directions/json?origin=Chennai&destination=Madurai&sensor=false"
        let theURL = URL(string: theUrlString)
        
        var mutableR = URLRequest.init(url: theURL!)
//        mutableR.httpMethod = "POST"
//        mutableR.allHTTPHeaderFields = ["Content-Type":"application/json","AuthenticationToken":securityKey]
        
//        let ParamsData = try? JSONSerialization.data(withJSONObject: parameterDict, options: .prettyPrinted)
//        print("Input = ",ParamsData!)
//        if (ParamsData != nil) {
//            mutableR.httpBody = ParamsData!
//        }
//        else {
//            completion([:],ResponceCodes.OtherError,false)
//            return
//        }
        
        
        if !(Alamofire.NetworkReachabilityManager()?.isReachable)! {
            completion([:],false)
            return
        }
        
        mutableR.timeoutInterval = 35
        mutableR.allowsCellularAccess = true
        
        Alamofire.request(mutableR)
            .responseJSON { (DataResponce) in
                switch DataResponce.result {
                case .success(let value):
                    completion(value,true)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([:],false)
                    break
                }
        }
        
    }
    
    
//    func callAutoAllAPI(Baseurl:String, Suffix:String,parameterDict: [String:String], completion: @escaping (_ data:(Any),_ success:Bool) -> ()) {
//
//        var parameters = ""
//        for (key,value) in parameterDict {
//            parameters.append(key + "=" + value + "&")
//        }
//        parameters.remove(at: parameters.index(parameters.endIndex, offsetBy: -1))
//
//        let soapLenth = String(parameters.characters.count)
//        let theUrlString = Baseurl
//        let theURL = URL(string: theUrlString)
//        var mutableR = URLRequest.init(url: theURL!)
//        // MUTABLE REQUEST
//
//        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
//        mutableR.httpMethod = "POST"
//        mutableR.httpBody = parameters.data(using: String.Encoding.utf8)
//
//        // AFNETWORKING REQUEST
//
//        Alamofire.request(mutableR)
//            .responseJSON { (DataResponce) in
//                switch DataResponce.result {
//                case .success(let value):
//                    print("From callAutoAllAPI = ",value)
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    print((DataResponce.response?.statusCode)!)
//                    break
//                }
//        }
//
//    }
    
    
//    func callAutoAllAPINew(Baseurl:String, Suffix:String,method:HTTPMethod,parameterDict: [String:String], completion: @escaping (_ data:(Any),_ success:Bool) -> ()) {
//
//        var parameters = ""
//        for (key,value) in parameterDict {
//            parameters.append(key + "=" + value + "&")
//        }
//        parameters.remove(at: parameters.index(parameters.endIndex, offsetBy: -1))
//
//        let soapLenth = String(parameters.characters.count)
//
//        let theUrlString: String!
//        let theURL: URL!
//
//        if method == .get {
//            theUrlString = Baseurl + "/" + Suffix + "?" + parameters
//            theURL = URL.init(string: theUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
//        }
//        else {
//            theUrlString = Baseurl + "/" + Suffix
//            theURL = URL.init(string: theUrlString)!
//        }
//
//        var mutableR = URLRequest.init(url: theURL)
//        // MUTABLE REQUEST
//
//        //        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
//        mutableR.httpMethod = method.rawValue
//
//        if method != .get {
//            mutableR.httpBody = parameters.data(using: String.Encoding.utf8)
//        }
//
//        // AFNETWORKING REQUEST
//
//
//        Alamofire.request(mutableR)
//            .responseJSON { (DataResponce) in
//                //                print(String.init(data: DataResponce.data!, encoding: .utf8)!)
//
//                switch DataResponce.result {
//                case .success(let value):
//                    //                    print(value)
//                    completion(value,true)
//
//                    break
//                case .failure(let error):
//
//                    completion([:],false)
//                    //                    print(error.localizedDescription)
//                    //                    print((DataResponce.response?.statusCode)!)
//                    break
//                }
//
//        }
//
//    }
    
}
