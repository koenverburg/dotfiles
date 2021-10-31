var spawn = require('child_process').spawn
const { Command } = require('commander')
const Spinner = require('cli-spinner').Spinner

const program = new Command()

const spinner = new Spinner('Running: %s')

spinner.setSpinnerString('|/-\\')

const longCommand = (cmd, onSuccess) => {
  return new Promise((resolve, reject) => {
    let process = spawn(cmd, { shell: true });
    spinner.start()
    process.on('exit', () => {
      spinner.stop()
      onSuccess()
      resolve()
    })
  })
}

program
  .command('reset [branch]')
  .description('A reset command to have a fresh start')
  .option('-b, --branch', 'which to rebase to')
  .option('-c, --config', 'config file to set a list of commands to run')
  .action((branch, options) => {

    const config = require('./project.config.js')

    console.log(branch, options, config.reset)

    if(config.reset.length > 0) {
      config.reset.forEach(cmd => longCommand(cmd, () => console.log(`Finished '${cmd}'`)))
      // longCommand(config.reset[0], () => console.log('done'))
    }
  })

program.parse(process.argv)
