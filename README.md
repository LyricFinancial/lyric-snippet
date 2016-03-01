# Lyric Snippet

Javascript library to allow you to integrate with Lyric services.

## Development

1) Clone the repository locally

	https://github.com/LyricFinancial/lyric-snippet.git

2) Install dev dependencies
  
  npm install

3) Make appropriate coding changes to either the lyric-snippet.coffee or lyric-widget.coffee and their corresponding templates

4) Build

  grunt

5) Make a commit to git, then add a tag using the next version number.  This is what dictates the versioning for bower.

6) Push to git making sure to push tags as well

  git push origin master --tags

7) Update bower file of projects using the lyric-snippet to use the latest version.