# Lyric Snippet

Javascript library to allow you to integrate with Lyric services.

## How to Use - Synchronous

1) Include js and css file in your project

**Using Bower**

    bower install lyric-snippet --save

    <script src="bower_components/lyric-snippet/dist/lyric-snippet.min.js"></script>
    <link href="bower_components/lyric-snippet/dist/lyric-snippet.css" rel="stylesheet">

2) Create an instance of LyricSnippet optionally overriding terms and conditions.

    lyric = new LyricSnippet("Custom Terms & Conditions")

or

    lyric = new LyricSnippet(document.getElementById('custom-terms').innerHTML)

3) Call confirm() function to display Terms and Conditions that the user will need to agree to before saving their data.

	<button class="md-raised md-primary" onclick="lyric.confirm()">Get Advance</button>

Or call from within another javascript function after any form validation has been completed.

4) Add event listener to listen for confirmationComplete event.  This event gets fired after user agrees to the terms and conditions.  It is within this listener that you would make your server call to save the data to the Lyric API.

	document.addEventListener('confirmationComplete', eventHandler);

5) Once the Lyric API has been successfully called, call advanceRequestComplete function passing the ACCESS_TOKEN that was returned in the header of the Lyric /clients API call.  This will remove the wait indicator as well as opent the Lyric vAtm page in a new browser.

	lyric.advanceRequestComplete(accessToken);

6) If an error occurs, call the advanceRequestError function.

	lyric.advanceRequestError(error)
