
const { ExtendedError } = require('./extended')
const { RethrownError } = require('./rethrown')

// ### FsError

// Create errors for the `fs` module that don't suck so much

// #### `new FsError(new_message, original_error)`

class FsError extends RethrownError {

  static create( message, error ) {
    switch(error.code) {
      case 'ENOENT': return new FsNotFoundError(`${message} : ${error.syscall} ${error.path}`, error)
      case 'EEXIST': return new FsAlreadyExistsError(`${message} : ${error.syscall} ${error.path}`, error)
      case 'EPERM': return new FsNotPermittedError(`${message} : ${error.syscall} ${error.path}`, error)
      default : return new FsError(`${message} : ${error.message}`, error)
    }
  }

  constructor( message, error ){
    super(message, error)
    this.code = error.code
    this.errno = error.errno
    this.syscall = error.syscall
    this.path = error.path
  }

}

// ### FsNotFoundError

// #### `new FsNotFoundError(new_message, original_error)`

class FsNotFoundError extends FsError {}
class FsAlreadyExistsError extends FsError {}
class FsNotPermittedError extends FsError {}

module.exports = { FsError, FsNotFoundError, FsAlreadyExistsError }
