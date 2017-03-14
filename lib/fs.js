
const { ExtendedError } = require('./extended')

// ### FsError

// Create errors for the `fs` module that don't suck so much

// #### `new FsError(new_message, original_error)`

class FsError extends ExtendedError {

  static create( message, error ) {
    switch(error.code) {
      case 'ENOENT': return new FsNotFoundError(message, error)
      default : return new FsError(message, error)
    }
  }

  constructor( message, error ){
    super(message)
    if (!error) throw new Error('FsError requires a message and error')
    this.code = error.code
    this.errno = error.errno
    this.syscall = error.syscall
    this.path = error.path
  }
}

// ### FsNotFoundError

// #### `new FsNotFoundError(new_message, original_error)`

class FsNotFoundError extends FsError {}

module.exports = { FsError, FsNotFoundError }
