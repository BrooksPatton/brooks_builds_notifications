const sys = Application('System Events')

class Channel {
  constructor(team, atPlatte, channelName) {
    this.name = team.name
    this.number = team.number
    this.atPlatte = atPlatte
    this.channelName = channelName
    this.myChannelName = team.myChannelName

    this.message = `@here I'm doing brooks builds today starting around ${timeToStart} at ${location} for ${sessionLength}. Today I'll be working on ${whatToWorkOn}. ${isStreaming ? "If you can't make it join me online at https://www.twitch.tv/brookzerker" : ""}`
  }

  sendMessage() {
    this.switchToSlackTeam()
    this.switchToChannel()
    this.sendMessage()
    this.switchToChannel(this.myChannelName)
  }

  switchToSlackTeam() {
    sys.keystroke(this.number, {using: 'command down'})
    delay(10)
	}

  switchToChannel(channel = this.channelName) {
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





  function launchSlack() {
    const slackApp = Application('Slack.app')

    if(slackApp.running()) {
      slackApp.activate()
      delay(0.5)
    } else {
      slackApp.activate()
      delay(5)
    }
  }







  launchSlack()

  const channels = channelsToSendMessageTo.reduce(function (arr, channel) {
    arr.push(new Channel(channel.team, channel.atPlatte, channel.channelName))

    return arr
  }, [])

  channels.forEach(function(channel) {
    channel.sendMessage()
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
