function run(input, parameters) {

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

	const message = `@here I'm doing brooks builds today starting around ${timeToStart} at ${location} for ${sessionLength}. Today I'll be working on ${whatToWorkOn}. ${isStreaming ? "If you can't make it join me online at https://www.twitch.tv/brookzerker" : ""}`

	const sys = Application('System Events')

	function switchToSlackTeam(slackTeamNumber) {
    sys.keystroke(slackTeamNumber, {using: 'command down'})
    delay(0.5)
	}

	function switchToChannel(name) {
		sys.keystroke('k', {using: 'command down'})
		delay(0.5)
		sys.keystroke(name)
		delay(0.5)
		sys.keyCode(36)
    delay(0.5)
	}

	function sendMessage(plan, channel) {
		if(channel) switchToChannel(channel)
		delay(0.5)
		sys.keystroke(plan)
		sys.keyCode(36)
	}

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
}
