const sys = Application('System Events')
const TEST = false

class Channel {
  constructor(team, atPlatte, channelName, timeToStart, delayAmount, inPerson, whatToWorkOn, location, isStreaming) {
    this.name = team.name
    this.number = team.number
    this.atPlatte = atPlatte
    this.channelName = channelName
    this.myChannelName = team.myChannelName
    this.delay = delayAmount
    this.atHere = team.atHere
    this.inPerson = inPerson
    this.whatToWorkOn = whatToWorkOn
    this.location = location
    this.timeToStart = timeToStart
    this.isStreaming = isStreaming
  }

  init(archiveUrl, test) {
    this.archiveUrl = archiveUrl

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
		delay(3)
		sys.keystroke(channel)
		delay(3)
		sys.keyCode(36)
    delay(3)
	}

  sendMessage() {
		sys.keystroke(this.generateMessage())
    delay(3)
		sys.keyCode(36)
    delay(3)
	}

  generateMessage() {
    // @here: Steam is all done, you can find the archive at https://www.twitch.tv/brookzerker/aoriesth
    var message = ''

    if(this.atHere) message += '@here: '
    if(this.archiveUrl) {
      message += `The stream is all done. You can watch the archive at ${this.archiveUrl} if you missed it.`
    } else if(this.inPerson && this.atPlatte) {
      message += `I’ll be doing Brooks Builds again today starting at ${this.timeToStart} in ${this.location}. Today I'm working on ${this.whatToWorkOn}. Please feel free to stop on by and say hi or ask any questions!${this.isStreaming ? " If you can't make it in person then you can watch it live at https://www.twitch.tv/brookzerker." : ''}`
    } else if(this.isStreaming) {
      message += `I’ll be doing Brooks Builds again today starting at ${this.timeToStart}. Today I'm working on ${this.whatToWorkOn}. You can watch me live at https://www.twitch.tv/brookzerker and ask any questions or just say hi!`
    } else {
      // I'm not available anywhere, so don't send any messages
      message = ''
    }

    return message
  }
}

function launchSlack() {
  const slackApp = Application('Slack.app')

  var amountToDelay = 3

  if(slackApp.running()) {
    slackApp.activate()
    delay(amountToDelay)
  } else {
    slackApp.activate()
    amountToDelay = 15
    delay(amountToDelay)
  }

  return amountToDelay
}

function run(input, parameters) {
  const denverDevs = {
    name: 'Denver Devs',
    number: 1,
    myChannelName: 'brooks',
    AtHere: false
  }

  const gStudent = {
    name: 'gStudent',
    number: 2,
    myChannelName: 'Brooks Patton',
    atHere: true
  }

  const gAlumni = {
    name: 'gAlumni',
    number: 3,
    myChannelName: 'Brooks Patton',
    atHere: true
  }

  const channelsToSendMessageTo = [
    {
      team: denverDevs,
      channelName: 'topic-twitch',
      atPlatte: false
    },
    {
      team: gStudent,
      channelName: 'denver_students',
      atPlatte: true
    },
    {
      team: gAlumni,
      channelName: 'g29_general',
      atPlatte: false
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
	const canPeopleJoinMeInPerson = input[3].toLowerCase() === 'true' ? true : false
	const timeToStart = input[2]
	const whatToWorkOn = input[1]
  const archiveUrl = input[5]

const delayAmount = launchSlack()

  const channels = channelsToSendMessageTo.reduce(function (arr, channel) {
    arr.push(new Channel(channel.team, channel.atPlatte, channel.channelName, timeToStart, delayAmount, canPeopleJoinMeInPerson, whatToWorkOn, location, isStreaming))

    return arr
  }, [])

  channels.forEach(function(channel) {
    channel.init(archiveUrl, TEST)
  })
}
