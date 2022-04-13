//
//  MostStaredVC.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import UIKit

class MostStaredVC: UIViewController {
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    
    var repositories:[repoElement] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getRepositories()

        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
        repositoriesTableView.register(UINib(nibName: String(describing:
        RepositoryCell.self), bundle: nil), forCellReuseIdentifier:
             String (describing: RepositoryCell.self))
    }

    func getRepositories() {
        APIService.sharedService.getRepositories { (repositories: repos?,
            error) in
            guard let repositories = repositories else {
                return
            }
            print(repositories)
            self.repositories = repositories.items
            DispatchQueue.main.async {
                self.repositoriesTableView.reloadData()
            }
    }
    }
}

//MARK:
extension MostStaredVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
//            TableviewDataSource
            repositories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier:
             String(describing: RepositoryCell.self), for: indexPath) as?
            RepositoryCell else {return UITableViewCell()}
        cell.configureCell(with: repositories[indexPath.row])
        return cell
    }
}
