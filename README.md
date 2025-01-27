# UsersAndFibonacci
Simple app to fetch users from a public API and show Fibonacci sequence.

- Download the project, open TableViewTest.xcodeproj. 
- It's ready to Run the app, there is no 3rd party dependencies.

##################################################

- Tech stack: iOS, Swift.
- Frameworks: SwiftUI, UIKit.
- Arquitetura: Clean architecture + MVVM.


Eu optei por implementar dois exemplos: 
1. Listagem de usuários consumindo uma API pública.
2. Calcular e exibir sequência de Fibonacci de acordo com o input do usuário.

A primeira tela foi implementada em SwiftUI e representa um Menu com dois botões, o primeiro botão redireciona para a tela de usuários, e o último para a tela de Fibonacci, ambas as telas utilizando UIKit.

Decidi aplicar alguns conceitos da Clean Architecture devido à sua maior adaptabilidade para uma futura modularização do projeto, que é uma necessidade bem comum em projetos de maior escala. Se houvesse mais tempo poderia criar ainda protocolos como UserRepository e UserUseCase na camada de Domain, e sua implementação UserRepositoryImpl na camada de Data. Mantendo uma clara separação de responsabilidades, permitindo que o código seja testável e de fácil manutenção.
Utilizei URL session para fazer a requisição dos usuários, e as informações foram apresentadas em uma UITableViewController.

Adicionei testes unitários para as seguintes viewModels: - UserViewModelTests.swift - FibonacciViewModelTests.swift

Caso houvesse mais tempo também poderia implementar funcionalidades como edição dos dados do usuário, upload de imagem, além de incluir testes de snapshots (UI).
