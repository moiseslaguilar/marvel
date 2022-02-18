//
//  FiguresViewModel.swift
//  exam
//
//  Created by Moises Lugo on 16/02/22.
//

import Foundation

class FiguresViewModel: NSObject {
    
    
    private var figuresService: FiguresServiceProtocol

    var reloadTableView: (() -> Void)?
        
        var figures = MarvelFigures()
        
        var figureCellViewModels = [FigureCellViewModel]() {
            didSet {
                reloadTableView?()
            }
        }
        
    
    init(figuresService: FiguresServiceProtocol = FiguresService()) {
        self.figuresService = figuresService
    
    }
    
    func getFigures() {
            figuresService.getFigures { success, model, error in
                if success, let figures = model {
                    self.fetchData(figures: figures)
                } else {
                    print(error!)
                }
            }
        }
    
    func fetchData(figures: MarvelFigures) {
           self.figures = figures // Cache
           var vms = [FigureCellViewModel]()
           for figure in figures {
               vms.append(createCellModel(figure: figure))
           }
           figureCellViewModels = vms
       }
    
    
    
    func createCellModel(figure: Marvel) -> FigureCellViewModel {
        let id = ("\(figure.data.total)")
        let name = ("\(figure.data.limit)")
       
        return FigureCellViewModel(id: id, name: name)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> FigureCellViewModel {
           return figureCellViewModels[indexPath.row]
       }
}
