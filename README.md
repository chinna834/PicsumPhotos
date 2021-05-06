# PicsumPhotos

Developed the Application in VIPER Architecture

-> Entire View Controller is located under the Photos Module folder

Configurator:
1) Defines the set of resposibilities for the View, Presenter, Interactor and Router

View:

PhotosViewController:
1) Responsible for displaying the Picsum photos and sending the request to download the next set of picsum photo records

PhotoCollectionViewCell:
1) Responsible for displaying the Author name and the Thumbnail image


Presenter:

PhotosViewPresenter:
1) Responsible for the actions sent by PhotosViewController and responds back with update
2) Communicates with Interactor for requesting Picsum photo records by page
3) Responsible to remove the Vowels from the selected picsum photo


PhotosViewInteractor:
1) Responsible for the actions sent by PhotosViewPresenter, performs the client server communication and responds to presenter back with an update

Entity:
1) Contains Picsum PhotoObject model  

Router:
1) Responsible for creating the PhotosViewController and configure the controller with Presenter, Interactor and Router


Utilities:
Contains Network manager, Constants, Server keys and Image View extensions

NetworkManager:
1) Responsible for performing any Client server communication provided by a Request object (PhotosViewInteractor creates the request and send it to NetworkManager)
2) Responsible for download the Image data through the API

ServerKeys:
1) Contains the apis for base download Image URL and Picsum phots records per page

UIImageViewExtensions:
1) Responsible for downloading the image communicating the NetworkManager and update the UIImageView with an image
2) Additional methods to add the corner raidus and scale a high resolution image to a smaller one
