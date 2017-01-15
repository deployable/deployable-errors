Errors = require '../'


describe 'Unit::Error::Dply', ->

  describe 'ExtendedError', ()->

    it 'should have an ExtendedError', ()->
      expect( Errors.ExtendedError ).to.be.ok

    it 'should create an error', ->
      err = new Errors.ExtendedError('msg')
      expect( err ).to.be.an.instanceOf Error
      expect( err.message ).to.equal 'msg'
      expect( err.name ).to.equal 'ExtendedError'
      expect( err.stack ).to.be.ok

    it 'should populate the simple message', ->
      err = new Errors.ExtendedError('msg', {simple: 'simple msg'})
      expect( err.simple ).to.equal 'simple msg'

    it 'should include all properties is json', ->
      err = new Errors.ExtendedError('msg', {simple: 'simple'})
      json = err.toJSON()
      expect( json ).to.have.all.keys ['message', 'simple', 'name', 'stack']
      expect( json ).to.have.property('message').and.equal('msg')
      expect( json ).to.have.property('simple').and.equal('simple')
      expect( json ).to.have.property('name').and.equal('ExtendedError')
      expect( json ).to.have.property('stack').and.match(/ExtendedError: msg\n/)

    it 'should exclude stack in toResponse()', ->
      err = new Errors.ExtendedError('msg', {simple: 'simple'})
      json = err.toResponse()
      expect( json ).to.have.all.keys ['message', 'simple', 'name']


  describe 'ValidationError', ()->

    it 'should have a ValidationError', ()->
      expect( Errors.ValidationError ).to.be.ok

    it 'should create an error', ->
      err = new Errors.ValidationError('msg')
      expect( err ).to.be.an.instanceOf Error
      expect( err.message ).to.equal 'msg'
      expect( err.name ).to.equal 'ValidationError'
      expect( err.status ).to.equal 400
      expect( err.stack ).to.be.ok
    
    it 'should remove stacks in prod', ->
      old_env = process.env.NODE_ENV
      process.env.NODE_ENV = 'production'
      err = new Errors.ValidationError('msg')
      json = err.toJSON()
      expect( json.message ).to.equal 'msg'
      expect( json ).to.not.have.property 'stack'
      process.env.NODE_ENV = old_env


  describe 'HttpError', ()->

    it 'should have a HttpError', ()->
      expect( Errors.HttpError ).to.be.ok

    it 'should create a new Error', ->
      err = new Errors.HttpError(400, 'msg')
      expect( err ).to.be.an.instanceOf Error
      expect( err.message ).to.equal 'msg'
      expect( err.name ).to.equal 'HttpError'
      expect( err.status ).to.equal 400
      expect( err.stack ).to.be.ok

    it 'should create an error', ->
      err = Errors.HttpError.create 403, 'nope'

    it 'should fail to create an unknown error', ->
      err = -> Errors.HttpError.create(444, 'msg')
      expect( err ).to.throw Error, /No HTTP error found 444/

    it 'should use a default message when none is provided', ->
      err = Errors.HttpError.create(403)
      expect( err.message ).to.equal 'Forbidden'

    it 'should use a default message when unkown error code', ->
      err = new Errors.HttpError(497)
      expect( err.message ).to.equal 'Error'
   
    it 'should attach a prior error to new Error', ->
      prior_err = new Errors.ValidationError 'a word', {value:"giggidy"}
      err = new Errors.HttpError(400, 'Wrong word', err: prior_err)
      expect( err.err ).to.be.an.instanceOf Error
      expect( err.err.value ).to.equal 'giggidy'


  describe 'KeyError', ()->

    it 'should have a KeyError', ()->
      expect( Errors.KeyError ).to.be.ok

    it 'should create an error', ->
      err = new Errors.KeyError('msg', {key:'akey'})
      expect( err ).to.be.an.instanceOf Error
      expect( err.message ).to.equal 'msg - akey'
      expect( err.name ).to.equal 'KeyError'
      expect( err.stack ).to.be.ok
      expect( err.key ).to.equal 'akey'
      expect( String(err) ).to.equal 'KeyError: msg - akey'

    it 'should create an error without key', ->
      err = new Errors.KeyError('msg')
      expect( err ).to.be.an.instanceOf Error
      expect( err.message ).to.equal 'msg'
      expect( err.name ).to.equal 'KeyError'
      expect( err.stack ).to.be.ok
      expect( err.key ).to.be.undefined
      expect( String(err) ).to.equal 'KeyError: msg'

    it 'should create an error with different status', ->
      err = new Errors.KeyError('msg', { status: 401 })
      expect( err.status ).to.equal( 401 )


  describe 'NotFoundError', ()->

    it 'should have a NotFoundError', ()->
      expect( Errors.NotFoundError ).to.be.ok

    it 'should create an error', ->
      err = new Errors.NotFoundError('msg', {url:'/aurl'})
      expect( err ).to.be.an.instanceOf Error
      expect( err.message ).to.equal 'msg'
      expect( err.name ).to.equal 'NotFoundError'
      expect( err.stack ).to.be.ok
      expect( err.url ).to.equal '/aurl'
      expect( err.status ).to.equal 404
      expect( String(err) ).to.equal 'NotFoundError: msg'

