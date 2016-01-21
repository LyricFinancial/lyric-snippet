# Lyric Snippet

Javascript library to allow you to integrate with Lyric services.

## How to Use - Synchronous

1) Include js and css file in header of index.html

	<script type="text/javascript" src="url-to-cdn/lyric-snippet-0.1.0.min.js"></script>
	<link href="url-to-cdn/lyric-snippet-0.1.0.css" rel="stylesheet">

2) Call confirm() function to display Terms and Conditions that the user will need to agree to before saving their data.

	<button class="md-raised md-primary" onclick="confirm()">Get Advance</button>

Or call from within another javascript function after any form validation has been completed.

3) Add event listener to listen for confirmationComplete event.  This event gets fired after user agrees to the terms and conditions.  It is within this listener that you would make your server call to save the data to the Lyric API.

	document.addEventListener('confirmationComplete', eventHandler);

4) Once the Lyric API has been successfully called, call advanceRequestComplete function passing the ACCESS_TOKEN that was returned in the header of the Lyric /clients API call.  This will remove the wait indicator as well as opent the Lyric vAtm page in a new browser.

	advanceRequestComplete(accessToken);

5) If an error occurs, call the advanceRequestError function.

	advanceRequestError(error)

6) Override Terms & Conditions (Optional)

	angular.element(document).ready ->
      document.getElementById('terms-container').innerHTML = "Custom Terms & Conditions"