//
//  HomeViewController.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 30/06/20.
//  Copyright © 2020 annam. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var questionsTableView: UITableView!
    
    private var viewModel = GetQuestionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNib()
        getQuestionsData()
    }
    
    private func getQuestionsData() {
        ActivityIndicator.sharedIndicator.showLoadingIndicator(onView: view)

        viewModel.getQuestionsListVM(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.questionsTableView.reloadData()
                ActivityIndicator.sharedIndicator.hideLoadingIndicator()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func loadNib() {
        QuestionsTableCell.registerWithTableViewNib(questionsTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsTableCell.reuseIdentifier, for: indexPath) as! QuestionsTableCell
        cell.setUpQuestionData(viewModel.questionResult[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answeredByVC = self.storyboard?.instantiateViewController(identifier: "AnsweredByVC") as! AnsweredByViewController
        answeredByVC.selectedQuestion = viewModel.questionResult[indexPath.row]
        self.navigationController?.pushViewController(answeredByVC, animated: true)
    }
}
