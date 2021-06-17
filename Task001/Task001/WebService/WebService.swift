//
//  WebService.swift
//  Task001
//
//  Created by Bhavin J kansara on 6/16/21.
//

import UIKit
import SwiftyJSON
import Alamofire

class WebService: NSObject {
    var operationQueue = OperationQueue()
    // Call with Raw/Json Parameter
    func CallGlobalAPI(url:String, headers:[String:String],parameters:NSDictionary, HttpMethod:String, ProgressView:Bool,uiView :UIView, NetworkAlert:Bool, responseDict:@escaping ( _ jsonResponce:JSON?, _ strErrorMessage:String ) -> Void ) {
        print("URL: \(url)")
        print("Headers: \n\(headers)")
        print("Parameters: \n\(parameters)")
        //Loader Required or Not
        
       
        
        let operation = BlockOperation.init {
            DispatchQueue.global(qos: .background).async {
                //Internet Checking
                if isConnectedToNetwork() {
                    if (HttpMethod == "POST") {
                        var req = URLRequest(url: try! url.asURL())
                        req.httpMethod = "POST"
                        req.allHTTPHeaderFields = headers
                        req.setValue("application/json", forHTTPHeaderField: "content-type")
                        req.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
                        req.timeoutInterval = 30 // 10 secs

                        Alamofire.request(req).responseJSON {
                            response in
                            
                            switch (response.result) {
                            case .success:
                                
                                if((response.result.value) != nil) {
                                    let jsonResponce = JSON(response.result.value!)
                                    print("Responce: \n\(jsonResponce)")
                                    DispatchQueue.main.async {
                                        
                                        responseDict(jsonResponce,"")
                                    }
                                }
                                break
                            case .failure(let error):
                                
                                let message : String
                               
                                if let httpStatusCode = response.response?.statusCode {
                                    print(httpStatusCode)
                                    switch(httpStatusCode) {
                                    case 400:
                                        message = "Username or password not provided."
                                    case 500:
                                        message = "Time Out"
                                    case 401:
                                        message = "The email/password is invalid."
                                       
                                        responseDict([:],message)
                                    default: break
                                    }
                                }
                                else {
                                    message = error.localizedDescription
                                    
                                    let jsonError = JSON(response.result.error!)
                                    DispatchQueue.main.async {
                                        
                                        responseDict(jsonError,"")
                                    }
                                }
                                break
                            }
                        }
                    }
                        
                    else if (HttpMethod == "GET") {
                        var req = URLRequest(url: try! url.asURL())
                        req.httpMethod = "GET"
                        req.allHTTPHeaderFields = headers
                        req.setValue("application/json", forHTTPHeaderField: "content-type")
                        req.timeoutInterval = 30 // 10 secs
                        
                        
                        Alamofire.request(req).responseJSON {
                            response in
                            
                            switch (response.result) {
                            case .success:
                                
                                if((response.result.value) != nil) {
                                    let jsonResponce = JSON(response.result.value!)
                                    
                                    // print("Responce: \n\(jsonResponce)")
                                    
                                    DispatchQueue.main.async {
                                       
                                        responseDict(jsonResponce,"")
                                    }
                                }
                                
                                break
                                
                            case .failure(let error):
                                
                                let message : String
                               // showAlertMsg(Message: "Something Went Wrong..Try Again", AutoHide: false)
                                if let httpStatusCode = response.response?.statusCode {
                                    switch(httpStatusCode) {
                                    case 400:
                                        message = "Something Went Wrong..Try Again"
                                    case 401:
                                        message = "Something Went Wrong..Try Again"
                                    case 500:
                                        message = "Time Out"
                                    case 200:
                                        message = "Something Went Wrong..Try Again"
                                        // print("!Error status code: %d",httpStatusCode)
                                        DispatchQueue.main.async {
                                          
                                            responseDict([:],message)
                                        }
                                        
                                    default: break
                                    }
                                }
                                else {
                                    message = error.localizedDescription
                                    
                                    let jsonError = JSON(response.result.error!)
                                    DispatchQueue.main.async
                                        {
                                       
                                        responseDict(jsonError,"")
                                    }
                                }
                                break
                            }
                        }
                    }
                }
                else {
                    print("No internet Available")
                }
            }
        }
        operation.queuePriority = .normal
        operationQueue.addOperation(operation)
        
    }
}
