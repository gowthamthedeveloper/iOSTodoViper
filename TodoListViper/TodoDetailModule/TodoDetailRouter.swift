//
//  TodoDetailRouter.swift
//  TodoListViper
//
//  Created by Alfian Losari on 7/2/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import UIKit

class TodoDetailRouter: TodoDetailRouterProtocol {
    
    func navigateBackToListViewController(from view: TodoDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static func createTodoDetailRouterModule(with parentView: TodoListViewProtocol, todo: TodoItem) -> UIViewController {
        
        guard let todoDetailVC = storyboard.instantiateViewController(withIdentifier: "TodoDetailViewController") as? TodoDetailViewController else {
            fatalError("Invalid view controller type")
        }
        
        let presenter: TodoDetailPresenter & TodoDetailInteractorOutputProtocol = TodoDetailPresenter()
        todoDetailVC.presenter = presenter
       
        let interactor: TodoDetailInteractorInputProtocol = TodoDetailInteractor()
        interactor.todoItem = todo
        interactor.presenter = presenter

        let router: TodoDetailRouterProtocol = TodoDetailRouter()
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = todoDetailVC
       
        presenter.parentView = parentView
        
        return todoDetailVC
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
