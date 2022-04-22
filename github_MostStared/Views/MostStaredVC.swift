//
//  MostStaredVC.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import UIKit

class MostStaredVC: UIViewController {
    @IBOutlet var repositoriesTableView: UITableView!
    var pageNumber = 1
    var hasMoreStars = true
    var repositories: [RepoElement] = []

    var reposVM = ReposVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureTableView()
        getRepositories(pageNumber: 1)
    }

    func configureTableView() {
        repositoriesTableView.register(UINib(nibName: String(describing:
            RepositoryCell.self), bundle: nil), forCellReuseIdentifier:
        String(describing: RepositoryCell.self))
    }

    func getRepositories(pageNumber: Int) {
        showLoadingView()

        reposVM.getReps(pageNumber: "\(pageNumber)") { _, _ in
            self.dismissLoadingView()

            DispatchQueue.main.async {
                self.repositoriesTableView.reloadData()
            }
        }
    }
}

extension MostStaredVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        reposVM.numbOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell
    {
        let vm = reposVM.repoIndex(at: indexPath)
        
        let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCell
        cell.configureCell(with: vm)
        return cell
    }
 
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMoreStars else { return }
            
        if scrollView == repositoriesTableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >=
                (scrollView.contentSize.height)
            {
                pageNumber += 1
                getRepositories(pageNumber: pageNumber)
            }
        }
    }
}
