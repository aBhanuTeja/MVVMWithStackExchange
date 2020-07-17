//
//  AnsweredByViewController.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 04/07/20.
//  Copyright © 2020 annam. All rights reserved.
//

import UIKit

class AnsweredByViewController: UIViewController {

    @IBOutlet weak var answeredByTableView: UITableView!
    
    private var viewModel = AnsweredByViewModel()
    var selectedQuestion: QuestionItemsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAnsweredByData()
        loadNib()
    }
    
    private func getAnsweredByData() {
        ActivityIndicator.sharedIndicator.showLoadingIndicator(onView: view)
        viewModel.getAnsweredByVM(questionID: selectedQuestion!.questionID!,
                                  completion: { [weak self] in
            DispatchQueue.main.async {
                self?.answeredByTableView.reloadData()
                ActivityIndicator.sharedIndicator.hideLoadingIndicator()
            }
        })
    }
}

extension AnsweredByViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func loadNib() {
        AnsweredByTableCell.registerWithTableViewNib(answeredByTableView)
        QuestionsTableCell.registerWithTableViewNib(answeredByTableView)
        answeredByTableView.tableHeaderView = headerView()
    }
    
    private func headerView() -> UIView {
        let cell = answeredByTableView.dequeueReusableCell(withIdentifier: QuestionsTableCell.reuseIdentifier) as! QuestionsTableCell
        cell.setUpQuestionData(selectedQuestion!)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Answered by:"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnsweredByTableCell.reuseIdentifier, for: indexPath) as! AnsweredByTableCell
        cell.setUpAnsweredByData(viewModel.getAnsweredByResult[indexPath.row])
        return cell
    }
}
