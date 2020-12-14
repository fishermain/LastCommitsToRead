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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Last Commits To Read In"
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
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
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
