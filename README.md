# Descrição do Projeto

## Visão Geral

Este projeto foi desenvolvido em Swift, visando oferecer uma aplicação iOS de alta qualidade e performance. Abaixo, detalharemos as principais escolhas e tecnologias utilizadas.

## Linguagem e Versão do iOS

- **Linguagem**: Swift
- **Construtor de UI**: UIKit
- **iOS Target**: 12.0

## Gerenciador de Frameworks

- **CocoaPods**

O CocoaPods foi escolhido como gerenciador de dependências pela sua popularidade e facilidade de uso. Ele nos permite integrar facilmente bibliotecas externas ao projeto.

## Frameworks Utilizados

- **KingFisher**: Utilizado para carregamento e cache de imagens, proporcionando uma experiência de usuário mais rápida e eficiente.
- **SnapKit**: Facilita a criação de layouts programáticos, substituindo o uso de Auto Layout com uma sintaxe mais clara e concisa.
- **RxSwift**: Implementa a programação reativa, facilitando o gerenciamento de eventos assíncronos e aumentando a escalabilidade do código.
- **SwiftLint**: Garante a padronização do código, identificando e corrigindo automaticamente violações de estilo.

## Estrutura de Pastas

### Core

A pasta `Core` contém várias subpastas com funções essenciais para o projeto:

- **Strings**: Gerencia as strings localizáveis da aplicação.
- **API**: Configurações e implementação das chamadas de API.
- **Coordinator**: Define o protocolo de coordenação de navegação entre as telas.
- **UI**: Contém componentes globais, protocolos para ViewCode e métodos auxiliares.

### Scene

A pasta `Scene` organiza os diferentes fluxos da aplicação. Cada fluxo contém estruturas básicas e uma pasta para cada tela. Cada tela contém as estrturuas básicas para a sua construção e pode conter uma pasta `Components` para views menores que são usadas apenas dentro do respectivo fluxo, por exemplo, células de uma UICollectionView específicas para uma tela.

Neste projeto, temos apenas o fluxo `Store`, que é subdividido em `Home` e `Details`.

- **Store**
  - **Home**: Contém a `StoreHomeView`, `StoreHomeViewModel`, `StoreHomeViewController` e uma pasta `Components`.
  - **Details**: Contém a `StoreDetailsView`, `StoreDetailsViewModel` e `StoreDetailsViewController`.
  - **StoreCoordinator**: Gerencia a navegação entre as telas do fluxo.
  - **StoreService**: Implementa as chamadas de API relacionadas ao fluxo.

## Arquitetura

O projeto segue o padrão de arquitetura MVVM-C (Model-View-ViewModel-Coordinator):

- **Model**: Define a estrutura dos dados e implementa a lógica de negócios.
- **View**: Responsável pela interface do usuário, implementada com UIKit e ViewCode.
- **ViewModel**: Gerencia a lógica de apresentação e comunica-se com a View através de bindings reativos com RxSwift.
- **Coordinator**: Gerencia a navegação entre as telas, garantindo um fluxo de navegação claro e desacoplado.

## Testes Unitários

Os testes unitários foram implementados para as ViewModels, garantindo a qualidade e a confiabilidade da lógica de apresentação. Utilizamos o framework XCTest para criar testes robustos e organizados.

## Chamadas de API

As chamadas de API foram feitas usando `URLSession` e modelos `Codable` para facilitar a serialização e desserialização dos dados. Isso garante que a comunicação com o servidor seja eficiente e segura.
