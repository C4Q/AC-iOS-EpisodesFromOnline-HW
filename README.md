# Unit 3 Week 2 HW - Getting Data from Online
# Marlon

## Summary

Create an app where you can search for a tv show.  Selecting a show should display a list of all episodes in the TV show.  Selecting an episode should display a detail view controller with more information about the episode.

![Sample gif](https://github.com/C4Q/AC-iOS-EpisodesFromOnline-HW/blob/master/gif1.gif)

## Documentation:

[https://www.tvmaze.com/api](https://www.tvmaze.com/api)

# View Controller One: Shows

Your view controller should contain:

- A table view
- A search bar

Entering a search term should make a request to load shows matching that description into the table view.  Your tableViewCell should have:

- An image of the show
- The name of the show
- Its rating

You will need to use a custom tableViewCell.

Selecting a show should segue to a view controller that lists the episodes.

# View Controller Two: Episodes

Your view controller should contain:

- A table view

The table view should have all the episodes from the show that the user selected.  The tableViewCell should have:

- An image of the episode
- The name of the episode
- The season and episode number

Selecting an episode should segue to a detail view controller that lists additional information.

# View Controller Three: Episode Detail

Your view controller should contain:

- A large image of the episode
- The episode's name
- The episode's season and episode number
- The episode's description


# Rubric

|Criterion|Points|
|---|---|
| App correctly uses Auto Layout for all portrait iPhones | 4 |
| Variable Naming and Readability | 4 |
| Loads an array of Shows into a tableView based on a search term | 8 |
| Show tableviewcell is correctly configured | 4 |
| Loads an array of Episodes into a tableView based on a segue | 4 |
| Episode tableviewcell is correctly configured | 4 |
| Episode Detail View Controller is correctly configured | 4 |
| Images load when available and without flickering | 4 |
| A UIActivityIndicator is displayed while images are loading | 4 |
