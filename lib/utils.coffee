@Utils =
  prettyDate: (date)->
    if date
      if Config.dateFormat
        moment(date).format(Config.dateFormat)
      else
        moment(date).format('D/M/YYYY')

  timeSince: (date)->
    if date
      seconds = Math.floor((new Date() - date) / 1000)
      interval = Math.floor(seconds / 31536000)
      return interval + "years ago"  if interval > 1
      interval = Math.floor(seconds / 2592000)
      return interval + " months ago"  if interval > 1
      interval = Math.floor(seconds / 86400)
      return interval + " days ago"  if interval > 1
      interval = Math.floor(seconds / 3600)
      return interval + " hours ago"  if interval > 1
      interval = Math.floor(seconds / 60)
      return interval + " minutes"  if interval > 1
      "just now"

  stringToTimeCompare: (startTime, endTime)->
    if startTime == undefined then startTime = "00:00"
    if endTime == undefined then endTime = "00:00"
    fromTokens = startTime.split(":")
    toTokens = endTime.split(":")
    return (fromTokens[0] < toTokens[0] || (fromTokens[0] == toTokens[0] && fromTokens[1] < toTokens[1]));

  isMobile: ->
    /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test navigator.userAgent

  loginRequired: ->
    Router.go '/sign-in'