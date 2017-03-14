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
      #expect( err.stack ).to.equal('')
      lines = err.stack.split('\n')
      expect( lines[0] ).to.equal 'RethrownError: Rethrown'
      expect( lines[1] ).to.match new RegExp("^    at .+#{__filename}:")
      expect( lines[2] ).to.equal 'Error: Original error message'
      expect( lines[3] ).to.match new RegExp("^    at .+#{__filename}:")

    it 'should create an error with 2 stack lines', ->
      ori = new Error('Original error message')
      err = new RethrownError('Rethrown', ori, stack: 2 )
      lines = err.stack.split('\n')
      expect( lines[0] ).to.equal 'RethrownError: Rethrown'
      expect( lines[1] ).to.match new RegExp("^    at .+#{__filename}:")
      expect( lines[3] ).to.equal 'Error: Original error message'

    it 'should create an error with all stack lines', ->
      ori = new Error('Original error message')
      err = new RethrownError('Rethrown', ori, stack: true )
      #expect( err.stack ).to.equal('')
      lines = err.stack.split('\n')
      ori_line_count = ori.stack.split('\n').length
      expect( lines[0] ).to.equal 'RethrownError: Rethrown'
      expect( lines[1] ).to.match new RegExp("^    at .+#{__filename}:")
      expect( lines ).to.include 'Error: Original error message'
      expect( lines.length ).to.equal( ori_line_count * 2 )

    it 'should create an error with no stack', ->
      ori = new Error('Original error message')
      err = new RethrownError('Rethrown', ori, stack: false )
      #expect( err.stack ).to.equal('')
      lines = err.stack.split('\n')
      ori_line_count = ori.stack.split('\n').length
      expect( lines[0] ).to.equal 'RethrownError: Rethrown'
      expect( lines ).to.include 'Error: Original error message'
      expect( lines.length ).to.equal( ori_line_count + 1 )

