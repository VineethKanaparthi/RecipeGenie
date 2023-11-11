# Recipe Browser App

This native iOS app allows users to browse recipes using The Meal DB API. It includes two main endpoints: one for fetching the list of meals in the Dessert category and another for fetching meal details by their ID. Users can explore a list of desserts, sorted alphabetically, and view detailed information about each meal.

## Features

- Browse and explore a list of dessert recipes.
- View meal details, including meal name, instructions, and ingredients/measurements.
- Link to youtube video

## For Reviewer 

- Included Accessibility labels
- Has comprehensive error handling with retries to network calls
- Handled nulls and empty values where ever required
- Modularized code with seperated out views
- Added documentation and comments
- Added togglable instructions and ingredients
- Demo video will be in demo folder

## App Demo

[Demo Video](https://www.youtube.com/shorts/8On4ZCir6y8)

![Demo GIF](./demo/demo.gif)

## Getting Started

These instructions will help you set up and run the project on your local machine for development and testing purposes.

### Prerequisites

- Xcode (the latest version recommended)
- Swift (the latest version recommended)

### Installation

1. Clone the repository to your local machine:

```
git clone <repository-url>
```

2. Open the project in Xcode.

3. Build and run the app using the iOS Simulator or a physical device.

### Usage

- Launch the app and explore a list of dessert recipes.
- Select a dessert to view detailed information, including meal name, instructions, and ingredients/measurements.

## API Reference

The app utilizes The Meal DB API to fetch recipe data. You can find more information about the API at [The Meal DB API](https://themealdb.com/api.php).

