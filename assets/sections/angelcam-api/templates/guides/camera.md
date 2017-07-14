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

Please note, a snapshot may be up to 24 hours old but we'll auto initiate refreshing when you access camera endoints in
API. If age is important to you, check the created_at field in the snapshots array returned by the
`cameras/{camera_id}/` and `cameras/` endpoints.
 
In cases where a more recent image is required, you can use a live snapshot or a MJPEG stream with a low frame rate
instead.

## Live snapshot
The live snapshot is a static picture of what the camera is currently shooting at the moment. This actually creates
a connection to the camera and extracts the last keyframe from the camera stream.

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

The applications added to a camera depend on the user's country as some of them are not available in every country.
