Navigation: Camera information
SortOrder: 400

# Camera information

With the cameras/ endpoint, you can obtain a paginated list of the current user's cameras. Alternatively, if you know a
camera's ID you can get the same information using the cameras/{camera_id}/ endpoint. In both cases you get important
camera information:

* camera ID, name and type
* snapshot (thumbnail of recent camera content)
* status (online, offline, unknown, ...)
* list of live stream URLs in various formats to watch

## Snapshot

A snapshot is an affordable and quick way to give your users a sample of their on-going live stream, by periodically
saving a picture of it. It's intended to give a preview of the camera's content without actually creating a connection
to the live stream, which can be a resource-expensive operation.

Please note, a snapshot may be up to 15 minutes old and you can't initiate it’s refresh from the API. If age is
important to you, check the created_at field in the snapshots array returned by the `cameras/{camera_id}/` and
`cameras/` endpoints. In cases where a more recent preview is required, you can use an MJPEG stream with a low
framerate instead.

## Live stream from camera

The live stream is what the camera is currently shooting at the moment. For H.264 type cameras, you can choose from
URLs in multiple live stream formats:

 * HLS
 * fMP4
 * MJPEG

For MJPEG type cameras you can output only a MJPEG live stream.

## Camera applications

Connecting a camera and being able to get a snapshot or watch a live stream is offered to every Angelcam user, but to
get the most out of a camera, users usually add some apps. Among other information, the cameras/{camera_id}/ and
cameras/ endpoints will tell you apps added to a user's camera as a list of app codes.

We currently support these applications in this API with the following codes (uppercase):

* LSA - Broadcasting
* CRA - Cloud Recording
* VVA - Video Verification
* VPA - Video Guard
* TLA - Time-Lapse

The applications added to a camera depend on the user's country as some of them are not available in every country.
