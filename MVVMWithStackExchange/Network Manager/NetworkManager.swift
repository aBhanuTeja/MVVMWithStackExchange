//
//  NetworkManager.swift
//  SampleURLSession
//
//  Created by Bhanuteja on 30/06/20.
//  Copyright © 2020 Bhanu. All rights reserved.
//

import Foundation
import UIKit

final class RequestMethod {
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 60
        return urlRequest
    }
}

class NetworkManager {
    
    static let sharedService = NetworkManager()
    
    func methodType(requestType: RequestMethod.Method, urlString: String,
                    params: [String: Any]? = nil,
                    completion:((_ responseData: Data?, _ statusCode: Bool)->Void)?) -> Void{
        if let reachability = Reachability(), !reachability.isReachable {
            print("Please check your Internet Connection")
            return
        }
        print("URL =====>\(urlString)")
        guard let url = URL(string: urlString) else {
            print("Something went wrong")
            return
        }
        var urlRequest = RequestMethod.request(method: requestType, url: url)
        
        if params != nil{
            let postData = try? JSONSerialization.data(withJSONObject: params!, options: .init(rawValue: 0))
            urlRequest.httpBody = postData
            
            let jsonInputData = try? JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted)
            let prettyString = String(data:jsonInputData!, encoding:String.Encoding.utf8)
            print("params ====>\(prettyString!)")
        }
        self.sessionWithRequest(urlRequest: urlRequest, completion: completion)
    }
    
    //Response
    func sessionWithRequest(urlRequest: URLRequest,
                            completion:((_ responseData: Data?, _ status: Bool) -> Void)?) -> Void{
        let sessionConfiguration =  URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConfiguration)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            let code = httpResponse?.statusCode
            if error == nil && data != nil {
                var jsonResponse: Any?
                do{
                    jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .init(rawValue: 0))
                   // print(jsonResponse as Any)
                }catch let error{
                    print(error)
                }
                if jsonResponse != nil{
                    if completion != nil {
                        switch code {
                        case 200:
                            completion!(data, true)
                        default:
                            print("Something went wrong")
                        }}
                }else{
                    print("Something went wrong")
                }}
            else {
                print("Something went wrong")
            }
        }
        dataTask.resume()
    }
}
