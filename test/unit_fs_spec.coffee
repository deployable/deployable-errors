{ FsError, FsNotFoundError } = require '../'


describe 'Unit::Deployable::Error', ->

  describe 'FsError', ()->

    it 'should have an FsError', ()->
      expect( FsError ).to.be.ok

    it 'should create an error', ->
      ori = new Error('Original error message')
      err = new FsError('fsmsg', ori)
      expect( err ).to.be.an.instanceOf Error
      expect( err.message ).to.equal 'fsmsg'
      expect( err.name ).to.equal 'FsError'
      expect( err.stack ).to.be.ok

    it 'should fail to create one without the error argument', ->
      fn = ()-> new FsError('fsmsg')
      expect( fn ).to.throw(/FsError requires a message and error/)


  describe 'FsNotFoundError', ()->

    it 'should have an FsNotFoundError', ()->
      expect( FsNotFoundError ).to.be.ok

    it 'should create an FsNotFoundError instance', ()->
      expect( new FsNotFoundError('a',{}) ).to.be.an.instanceof(FsNotFoundError)


  describe 'FsError#create', ()->

    it 'should have an FsError.create', ()->
      expect( FsError.create ).to.be.a.function

    it 'should create a plain FsError', ()->
      expect( FsError.create('msg', new Error()) ).to.be.instanceof(FsError)

    it 'should create a plain FsError', ()->
      err = new Error()
      err.code = 712873821
      expect( FsError.create('msg', err) ).to.be.instanceof(FsError)

    it 'should create a FsNotFoundError', ()->
      err = new Error()
      err.code = 'ENOENT'
      expect( FsError.create('msg', err) ).to.be.instanceof(FsNotFoundError)