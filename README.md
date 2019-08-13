<p align="center">
  <a href="https://cocoapods.org">
    <img src="https://img.shields.io/badge/Cocoapods-Implemented-brightgreen.svg"/>
  </a>
  <a href="https://github.com/Carthage/Carthage">
    <img src="https://img.shields.io/badge/Carthage-Implemented-brightgreen.svg"/>
  </a>
  <a href="https://swift.org/package-manager/">
    <img src="https://img.shields.io/badge/Package%20Manager-Non--implemented-red.svg"/>
  </a>
  <a href="https://swift.org/blog/5-0-release-process/">
    <img src="https://img.shields.io/badge/Language-Swift%205-orange.svg"/>
  </a>
  <a href="">
    <img src="https://img.shields.io/badge/Platform-iOS-lightgrey.svg"/>
  </a>
</p>



# MovieSearch



## Getting Started

1. Install [Xcode](<https://developer.apple.com/xcode/>)

2. Clon or Download [MovieSearch for iOS Source Code](https://github.com/pipemontoya/MovieSearch) or https://github.com/pipemontoya/MovieSearch

3. Open the project location Then, run the following comands:

   ### CocoaPods

   ```bash
   $ pod install
   ```

   if you have not installed [Cocoapods](https://cocoapods.org) , you can install it with [Homebrew](http://brew.sh/) using the following command:

   ```bash
   $ gem install cocoapods
   ```

   

   ### Carthage

   ```bash
   $ carthage update --platform iOS
   ```

   if you have not installed [Carthage](https://github.com/Carthage/Carthage) yet, you can install it with [Homebrew](http://brew.sh/) using the following command:

   ```bash
   $ brew update
   $ brew install carthage
   ```

4. Open "MoviewSearch.xcworkspace" in Xcode.

5. Connect your iPad or iPhone using USB and select it in Xcode's Product menu > Destination.

6. Press CMD+R or Product > Run to install MovieSearch.

   

## Description





### Services 

#### Animator 

1. Animator.swift

   **Responsability**: Animate detail of cell. 

#### Network 

1. ApiService.swift

   **Responsability**: Bring the data from the server to convert them into models within the app

### Business 

1. PagerViewModel.swift

   **Responsability**: Create views to page the categories

2. MoviesViewModel.swift

   **Responsability**:  Manage objects to update movies.

3. MoviesDetailViewModel.swift

   **Responsability**: Manage objects to show movie choosed details brought from Movies.

4. OnlineSearchViewModel.swift

   **Responsability**: Manage objects to search movies by name online.

### ViewControllers

**Responsability**: Communicates the view with viewModels.

1. PagerViewController.swift
2. MoviesViewController.swift
3. MovieDetailViewController.swift
4. OnlineSearchViewController.swft
5. VideoViewController.swift

### Views 

**Responsability**: Contains all ViewControllers with its views.

1. Main.storyboard
2. Movies.storyboard
3. Video.storyboard

####Sub-Views

**Responsability**: Show data of the objects brought from ViewModels.

1. MovieTableViewCell.swift
2. MovieDetailTableViewCell.swift
3. MoreTableViewCell.swift
4. OnlineCollectionViewCell.swift

#### extension 

**Responsability**: Create effects (blur and shadow) in classes iherited from UIView class.

1. UIView.swift

### Models

**Responsability**: Show data brought from server in objects inside the application.

1. Movie.self
2. Video.self



## Questions (es-co)

#### 1. En que consiste el principio de responsabilidad única? Cuál es su propósito?

- El principio de responsabilidad única consiste en que cada clase debe realizar una sola cosa, es decir, por ejemplo se tiene una 'arquitectura' MVVM y se tiene un ViewModel, este solo debe realizar la operacion de datos del controlador. su responsabilidad es operar y actualizar todos los datos mostrados en la vista.

#### 2. Qué características tiene, según su opinión, un “buen” código o código limpio

- Para mi un codigo limpio debe ser un código que sea legible para cualquier desarrollador no importa su nivel, es decir que cualquier desarrollador que trabaje sobre el código,  logre entender cual es la idea del proyecto y lo que hace. También debe tener buenas prácticas tales tener un código bien identado, buenas convenciones para variables y constantes, tener en cuenta las lineas de código de cada método, y algo que en mi concepto es importante es programar en ingles ya que es universal y cualquiera puede entender más facil el código, etc.











