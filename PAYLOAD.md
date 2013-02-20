# Anatomy of a Payload

JSON dictionary ([RFC 4627](http://www.rfc-editor.org/rfc/rfc4627.txt)) weighing in at a max of 256 bytes.

Must contain `aps` dictionary with at least one of the following keys:

- `alert` (string or dictionary): The message to display or a dictionary which let's you specify further things (see below).
- `badge` (number): The number to add to the app icon. If absent, the current badge is not changed. 0 clears the badge.
- `sound` (string): The identifier of a sound to play.

The `alert` dictionary can contain the following keys:

- `body` (string): The message to display.
- `action-loc-key` (string or null): The localization key of the string to use in place of "View" in the right button. Specify null to only show the "OK" button.
- `loc-key` (string): The localization key of the string that is used as the message.
- `loc-args` (array of strings): The arguments to appear in place of the format specifiers in `low-key`.
- `launch-image` (string): The filename of an image file in the application bundle (may omit the extension).

