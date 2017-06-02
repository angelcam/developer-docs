Navigation: Broadcasting application
SortOrder: 500

# Broadcasting application

![Broadcasting application sequence diagram](https://www.lucidchart.com/publicSegments/view/c93a31f3-f8d2-4ce4-8382-798187819b5e/image.png)

Live streams are at the core of the Broadcasting app (BCA). The application itself only adds some customizations
features, like embedding to third party websites. The Broadcasting application was formerly known as LSA, or Live
Stream Application, and we kept this application code for backward-compatibility.

Building a broadcasting client, using the Angelcam API is trivial - from the cameras/{camera_id}/ and cameras/
endpoints figure out the live stream URL in the appropriate format.
