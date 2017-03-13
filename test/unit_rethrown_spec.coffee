{ ExtendedError, RethrownError } = require '../'


describe 'Unit::Deployable::Error', ->

  describe 'RethrownError', ()->

    it 'should have an RethrownError', ()->
      expect( RethrownError ).to.be.ok

    it 'should create an error', ->
      ori = new Error('Original error message')
      err = new RethrownError('Rethrown', ori)
      expect( err ).to.be.an.instanceOf Error
      expect( err.message ).to.equal 'Rethrown'
      expect( err.name ).to.equal 'RethrownError'
      expect( err.stack ).to.be.a.string
      lines = err.stack.split('\n')
      expect( lines[0] ).to.equal 'RethrownError: Rethrown'
      expect( lines[1] ).to.match new RegExp("^    at .+#{__filename}:")
      expect( lines[2] ).to.equal 'Error: Original error message'
      expect( lines[3] ).to.match new RegExp("^    at .+#{__filename}:")

