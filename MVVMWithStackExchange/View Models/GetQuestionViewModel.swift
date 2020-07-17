//
//  GetQuestionViewModel.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 30/06/20.
//  Copyright © 2020 annam. All rights reserved.
//

import Foundation

class GetQuestionViewModel {
    
    init(model: [QuestionItemsData]? = nil) {
        if let inputModel = model {
            questionResult = inputModel
        }
    }
    
    var numberOfRows = 0
    var questionResult = [QuestionItemsData]()

    private func prepareTableDataSource(response: QuestionResponse) {
        questionResult = response.items ?? []
        numberOfRows = response.items?.count ?? 0
    }
    
    func getQuestionsListVM(completion: @escaping () -> ()){
        InteractionManager().getQuestionsListIM(completion: { (result) in
            self.prepareTableDataSource(response: result!)
            completion()
        })
    }
}
