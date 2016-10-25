const sys = Application('System Events')
const TEST = true

class Channel {
  constructor(team, atPlatte, channelName, timeToStart, delayAmount) {
    this.name = team.name
    this.number = team.number
    this.atPlatte = atPlatte
    this.channelName = channelName
    this.myChannelName = team.myChannelName
    this.delay = delayAmount
  }

  init(test) {
    this.switchToSlackTeam()

    if(test) {
      this.switchToChannel('slackbot')
    } else {
      this.switchToChannel()
    }

    this.sendMessage()
    this.switchToChannel(this.myChannelName)
  }

  switchToSlackTeam() {
    sys.keystroke(this.number, {using: 'command down'})
    delay(this.delay)
	}

  switchToChannel(channel) {
    channel = channel || this.channelName

		sys.keystroke('k', {using: 'command down'})
		delay(0.5)
		sys.keystroke(channel)
		delay(0.5)
		sys.keyCode(36)
    delay(0.5)
	}

  sendMessage() {
		sys.keystroke(this.message)
    delay(0.5)
		sys.keyCode(36)
    delay(0.5)
	}
}

function launchSlack() {
  const slackApp = Application('Slack.app')

  var amountToDelay = .5

  if(slackApp.running()) {
    slackApp.activate()
    delay(amountToDelay)
  } else {
    slackApp.activate()
    amountToDelay = 5
    delay(amountToDelay)
  }

  return amountToDelay
}

function run(input, parameters) {
  const denverDevs = {
    name: 'Denver Devs',
    number: 1,
    myChannelName: 'brooks'
  }

  const gStudent = {
    name: 'gStudent',
    number: 2,
    myChannelName: 'Brooks Patton'
  }

  const gAlumni = {
    name: 'gAlumni',
    number: 3,
    myChannelName: 'Brooks Patton'
  }

  const channelsToSendMessageTo = [
    {
      team: denverDevs,
      channelName: 'topic-twitch',
      atPlatte: false
    },
    {
      team: gStudent,
      channelName: 'g31_platte_general',
      atPlatte: true
    },
    {
      team: gStudent,
      channelName: 'g25_platte_general',
      atPlatte: true
    },
    {
      team: gStudent,
      channelName: 'g29_platte_general',
      atPlatte: true
    },
    {
      team: gStudent,
      channelName: 'g30_goldentriangle',
      atPlatte: false
    },
    {
      team: gStudent,
      channelName: 'g38_platte',
      atPlatte: true
    },
    {
      team: gAlumni,
      channelName: 'g15_platte',
      atPlatte: false
    },
    {
      team: gAlumni,
      channelName: 'checkthisout',
      atPlatte: false
    },
    {
      team: gAlumni,
      channelName: 'g18_platte',
      atPlatte: false
    },
    {
      team: gAlumni,
      channelName: 'g25_platte_alumni',
      atPlatte: false
    }
  ]

	const isStreaming = input[0] === 'true' ? true : false
	const location = input[4]
	const sessionLength = input[3]
	const timeToStart = input[2]
	const whatToWorkOn = input[1]
  const SLACK_TEAMS = {
    denverDevs: 4,
    gStudent: 5,
    gAlumni: 8
  }













  const delayAmount = launchSlack()

  const channels = channelsToSendMessageTo.reduce(function (arr, channel) {
    arr.push(new Channel(channel.team, channel.atPlatte, channel.channelName, timeToStart, delayAmount))

    return arr
  }, [])

  channels.forEach(function(channel) {
    channel.init(TEST)
  })



  /*
	// send message to denver devs
	switchToSlackTeam(SLACK_TEAMS.denverDevs)

	sendMessage(message, 'slackbot')

	switchToChannel('brooks_patton')

	// send message to gstudent
	switchToSlackTeam(SLACK_TEAMS.gStudent)

	sendMessage(message, 'g31_platte_general')
	sendMessage(message, 'g25_platte_general')
	sendMessage(message, 'g29_platte_general')
  if(isStreaming) sendMessage(message, 'g30_goldentriangle')
  sendMessage(message, 'g38_platte')

	switchToChannel('brooks_patton')

  // send messages to gAlumni
  switchToSlackTeam(SLACK_TEAMS.gAlumni)

  sendMessage(message, 'checkthisout')
  sendMessage(message, 'g15_platte')
  sendMessage(message, 'g18_platte')
  sendMessage(message, 'g25_platte_alumni')

  switchToChannel('Brooks Patton')
  */
}
