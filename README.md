# An e-book viewer built with Ruby, Sinatra, ERB, JavaScript, HTML and CSS

This app is an e-book viewer for the book [The Adventures of Sherlock Holmes](http://www.gutenberg.org/ebooks/1661).

It displays the text for each chapter, and also includes basic text search functionality.

It is currently deployed to [Heroku](https://ls-rb175-book-viewer-kjhwong.herokuapp.com/).

To run the app locally:

1. Clone the repo
   ```
   $ git clone https://github.com/kelvinjhwong/book-viewer.git
   ```
2. `cd` into the repo
   ```
   $ cd book-viewer
   ```
3. Install dependencies with Bundler
   ```
   $ bundle install
   ```
4. Start the web server
   ```
   $ ruby book_viewer.rb
   ```
5. Visit the app at `localhost:4567`
