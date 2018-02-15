Navigation: Date and time formats
SortOrder: 600

# Time and duration formats

## Time and date formats

Whenever you need to specify or have the API send you a date and time, it will be in the ISO 8601
_YYYY-MM-DDTHH:MM:SSZ_ format (i.e. 2016-03-19T13:15:32Z) where:

* YYYY is the year (i.e. 2016), MM is the month (i.e. 03), and DD is the day of the month (i.e. 19)
* T is the delimiter between the date and time
* HH is the hour, in 24-hour format (i.e. 1PM is 13), MM is the minute (i.e. 15), and SS is the seconds (i.e. 32)
* Z indicates the UTC (GMT 0) timezone

All times from the API have both a date and time. You must pass a time part in all inputs, even if it's 00:00:00.

All times from the API are in UTC. Similarly, all time inputs are expected in a UTC timezone.

## Duration format

Some parts of the API, like the retention field in `cameras/{camera_id}/` and `cameras/`, use duration to denote a
span of time (i.e. "30 days" or "2 months"). We use the standard ISO 8601 duration format which uses the
_P[n]Y[n]M[n]DT[n]H[n]M[n]S_ format. Here are a few examples of various durations:

* P30D - 30 days
* P2M - 2 months
* P2M10D - 2 months and 10 days
* P3Y6M4DT12H30M5S - 3 years, 6 months, 4 days, 12 hours, 30 minutes, and 5 seconds
