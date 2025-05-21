//
//  DefaultBDUIMapper.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 15.05.2025.
//
import UIKit

final class DefaultBDUIMapper: BDUIMapperProtocol {
    
    private var context: [String: UIView] = [:]

    func makeView(from viewType: ViewType) -> UIView {
        switch viewType {
            
        case .contentView(let model):
            let view = UIView()
            view.backgroundColor = UIColor(named: model.content.backgroundColor ?? "white")
            let subviews = model.subviews.map { makeView(from: $0) }
            subviews.forEach { view.addSubview($0) }
            guard let stack = subviews.first as? UIStackView else {
                subviews.forEach { view.addSubview($0) }
                return view
            }
            stack.translatesAutoresizingMaskIntoConstraints = false
               
            view.addSubview(stack)
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: view.topAnchor),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                stack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            return view

        case .stackView(let model):
            let stack = UIStackView()
            stack.axis = .vertical
            model.subviews.map { makeView(from: $0) }.forEach { stack.addArrangedSubview($0) }
            return stack

        case .label(let model):
            let label = UILabel()
            label.text = model.content.text
            return label

        case .button(let model):
            let button = Button()
            button.configure(with: .init(title: model.style.title, style: ButtonViewModel.Style(rawValue: model.style.style ?? "primary") ?? .primary))
            if let action = model.action {
                button.addAction(UIAction { _ in
                    self.handleAction(action)
                }, for: .touchUpInside)
            }
            return button
            
        case .textField(let model):
            let textField = TextField()
            textField.configure(with: .init(placeholder: model.style.placeholder, style: TextFieldViewModel.Style(rawValue: model.style.style ?? "filledGray") ?? .filledGray))
            context[model.id] = textField
            return textField
            
        case .logo(let model):
            let logo = Logo()
            logo.configure(with: .init(
                size: CGSize(width: model.size?.Width ?? 0, height: model.size?.Height ?? 0),
                color: LogoViewModel.Color(rawValue: model.color ?? "white") ?? .primary,
                lineWidth: CGFloat()))
            return logo
            
        case .styledAccount(let model):
            let styledAccount = StyledAccountView()
            styledAccount.configure(with: StyledAccountViewModel.init(
                    accountType: model.accountType,
                    balance: model.balance,
                    currency: model.currency,
                    style: StyledAccountViewModel.Style(rawValue: model.style) ?? .filledRed
                )
            )
            return styledAccount
        case .scrollView(let model):
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 8
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(stack)
            
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                stack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                stack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                stack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                stack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
            ])
            
            model.subviews.forEach { subviewType in
                let subview = makeView(from: subviewType)
                subview.translatesAutoresizingMaskIntoConstraints = false
                stack.addArrangedSubview(subview)
            }
            
            return scrollView
        }
    
    }

    private func handleAction(_ action: ButtonAction) {
        switch action.type {
        case "submit":
            guard
                let fieldIDs = action.textFieldIDs,
                let endpoint = action.endpoint,
                let url = URL(string: endpoint)
            else {
                print("Некорректные данные в экшене")
                return
            }

            let formData = fieldIDs.reduce(into: [String: String]()) { result, id in
                if let textField = context[id] as? UITextField {
                    result[id] = textField.text ?? ""
                }
            }

            sendFormData(formData, to: url, method: action.httpMethod ?? "POST")

        default:
            break
        }
    }

    private func sendFormData(_ data: [String: String], to url: URL, method: String) {
        var request = URLRequest(url: url)
        request.httpMethod = method.uppercased()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(data)
        } catch {
            print("Ошибка при кодировании данных: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse {
                print("Ответ сервера: \(httpResponse.statusCode)")
                if let data = data, let body = String(data: data, encoding: .utf8) {
                    print("Тело ответа: \(body)")
                }
            }
        }

        task.resume()
    }
}
