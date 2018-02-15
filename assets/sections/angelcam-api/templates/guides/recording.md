Navigation: Recording
SortOrder: 400

# Recording

![Recording sequence diagram](https://www.lucidchart.com/publicSegments/view/d0b70503-ac78-4e87-b6b8-e74f3cdc7490/image.png)

The Cloud Recording application (CRA) safely stores any content captured by your camera to the cloud. If a camera
doesn't have the CRA application, all camera recording endpoints will return 404. Otherwise, you can start by asking general
recording information using the `cameras/{camera_id}/recording/` endpoint.

Most notably, this endpoint tells you whether the camera is currently recording or not (i.e. recording might not have
been started by the user yet, there’s an error, etc.). As with all "active" operations, the user must use our web
application to start a recording.

Another piece of information reported by this endpoint is the retention period, which dictates how long a video will be
stored. This is particularly useful for obtaining a `cameras/{camera_id}/recording/timeline/`.

## Timeline and segments

It's important to note that in the Angelcam API there are some terms that sound similar but have different meanings:

* _record_ (noun) - a continuous block of video content, as stored by the recording. To clearly distinguish it from a
  “recording” we called it a _record segment_ or simply, _segment_.
* _recording_ (verb) - the process of capturing a record, or records, which are then stored.

Timeline listening at the `cameras/{camera_id}/recording/timeline/` endpoint is a collection of record segments for a
given camera and time interval. In  order to save bandwidth and resources, the maximum length of timeline you can
request, per single call, is 24 hours.

If a recording was running uninterrupted, within a specified start and end time, the result will contain one segment.
Often "missing" slots will appear on the timeline, usually because the user may have manually stopped the recording or
there were some camera errors.

## Recording stream

If you know which video segment(s) from the timeline you want to play, calling `cameras/{camera_id}/recording/stream/`
will create a stream from that specified segment(s) and tells you its URL and format.

Using `start` and `end` query parameters, you can specify a beginning and ending time of the stream. You can even omit
the `end` parameter and the stream will play until the very end of the recorded footage or, if the camera is currently
recording, the stream will continue uninterrupted.

Among other things, the endpoint tells you the URL of `recording/stream/{streamer_name}/{stream_id}/` with the stream's
additional details.

## Syncing stream and timeline

Due to various reasons, the time a user spends watching a stream doesn't necessarily have to match the time actually
elapsed in the recorded video (i.e. a 5-minute long stream takes 6 minutes to watch on a user's slow mobile network
connection due to lag).

Periodically calling endpoint, `recording/stream/{streamer_name}/{stream_id}/`, comes in handy in this case, because it
synchronizes the time shown to the user in your UI, with the current time of the stream. This endpoint tells you the
exact time where the stream is positioned at the current moment. You normally don't have to know the `streamer_name`
and `streamer_id` path parameters, but use the generated endpoint URL as reported by `stream_info` field from
`cameras/{camera_id}/recording/stream/`.
