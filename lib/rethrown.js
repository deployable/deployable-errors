
const { ExtendedError } = require('./extended')

// ### RethrownError

// #### `new RethrownError(new_message, original_error, options)`
//
// Options: 
//   stack: true/false/Integer - Disable, enable or set the number of lines of stack output

// https://stackoverflow.com/questions/42754270/re-throwing-exception-in-nodejs-and-not-losing-stack-trace

class RethrownError extends ExtendedError {

  constructor(message, error, options = {} ){
    super(message)
    if (!error) throw new Error(`new ${this.name} requires a message and error`)

    // when stack = true dump all lines
    let all_lines = ( options.stack === true ) ? true : false

    // when stack = false, dump no lines
    let stack_lines = ( options.stack === false ) ? 0 : 1

    // when stack = undefined, dump 1 otherwise stack is the number of lines
    stack_lines = (options.stack === undefined) ? 1 : options.stack
    
    this.original = error
    this.new_stack = this.stack
    let message_lines =  (this.message.match(/\n/g)||[]).length + 1
    let new_stack = ( all_lines ) 
      ? this.stack
      : this.stack.split('\n').slice(0, message_lines+stack_lines).join('\n')
    this.stack = new_stack + '\n' +  error.stack
  }

}

module.exports = { RethrownError }
