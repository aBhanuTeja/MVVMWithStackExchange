//
//  InteractionManager.swift
//  SampleMVVMwithURLSession
//
//  Created by Bhanuteja on 30/06/20.
//  Copyright © 2020 Bhanu. All rights reserved.
//

import Foundation

struct InteractionManager {
    func getQuestionsListIM(completion: @escaping (QuestionResponse?)->()) {
        NetworkManager.sharedService.methodType(requestType: .GET,
                                    urlString: APIURL.getAllQuestions.apiString,
                                    params: nil,
                                    completion: { (response, status) in
                                        DispatchQueue.main.async {
                                            if status{
                                                let questionRes = try? JSONDecoder().decode(QuestionResponse.self, from: response!)
                                                completion(questionRes)
                                            }
                                        }
        })
    }
    
    func getAnsweredByIM(questionID: Int, completion: @escaping (GetAnsweredByResponse?)->()) {
        NetworkManager.sharedService.methodType(requestType: .GET,
                                    urlString: APIURL.BASE_URL + "/\(questionID)" + APIURL.getAnsweredBy.apiString,
                                    params: nil,
                                    completion: { (response, status) in
                                        DispatchQueue.main.async {
                                            if status{
                                                let getAnsweredByRes = try? JSONDecoder().decode(GetAnsweredByResponse.self, from: response!)
                                                completion(getAnsweredByRes)
                                            }
                                        }
        })
    }
}
