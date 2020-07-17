//
//  AnsweredByViewModel.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 04/07/20.
//  Copyright © 2020 annam. All rights reserved.
//

import Foundation

class AnsweredByViewModel {
    
    init(model: [GetAnsweredItemsData]? = nil) {
        if let inputModel = model {
            getAnsweredByResult = inputModel
        }
    }
    
    var numberOfRows = 0
    var getAnsweredByResult = [GetAnsweredItemsData]()

    private func prepareTableDataSource(response: GetAnsweredByResponse) {
        getAnsweredByResult = response.items ?? []
        numberOfRows = response.items?.count ?? 0
    }
    
    func getAnsweredByVM(completion: @escaping () -> ()){
        InteractionManager().getAnsweredByIM(completion: { (result) in
            self.prepareTableDataSource(response: result!)
            completion()
        })
    }

}

