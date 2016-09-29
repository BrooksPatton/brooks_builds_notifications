const defaultWorkingOn  = 'something random'
const sys               = Application('System Events')
const standardWaitTime  = 0.5
const keyCodeReturn     = 36
const slackTeamNumber   = 5
const myChannel         = 'Brooks Patton'
const room              = ':pikachu:'
const channelsToMessage = ['g31_platte_updates', 'g29_platte_general', 'g25_platte_general']

function getTodaysPlan () {
  const currentApp = Application.currentApplication()
  currentApp.includeStandardAdditions = true
  // using var here because const doesn't work with destructuring :(
  var {textReturned} = currentApp.displayDialog('What am I working on today?', {defaultAnswer: ''})
  return textReturned || defaultWorkingOn
}

function wait (time) {
  delay(time)
}

function startApp (app) {
  const waitTime = app.running() ? 0.3 : 15
  app.activate()
}

function switchToSlackTeam(slackTeamNumber) {
  sys.keystroke('5', {using: 'command down'})
  wait(standardWaitTime)
}

function sendMessageToChannel(plan, channel) {
  switchToChannel(channel)
  wait(standardWaitTime)
  sys.keystroke(plan)
  sys.keyCode(keyCodeReturn)
}

function switchToChannel(name) {
  sys.keystroke('k', {using: 'command down'})
  wait(standardWaitTime)
  sys.keystroke(name)
  wait(standardWaitTime)
  sys.keyCode(keyCodeReturn)
}

const todaysPlan = `@channel, brooks builds today at 11:45 - 12:45 in *${room}* at platte. Today I'll be working on *${getTodaysPlan()}*. If you can't make it in person watch the stream at https://www.twitch.tv/brookzerker!`

const slack = Application('slack')

startApp(slack)

switchToSlackTeam(slackTeamNumber)
wait(standardWaitTime)

channelsToMessage.forEach(function(channel) {
  sendMessageToChannel(todaysPlan, channel)
  wait(standardWaitTime)
})

switchToChannel(myChannel)
