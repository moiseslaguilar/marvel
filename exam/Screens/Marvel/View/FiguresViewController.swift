//
//  ViewController.swift
//  exam
//
//  Created by Moises Lugo on 16/02/22.
//

import UIKit
import Lottie

class FiguresViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    private var animationView: AnimationView!

    lazy var viewModel = {
        FiguresViewModel()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }

    func initView() {
           // TableView customization
           tableView.delegate = self
           tableView.dataSource = self
           tableView.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
           tableView.separatorColor = .white
           tableView.separatorStyle = .singleLine
           tableView.tableFooterView = UIView()
           tableView.allowsSelection = false

           tableView.register(MarvelCell.nib, forCellReuseIdentifier: MarvelCell.identifier)
       }

    func initViewModel() {
           viewModel.getFigures()
           viewModel.reloadTableView = { [weak self] in
               DispatchQueue.main.async {
                   self?.tableView.reloadData()
               }
           }
       }
    
    private func loadAnimation(){
        animationView = .init(name: "ironman")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView.play { (finished) in
            self.animationView!.isHidden = true
        }

    }
    

}


// MARK: - UITableViewDelegate

extension FiguresViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: - UITableViewDataSource

extension FiguresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.figureCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarvelCell.identifier, for: indexPath) as? MarvelCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
                cell.cellViewModel = cellVM
        loadAnimation()
        return cell
    }
}
