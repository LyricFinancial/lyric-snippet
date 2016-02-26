# Lyric Snippet

Javascript library to allow you to integrate with Lyric services.

## Snippet

### How to Use - Synchronous

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

## Widget

Once one of your clients is registered in the Lyric system, you can integrate the Lyric Widget into your website so when the client is logged in, they can see their Advance Limit, Current Balance and Available Balance.

### How to Use

1) Create a Web Service Call that generates a JWT token

The Lyric Widget makes a web service call to Lyric's APIs to get the Advance information.  In order to authenticate this call, you will need to provide a JWT token to the widget.  You can find more information on this [here](https://github.com/LyricFinancial/demo-integration-server#token-api).

2) Call your new web service and get the newly generated token.  You can store this token in local storage if you'd like so you're not creating a new token every time the page is refreshed.

3) Create an instance of Lyric Widget.  The constructor takes the memberToken and an optional advanceUrl.  By default, the advance api in the Lyric services will be used, but it can be overridden to use a different url.  Then call loadData() on it passing the newly generated token.  loadData() returns a promise so in the .then you can then get the html of the widget to add to your web page.

	lyricWidget = new LyricWidget(:memberToken)
	lyricWidget.loadData(token)
	.then ->
		html = lyricWidget.getWidget()
		document.getElementById('lyric-container').innerHtml = html

4) Customize the lyric widget how you'd like

	.widget-label {
		font-weight: bold;
	}

	.widget-value {
		
	}

	.widget-container {
		border-radius: 25px;
	  background: #d01e1e;
	  color: #fff;
	  padding: 20px; 
	  width: 235px;

	  h3 {
	  	margin-top: 2px;
	  }
	}

 
