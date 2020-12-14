//
//  CommitDisplayViewController.swift
//  LastCommitsToReadIn
//
//  Created by Edgar Jr on 12/13/20.
//

import UIKit

struct Commit
{
    var commitAuthor: String = ""
    var commitHash: String = ""
    var commitMessage: String = ""
}

class CommitDisplayViewController: UIViewController
{
    @IBOutlet weak var commitDisplayTableView: UITableView!
    var commitArray: [Commit] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Last Commits To Read In"
        commitDisplayTableView.tableFooterView = UIView()
        getLatestCommits()
    }
    
    func getLatestCommits()
    {
        guard let url = URL(string: "https://api.github.com/search/commits?per_page=100&q=language:Swift&sort=committer-date&order=desc")
        else
        {
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "GET"
        //urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/vnd.github.cloak-preview+json", forHTTPHeaderField: "Accept")
        //urlRequest.addValue("q=committer-date:>2020-12-12 sort:committer-date-desc", forHTTPHeaderField: "Query")
        var commitShaString, commitMessageString, commitAuthorString: String
        let task = URLSession.shared.dataTask(with: urlRequest)
            {
                (data, response, error) -> Void in
                guard error == nil
                else
                {
                    print("Error while fetching github: \(String(describing: error))")
                    return
                }
                guard let data = data, let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                else
                {
                    print("Nil data received from fetching github service")
                    return
                }
                for dict in json
                {
                    if dict.key == "items"
                    {
                        if let items = dict.value as? [[String: Any]]
                        {
                            for dict in items
                            {
                                if let commitDict = dict["commit"] as? [String: Any]
                                {
                                    if let message = commitDict["message"] as? String
                                    {
                                        commitMessageString = message
                                    }
                                    if let authorDict = commitDict["author"] as? [String: Any]
                                    {
                                        if let author = authorDict["name"] as? String
                                        {
                                            commitAuthorString = author
                                        }
                                    }
                                    if let shaValue = dict["sha"] as? String
                                    {
                                        commitShaString = shaValue
                                    }
                                }
                                self.commitArray.append(Commit(commitAuthor: commitAuthorString, commitHash: commitShaString, commitMessage: commitMessageString))
                            }
                        }
                    }
                }
            }
        task.resume()
    }
}

extension CommitDisplayViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return commitArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "lastCommitCell"
        if let cell = commitDisplayTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? LastCommitCell
        {
            let commit = commitArray[indexPath.row]
            cell.setUpUsing(commit)
            return cell
        }
        return UITableViewCell()
    }
}

extension CommitDisplayViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 144.0
    }
}
