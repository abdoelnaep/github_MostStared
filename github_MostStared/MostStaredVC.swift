//
//  MostStaredVC.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import UIKit

class MostStaredVC: UIViewController {
    @IBOutlet var repositoriesTableView: UITableView!
    var pageNumper = 1
    var hasMoreStars = true
    var repositories: [repoElement] = []
    var last30Days: Date = .init()
    var dateString: String = ""
    var dateStringPassed: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        getTargetDate()
        configureTableView()
        getRepositories(pageNumber: 1, dateString: dateString)
    }
    
    func getTargetDate() {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = -30
        last30Days = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
        print(currentDate)
        print(last30Days)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale(identifier: "en")

        dateString = dateFormatter.string(from: last30Days)
        print(dateString)
    }
    
    func configureTableView() {
        repositoriesTableView.register(UINib(nibName: String(describing:
            RepositoryCell.self), bundle: nil), forCellReuseIdentifier:
        String(describing: RepositoryCell.self))
    }

    func getRepositories(pageNumber: Int, dateString: String) {
        showLoadingView()
        APIService.sharedService.getRepositories(pageNum: pageNumper, past30Days: dateString) { (repositories: repos?,_) in
                self.dismissLoadingView()
                guard let repositories = repositories else {
                    return
                }
                if repositories.items.count < 30 {
                    self.hasMoreStars = false
                }
             
                self.repositories.append(contentsOf: repositories.items)

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
        repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell
    {
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier:
            String(describing: RepositoryCell.self), for: indexPath) as?
            RepositoryCell else { return UITableViewCell() }
        cell.configureCell(with: repositories[indexPath.row])
        
        return cell
    }
 
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMoreStars else { return }
            
        if scrollView == repositoriesTableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >=
                (scrollView.contentSize.height)
            {
                pageNumper += 1
                getRepositories(pageNumber: pageNumper, dateString: dateString)
            }
        }
    }
}
